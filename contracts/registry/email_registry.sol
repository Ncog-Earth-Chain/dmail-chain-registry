// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HostRegistryContract {

    // Struct to store user data
    struct UserData {
        address contractAddress;
        string userData;
    }
    
    // Mapping to store user data by username
    mapping(string => UserData) public users;

    // Function to return a simple confirmation string
    function ping() external pure returns (string memory) {
        return "yes";
    }

    // Function to register user data
    function registerChain(string memory username, address _contractAddress, string memory _userData) public {
        users[username] = UserData(_contractAddress, _userData);
    }

    // Function to get user data by username
    function getChainDetails(string memory username) public view returns (address, string memory) {
        UserData memory userData = users[username];
        return (userData.contractAddress, userData.userData);
    }

    // Function to update user data
    function updateChain(string memory username, address _contractAddress, string memory _userData) public {
        require(users[username].contractAddress != address(0), "User does not exist");
        users[username] = UserData(_contractAddress, _userData);
    }

    // Function to delete user data
    function deleteChain(string memory username) public {
        require(users[username].contractAddress != address(0), "User does not exist");
        delete users[username];
    }
}
