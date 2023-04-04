// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract ERC20TokenV1 is Initializable, ERC20Upgradeable {
    address public owner;

    function initialize(uint _totalSupply) public initializer {
        __ERC20_init("ERC20 Token", "TKN");
        _mint(msg.sender, _totalSupply);
        owner = msg.sender;
    }
}
