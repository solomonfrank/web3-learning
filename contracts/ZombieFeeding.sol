// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {

    KittyInterface kittyinterface;
    function setKittyContractAddress(address _address) external {
        kittyinterface = KittyInterface(_address);
    }
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage zombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (_targetDna + zombie.dna) / 2;
        
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
        _createZombies("NoName", newDna);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,, kittyDna) = kittyinterface.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}

interface KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
);
}

