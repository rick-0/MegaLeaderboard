# MegaLeaderboard
A leaderboard solution for a game Inertial Drift to provide users with their rank versus others with associated metrics and stats.

## Problem Statement
Problem
Games and other applications which have a competitive element to them often rely on leaderboard functionality to display a users rank versus other users in the system.
Many generic leaderboard solutions exist but don't offer the flexibility and additional features required for Inertial Drift to provide the user with relevant statistics.
We will create a leaderboard that contains this set of features:
- Ranking
  - Locality
  - Friend
  - Regional
  - Track
  - Car
- Ability to check a users rank across multiple boards in one request
- Filter rankings by platform (playstation/xbox/steam/etc)
- Community challenge generation
	- Endpoint to generate the challenege based on set of parameters (Track?, Car?, Gamemode?)
- Friend challenges
	- Create a challenge, similar to community challenge but only friends can do it
- Ghost Storage
- Storage for additional metrics
  - Aggregate Metrics (Time spent drifting, number of tracks raced etc)
  - ???
- Authentication that can work with each of the platforms token services (If possible, need to research)

It must return users results with a response time lower than 10 seconds at the most and should cost less that X per month (???)

## Dictionary of Terms
Track - A race track that the users will race on and record a completion time.

Car - A car from the limited set of cars available to the user.

Ghost - The positional and chronological recording of a user's race on a specific track. It records positions in a Vector3 format.

Ranking - A user's race time (or other metric) specific to one track, compared with those of others users.

Locality Ranking - The rankings of other users close to the ranking of that user.

Friend Ranking - The rankings of a user's friends relative to the ranking of that user.

Regional Ranking - The ranking of other users in the same regional area as that user.
