pragma solidity ^0.4.24;

interface JIincInterfaceForForwarder {
    function deposit(address _addr) external payable returns (bool);
    function migrationReceiver_setup() external returns (bool);
}
