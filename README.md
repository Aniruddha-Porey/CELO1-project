# 🪙 ChainToss — Simple On-Chain Coin Flip

---

## 📖 Project Description

**ChainToss** is a simple demo smart contract built in Solidity that simulates a **coin flip game** directly on-chain.
Players send a fixed bet amount (**0.01 ETH**) and guess **Heads or Tails**.
The contract then generates a pseudo-random result — if the player guesses correctly, they **instantly win double their bet!**

This project serves as an **educational example**, ideal for beginners learning:

* Payable functions
* Events
* Randomness (and its limitations on-chain)
* ETH transfers and balance handling

---

## ⚙️ What It Does

1. Player calls `flipCoin()` and sends **0.01 ETH**.
2. Provides their guess (`true` = Heads, `false` = Tails).
3. Contract uses block data to generate a pseudo-random result.
4. If guess matches the result:

   * Player receives **2×** their bet.
   * The outcome is logged as an event.
5. Last player, guess, and result are recorded on-chain.

---

## 🌟 Features

* 🔒 **Fixed bet amount:** 0.01 ETH for simplicity and fairness.
* ⚡ **Instant payouts:** Winners are paid automatically.
* 📜 **Event logging:** Each coin flip emits a detailed event.
* 💰 **Balance tracking:** Check total contract ETH anytime.
* 🧩 **Beginner-friendly:** Clean Solidity logic with clear naming.

> ⚠️ **Note:** Randomness here is *not secure* — for learning only, not real betting or production.

---

## 🧰 Tech Stack

* Solidity ^0.8.19
* Ethereum (Testnet: Sepolia)
* Remix IDE
* MetaMask
* Etherscan (for verification)

---

## 🚀 Deployed Smart Contract

**Network:** Sepolia Testnet
**Contract Address:** `0x46e10eC1502680F772e4643eD671082f0c925Ae6`

![Contract Screenshot](https://github.com/user-attachments/assets/4cde8d52-ad50-431f-a499-5dbb2f5928b0)

---

## 🧠 Code

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

## 🎮 Try It Out

1. Open [Remix IDE](https://remix.ethereum.org/)
2. Paste the code into a new Solidity file.
3. Deploy using **Injected Provider (Sepolia)** from MetaMask.
4. Fund the contract with ETH.
5. Call `flipCoin(true)` or `flipCoin(false)` with **0.01 ETH**.
6. View the result in transaction logs or via `outcomeText()`.
7. Use `getBalance()` to check total contract funds.

---

## 🔮 Future Improvements

* Integrate **Chainlink VRF** for true randomness
* Add **multi-player and leaderboard** features
* Build a **frontend UI** (React + Ethers.js)
* Include **owner withdrawal** and **pause/resume** functionality

---

## 🧩 Author

👨‍💻 **Aniruddha Porey**
Demo version — for educational and experimental use only.

---

## 🧾 License

This project is licensed under the **MIT License** — feel free to learn, modify, and build upon it.

---

🪙 *“Sometimes you win, sometimes you learn.”*
