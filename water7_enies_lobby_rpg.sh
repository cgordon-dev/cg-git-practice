#!/bin/bash

# Welcome message
echo "Welcome to the Water 7 and Enies Lobby RPG!"
echo "You're about to embark on an adventure with the Straw Hat Pirates."
echo "Choose wisely, as your decisions will affect the outcome of your journey."
echo "Let's begin!"

# Introduction
echo -e "\nYou and the Straw Hat Pirates arrive at Water 7, a city known for its shipwrights."
echo "Your ship, the Going Merry, is in need of repairs."
echo "Do you want to (1) Visit Dock 1 to find a shipwright or (2) Explore the city first?"

# First choice
read -p "Enter your choice (1 or 2): " choice1

if [ "$choice1" -eq 1 ]; then
    echo -e "\nYou head to Dock 1 and meet the legendary shipwrights of Galley-La Company."
    echo "You ask them to repair the Going Merry, but they reveal that the ship is beyond repair."
    echo "The news devastates the crew, but you realize that you must move forward."
else
    echo -e "\nYou decide to explore the city first. As you walk through Water 7, you hear rumors about a powerful group called CP9."
    echo "You also learn that Nico Robin has disappeared."
    echo "The crew decides to investigate, leading them to Dock 1."
fi

# Second choice
echo -e "\nAs you investigate, you learn that Robin has been taken by CP9 to Enies Lobby, a government stronghold."
echo "Do you (1) Plan a stealthy rescue mission or (2) Launch a full-scale attack on Enies Lobby?"

read -p "Enter your choice (1 or 2): " choice2

if [ "$choice2" -eq 1 ]; then
    echo -e "\nYou decide to plan a stealthy rescue mission. The crew sneaks into Enies Lobby under the cover of night."
    echo "You manage to avoid most of the guards, but eventually, you're discovered, and a fierce battle ensues."
else
    echo -e "\nYou choose to launch a full-scale attack on Enies Lobby. The crew fights their way through countless Marines and CP9 agents."
    echo "The battle is intense, but your determination never wavers."
fi

# Final choice
echo -e "\nAfter a long and arduous battle, you finally reach Nico Robin. She's being held by CP9's leader, Spandam."
echo "Do you (1) Fight Spandam yourself or (2) Let Luffy handle the fight while you free Robin?"

read -p "Enter your choice (1 or 2): " choice3

if [ "$choice3" -eq 1 ]; then
    echo -e "\nYou face Spandam in a one-on-one fight. Though he's no match for your skills, he tries to stall you with underhanded tactics."
    echo "In the end, you defeat Spandam and free Robin yourself. The crew reunites, and you escape Enies Lobby together."
else
    echo -e "\nYou let Luffy take on Spandam while you free Robin. Luffy quickly defeats Spandam with his Gear Second technique."
    echo "With Robin safe, the crew makes their daring escape from Enies Lobby."
fi

# Conclusion
echo -e "\nCongratulations! You successfully completed the Water 7 and Enies Lobby arc."
echo "The Straw Hat Pirates are stronger than ever, and Nico Robin has rejoined the crew."
echo "Your journey continues as you sail towards new adventures in the Grand Line."

# End of game
echo -e "\nThank you for playing! Goodbye."
