do language plpgsql $$

declare player_1_id integer;
declare player_2_id integer;
declare player_3_id integer;
declare player_4_id integer;

declare races_id integer;

begin

insert into car
    (id, name)
values
    (1, 'car1'),
    (2, 'car2'),
    (3, 'car3');

insert into track
    (id, name)
values
    (1, 'track1'),
    (2, 'track2'),
    (3, 'track3');

-- player 1
insert into player
values
    (default) returning id into player_1_id;

insert into platform_steam_player
    (platform_player_id, display_name, player_id)
values
    ('steam_123', 'mr. player', player_1_id);

-- player 2
insert into player
values
    (default) returning id into player_2_id;

insert into platform_xbox_player
    (platform_player_id, display_name, player_id)
values
    ('xb_7fg8d', 'iamnumberone', player_2_id);

-- player 3
insert into player
values
    (default) returning id into player_3_id;

insert into platform_playstation_player
    (platform_player_id, display_name, player_id)
values
    ('ps_abc1', 'playstation_king', player_3_id);

-- player 4
insert into player
values
    (default) returning id into player_4_id;

insert into platform_steam_player
    (platform_player_id, display_name, player_id)
values
    ('steam_456', 'racer', player_4_id);

-- friends
insert into platform_player_friend
(player_id, player_friend_id)
values
    (player_1_id, player_4_id);

-- race 1
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_1_id, 1, 1, '2023-01-15 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 60);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 2
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_2_id, 1, 1, '2023-01-16 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 70);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 3
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_3_id, 1, 1, '2023-01-16 14:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 65);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 4
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_1_id, 2, 3, '2023-01-15 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 200);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 5
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_2_id, 2, 3, '2023-01-17 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 210);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 6
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_2_id, 2, 3, '2023-01-18 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 195);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 7
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_2_id, 3, 1, '2023-01-17 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 120);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 8
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_3_id, 3, 1, '2023-01-17 13:31:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 120);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

-- race 9
insert into race
(player_id, track_id, car_id, timestamp_finished)
values
    (player_1_id, 1, 1, '2023-01-17 13:30:00') returning id into races_id;
insert into race_detail_time
(race_id, time_elapsed)
values
    (races_id, 63);
insert into ghost
(race_id, binary_data)
values
    (races_id, '');

end;
$$;