INSERT INTO car
    (id, name)
values
    (1, 'car1'),
    (2, 'car2'),
    (3, 'car3');

INSERT INTO track
    (id, name)
values
    (1, 'track1'),
    (2, 'track2'),
    (3, 'track3');

INSERT INTO player
values
    (default),
    (default),
    (default),
    (default);

insert into platform_player_friend
(player_id, player_friend_id)
values
    (1, 4);

insert into platform_steam_player
    (platform_player_id, display_name, player_id)
values
    ('steam_123', 'mr. player', 1),
    ('steam_456', 'racer', 4);

insert into platform_xbox_player
    (platform_player_id, display_name, player_id)
values
    ('xb_7fg8d', 'IAmNumberOne', 1);

insert into platform_playstation_player
    (platform_player_id, display_name, player_id)
values
    ('ps_abc1', 'playstation_king', 1);

INSERT INTO race
(player_id, track_id, car_id, timestamp_finished)
values
    (1, 1, 1, '2023-01-15 13:30:00'),
    (2, 1, 1, '2023-01-16 13:30:00'),
    (3, 1, 1, '2023-01-16 14:30:00'),
    (1, 2, 3, '2023-01-15 13:30:00'),
    (2, 2, 3, '2023-01-17 13:30:00'),
    (2, 2, 3, '2023-01-18 13:30:00'),
    (2, 3, 1, '2023-01-17 13:30:00'),
    (3, 3, 1, '2023-01-17 13:31:00'),
    (1, 1, 1, '2023-01-17 13:30:00');

INSERT INTO race_detail_time
(race_id, time_elapsed)
values
    (1, 60),
    (2, 70),
    (3, 65),
    (4, 200),
    (5, 210),
    (6, 195),
    (7, 120),
    (8, 120),
    (9, 63);

insert into ghost
(race_id, binary_data)
values
    (1, ''),
    (2, ''),
    (3, ''),
    (4, ''),
    (5, ''),
    (6, ''),
    (7, ''),
    (8, ''),
    (9, '');

--select setval(pg_get_serial_sequence('track', 'id'), max(id))
--from track;

--select nextval(pg_get_serial_sequence('player', 'id'))
--select currval(pg_get_serial_sequence('player', 'id'))