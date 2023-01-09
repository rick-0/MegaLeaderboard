CREATE TABLE player (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY not null,
    timestamp_created timestamp default CURRENT_TIMESTAMP not null
);

CREATE TABLE platform_steam_player (
    platform_player_id text PRIMARY KEY not null,
    display_name text not null,
    player_id int not null,

    CONSTRAINT fk__platform_steam_player__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE platform_xbox_player (
    platform_player_id text PRIMARY KEY not null,
    display_name text not null,
    player_id int not null,

    CONSTRAINT fk__platform_xbox_player__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE platform_playstation_player (
    platform_player_id text PRIMARY KEY not null,
    display_name text not null,
    player_id int not null,

    CONSTRAINT fk__platform_playstation_player__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE platform_switch_player (
    platform_player_id text PRIMARY KEY not null,
    display_name text not null,
    player_id int not null,

    CONSTRAINT fk__platform_switch_player__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE platform_epic_player (
    platform_player_id text PRIMARY KEY not null,
    display_name text not null,
    player_id int not null,

    CONSTRAINT fk__platform_epic_player__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE platform_player_friend (
    player_id int not null,
    player_friend_id int not null,

    CONSTRAINT fk__platform_player_friend__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id),
    CONSTRAINT fk__platform_player_friend__player_friend_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id)
);

CREATE TABLE car (
    id int PRIMARY KEY not null,
    name text not null
);

CREATE TABLE track (
    id int PRIMARY KEY not null,
    name text not null
);

CREATE TABLE race (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY not null,
    player_id int not null,
    track_id int not null,
    car_id int not null,
    timestamp_finished timestamp not null,

    CONSTRAINT fk__race__player_id__player__id FOREIGN KEY (player_id)
        REFERENCES player(id),
    CONSTRAINT fk__race__track_id__track__id FOREIGN KEY (track_id)
        REFERENCES track(id),
    CONSTRAINT fk__race__car_id__car__id FOREIGN KEY (car_id)
        REFERENCES car(id)
);

CREATE TABLE race_detail_time (
    race_id int not null,
    time_elapsed decimal not null,

    CONSTRAINT fk__race_detail_time__race_id__race__id FOREIGN KEY (race_id)
        REFERENCES race(id)
);

CREATE TABLE ghost (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY not null,
    race_id int not null,
    binary_data text null,

    CONSTRAINT fk__ghost__race_id__race__id FOREIGN KEY (race_id)
        REFERENCES race(id)
);