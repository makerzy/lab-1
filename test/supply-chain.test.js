const chai = require("chai");
const { BigNumber, Contract, constants, utils } = require("ethers");
const {
  solidity,
  MockProvider,
  createFixtureLoader,
  deployContract,
} = require("ethereum-waffle");
const {
  mineBlock,
  expandTo18Decimals,
  toHumanVal,
  toBigNumber,
  DELAY,
  ADDRESS_ZERO,
} = require("./utils/utils");
const {
  takeSnapshot,
  advanceTime,
  revertTime,
} = require("./utils/time-travel");
const {
  expandToEthers,
  addNumbers,
  subNumbers,
  toBNumber,
} = require("./utils/mathHelp");
const expect = chai.expect;
chai.use(solidity);

const provider = new MockProvider({
  ganacheOptions: {
    hardfork: "istanbul",
    mnemonic: "horn horn horn horn horn horn horn horn horn horn horn horn",
    gasLimit: 9999999,
  },
});

const overrides = {
  gasLimit: 9999999,
};

const accounts = provider.getWallets();
const [wallet, other0, other1, other2, other3, other4, other5, other6] =
  accounts;

let shippmentManager;

beforeEach(async () => {
  const ShippmentManager = await ethers.getContractFactory(
    "ShippmentManager",
    wallet,
  );
  shippmentManager = await ShippmentManager.deploy();
  await shippmentManager
    .connect(other0)
    .initializeShippment(
      other0.address,
      expandTo18Decimals(1),
      "A computer",
      overrides,
  )
  const container = await shippmentManager.getContainer(1);
  expect(container.owner).to.equal(other0.address);
});

describe("supply chain", () => {
  it("Set Ready", async () => {

    await expect(shippmentManager.connect(wallet).setReadyState(1, overrides)).to.revertedWith("only container owner")
    /* State enum ReadyforShipment = 1 */
    await expect(shippmentManager.connect(other0).setReadyState(1, overrides)).to.emit(shippmentManager, "ShippmentReady").withArgs(other0.address, 1, 1)
    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Set deposit for shipment", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await expect(shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(0).toString(10),
    })).to.revertedWith("ShippmentManager: value cannot be lesser than shippent price")

    await expect(shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })).to.emit(shippmentManager, "MoneyDeposited").withArgs(other1.address, expandToEthers(1).toString(10), 1)
    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Start shipping", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await expect(shippmentManager.connect(other1).startShippment(1, overrides)).to.be.revertedWith("only container owner")
    await expect(shippmentManager.connect(other0).startShippment(1, overrides)).to.emit(shippmentManager, "ShippmentStarted").withArgs(other0.address, 3)
    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Container arrived", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await shippmentManager.connect(other0).startShippment(1, overrides)
    await expect(shippmentManager.connect(other0).shipmentArrived(1, overrides)).to.revertedWith("only container receiver")
    /* other1 paid for the container */
    await expect(shippmentManager.connect(other1).shipmentArrived(1, overrides)).to.emit(shippmentManager, "ShippmentCompleted").withArgs(other1.address, 1)

    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Report violation", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await shippmentManager.connect(other0).startShippment(1, overrides)
    await expect(shippmentManager.connect(other2).reportViolation(1, 2, overrides)).to.revertedWith("only container receiver")
    await expect(shippmentManager.connect(other1).reportViolation(1, 4, overrides)).to.revertedWith("invalid violation type")
    /* other1 paid for the container */
    await expect(shippmentManager.connect(other1).reportViolation(1, 2, overrides)).to.emit(shippmentManager, "ViolationReported").withArgs(other1.address, 1, 2)

    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Container arrived with violation", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await shippmentManager.connect(other0).startShippment(1, overrides)
    /* other1 paid for the container */
    await expect(shippmentManager.connect(other1).arrivedWithViolation(1, 2, overrides)).to.emit(shippmentManager, "shipmentArrivedWithViolation")
      .withArgs(other1.address, 1, 2)

    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })
  it("Delay fund withdrawal until 48 hours", async () => {

    /* shipment id = 1 */
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await shippmentManager.connect(other0).startShippment(1, overrides)
    /* other1 paid for the container */
    await shippmentManager.connect(other1).shipmentArrived(1, overrides)
    advanceTime(provider, (24 * 60 * 60))
    await expect(shippmentManager.connect(other0).getShipmentMoney(1, overrides)).to.revertedWith("withdraw request too early")
    advanceTime(provider, (24 * 60 * 60))
    await expect(shippmentManager.connect(other1).getShipmentMoney(1, overrides)).to.revertedWith("only container owner")
    await expect(shippmentManager.connect(other0).getShipmentMoney(1, overrides)).to.emit(shippmentManager, "ShippmentMoneySent").withArgs(other0.address, 1, expandToEthers(1).toString(10))

    expect(await shippmentManager.owner()).to.equal(wallet.address);
  })

  it("refunds", async () => {
    await shippmentManager.connect(other0).setReadyState(1, overrides)
    await shippmentManager.connect(other1).depositMoneyforShipment(1, {
      ...overrides,
      value: expandToEthers(1).toString(10),
    })
    await shippmentManager.connect(other0).startShippment(1, overrides)
    /* other1 paid for the container */
    await shippmentManager.connect(other1).arrivedWithViolation(1, 3, overrides)

    await expect(shippmentManager.connect(other1).refund(1, overrides)).to.revertedWith("Only Admin")
    await expect(shippmentManager.connect(wallet).refund(1, overrides)).to.emit(shippmentManager, "Refund").withArgs(wallet.address, expandToEthers(1).toString(10), 1)
  })


});
