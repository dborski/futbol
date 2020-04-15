# Fútbol
​
This is the first group project of module 1 for the backend program at Turing School of Software and Design
​
### Group Members:
Whitney Kidd  
Derek Borski  
Norma Lopez  
Kyle Iverson
​
### Organization of Project
​
Our strategy was to organize our classes in the following format:
​
#### Object Classes
1. Game class
  * Defines Game objects from row objects that were created from csv
2. Team class
  * Defines Team objects from row objects that were created from csv
3. GameTeam class
  * Defines GameTeam objects from row objects that were created from csv
​
#### Stats Collection Classes
1. LeagueStats class
  * Houses all methods for league statistics in fútbol league
2. SeasonStats class
  * Houses all methods for season statistics in fútbol league
3. TeamStats class
  * Houses all methods for team statistics in fútbol league
4. GameStats class
  * Houses all methods for game statistics in fútbol league
​
#### Stats Class
StatTracker class - All of our stats methods run on this one class
​
#### Modules:
​
1. Collectable
  * This module creates all of our objects from the csv files, which we've incorporated into all of our stats collection classes
2. Mathable
  * This module contains **percentage** and **average** methods which we've incorporated everywhere in our project that does these calculations
