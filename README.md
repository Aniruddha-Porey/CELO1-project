# 🪙 ChainToss — Simple On-Chain Coin Flip


---
<img width="1547" height="880" alt="image" src="https://github.com/user-attachments/assets/4cde8d52-ad50-431f-a499-5dbb2f5928b0" />


## 📖 Project Description

**ChainToss** is a simple demo smart contract built in Solidity that simulates a **coin flip game** directly on-chain.
Players can send a fixed bet amount (0.01 ETH) and guess **Heads or Tails**.
The contract then generates a pseudo-random result, and if the player guesses correctly, they instantly **win double their bet!**

This project is designed as an **educational example** — ideal for Solidity beginners who want to learn about:

* Payable functions
* Events
* Randomness (and its limitations on-chain)
* ETH transfers and balances

---

## ⚙️ What It Does

1. Players call the `flipCoin()` function and send exactly **0.01 ETH**.
2. They provide their guess (`true` for Heads, `false` for Tails).
3. The contract generates a pseudo-random result using block data.
4. If the player’s guess matches the result:

   * They **receive double** their bet back.
   * The outcome is recorded and emitted as an event.
5. The contract keeps track of the last player, their guess, and the outcome.

---

## 🌟 Features

* 🔒 **Fixed bet amount:** 0.01 ETH to keep things simple and fair.
* ⚡ **Instant payouts:** Winners are paid automatically.
* 📜 **Event logging:** Every coin flip is recorded on the blockchain with details.
* 💰 **Balance tracking:** Anyone can view the contract’s total ETH balance.
* 🧩 **Beginner-friendly:** Uses simple Solidity logic and clear variable naming.

> ⚠️ **Note:** Randomness in this contract is *not secure* and should **not** be used for real betting or production environments. This is a demo for learning purposes only.

---

## 🚀 Deployed Smart Contract

**Network:** [Testnet/Mainnet as applicable]
**Contract Address:** `XXX`

---

## 🧠 Code

Below is the complete Solidity source code for the contract:

```solidity

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

```

---

## 🧩 Author

👨‍💻 **Aniruddha Porey**
Demo version — for educational and experimental use.

---

## 🏗️ How to Use

1. Deploy the contract in Remix IDE (Solidity ^0.8.19).
2. Fund the contract with some ETH to allow payouts.
3. Call `flipCoin(true)` or `flipCoin(false)` with exactly **0.01 ETH**.
4. Check transaction logs or call the `outcomeText()` function to see the result.
5. Use `getBalance()` anytime to view contract funds.

---

## 🧾 License

This project is licensed under the **MIT License** — feel free to learn, modify, and build upon it.

---

🪙 *“Sometimes you win, sometimes you learn.”*
