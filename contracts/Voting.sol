// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Vote {
    // structure
    struct candidator {
      string name;
      uint upVote;
    }

    // variable
    bool live;
    address owner;
    candidator[] public candidatorList;

    // mapping
    mapping(address => bool) Voted;   

    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);

    // modifier
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }

    // constructor
    constructor() {
      owner = msg.sender;
      live = true;

      emit Voting(owner);
    }
    
    // add candidator
    // argument에는 관용적으로 _를 붙인다.
    // Explicit data location for all variables of struct, array or mapping types is now mandatory. (0.5.0~)
    function addCandidator(string memory _name) public onlyOwner {
        require(live == true);
        require(candidatorList.length < 5);
        candidatorList.push(candidator(_name, 0));

        // emit event
        emit AddCandidator(_name);
    }
    
    // voting
    function upVote(uint _indexOfCandidator) public {
        require(live == true);
        require(_indexOfCandidator < candidatorList.length );
        require(Voted[msg.sender] == false);
        
        candidatorList[_indexOfCandidator].upVote++;

        Voted[msg.sender] = true;

        // emit event
        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    
    // finish voting
    // contract 주인만 vote를 닫을 수 있도록 해야 함
    function finishVote() public onlyOwner {
        require(live == true);
        live = false;

        emit FinishVote(live);
    }
    
}

