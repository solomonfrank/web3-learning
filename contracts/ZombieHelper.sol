// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  // Start here
modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
    }
}