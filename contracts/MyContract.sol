// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

// Contract definition
contract MyContract {
    
    /* VARIABLES */
    
    // Fixed-size variables
    bool status; // True or False
    uint price; // Unsigned integer
    address _address; // Ethereum address
    bytes32 _bytes32; // Fixed-size bytes array

    // Dynamically-sized variables
    string name; // Dynamic string
    bytes _bytes; // Dynamic bytes array
    uint[] vector; // Dynamic array of unsigned integers
    mapping(uint => string) dictionary; // Mapping of unsigned integers to strings

    // User-defined variables
    // A struct is a way to define a custom data type by grouping together variables with different data types.
    struct Person {
        string name;
        string surname;
        uint age;
    }

    // An enum is a special data type that allows for a variable to take on one of a set of predefined values.
    enum Status {
        ON,
        OFF
    }

    /* VISIBILITY */

    // The visibility of a variable or function can be specified as private, internal, public, or omitted (which defaults to internal).
    string private privateName = "Andrea";
    string internal internalName = "Andrea";
    string public publicName = "Andrea";
    uint number = 11;

    /* FUNCTIONS */

    /*  
        Structure of a function: 
            
        function functionName() visibilityKeyword modifierKeyword returns(dataType) {}

        The visibility keyword indicates where and how the function can be called and viewed
        - private: can be called only within the same contract
        - internal: can be called within the same contract and by contracts that inherit from it
        - external: can be called only by external contracts
        - public: can be called from any location, both internal and external
    
        The modifier keyword indicates how the function modifies the state of the contract
        - pure: does not access or modify the state of the contract, similar to a function in C
        - view: does not modify the state of the contract, but accesses the state of the contract, for example to read a value from a state variable
        - (omitted): modifies the state of the contract, for example to write a value to a state variable
    */

    // Set the name
    function setName(string memory _name) external {
        name = _name;
    }

    // Get the name
    function getName() external view returns(string memory) {
        return name;    
    }

    // SPECIAL VARIABLE & FUNCTIONS

    /* transactions (tx)
        tx.gasprice (uint): gas price of the transaction
        tx.origin (address payable): sender of the transaction (full call chain)
    */

    /* message (msg)
        msg.data (bytes calldata): complete calldata
        msg.sender (address payable): sender of the message (current call)
        msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
        msg.value (uint): number of wei sent with the message 
    */

    /* blocks (blocks)
        block.coinbase (address payable): current block miner’s address
        block.difficulty (uint): current block difficulty
        block.gaslimit (uint): current block gaslimit
        block.number (uint): current block number
        block.timestamp (uint): current block timestamp as seconds since unix epoch
    */

    // Function to return sender address, block number and gas price
    function getSummary() external view returns(address, uint, uint) {
        return (msg.sender, block.number, tx.gasprice);
    }

    /* IF statements */

    // Public variable declaration
    string public output;
    string valueToCheck = "pizza";

    // Check if the value passed as an argument is equal to "pizza"
    function ifStatement(string memory value) external returns(string memory) {
        if(keccak256(abi.encodePacked(value))==keccak256(abi.encodePacked(valueToCheck))){
            output = "buona la pizza";
        } 
        else {
            output = "non ti piace la pizza?";
        }

        return output; 
    } 

    /* FOR loop */

    // Public variable declaration
    uint public sum;

    // Increment the "sum" variable for a number of times equal to the "end" argument
    function forLoop(uint end) external returns(uint) {
        for(uint i=0; i<end; i++){
            sum = sum+1;
        }
        return sum;
    }

    /* WHILE loop */

    // Function definition to execute a WHILE loop.
    function whileLoop(uint end) external pure returns(string memory) {
        uint j = 0;
        while(j<end) {
            j = j+1;
        }
        return "Done";
    }

    /* ARRAY or VECTORS */

    // Storage array
    // Declare a public string array and a public uint array
    string[] public nameArray;
    uint[] public numberArray;

    // Function to push values into the arrays
    function pushToArrays() public {
        nameArray.push("carlo");
        numberArray.push(11);
        nameArray.push("giorgio");
        numberArray.push(35);
        nameArray.push("pina");
        numberArray.push(14);
    }

    // Function to delete values from the arrays
    function deleteToArrays() public {
        delete nameArray[1];
        delete numberArray[1];
    }

    // Memory array
    // Declare a memory uint array 
    // This will give a compilation error because you cannot declare a memory array with a fixed size.
    // uint[] memory myArray2 = new uint[](10);

    /* 
        Example using storage arrays
    */

    // Declare a public uint (storage) array
    uint[] public myArray1; 

    // Function to add values to the (storage) array
    function myFunc1(uint end) external returns(uint[] memory) {
        for(uint i=0; i<end; i++) {
            myArray1.push(i*2); // Pushes the value of i*2 into the storage array
        }
        return myArray1; // Returns the storage array
    }
    
    // Function to get the values from the (storage) array
    function getMyArray1() external view returns(uint[] memory){        
        uint leng = myArray1.length; // Assigns the length of the storage array to 'leng'
        uint[] memory result = new uint[](leng); // Declares a memory array 'result' with length 'leng'
        for(uint i=0; i<leng; i++){
            result[i] = myArray1[i]; // Assigns each value of the storage array to the memory array
        }
        return result; // Returns the memory array
    }

    /* 
        Example using memory arrays
    */

    // Function to create a memory array and modify it
    function myFunc2() external pure returns(uint[] memory) {
        uint[] memory myArray2 = new uint[](10); // Declares a memory array 'myArray2' with length 10
        for(uint i=0; i<myArray2.length; i++) {
            myArray2[i] = i*2; // Assigns the value of i*2 to each element of the memory array
        }
        myArray2[5] = 5; // Modifies the 6th element of the memory array to 5
        delete myArray2[3]; // Deletes the 4th element of the memory array
        return myArray2; // Returns the memory array
    }

    // Some rules
    function myFunc3(uint[] calldata _myArray) external {} // Accepts a memory array passed as a parameter in a function
    function myFunc4(uint[] memory _myArray) internal {} // Accepts a memory array passed as a parameter in a function
    function myFunc5(uint[] memory _myArray) private {} // Accepts a memory array passed as a parameter in a function
    function myFunc6(uint[] calldata _myArray) public {} // Accepts a memory array passed as a parameter in a function

    /* MAPPING */

    // a -> 1
    // f -> 4
    // p -> 2

    // Declares a mapping data structure that maps an address to a uint value representing age. 
    // The age value can be accessed using the address as the key.
    mapping (address => uint) public age; 

    // The function assignAge assigns a value to the map for the sender's address of the transaction.
    function assignAge(uint _age) external {
    age[msg.sender] = _age;
    }

    // The function getAge returns the value associated with the address specified as a parameter.
    function getAge(address _sender) external view returns(uint) {
    return age[_sender];
    }

    /* STRUCTURES */

    // Definition of the Player structure containing the name, address, and number of goals of the player
    struct Player {
        string name;
        address addr;
        uint goals;
    }

    // Declaration of the public array of players
    Player[] public players;

    // Adding a player to the players array
    function addPlayer1(string calldata _name, uint _goals) external {
        // Creating a Player object with the provided parameters and adding it to the players array
        Player memory player1 = Player({name:_name, addr:msg.sender, goals:_goals});
        players.push(player1);
        // Creating another Player object and adding it to the players array
        Player memory _player1 = Player(_name, msg.sender, _goals);
        players.push(_player1);
    }

    // Declaration of a mapping of type Player that can be accessed via address
    mapping(address => Player) public _players;

    // Adding a player to the _players mapping
    function addPlayer2() external {
        // Creating a Player object with the predefined parameters and adding it to the _players mapping
        Player memory player2 = Player({name:'Mbappe', addr:msg.sender, goals: 30});
        address playerAddress = 0x993b3EfEEEf7eF1DF59Ef507a188e66Be634D465;
        _players[playerAddress] = player2;
    }

    /* ENUM */

    // Declaration of the STATUS enumeration containing the ON and OFF options
    enum STATUS {
        ON,
        OFF
    }

    // Declaration of a public variable of type STATUS called light
    STATUS public light;

    // Function that changes the value of the light variable based on its current value
    function switchLight() external {
        if(keccak256(abi.encodePacked(light)) == keccak256(abi.encodePacked(STATUS.ON))){
            light = STATUS.OFF;
        } 
        else {
            light = STATUS.ON;
        }
    }

    // Function that returns the value of the light variable
    function getLightStatus() external view returns(STATUS) {
        return light;
    }

    /* EVENTS */

    // Declaration of the Score event that is emitted when a goal is scored
    event Score (
        uint256 date,
        string playerName,
        string playerTeam
    );

    // Function that emits the Score event with the provided parameters
    function goalScored(string calldata _player, string calldata _team) external {
        emit Score(block.timestamp, _player, _team);
    }
}

// MyContract.deployed().then(function(i){contract=i;})




