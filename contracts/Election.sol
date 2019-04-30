pragma solidity ^0.5.0;

contract Election {
    struct UserRequest {
      bool isExecute;
      // Details of hash(request data), details can be reffer in the database
      // Store the hash data here to be validated for the further usage
      string hashData;
    }
    mapping(uint => UserRequest) public userRequest;
    mapping(address => uint) public member;

    // store requestID to its hashValue
    mapping(uint => string) public airlineRequest;

    // store requestID to it's executed or not
    mapping(uint => bool) public airlineResponse;
    // chairman account, let airline deposit to become a member
    address public chairman;

    // Constructor
    constructor () public {
        chairman = msg.sender;
    }

    // airline register
    function register() public payable{
        // at least deposit 1000 wei
        require(msg.value >= 1000.0);
        member[msg.sender] = msg.value;
    }

    modifier onlyChairman() {
        require (msg.sender == chairman);
        _;
    }

    function unregister(address payable account) public onlyChairman() {
        // cost 100 wei for unregister fee
        account.transfer(member[account] -100);
        delete member[account];
    }

    // create a record to store the result of new order's hash data, for confidencial purpose
    function createOrderRequest(uint requestID, bool isExecute, string memory hashData) public{
        userRequest[requestID] = UserRequest(isExecute, hashData);
    }

    // create a record when airline a transfer a user's order to airline b
    function request(uint requestID, string memory hashData) public{
        airlineRequest[requestID] = hashData;
    }

    // create a record when airline b decide the request from airline a, may be executed or non-executed
    function response(uint requestID, bool isExecute) public{
        airlineResponse[requestID] = isExecute;
    }
}
