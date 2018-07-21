pragma solidity ^0.4.24;

interface PlayerBookReceiverInterface {
    function receivePlayerInfo(uint256 _pID, address _addr, bytes32 _name, uint256 _laff) external;
    function receivePlayerNameList(uint256 _pID, bytes32 _name) external;
}
