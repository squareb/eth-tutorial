pragma solidity ^0.4.18;(

    /**
    * Example script for the Ethereum development walkthrough
    */

contract Handshake {
    /**
    * Our persons
    */
	address public person1;
	address public person2;

	uint public person1GivingHandshake;
	uint public person1ReceivingHandshake;
	uint private person1ReceivedValue;
	uint public person2GivingHandshake;
	uint public person2ReceivingHandshake;
	uint private person2ReceivedValue;

    /**
    * The logs that will be emitted in every step of the contract's life cycle
    */
	event ShakeHands(address person1, address person2);

    /**
    * The contract constructor
    */
	constructor() public {
		person1 = msg.sender;
	}

    /**
    * A second person can register
    */
	function registerPerson() public {
        require(person2 == address(0));

        person2 = msg.sender;

        emit ShakeHands(person1, person2);
    }

    /**
    * Two persons can shake hands and the receiving end will receive the value payed
    */
    function handshake() public payable {
    	require(msg.sender == person1 || msg.sender == person2);

    	if(msg.sender == person1) {
    		person1GivingHandshake += 1;
			person2ReceivingHandshake += 1;
			person2ReceivedValue = person2ReceivedValue + msg.value;
    	} else {
    		person2GivingHandshake +=1;
			person1ReceivingHandshake += 1;
			person1ReceivedValue = person1ReceivedValue + msg.value;
    	}
    }

    /**
    * The withdraw function, following the withdraw pattern shown and explained here:
    * http://solidity.readthedocs.io/en/develop/common-patterns.html#withdrawal-from-contracts
    */
    function withdraw() public {
        require(msg.sender == person1 || msg.sender == person2);
		
		if(msg.sender == person1) {
			msg.sender.transfer(person1ReceivedValue);
		} else {
			msg.sender.transfer(person2ReceivedValue);
		}
    }
}