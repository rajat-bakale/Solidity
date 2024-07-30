# Voting Smart Contract & CrowdFunding Smart Contract
  This is a basic voting smart contract written in Solidity. It allows registered voters to vote on proposals. The chairperson, who is the deployer of the 
  contract, has the authority to register voters.

  This is a CrowdFunding smart contract written in Solidity. It allows users to contribute funds towards a target within a specified deadline. If the target is not 
  met by the deadline, contributors can claim a refund. The manager of the contract can create spending requests, which need to be approved by the contributors 
  before funds are released.

  ## Features of voting smart contract
  - Chairperson: The person who deploys the contract becomes the chairperson and has the ability to register voters.
  - Registering Voters: Only the chairperson can register voters.
  - Voting: Registered voters can vote on proposals.
  - Winning Proposal: The contract can determine and return the proposal with the most votes.

  ## Features of CrowdFunding smart contract
  - Contribution: Users can contribute ETH to the crowdfunding campaign.
  - Refunds: Contributors can get a refund if the target is not met by the deadline.
  - Requests: The manager can create spending requests for the collected funds.
  - Voting: Contributors can vote on spending requests.
  - Payments: Funds are released to the recipient only if the majority of contributors approve the request.

  ## License

  This project is licensed under the MIT License.
