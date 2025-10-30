// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title ChainToss Simple Coin Flip
 * @author
 * Aniruddha Porey (demo version)
 *
 * @notice Beginner-friendly on-chain coin flip (no external inputs needed).
 */

contract ChainToss {
    uint256 public betAmount = 0.01 ether; // fixed bet
    address public lastPlayer;
    bool public lastGuess;
    bool public lastResult;
    string public outcomeText;

    event CoinFlipped(address indexed player, bool guess, bool result, string outcome);

    // Player flips a coin and sends exactly 0.01 ETH
    function flipCoin(bool _guess) external payable {
        require(msg.value == betAmount, "Must send exactly 0.01 ETH");

        // Generate pseudo-random number (unsafe for real use)
        uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, block.prevrandao)));
        bool result = random % 2 == 0; // true = Heads, false = Tails

        lastPlayer = msg.sender;
        lastGuess = _guess;
        lastResult = result;
        outcomeText = result ? "Heads" : "Tails";

        if (result == _guess) {
            payable(msg.sender).transfer(msg.value * 2); // winner gets double
        }

        emit CoinFlipped(msg.sender, _guess, result, outcomeText);
    }

    // Allow contract to receive ETH for payouts
    receive() external payable {}

    // View contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
