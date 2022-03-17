// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ZombieFactory {
        uint dnaDigits = 16;
        uint dnaModulus = 10 ** dnaDigits;

        struct Zombie {
            string name;
            uint dna;
        }

        event NewZombie(uint zombieId, string name, uint dna);
        Zombie[] public zombies;
        mapping (uint => address) public zombieToOwner;
        mapping(address => uint) ownerZombieCount;

        function _createZombies(string memory _name, uint _dna) internal {
            zombies.push(Zombie(_name, _dna));
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