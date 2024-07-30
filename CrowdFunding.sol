// SPDX-License-Identifier: MIT
pragma solidity >=  0.5.0 < 0.9.0 ; 

contract CrowdFunding{
    mapping (address=>uint) public contributers;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noofContributers;

    struct Request{
        string discription;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping (address=>bool) voters;
    }
    mapping (uint=>Request) public requests;
    uint public numRequests;

    constructor (uint _target, uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        minimumContribution=100 wei;
        manager=msg.sender;
    }
    function sendETH() public payable {
        require(block.timestamp < deadline, "Deadline has passed");
        require(msg.value >=minimumContribution,"Minimum contribution has not met");

        if(contributers[msg.sender]==0){
            noofContributers++;
        }
        contributers[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }
    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }
    function refund() public {
        require(block.timestamp>deadline && raisedAmount<target, "you are not eligible for refund");
        require(contributers[msg.sender]>0);
        address payable user=payable (msg.sender);
        user.transfer(contributers[msg.sender]);
        user.transfer(100);
        contributers[msg.sender]=0;
    }
    modifier onlyManager(){
        require(msg.sender==manager,"only manager can call this function");
        _;
    }
    function createRequests(string memory _discrption,address payable _recipient, uint _value) public onlyManager{
    Request storage newRequest = requests[numRequests];
    numRequests++;
    newRequest.discription=_discrption;
    newRequest.recipient=_recipient;
    newRequest.value=_value;
    newRequest.completed=false;
    newRequest.noOfVoters=0; 
    }
    function voteRequest(uint _requestNo) public {
        require(contributers[msg.sender]>0, "you must be contributer");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false, "you have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }
    function makePayment(uint _requestNo) public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest= requests[_requestNo];
        require(thisRequest.completed==false,"the request is completed");
        require(thisRequest.noOfVoters > noofContributers/2, "Majority do not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }
}