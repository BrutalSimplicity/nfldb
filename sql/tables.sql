DROP TABLE IF EXISTS play_player;
DROP TABLE IF EXISTS agg_play;
DROP TABLE IF EXISTS play;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS drive;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS meta;
DROP TABLE IF EXISTS game_phase;
DROP TABLE IF EXISTS game_day;

CREATE TABLE game_day (
  Day   TEXT PRIMARY KEY NOT NULL,
  Seq   INTEGER
);

INSERT INTO game_day VALUES
  ('Sunday', 1),
  ('Monday', 2),
  ('Tuesday', 3),
  ('Wednesday', 4),
  ('Thursday', 5),
  ('Friday', 6),
  ('Saturday', 7);


CREATE TABLE game_phase (
  Phase    TEXT PRIMARY KEY NOT NULL,
  Seq      INTEGER
);

INSERT INTO game_phase VALUES
  ('Pregame', 1),
  ('Q1', 2),
  ('Q2', 3),
  ('Half', 4),
  ('Q3', 5),
  ('Q4', 6),
  ('OT', 7),
  ('OT2', 8),
  ('Final', 9);


CREATE TABLE agg_play
(
  gsis_id gameid NOT NULL,
  drive_id usmallint NOT NULL,
  play_id usmallint NOT NULL,
  defense_ast smallint NOT NULL DEFAULT 0,
  defense_ffum smallint NOT NULL DEFAULT 0,
  defense_fgblk smallint NOT NULL DEFAULT 0,
  defense_frec smallint NOT NULL DEFAULT 0,
  defense_frec_tds smallint NOT NULL DEFAULT 0,
  defense_frec_yds smallint NOT NULL DEFAULT 0,
  defense_int smallint NOT NULL DEFAULT 0,
  defense_int_tds smallint NOT NULL DEFAULT 0,
  defense_int_yds smallint NOT NULL DEFAULT 0,
  defense_misc_tds smallint NOT NULL DEFAULT 0,
  defense_misc_yds smallint NOT NULL DEFAULT 0,
  defense_pass_def smallint NOT NULL DEFAULT 0,
  defense_puntblk smallint NOT NULL DEFAULT 0,
  defense_qbhit smallint NOT NULL DEFAULT 0,
  defense_safe smallint NOT NULL DEFAULT 0,
  defense_sk real NOT NULL DEFAULT 0.0,
  defense_sk_yds smallint NOT NULL DEFAULT 0,
  defense_tkl smallint NOT NULL DEFAULT 0,
  defense_tkl_loss smallint NOT NULL DEFAULT 0,
  defense_tkl_loss_yds smallint NOT NULL DEFAULT 0,
  defense_tkl_primary smallint NOT NULL DEFAULT 0,
  defense_xpblk smallint NOT NULL DEFAULT 0,
  fumbles_forced smallint NOT NULL DEFAULT 0,
  fumbles_lost smallint NOT NULL DEFAULT 0,
  fumbles_notforced smallint NOT NULL DEFAULT 0,
  fumbles_oob smallint NOT NULL DEFAULT 0,
  fumbles_rec smallint NOT NULL DEFAULT 0,
  fumbles_rec_tds smallint NOT NULL DEFAULT 0,
  fumbles_rec_yds smallint NOT NULL DEFAULT 0,
  fumbles_tot smallint NOT NULL DEFAULT 0,
  kicking_all_yds smallint NOT NULL DEFAULT 0,
  kicking_downed smallint NOT NULL DEFAULT 0,
  kicking_fga smallint NOT NULL DEFAULT 0,
  kicking_fgb smallint NOT NULL DEFAULT 0,
  kicking_fgm smallint NOT NULL DEFAULT 0,
  kicking_fgm_yds smallint NOT NULL DEFAULT 0,
  kicking_fgmissed smallint NOT NULL DEFAULT 0,
  kicking_fgmissed_yds smallint NOT NULL DEFAULT 0,
  kicking_i20 smallint NOT NULL DEFAULT 0,
  kicking_rec smallint NOT NULL DEFAULT 0,
  kicking_rec_tds smallint NOT NULL DEFAULT 0,
  kicking_tot smallint NOT NULL DEFAULT 0,
  kicking_touchback smallint NOT NULL DEFAULT 0,
  kicking_xpa smallint NOT NULL DEFAULT 0,
  kicking_xpb smallint NOT NULL DEFAULT 0,
  kicking_xpmade smallint NOT NULL DEFAULT 0,
  kicking_xpmissed smallint NOT NULL DEFAULT 0,
  kicking_yds smallint NOT NULL DEFAULT 0,
  kickret_fair smallint NOT NULL DEFAULT 0,
  kickret_oob smallint NOT NULL DEFAULT 0,
  kickret_ret smallint NOT NULL DEFAULT 0,
  kickret_tds smallint NOT NULL DEFAULT 0,
  kickret_touchback smallint NOT NULL DEFAULT 0,
  kickret_yds smallint NOT NULL DEFAULT 0,
  passing_att smallint NOT NULL DEFAULT 0,
  passing_cmp smallint NOT NULL DEFAULT 0,
  passing_cmp_air_yds smallint NOT NULL DEFAULT 0,
  passing_incmp smallint NOT NULL DEFAULT 0,
  passing_incmp_air_yds smallint NOT NULL DEFAULT 0,
  passing_int smallint NOT NULL DEFAULT 0,
  passing_sk smallint NOT NULL DEFAULT 0,
  passing_sk_yds smallint NOT NULL DEFAULT 0,
  passing_tds smallint NOT NULL DEFAULT 0,
  passing_twopta smallint NOT NULL DEFAULT 0,
  passing_twoptm smallint NOT NULL DEFAULT 0,
  passing_twoptmissed smallint NOT NULL DEFAULT 0,
  passing_yds smallint NOT NULL DEFAULT 0,
  punting_blk smallint NOT NULL DEFAULT 0,
  punting_i20 smallint NOT NULL DEFAULT 0,
  punting_tot smallint NOT NULL DEFAULT 0,
  punting_touchback smallint NOT NULL DEFAULT 0,
  punting_yds smallint NOT NULL DEFAULT 0,
  puntret_downed smallint NOT NULL DEFAULT 0,
  puntret_fair smallint NOT NULL DEFAULT 0,
  puntret_oob smallint NOT NULL DEFAULT 0,
  puntret_tds smallint NOT NULL DEFAULT 0,
  puntret_tot smallint NOT NULL DEFAULT 0,
  puntret_touchback smallint NOT NULL DEFAULT 0,
  puntret_yds smallint NOT NULL DEFAULT 0,
  receiving_rec smallint NOT NULL DEFAULT 0,
  receiving_tar smallint NOT NULL DEFAULT 0,
  receiving_tds smallint NOT NULL DEFAULT 0,
  receiving_twopta smallint NOT NULL DEFAULT 0,
  receiving_twoptm smallint NOT NULL DEFAULT 0,
  receiving_twoptmissed smallint NOT NULL DEFAULT 0,
  receiving_yac_yds smallint NOT NULL DEFAULT 0,
  receiving_yds smallint NOT NULL DEFAULT 0,
  rushing_att smallint NOT NULL DEFAULT 0,
  rushing_loss smallint NOT NULL DEFAULT 0,
  rushing_loss_yds smallint NOT NULL DEFAULT 0,
  rushing_tds smallint NOT NULL DEFAULT 0,
  rushing_twopta smallint NOT NULL DEFAULT 0,
  rushing_twoptm smallint NOT NULL DEFAULT 0,
  rushing_twoptmissed smallint NOT NULL DEFAULT 0,
  rushing_yds smallint NOT NULL DEFAULT 0,
  CONSTRAINT agg_play_pkey PRIMARY KEY (gsis_id, drive_id, play_id),
  CONSTRAINT agg_play_gsis_id_fkey FOREIGN KEY (gsis_id, drive_id, play_id)
      REFERENCES play (gsis_id, drive_id, play_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT agg_play_gsis_id_fkey1 FOREIGN KEY (gsis_id, drive_id)
      REFERENCES drive (gsis_id, drive_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT agg_play_gsis_id_fkey2 FOREIGN KEY (gsis_id)
      REFERENCES game (gsis_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE drive
(
  gsis_id gameid NOT NULL,
  drive_id usmallint NOT NULL,
  start_field field_pos CHECK (((start_field >= (-50)) AND (start_field <= 50))),
  start_time game_time NOT NULL,
  end_field field_pos,
  end_time game_time NOT NULL,
  pos_team character varying(3) NOT NULL,
  pos_time pos_period,
  first_downs usmallint NOT NULL,
  result text,
  penalty_yards smallint NOT NULL,
  yards_gained smallint NOT NULL,
  play_count usmallint NOT NULL,
  time_inserted utctime NOT NULL,
  time_updated utctime NOT NULL,
  CONSTRAINT drive_pkey PRIMARY KEY (gsis_id, drive_id),
  CONSTRAINT drive_gsis_id_fkey FOREIGN KEY (gsis_id)
      REFERENCES game (gsis_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT drive_pos_team_fkey FOREIGN KEY (pos_team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE game
(
  gsis_id gameid NOT NULL,
  gamekey character varying(5),
  start_time utctime NOT NULL,
  week usmallint NOT NULL,
  day_of_week game_day NOT NULL,
  season_year usmallint NOT NULL,
  season_type season_phase NOT NULL,
  finished boolean NOT NULL,
  home_team character varying(3) NOT NULL,
  home_score usmallint NOT NULL,
  home_score_q1 usmallint,
  home_score_q2 usmallint,
  home_score_q3 usmallint,
  home_score_q4 usmallint,
  home_score_q5 usmallint,
  home_turnovers usmallint NOT NULL,
  away_team character varying(3) NOT NULL,
  away_score usmallint NOT NULL,
  away_score_q1 usmallint,
  away_score_q2 usmallint,
  away_score_q3 usmallint,
  away_score_q4 usmallint,
  away_score_q5 usmallint,
  away_turnovers usmallint NOT NULL,
  time_inserted utctime NOT NULL,
  time_updated utctime NOT NULL,
  CONSTRAINT game_pkey PRIMARY KEY (gsis_id),
  CONSTRAINT game_away_team_fkey FOREIGN KEY (away_team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT game_home_team_fkey FOREIGN KEY (home_team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT game_season_year_check CHECK (season_year >= 1960 AND season_year <= 2100),
  CONSTRAINT game_week_check CHECK (week >= 0 AND week <= 25)
);

CREATE TABLE meta
(
  version smallint,
  last_roster_download utctime NOT NULL,
  season_type season_phase,
  season_year usmallint,
  week usmallint,
  CONSTRAINT meta_season_year_check CHECK (season_year >= 1960 AND season_year <= 2100),
  CONSTRAINT meta_week_check CHECK (week >= 0 AND week <= 25)
);

CREATE TABLE play
(
  gsis_id gameid NOT NULL,
  drive_id usmallint NOT NULL,
  play_id usmallint NOT NULL,
  "time" game_time NOT NULL,
  pos_team character varying(3) NOT NULL,
  yardline field_pos,
  down smallint,
  yards_to_go smallint,
  description text,
  note text,
  time_inserted utctime NOT NULL,
  time_updated utctime NOT NULL,
  first_down smallint NOT NULL DEFAULT 0,
  fourth_down_att smallint NOT NULL DEFAULT 0,
  fourth_down_conv smallint NOT NULL DEFAULT 0,
  fourth_down_failed smallint NOT NULL DEFAULT 0,
  passing_first_down smallint NOT NULL DEFAULT 0,
  penalty smallint NOT NULL DEFAULT 0,
  penalty_first_down smallint NOT NULL DEFAULT 0,
  penalty_yds smallint NOT NULL DEFAULT 0,
  rushing_first_down smallint NOT NULL DEFAULT 0,
  third_down_att smallint NOT NULL DEFAULT 0,
  third_down_conv smallint NOT NULL DEFAULT 0,
  third_down_failed smallint NOT NULL DEFAULT 0,
  timeout smallint NOT NULL DEFAULT 0,
  xp_aborted smallint NOT NULL DEFAULT 0,
  CONSTRAINT play_pkey PRIMARY KEY (gsis_id, drive_id, play_id),
  CONSTRAINT play_gsis_id_fkey FOREIGN KEY (gsis_id, drive_id)
      REFERENCES drive (gsis_id, drive_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT play_gsis_id_fkey1 FOREIGN KEY (gsis_id)
      REFERENCES game (gsis_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT play_pos_team_fkey FOREIGN KEY (pos_team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT play_down_check CHECK (down >= 1 AND down <= 4),
  CONSTRAINT play_yards_to_go_check CHECK (yards_to_go >= 0 AND yards_to_go <= 100)
);

CREATE TABLE play_player
(
  gsis_id gameid NOT NULL,
  drive_id usmallint NOT NULL,
  play_id usmallint NOT NULL,
  player_id character varying(10) NOT NULL,
  team character varying(3) NOT NULL,
  defense_ast smallint NOT NULL DEFAULT 0,
  defense_ffum smallint NOT NULL DEFAULT 0,
  defense_fgblk smallint NOT NULL DEFAULT 0,
  defense_frec smallint NOT NULL DEFAULT 0,
  defense_frec_tds smallint NOT NULL DEFAULT 0,
  defense_frec_yds smallint NOT NULL DEFAULT 0,
  defense_int smallint NOT NULL DEFAULT 0,
  defense_int_tds smallint NOT NULL DEFAULT 0,
  defense_int_yds smallint NOT NULL DEFAULT 0,
  defense_misc_tds smallint NOT NULL DEFAULT 0,
  defense_misc_yds smallint NOT NULL DEFAULT 0,
  defense_pass_def smallint NOT NULL DEFAULT 0,
  defense_puntblk smallint NOT NULL DEFAULT 0,
  defense_qbhit smallint NOT NULL DEFAULT 0,
  defense_safe smallint NOT NULL DEFAULT 0,
  defense_sk real NOT NULL DEFAULT 0.0,
  defense_sk_yds smallint NOT NULL DEFAULT 0,
  defense_tkl smallint NOT NULL DEFAULT 0,
  defense_tkl_loss smallint NOT NULL DEFAULT 0,
  defense_tkl_loss_yds smallint NOT NULL DEFAULT 0,
  defense_tkl_primary smallint NOT NULL DEFAULT 0,
  defense_xpblk smallint NOT NULL DEFAULT 0,
  fumbles_forced smallint NOT NULL DEFAULT 0,
  fumbles_lost smallint NOT NULL DEFAULT 0,
  fumbles_notforced smallint NOT NULL DEFAULT 0,
  fumbles_oob smallint NOT NULL DEFAULT 0,
  fumbles_rec smallint NOT NULL DEFAULT 0,
  fumbles_rec_tds smallint NOT NULL DEFAULT 0,
  fumbles_rec_yds smallint NOT NULL DEFAULT 0,
  fumbles_tot smallint NOT NULL DEFAULT 0,
  kicking_all_yds smallint NOT NULL DEFAULT 0,
  kicking_downed smallint NOT NULL DEFAULT 0,
  kicking_fga smallint NOT NULL DEFAULT 0,
  kicking_fgb smallint NOT NULL DEFAULT 0,
  kicking_fgm smallint NOT NULL DEFAULT 0,
  kicking_fgm_yds smallint NOT NULL DEFAULT 0,
  kicking_fgmissed smallint NOT NULL DEFAULT 0,
  kicking_fgmissed_yds smallint NOT NULL DEFAULT 0,
  kicking_i20 smallint NOT NULL DEFAULT 0,
  kicking_rec smallint NOT NULL DEFAULT 0,
  kicking_rec_tds smallint NOT NULL DEFAULT 0,
  kicking_tot smallint NOT NULL DEFAULT 0,
  kicking_touchback smallint NOT NULL DEFAULT 0,
  kicking_xpa smallint NOT NULL DEFAULT 0,
  kicking_xpb smallint NOT NULL DEFAULT 0,
  kicking_xpmade smallint NOT NULL DEFAULT 0,
  kicking_xpmissed smallint NOT NULL DEFAULT 0,
  kicking_yds smallint NOT NULL DEFAULT 0,
  kickret_fair smallint NOT NULL DEFAULT 0,
  kickret_oob smallint NOT NULL DEFAULT 0,
  kickret_ret smallint NOT NULL DEFAULT 0,
  kickret_tds smallint NOT NULL DEFAULT 0,
  kickret_touchback smallint NOT NULL DEFAULT 0,
  kickret_yds smallint NOT NULL DEFAULT 0,
  passing_att smallint NOT NULL DEFAULT 0,
  passing_cmp smallint NOT NULL DEFAULT 0,
  passing_cmp_air_yds smallint NOT NULL DEFAULT 0,
  passing_incmp smallint NOT NULL DEFAULT 0,
  passing_incmp_air_yds smallint NOT NULL DEFAULT 0,
  passing_int smallint NOT NULL DEFAULT 0,
  passing_sk smallint NOT NULL DEFAULT 0,
  passing_sk_yds smallint NOT NULL DEFAULT 0,
  passing_tds smallint NOT NULL DEFAULT 0,
  passing_twopta smallint NOT NULL DEFAULT 0,
  passing_twoptm smallint NOT NULL DEFAULT 0,
  passing_twoptmissed smallint NOT NULL DEFAULT 0,
  passing_yds smallint NOT NULL DEFAULT 0,
  punting_blk smallint NOT NULL DEFAULT 0,
  punting_i20 smallint NOT NULL DEFAULT 0,
  punting_tot smallint NOT NULL DEFAULT 0,
  punting_touchback smallint NOT NULL DEFAULT 0,
  punting_yds smallint NOT NULL DEFAULT 0,
  puntret_downed smallint NOT NULL DEFAULT 0,
  puntret_fair smallint NOT NULL DEFAULT 0,
  puntret_oob smallint NOT NULL DEFAULT 0,
  puntret_tds smallint NOT NULL DEFAULT 0,
  puntret_tot smallint NOT NULL DEFAULT 0,
  puntret_touchback smallint NOT NULL DEFAULT 0,
  puntret_yds smallint NOT NULL DEFAULT 0,
  receiving_rec smallint NOT NULL DEFAULT 0,
  receiving_tar smallint NOT NULL DEFAULT 0,
  receiving_tds smallint NOT NULL DEFAULT 0,
  receiving_twopta smallint NOT NULL DEFAULT 0,
  receiving_twoptm smallint NOT NULL DEFAULT 0,
  receiving_twoptmissed smallint NOT NULL DEFAULT 0,
  receiving_yac_yds smallint NOT NULL DEFAULT 0,
  receiving_yds smallint NOT NULL DEFAULT 0,
  rushing_att smallint NOT NULL DEFAULT 0,
  rushing_loss smallint NOT NULL DEFAULT 0,
  rushing_loss_yds smallint NOT NULL DEFAULT 0,
  rushing_tds smallint NOT NULL DEFAULT 0,
  rushing_twopta smallint NOT NULL DEFAULT 0,
  rushing_twoptm smallint NOT NULL DEFAULT 0,
  rushing_twoptmissed smallint NOT NULL DEFAULT 0,
  rushing_yds smallint NOT NULL DEFAULT 0,
  CONSTRAINT play_player_pkey PRIMARY KEY (gsis_id, drive_id, play_id, player_id),
  CONSTRAINT play_player_gsis_id_fkey FOREIGN KEY (gsis_id, drive_id, play_id)
      REFERENCES play (gsis_id, drive_id, play_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT play_player_gsis_id_fkey1 FOREIGN KEY (gsis_id, drive_id)
      REFERENCES drive (gsis_id, drive_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT play_player_gsis_id_fkey2 FOREIGN KEY (gsis_id)
      REFERENCES game (gsis_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT play_player_player_id_fkey FOREIGN KEY (player_id)
      REFERENCES player (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT play_player_team_fkey FOREIGN KEY (team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE player
(
  player_id character varying(10) NOT NULL,
  gsis_name character varying(75),
  full_name character varying(100),
  first_name character varying(100),
  last_name character varying(100),
  team character varying(3) NOT NULL,
  "position" player_pos NOT NULL,
  profile_id integer,
  profile_url character varying(255),
  uniform_number usmallint,
  birthdate character varying(75),
  college character varying(255),
  height usmallint,
  weight usmallint,
  years_pro usmallint,
  status player_status NOT NULL,
  CONSTRAINT player_pkey PRIMARY KEY (player_id),
  CONSTRAINT player_team_fkey FOREIGN KEY (team)
      REFERENCES team (team_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT player_player_id_check CHECK (length(player_id) = 10)
);

CREATE TABLE team
(
  team_id character varying(3) NOT NULL,
  city character varying(50) NOT NULL,
  name character varying(50) NOT NULL,
  CONSTRAINT team_pkey PRIMARY KEY (team_id)
);
