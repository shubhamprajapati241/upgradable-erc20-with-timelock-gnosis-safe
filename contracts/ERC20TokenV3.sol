// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract ERC20TokenV3 is Initializable, ERC20Upgradeable {

    address public owner;

    function initialize(uint _totalSupply) public initializer {
        __ERC20_init("ERC20 Token", "TKN");
        _mint(msg.sender, _totalSupply);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this operation");
        _;
    }

     modifier nonReentrant() {
        bool locked;
        require(locked == false, "Cannot Reenter Method");
        locked = true;
        _;
    }

    /***************** PHASE 2 : Added Mint(), Burn(), Buy() **********************/ 
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address to, uint256 amount) public onlyOwner {
        _burn(to, amount);
    }

    receive() external payable {}

    function buy() external payable returns(bool) {
        require(msg.sender.balance >= msg.value && msg.value >= 0, "Insufficient Balance in the Contract");
        (bool success, ) = address(this).call{value: msg.value }("");
        require(success,"Unsucessful buy attempt");
        uint _amount = msg.value * 1000;
        _transfer(owner, msg.sender, _amount);
        return true;
    }

    function allowanceToken(address _account, uint256 _amount) public returns (bool){
        require (_account != address(this) && _amount != 0, "ERC20: ");
        _spendAllowance(msg.sender, _account, _amount);
        return true;
    }


    /***************** PHASE 3 : Added Withdraw() and nonReentrant **********************/
    function withdraw(uint _amount) external payable  onlyOwner nonReentrant returns(bool) {
        require (_amount <= address(this).balance, "Insufficient Balance");
        (bool success, ) = owner.call{value: _amount }("");
        require(success,"Withdrawl of funds unsucessful");
        return(true);
    }

    function getContractBalance() public view returns(uint256) {
        return address(this).balance;
    }
}
