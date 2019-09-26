
pragma solidity 0.4.26;

contract Vote {


    struct candidator {
        string name;
        uint    upVote; 
    }

    //variable
    bool live;
    address owner;
    candidator[] public candidatorList;
    
    
    //mapping
    mapping(address =>bool) Voted;
    
    //event trigger
    event AddCandidatorEvent(string name);
    event UpVoteEvent(string candidator, uint upVote);
    event FinishVoteEvent(bool live);
    event VottingEvent(address owner);

    //modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    //constructor
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit VottingEvent(owner);
    }

    //candidator
    function addCandidator(string _name) public {
        //limit candidator list to 5
        require(live == true);
        
        require(candidatorList.length <10);
        
        candidatorList.push(candidator(_name, 0));
        
        
        
        //emit event
        emit AddCandidatorEvent(_name);
    
    }
    //get candidator
    
    
    //voting
    function upVote(uint _indexOfCandidator) public {
        require(live == true);
        require(candidatorList.length > _indexOfCandidator);
        require(Voted[msg.sender] == false);
        candidatorList[_indexOfCandidator].upVote++;
        
        Voted[msg.sender] = true;
         
        emit UpVoteEvent(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
        
    }
    //finish Vote
    function finishVote() public onlyOwner {
        require(live == true);
        live = false;
        
        emit FinishVoteEvent(live);
        
    }
    
    
    
}
