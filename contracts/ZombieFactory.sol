// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Ownable.sol";

contract ZombieFactory is Ownable {
        uint dnaDigits = 16;
        uint dnaModulus = 10 ** dnaDigits;
        uint coolDownTime = 1 days;

        struct Zombie {
            string name;
            uint dna;
            uint32 readyTime;
            uint32 level;
        }

        event NewZombie(uint zombieId, string name, uint dna);
        Zombie[] public zombies;
        mapping (uint => address) public zombieToOwner;
        mapping(address => uint) ownerZombieCount;

        function _createZombies(string memory _name, uint _dna) internal {
            zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + coolDownTime)));
            uint id = zombies.length - 1;
            zombieToOwner[id] = msg.sender;
            ownerZombieCount[msg.sender]++;
            emit NewZombie(zombies.length - 1, _name, _dna);
        }
            // start here
        function _generateRandomDna(string memory _str) public view returns (uint) {
            uint rand = uint(keccak256(abi.encodePacked(_str)));
            return rand % dnaModulus;
        }
        function createRandomZombie(string memory _name) public {
            require( ownerZombieCount[msg.sender] == 0);
            uint randDna = _generateRandomDna(_name);
            _createZombies(_name, randDna);
    }
}