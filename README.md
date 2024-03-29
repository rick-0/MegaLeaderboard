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
%%{init: {'theme':'neutral'}}%%
erDiagram
    platform_steam_player ||--|| player : ""
    platform_xbox_player ||--|| player : ""
    platform_playstation_player ||--|| player : ""
    platform_switch_player ||--|| player : ""
    platform_epic_player ||--|| player : ""
    platform_player_friend ||--|{ player : ""
    player ||--|{ race : ""
    ghost ||--|| race : ""
    race ||--|| race_detail_time : ""
    race }|--|| car : ""
    race }|--|| track : ""

    player {
        serial id PK
	timestamp timestamp_created
    }
    platform_player_friend {
        int id PK
	int player_id FK
        int player_friend_id FK
    }
    platform_steam_player {
        text platform_player_id PK
        text display_name
	    int player_id FK
    }
    platform_xbox_player {
        text platform_player_id PK
        text display_name
	    int player_id FK
    }
    platform_playstation_player {
        text platform_player_id PK
        text display_name
	    int player_id FK
    }
    platform_switch_player {
        text platform_player_id PK
        text display_name
	    int player_id FK
    }
    platform_epic_player {
        text platform_player_id PK
        text display_name
	    int player_id FK
    }
    race {
        serial id PK
        int player_id FK
        int car_id FK
        int track_id FK
        timestamp timestamp_finished
    }
    race_detail_time {
        int race_id FK
        decimal time_elapsed
    }
    ghost {
        serial id PK
        int race_id FK
        text binary_data
    }
    car {
        serial id PK
        text name
    }
    track {
        serial id PK
        text name
    }
```

```mermaid
%%{init: {'theme':'neutral'}}%%
erDiagram
    platform ||--|{ platform_player : ""
    player ||--|{ platform_player : ""
    platform_player_friend ||--|{ player : ""
    player ||--|{ race : ""
    ghost ||--|| race : ""
    race ||--|| race_detail_time : ""
    race }|--|| car : ""
    race }|--|| track : ""

    player {
        serial id PK
	    timestamp timestamp_created
    }
    platform {
        serial id PK
        text name
    }
    platform_player {
        serial id PK
        int platform_id FK
        int player_id FK
    }
    platform_player_friend {
        int id PK
	    int player_id FK
        int player_friend_id FK
    }
    race {
        serial id PK
        int player_id FK
        int car_id FK
        int track_id FK
        timestamp timestamp_finished
    }
    race_detail_time {
        int race_id FK
        decimal time_elapsed
    }
    ghost {
        serial id PK
        int race_id FK
        text binary_data
    }
    car {
        serial id PK
        text name
    }
    track {
        serial id PK
        text name
    }
```

## API Specification

### Races
<details><summary>GET /platforms/{platform}/races</summary>
<p>

Parameters:
- track={track_id}
- car={car_id}
	
Return a list of the races for the a platform (order by time_elapsed) given a car_id and track_id

Response `200 OK`

```json
[
  {
    "id": 1,
    "time_elapsed": 60.5,
    "ghost_id": 1,
    "track": {
      "id": "1",
	  "name": "track1"
    },
    "car": {
      "id": "1",
	  "name": "car1"
    },
    "player": {
    	"id": "1",
	  "platform_player_id": ABCDXYZ123,
	  "display_name": "Player123"
    }
  }
]
```

</p>
</details>

<details><summary>POST /platforms/{platform}/races</summary>
<p>
	
Create a new race with the following attributes.

Request
```json
{
  "player_id": "1",
  "track_id": "1",
  "car_id": "1",
  "elapsed_time": 60.5
}
```
	
Response `201 Created`

</p>
</details>

---

### Players

<details><summary>GET /players/{player_id}</summary>
<p>
	
Get the details of a player specified by their id
	
Response `200 OK`
	
```json
{
  "id": 1,
  "timestamp_created": ""
}
```
	
</p>
</details>

<details><summary>GET /platforms/{platform}/players/{platform_player_id}</summary>
<p>
	
Get the details of a player specified by their platform specific id
	
Response `200 OK`
	
```json
{
  "id": 1,
  "platform_player_id": ABCDXYZ123,
  "display_name": "Player123"
}
```
	
</p>
</details>

<details><summary>POST /platforms/{platform}/players</summary>
<p>
	
Create a new player with the following attributes

Request
```json
{
  "platform_player_id": ABCDXYZ123,
  "display_name": "Player123"
}
```

Response `201 Created`

</p>
</details>

---

### Ghosts

<details><summary>GET /platforms/{platform}/ghosts/{ghost_id}</summary>
<p>

Get the details of a ghost by id
	
Response `200 OK`
	
```json
{
  "id": 1,
  "race_id": 1,
  "binary_data": "123456789"
}
```

</p>
</details>

<details><summary>POST /platforms/{platform}/ghosts</summary>
<p>
	
Create a new ghost with the following attributes.

Request
```json
{
  "race_id": 1,
  "binary_data": "123456789"
}
```

Response `201 Created`

</p>
</details>

---

### Friend

<details><summary>GET /platforms/{platform}/friends/{player_id}</summary>
<p>

Get the friends of a player specified by player_id
	
Response `200 OK`
	
```json
[
  {
    "id": 1,
    "platform_player_id": ABCDXYZ123,
    "display_name": "Player123"
  },
    {
    "id": 2,
    "platform_player_id": ABCDXYZ678,
    "display_name": "Player678"
  }
]
```

</p>
</details>

<details><summary>POST /platforms/{platform}/friends/{player_id}</summary>
<p>
	
Associate a player with other players as friends specified by player_id

Request
```json
[
  {
    "player_friend_id": 2
  },
  {
    "player_friend_id": 3
  }
]
```

Response `201 Created`

</p>
</details>

<details><summary>DELETE /platforms/{platform}/friends/{player_id}</summary>
<p>
	
Delete players associated with a player as friends specified by player_id

Request
```json
[
  {
    "player_friend_id": 2
  },
  {
    "player_friend_id": 3
  }
]
```

Response `201 Created`

</p>
</details>
