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
});

describe("supply chain", () => {
  // it("deploy", async () => {
  //   expect(await shippmentManager.owner()).to.equal(wallet.address);
  // });
  it("initializeShippment", async () => {
    await expect(
      shippmentManager
        .connect(wallet)
        .initializeShippment(
          other0.address,
          expandTo18Decimals(1),
          "A computer",
          overrides,
        ),
    )
      .to.emit(shippmentManager, "Initialized")
      .withArgs(other0.address, expandTo18Decimals(1), 1);
    const container = await shippmentManager.getContainer(1);
    expect(container.owner).to.equal(other0.address);
  });
});
