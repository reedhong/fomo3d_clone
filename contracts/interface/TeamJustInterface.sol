pragma solidity ^0.4.24;

interface TeamJustInterface {
    function requiredSignatures() external view returns(uint256);
    function requiredDevSignatures() external view returns(uint256);
    function adminCount() external view returns(uint256);
    function devCount() external view returns(uint256);
    function adminName(address _who) external view returns(bytes32);
    function isAdmin(address _who) external view returns(bool);
    function isDev(address _who) external view returns(bool);
}