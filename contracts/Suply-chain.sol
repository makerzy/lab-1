pragma solidity ^0.6.12;

// SPDX-License-Identifier: MIT

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data)
        internal
        view
        returns (bytes memory)
    {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

contract ShippmentManager {
    using SafeMath for uint256;
    using Address for address;

    struct Container {
        uint256 containerID;
        address receiver;
        address owner;
        string content;
        uint256 shipmentPrice;
        uint256 createdAt;
        uint256 paymentReceivedTime;
        uint256 shippmentStartTime;
        uint256 shippmentReceivedTime;
        PackageState state;
        ViolationType violation;
    }

    mapping(uint256 => Container) public getContainer;

    enum PackageState {
        NotReady,
        ReadyforShipment,
        MoneyDeposited,
        StartShippment,
        ShipmentReceived,
        Aborted
    }

    uint256 public CONTAINER_ID = 0;
    uint256 public  DELAY = 48 hours;

    enum ViolationType {
        None,
        Open,
        Route,
        Jerk
    }
    address public owner;

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _blocktime() internal view returns (uint256) {
        return block.timestamp;
    }

    constructor() public {
        owner = _msgSender();
    }

    event Initialized(
        address owner,
        uint256 shippmentPrice,
        uint256 shippmentId
    );

    function initializeShippment(
        address _owner,
        uint256 _shippmentPrice,
        string calldata _content
    ) external returns (bool) {
        Container memory container;
        CONTAINER_ID = CONTAINER_ID.add(1);
        container.owner = _owner;
        container.containerID = CONTAINER_ID;
        container.shipmentPrice = _shippmentPrice;
        container.content = _content;
        container.createdAt = _blocktime();
        container.state = PackageState.NotReady;
        getContainer[container.containerID] = container;

        emit Initialized(_owner, _shippmentPrice, container.containerID);
    }

    event ShippmentReady(
        address owner,
        PackageState state,
        uint256 shippmentId
    );

    function setReadyState(uint256 Id) public OnlyContainerOwner(Id) {
        Container storage container = getContainer[Id];
        container.state = PackageState.ReadyforShipment;
        emit ShippmentReady(
            _msgSender(),
            container.state,
            container.containerID
        );
    }

    event MoneyDeposited(
        address sender,
        uint256 valueReceived,
        uint256 shippmentId
    );

    function depositMoneyforShipment(uint256 Id)
        external
        payable
        ContainerExist(Id)
    {
        Container storage container = getContainer[Id];
        if (container.state == PackageState.ReadyforShipment) {
            require(
                msg.value >= container.shipmentPrice,
                "ShippmentManager: value cannot be lesser than shippent price"
            );
            container.state = PackageState.MoneyDeposited;
            container.paymentReceivedTime = _blocktime();
            container.receiver = _msgSender();
            emit MoneyDeposited(_msgSender(), msg.value, Id);
        } else revert("Invalid shippment Id");
    }

    modifier OnlyContainerOwner(uint256 shippmentId) {
        Container storage container = getContainer[shippmentId];
        require(_msgSender() == container.owner, "only container owner");
        _;
    }

    modifier OnlyContainerReceiver(uint256 shippmentId) {
        Container storage container = getContainer[shippmentId];
        require(_msgSender() == container.receiver, "only container receiver");
        _;
    }

    modifier ContainerExist(uint256 shippmentId) {
        Container storage container = getContainer[shippmentId];
        require(container.owner != address(0), "Invalid shippment");
        _;
    }

    event ShippmentStarted(address sender, PackageState state);

    function startShippment(uint256 shippmentId)
        external
        OnlyContainerOwner(shippmentId)
    {
        Container storage container = getContainer[shippmentId];

        require(
            container.state == PackageState.MoneyDeposited,
            "ShippmentManager: shippment start too early"
        );
        container.state = PackageState.StartShippment;
        container.shippmentStartTime = _blocktime();
        emit ShippmentStarted(_msgSender(), container.state);
    }

    event ShippmentCompleted(address sender, uint256 shippmentId);

    function shipmentArrived(uint256 shippmentId)
        external
        OnlyContainerReceiver(shippmentId)
        ContainerExist(shippmentId)
    {
        Container storage container = getContainer[shippmentId];
        require(
            container.state == PackageState.StartShippment,
            "ShippmentManager: shippment received too early"
        );
        container.state = PackageState.ShipmentReceived;
        container.shippmentReceivedTime = _blocktime();
        emit ShippmentCompleted(_msgSender(), shippmentId);
    }
    
    event shipmentArrivedWithViolation(address sender, uint256 shippmentId, uint8 violation);
    // Function Overloading
    function arrivedWithViolation(uint256 shippmentId, uint8 violation)
        external
        OnlyContainerReceiver(shippmentId)
        ContainerExist(shippmentId)
    {
        Container storage container = getContainer[shippmentId];
        require(
            container.state == PackageState.StartShippment,
            "ShippmentManager: shippment received too early"
        );
        container.state = PackageState.ShipmentReceived;
        container.shippmentReceivedTime = _blocktime();
        container.violation = ViolationType(violation);

        emit shipmentArrivedWithViolation(_msgSender(), shippmentId, violation);
    }

    event ViolationReported(
        address sender,
        uint256 shippmentId,
        uint8 violation
    );

    function reportViolation(uint256 shippmentId, uint8 violation)
        external
        ContainerExist(shippmentId)
        OnlyContainerReceiver(shippmentId)
    {
        require(violation >= 0 && violation <= 3, "invalid violation type");
        Container storage container = getContainer[shippmentId];
        container.violation = ViolationType(violation);
        emit ViolationReported(_msgSender(), shippmentId, violation);
        
    }

    modifier OnlyOwner() {
        require(_msgSender() == owner, "Only Admin");
        _;
    }

    event ShippmentMoneySent(address sender,uint256 shippmentId, uint256 value);
    function getShipmentMoney(uint256 shippmentId)
        external
        OnlyContainerOwner(shippmentId)
    {
        Container storage container = getContainer[shippmentId];
        require(container.violation == ViolationType.None, "violation reported");
        require(_blocktime() > container.shippmentReceivedTime.add(DELAY), "withdraw request too early");

        // refund the buyer
        (bool sent, ) = payable(container.owner).call{
            value: container.shipmentPrice
        }("");
        require(sent, "Failed to send Ether");
        emit ShippmentMoneySent(_msgSender(), shippmentId, container.shipmentPrice);
    }

    event Refund(address sender, uint256 amount, uint256 shippmentId);

    function refund(uint256 shippmentId) external OnlyOwner {
        Container storage container = getContainer[shippmentId];
        require(container.violation != ViolationType.None, "No violation");
        // refund the buyer
        (bool sent, ) = payable(container.receiver).call{
            value: container.shipmentPrice
        }("");
        require(sent, "Failed to send Ether");

        container.state = PackageState.Aborted;
        emit Refund(_msgSender(), container.shipmentPrice, shippmentId);
    }
}
