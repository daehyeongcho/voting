// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Voting {
  // construct to initialize candidates
  // vote for candidates
  // get count of votes for each candidates

  string[] public candidateList;
  mapping (string => uint) public votesReceived;
  constructor(string[] memory candidateNames) {
    candidateList = candidateNames;
  }

  function voteForCandidate(string memory candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }

  // 수정하는 게 없을 경우 view 키워드를 넣어줘야 함
  function totalVotesFor(string memory candidate) view public returns(uint) {
    return votesReceived[candidate];
  }

  // string끼리 비교하려면 ==를 사용할 수 없고 hashing해서 비교해야함
  // 아니면 StringUtils 라이브러리에서 지원하는 equal함수를 사용해도 됨
  function validCandidate(string memory candidate) view public returns(bool) {
    for (uint i=0; i < candidateList.length; i++) {
      if (keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))) {
        return true;
      }
    }
    return false;
  }
}