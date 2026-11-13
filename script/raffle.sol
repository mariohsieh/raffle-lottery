// SPDX-License-Identifier: MIT
pragma solidity ~0.8.38;

/**
  * Errors
  */
error Raffle_SendMoreToEnterRaffle();

/**
 * @title Sample raffle lottery contract
 * @author Mario Hsieh
 * @notice A simple contract to create a sample raffle on chain
 * @dev Implements chainlink VRFv2.5
 */
contract Raffle {
  /**
   * State Variables
   */
  // cost to enter raffle
  uint256 private immutable i_entranceFee;
  // time between picking winners for the raffle
  uint256 private immutable i_interval;
  address payable[] private s_players;
  uint256 private s_lastTimestamp;

  /**
   * Events
   */
  event RaffleEntered(address indexed player);

  /**
   * Set entrance fee from argument on contract deployment
   */
  constructor(uint256 entranceFee, uint256 interval) {
    i_entranceFee = entranceFee;
    i_interval = interval;
    s_lastTimestamp = block.timestamp;
  }

  /**
   * Setter Functions
   */
  function enterRaffle() external payable {
    // require(msg.value >= i_entranceFee, "Not enough ETH sent!");

    // latest updates can put errors inside a require
    // requires additional compiling
    // require(msg.value >= i_entranceFee, SendMoreToEnterRaffle);

    // if conditional to throw error uses less gas than require
    if (msg.value < i_entranceFee) {
      revert Raffle_SendMoreToEnterRaffle();
    }
    s_players.push(payable(msg.sender));
    emit RaffleEntered(msg.sender);
  }

  // TODO
  // get a random number
  // use random number to pick a player
  // be automatically called
  function pickWinner() external view {
    // check to see how much time has passed
    if ((block.timestamp - s_lastTimestamp) > i_interval) {
      revert ();
    }
  }

  /**
   * getter functions
   */
  function getEntranceFee() external view returns (uint256) {
    return i_entranceFee;
  }
}
