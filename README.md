<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

</head>

<body>

<div align="center">

  <h1>🗳️ Vote Smart Contract</h1>
  <h3><em>Secure • Transparent • Decentralized Voting on Blockchain</em></h3>

  <p>
    <img src="https://img.shields.io/badge/Solidity-%3E%3D0.7.0%20%3C0.9.0-363636?style=for-the-badge&logo=solidity&logoColor=white" />
    <img src="https://img.shields.io/badge/Ethereum-Compatible-3C3C3D?style=for-the-badge&logo=ethereum&logoColor=white" />
    <img src="https://img.shields.io/badge/Status-Functional-success?style=for-the-badge" />
  </p>

  <hr />

  <p>
    <a href="#overview">Overview</a> •
    <a href="#features">Core Features</a> •
    <a href="#architecture">Contract Architecture</a> •
    <a href="#functions">Function Reference</a> •
    <a href="#deployment">Deployment</a> •
    <a href="#author">Author</a>
  </p>

</div>

<hr />

<h2 id="overview">🏛️ Overview</h2>

<p>
  <strong>Vote</strong> is a decentralized voting smart contract built using Solidity.
  It enables a secure, transparent, and tamper-resistant election process on the blockchain.
  The contract manages voter registration, candidate registration, voting periods, vote casting,
  and winner declaration under the control of an Election Commission.
</p>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th align="left">Specification</th>
    <th align="left">Details</th>
  </tr>
  <tr>
    <td>Compiler Version</td>
    <td>&gt;= 0.7.0 &lt; 0.9.0</td>
  </tr>
  <tr>
    <td>Network</td>
    <td>Ethereum Compatible</td>
  </tr>
  <tr>
    <td>Contract Type</td>
    <td>Decentralized Voting System</td>
  </tr>
  <tr>
    <td>Control Authority</td>
    <td>Election Commission</td>
  </tr>
</table>

<hr />

<h2 id="features">🚀 Core Features</h2>

<h3>👤 Voter Management</h3>
<ul>
  <li>Voter registration with age validation (18+)</li>
  <li>Prevents duplicate voter registration</li>
  <li>Each voter can cast only one vote</li>
</ul>

<h3>🏛️ Candidate Management</h3>
<ul>
  <li>Candidate registration with age validation</li>
  <li>Maximum two candidates allowed</li>
  <li>Election Commission cannot be a candidate</li>
</ul>

<h3>🕒 Voting Control</h3>
<ul>
  <li>Configurable voting start and end time</li>
  <li>Automatic voting status tracking</li>
  <li>Emergency voting stop by Election Commission</li>
</ul>

<h3>🏆 Result Declaration</h3>
<ul>
  <li>Vote counting handled on-chain</li>
  <li>Winner announced transparently</li>
  <li>Immutable voting results</li>
</ul>

<hr />

<h2 id="architecture">⚙️ Contract Architecture</h2>

<h3>📦 Data Structures</h3>

<h4>Voter Struct</h4>
<ul>
  <li>Name</li>
  <li>Age</li>
  <li>Voter ID</li>
  <li>Gender</li>
  <li>Voted Candidate ID</li>
  <li>Wallet Address</li>
</ul>

<h4>Candidate Struct</h4>
<ul>
  <li>Name</li>
  <li>Party</li>
  <li>Age</li>
  <li>Gender</li>
  <li>Candidate ID</li>
  <li>Wallet Address</li>
  <li>Total Votes</li>
</ul>

<h3>📊 Enums</h3>
<ul>
  <li><strong>Gender</strong>: NotSpecified, Male, Female, Other</li>
  <li><strong>VotingStatus</strong>: NotStarted, Inprogress, Ended</li>
</ul>

<hr />

<h2 id="functions">🛠️ Function Reference</h2>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th align="left">Function</th>
    <th align="left">Access</th>
    <th align="left">Description</th>
  </tr>
  <tr>
    <td>registerCandidate</td>
    <td>External</td>
    <td>Registers a new candidate</td>
  </tr>
  <tr>
    <td>registerVoter</td>
    <td>External</td>
    <td>Registers a new voter</td>
  </tr>
  <tr>
    <td>castVote</td>
    <td>External</td>
    <td>Casts a vote for a candidate</td>
  </tr>
  <tr>
    <td>setVotingPeriod</td>
    <td>Commissioner</td>
    <td>Sets voting start and end time</td>
  </tr>
  <tr>
    <td>getVotingStatus</td>
    <td>View</td>
    <td>Returns current voting status</td>
  </tr>
  <tr>
    <td>announceVotingResult</td>
    <td>Commissioner</td>
    <td>Declares the election winner</td>
  </tr>
  <tr>
    <td>emergencyStopVotin</td>
    <td>Commissioner</td>
    <td>Stops voting immediately</td>
  </tr>
</table>

<hr />

<h2 id="deployment">🚀 Deployment & Usage</h2>

<ol>
  <li>Compile the contract using Solidity compiler version 0.7.x or 0.8.x</li>
  <li>Deploy using Remix, Hardhat, or Truffle</li>
  <li>Deployer becomes the Election Commission</li>
  <li>Register candidates and voters</li>
  <li>Set voting period</li>
  <li>Allow voters to cast votes</li>
  <li>Announce results</li>
</ol>

<hr />

<h2>🔒 Security Considerations</h2>
<ul>
  <li>One-person-one-vote enforcement</li>
  <li>Strict role-based access control</li>
  <li>Time-based voting restrictions</li>
  <li>On-chain immutable records</li>
</ul>

<hr />

<h2 id="author">📬 Author</h2>

<p>
  <strong>Developed by:</strong> Kalpathon / Web3 Developer<br/>
  <strong>Domain:</strong> Blockchain • Smart Contracts • Decentralized Governance
</p>

<hr />

<p align="center">
  <em>This project is intended for educational, academic, and hackathon purposes.</em>
</p>

</body>
</html>
