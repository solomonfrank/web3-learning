// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage zombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (_targetDna + zombie.dna) / 2;
        _createZombies("NoName", newDna);
    }
}

