#!/bin/bash

# Initialize variables
player_hp=100
crew_hp=100
robin_rescued=false
merry_lost=false
franky_joined=false
usopp_returned=false
cp9_defeated=false
franky_save_triggered=false

# Function to simulate a dice roll (1-20)
roll_dice() {
    echo $(( RANDOM % 20 + 1 ))
}

# Function to handle combat
combat() {
    local damage=$(( RANDOM % 20 + 5 ))
    echo "You take $damage damage."
    player_hp=$(( player_hp - damage ))
    if [ $player_hp -le 0 ]; then
        echo "You have been defeated!"
        exit 1
    else
        echo "Your current HP: $player_hp"
    fi
}

# Hidden Franky save function
franky_save() {
    local roll=$(roll_dice)
    if [ "$roll" -ge 18 ]; then
        echo -e "\nFranky unexpectedly shows up and assists you!"
        echo "With Franky's help, you avoid the worst damage and gain the upper hand."
        player_hp=$(( player_hp + 20 ))  # Franky's help restores some HP
        franky_save_triggered=true
        echo "Your current HP: $player_hp"
    fi
}

# Welcome message
echo "Welcome to the Water 7 and Enies Lobby RPG!"
echo "You're about to embark on an adventure with the Straw Hat Pirates."
echo "Your choices will shape the fate of your crew."
echo "Let's begin!"

# Introduction
echo -e "\nYou and the Straw Hat Pirates arrive at Water 7, a city known for its shipwrights."
echo "Your ship, the Going Merry, is in need of repairs."

# First choice
echo "Do you want to (1) Visit Dock 1 to find a shipwright or (2) Explore the city first?"

read -t 10 -p "Enter your choice (1 or 2): " choice1

if [ -z "$choice1" ]; then
    echo -e "\nTime's up! You default to visiting Dock 1."
    choice1=1
fi

if [ "$choice1" -eq 1 ]; then
    echo -e "\nYou head to Dock 1 and meet the shipwrights of Galley-La Company."
    echo "They assess the Going Merry and reveal that it is beyond repair."
    merry_lost=true
    echo "This news hits Usopp hard, and he leaves the crew in anger."
else
    echo -e "\nYou decide to explore the city. As you wander, you encounter a masked figure."
    echo "It's Kaku from CP9! He challenges you to a fight."
    echo "Rolling for initiative..."
    roll=$(roll_dice)
    echo "You rolled a $roll."

    if [ $roll -ge 10 ]; then
        echo "You dodge his attack and counter with your own!"
        echo "Kaku retreats, but the fight has left you injured."
        combat
    else
        echo "Kaku strikes first! You're injured but manage to escape."
        combat
    fi
    franky_save  # Hidden chance for Franky to help out
    echo "You later meet the shipwrights and learn that the Going Merry is beyond repair."
    merry_lost=true
    echo "Usopp, devastated, leaves the crew after a heated argument."
fi

# Second choice - Usopp's Return
echo -e "\nUsopp has left the crew. Do you (1) Try to convince Usopp to return or (2) Respect his decision and move on?"

read -t 10 -p "Enter your choice (1 or 2): " choice2

if [ -z "$choice2" ]; then
    echo -e "\nTime's up! You default to respecting his decision."
    choice2=2
fi

if [ "$choice2" -eq 1 ]; then
    echo -e "\nYou find Usopp and manage to convince him to return after a heartfelt conversation."
    usopp_returned=true
else
    echo -e "\nYou respect Usopp's decision. The crew is saddened, but they continue their journey without him."
    usopp_returned=false
fi

# Third choice - Franky
echo -e "\nYou learn that Franky, the leader of the Franky Family, has connections with CP9."
echo "Do you (1) Confront Franky directly or (2) Try to form an alliance with him?"

read -t 10 -p "Enter your choice (1 or 2): " choice3

if [ -z "$choice3" ]; then
    echo -e "\nTime's up! You default to forming an alliance."
    choice3=2
fi

if [ "$choice3" -eq 1 ]; then
    echo -e "\nYou confront Franky, leading to a battle between his gang and your crew."
    echo "Rolling for combat..."
    roll=$(roll_dice)
    echo "You rolled a $roll."

    if [ $roll -ge 12 ]; then
        echo "You defeat Franky, but he respects your strength and decides to join forces with you."
        franky_joined=true
    else
        echo "Franky escapes, and you lose the chance to form an alliance."
    fi
else
    echo -e "\nYou approach Franky and propose an alliance. After some negotiation, Franky agrees to help you."
    franky_joined=true
fi

# Fourth choice - Gathering Allies
echo -e "\nAs you prepare to rescue Robin from CP9, you realize you need more allies."
echo "Do you (1) Seek out the Galley-La foremen or (2) Ask the Franky Family for help?"

read -t 10 -p "Enter your choice (1 or 2): " choice4

if [ -z "$choice4" ]; then
    echo -e "\nTime's up! You default to asking the Franky Family."
    choice4=2
fi

if [ "$choice4" -eq 1 ]; then
    if [ "$franky_joined" = true ]; then
        echo -e "\nWith Franky's help, you manage to convince the Galley-La foremen to join your cause."
        crew_hp=$(( crew_hp + 20 ))
        echo "Your crew's strength has increased!"
    else
        echo -e "\nWithout Franky, the Galley-La foremen refuse to help you."
        echo "You must face CP9 with only your current allies."
    fi
else
    if [ "$franky_joined" = true ]; then
        echo -e "\nThe Franky Family joins you, providing additional support during the rescue mission."
        crew_hp=$(( crew_hp + 20 ))
        echo "Your crew's strength has increased!"
    else
        echo -e "\nWithout Franky, the Franky Family is hesitant to help, but they agree to provide minor assistance."
    fi
fi

# Fifth choice - The Rescue Mission
echo -e "\nIt's time to execute your plan to rescue Robin from Enies Lobby."
echo "Do you (1) Attack the main gate head-on or (2) Use the Sea Train to launch a surprise attack?"

read -t 10 -p "Enter your choice (1 or 2): " choice5

if [ -z "$choice5" ]; then
    echo -e "\nTime's up! You default to attacking the main gate."
    choice5=1
fi

if [ "$choice5" -eq 1 ]; then
    echo -e "\nYou launch a full-scale attack on the main gate. The battle is intense, and your crew takes heavy damage."
    combat
    franky_save  # Hidden chance for Franky to help out
    if [ $player_hp -gt 0 ]; then
        echo "Despite the injuries, you break through the gate and reach Robin."
        robin_rescued=true
    else
        echo "You fall in battle, and Robin remains captive. The mission fails."
        exit 1
    fi
else
    echo -e "\nYou use the Sea Train to launch a surprise attack, catching the enemy off guard."
    echo "Rolling for success..."
    roll=$(roll_dice)
    echo "You rolled a $roll."

    if [ $roll -ge 10 ]; then
        echo "Success! You reach Robin with minimal resistance."
        robin_rescued=true
    else
        echo "Failure! The Sea Train derails, leading to a chaotic battle."
        combat
        franky_save  # Hidden chance for Franky to help out
        if [ $player_hp -gt 0 ]; then
            echo "Despite the chaos, you manage to rescue Robin."
            robin_rescued=true
        else
            echo "You fall in battle, and Robin remains captive. The mission fails."
            exit 1
        fi
    fi
fi

# Final choice - CP9 Showdown
echo -e "\nYou finally confront CP9 at the Tower of Justice."
echo "Do you (1) Challenge Lucci, the strongest CP9 member, or (2) Focus on freeing Robin while the crew handles CP9?"

read -t 10 -p "Enter your choice (1 or 2): " choice6

if [ -z "$choice6" ]; then
    echo -e "\nTime's up! You default to freeing Robin."
    choice6=2
fi

if [ "$choice6" -eq 1 ]; then
    echo -e "\nYou bravely challenge Lucci. The battle is fierce and could determine the fate of your crew."
    echo "Rolling for combat..."
    roll=$(roll_dice)
    echo "You rolled a $roll."

    if [ $roll -ge 15 ]; then
        echo "You defeat Lucci in an epic showdown, securing victory for your crew."
        cp9_defeated=true
    else
        echo "Lucci overpowers you. The crew loses morale, but they continue to fight."
        combat
        franky_save  # Hidden chance for Franky to help out
        if [ $player_hp -gt 0 ]; then
            echo "Despite your loss, the crew manages to rescue Robin and escape."
            robin_rescued=true
        else
            echo "You fall in battle, and the mission fails."
            exit 1
        fi
    fi
else
    echo -e "\nYou focus on freeing Robin while your crew battles CP9."
    echo "Rolling for success..."
    roll=$(roll_dice)
    echo "You rolled a $roll."

    if [ $roll -ge 12 ]; then
        echo "Success! You free Robin, and the crew manages to escape with her."
        robin_rescued=true
    else
        echo "Failure! The crew is overwhelmed by CP9, but you still manage to escape with Robin."
        combat
        franky_save  # Hidden chance for Franky to help out
        if [ $player_hp -gt 0 ]; then
            echo "You escape, but the crew is injured, and CP9 remains undefeated."
        else
            echo "You fall in battle, and the mission fails."
            exit 1
        fi
    fi
fi

# Conclusion
if [ "$robin_rescued" = true ]; then
    echo -e "\nCongratulations! You successfully rescued Nico Robin."
else
    echo -e "\nYou failed to rescue Nico Robin. The crew is devastated, but they vow to continue their journey."
fi

if [ "$merry_lost" = true ]; then
    echo "The Going Merry could not be saved, but its spirit will live on in your hearts."
else
    echo "Against all odds, the Going Merry is repaired, and you continue your adventure."
fi

if [ "$franky_joined" = true ]; then
    echo "Franky decides to join your crew, bringing his shipbuilding skills with him."
else
    echo "Without Franky's help, the crew faces more challenges ahead."
fi

if [ "$usopp_returned" = true ]; then
    echo "Usopp has rejoined the crew, and his bravery inspires everyone."
else
    echo "Usopp remains estranged from the crew, a decision that haunts everyone."
fi

if [ "$cp9_defeated" = true ]; then
    echo "CP9 has been defeated, and the world government has suffered a major blow."
else
    echo "CP9 remains at large, a constant threat to your journey."
fi

# Hidden Franky Easter Egg Message
if [ $franky_save_triggered ]; then
    echo -e "\nEaster Egg: Franky came through in the clutch to save the day more than once!"
fi

# End of game
echo -e "\nThank you for playing! Goodbye."
