// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

interface IQuest {
    function startQuest() external;
    function completeQuest() external;
    function getReward() external;
}

contract QuestManager is IQuest{
    bool isQuestActive = false;
    uint completedQuests = 0;
    uint lvl = 1;
    uint rewardsCount = 0;
    function startQuest() external {
        if(!isQuestActive){
            isQuestActive = true;
        }
        else{
            console.log("You can't pick more quests you allready have one");
        }
    }
    function completeQuest() external{
        if(isQuestActive){
            isQuestActive = false;
            completedQuests++;
        }
        else{
            console.log("You can't complete the quest");
        }
    }
    function getReward() external{
        rewardsCount += 1 * completedQuests;
        lvl += 1 *  completedQuests;
    }
    function getStatus() external view {
        console.log("IsQuestActive: ", isQuestActive);
        console.log("CompletedQuests: ", completedQuests);
        console.log("lvl: ", lvl);
        console.log("Rewards: ", rewardsCount);
    }
}


library ResourceUtils{
    function distributeEnergy() external pure{
        console.log("The distribution of energy was quite good.");
    }
    function CostOfImprovements() external pure returns (uint){
        return 10000;
    }
    function OptimizeGoldPrive() external pure {
        console.log("Gold price optimized");
    }
}

contract ResourceManager{
    using ResourceUtils for ResourceManager;
    function distributeEnergy() external pure {
        ResourceUtils.distributeEnergy();
    }
    function CostOfImprovements() external pure returns(uint){
        return ResourceUtils.CostOfImprovements();
    }
    function OptimizeGoldPrive() external pure {
        ResourceUtils.OptimizeGoldPrive();
    }
}


