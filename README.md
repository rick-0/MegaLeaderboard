# MegaLeaderboard

Repo for (the poorly named) ranking leaderboard for use in games (specifically a game called Inertial Drift)

## What is the application?

Games and other applications which have a competitive element to them often rely on leaderboard functionality to display a users rank versus other users in the system.
The game Inertial Drift is a unique racing game in which players can choose from a variety of cars with different handling to compete and post times to a leaderboard.
The leaderboard is currently lacking in features such as locality ranking (showing users with a score close to you) and doesn't allow for players to race against others players 'ghosts'.
It also doesn't allow for the automatic generation of weekly player challenges and leaderboards to match.
Many generic leaderboard solutions exist but don't offer the flexibility and additional features required for Inertial Drift to provide the player with all of the stats relevant to the game.
 
## Why?

This will provide much more meaningful data to the player and will allow for the game to generate content without the oversight of a developer thus prolonging player engagement.

## How?

A player will be automatically logged in by the game based on the platform the player is using such as steam/playstation/xbox/epic etc.
When a player completes a track, their race ghost will be uploaded to the API which will then parse the ghost data and place it into the relevant ranking leaderboard.

## MVP

- Ranking Leaderboards
  - Locality
  - Friend
  - Regional
  - Track
  - Car
- Ability to check a users rank across multiple boards in one request
- Filter rankings by platform (playstation/xbox/steam/etc)
- Ghost Storage

## Stretch

- Community challenge generation
	- Endpoint to generate the challenege based on set of parameters (Track?, Car?, Gamemode?)
- Friend challenges
	- Create a challenge, similar to community challenge but only friends can do it
- Storage for additional metrics
  - Aggregate Metrics (Time spent drifting, number of tracks raced etc)
  
## Dictionary of Terms
Track - A race track that the users will race on and record a completion time.

Car - A car from the limited set of cars available to the user.

Ghost - The positional and chronological recording of a user's race on a specific track. It records positions in a Vector3 format.

Ranking - A user's race time (or other metric) specific to one track, compared with those of others users.

Locality Ranking - The rankings of other users close to the ranking of that user.

Friend Ranking - The rankings of a user's friends relative to the ranking of that user.

Regional Ranking - The ranking of other users in the same regional area as that user.
  
## Domain Model
``` mermaid
%%{init: {'theme':'neutral'}}%%
erDiagram
    Ranking ||--|| Leaderboard : ""
    Ghost ||--|| Ranking : ""
    Player ||--|| Ranking : ""
    Friend ||--|| Player : ""
    Challenge ||--|| Leaderboard : ""
    Car ||--|| Ghost : ""
    Track ||--|| Ghost : ""
    Platform ||--|| Ranking : ""

```

## Entity-Relationship Diagram
``` mermaid
%%{init: {'themeVariables': { 'darkMode': true }}}%%
erDiagram
    User ||--|{ Player : ""
    Player ||--|{ Race : ""
    Platform ||--|| Player : ""
    PlayerFriend }o--|{ Player : ""
    Ghost ||--|| Race : ""
    Race ||--|| RaceDetail : ""
    Ghost ||--|| Car : ""
    Ghost ||--|| Track : ""
    Leaderboard ||--|{ Race : ""   

    User {
        serial id PK
    }
    Player {
        serial id PK
        serial user_id FK
        serial platform_id FK
        text display_name
    }
    Platform {
        serial id PK
        text name
    }
    PlayerFriend {
        serial id PK
        serial player_id FK
    }
    Ghost {
        serial id PK
        serial car_id FK
        serial track_id FK
        UUID ghost_storage_id
    }
    RaceDetail {
        serial id PK
        decimal time_elapsed
        decimal score
    }
    Race {
        serial id PK
        serial leaderboard_id FK
        serial player_id FK
    }
    Car {
        serial id PK
        text name
    }
    Track {
        serial id PK
        text name
    }
    Leaderboard {
        serial id PK
        text name
        int type
    }
```
