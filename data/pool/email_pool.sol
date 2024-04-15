// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface OtherContractInterface {
    function saveEmailFromDifferentChain(string calldata username, string calldata sendString) external;
}

contract EmailPoolContract {
    mapping(string => string[]) private emailsByDomain;
    mapping(string => string[]) private emailsForSending;

    function saveEmailsBasedOnDomain(string memory domain, string memory email) public {
        emailsByDomain[domain].push(email);
    }

    function getEmailsByDomain(string memory domain) public view returns (string[] memory) {
        return emailsByDomain[domain];
    }
    
    function deleteEmailsBasedOnDomain(string memory domain) public {
        string[] storage emails = emailsByDomain[domain];
        for (uint i = 0; i < emails.length; i++) {
            delete emails[i];
        }
        delete emailsByDomain[domain];
    }

    function sendEmailsBasedOnDomain(string memory domain, string memory email) public {
        emailsForSending[domain].push(email);
    }

    function getSendEmailsByDomain(string memory domain) public view  returns (string[] memory) {
        return emailsForSending[domain];
    }

    function deleteSendEmailsBasedOnDomain(string memory domain) public {
        string[] storage emails = emailsForSending[domain];
        for (uint i = 0; i < emails.length; i++) {
            delete emails[i];
        }
        delete emailsForSending[domain];
    }

    function callSendEmailRequest(string calldata username, string calldata sendString , address otherContractAddress) public {
        OtherContractInterface otherContract = OtherContractInterface(otherContractAddress);
        otherContract.saveEmailFromDifferentChain(username, sendString);
    }
}
