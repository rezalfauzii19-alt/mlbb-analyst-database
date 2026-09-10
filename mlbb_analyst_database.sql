-- ============================================
-- MLBB ANALYST DATABASE - SQL SCHEMA
-- ============================================
-- Database untuk analisis pertandingan Mobile Legends: Bang Bang
-- Dengan struktur Entity Relationship yang lengkap
-- ============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS mlbb_analyst_db;
USE mlbb_analyst_db;

-- ============================================
-- MASTER DATA TABLES
-- ============================================

-- 1. TEAMS TABLE
CREATE TABLE IF NOT EXISTS teams (
    id_team INT PRIMARY KEY AUTO_INCREMENT,
    nama_tim VARCHAR(100) NOT NULL UNIQUE,
    singkatan VARCHAR(50),
    logo_url VARCHAR(255),
    negara VARCHAR(50),
    aktif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_aktif (aktif),
    INDEX idx_negara (negara)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. PLAYERS TABLE
CREATE TABLE IF NOT EXISTS players (
    id_player INT PRIMARY KEY AUTO_INCREMENT,
    nama_player VARCHAR(100) NOT NULL,
    nickname VARCHAR(50) UNIQUE,
    id_team INT,
    role VARCHAR(20),
    tanggal_lahir DATE,
    negara VARCHAR(50),
    aktif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE SET NULL,
    INDEX idx_id_team (id_team),
    INDEX idx_aktif (aktif),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. ROLES TABLE
CREATE TABLE IF NOT EXISTS roles (
    id_role INT PRIMARY KEY AUTO_INCREMENT,
    nama_role VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT,
    icon_url VARCHAR(255),
    aktif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_aktif (aktif)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. HEROES TABLE
CREATE TABLE IF NOT EXISTS heroes (
    id_hero INT PRIMARY KEY AUTO_INCREMENT,
    nama_hero VARCHAR(50) NOT NULL UNIQUE,
    tipe VARCHAR(50),
    kesulitan INT,
    icon_url VARCHAR(255),
    deskripsi TEXT,
    release_date DATE,
    aktif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_aktif (aktif),
    INDEX idx_tipe (tipe)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. HERO_ROLES TABLE (Many-to-Many)
CREATE TABLE IF NOT EXISTS hero_roles (
    id_hero_role INT PRIMARY KEY AUTO_INCREMENT,
    id_hero INT NOT NULL,
    id_role INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    FOREIGN KEY (id_role) REFERENCES roles(id_role) ON DELETE CASCADE,
    UNIQUE KEY unique_hero_role (id_hero, id_role),
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_role (id_role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. PATCHES TABLE
CREATE TABLE IF NOT EXISTS patches (
    id_patch INT PRIMARY KEY AUTO_INCREMENT,
    nama_patch VARCHAR(50) NOT NULL UNIQUE,
    tanggal DATE NOT NULL,
    icon_url TEXT,
    icon_uri VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tanggal (tanggal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. ITEMS TABLE
CREATE TABLE IF NOT EXISTS items (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    nama_item VARCHAR(100) NOT NULL UNIQUE,
    tipe VARCHAR(50),
    harga INT,
    deskripsi TEXT,
    icon_url VARCHAR(255),
    id_hero INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE SET NULL,
    INDEX idx_id_hero (id_hero),
    INDEX idx_tipe (tipe)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. ITEM_COMPONENTS TABLE
CREATE TABLE IF NOT EXISTS item_components (
    id_component INT PRIMARY KEY AUTO_INCREMENT,
    id_item INT NOT NULL,
    nama_komponen VARCHAR(100),
    deskripsi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_item) REFERENCES items(id_item) ON DELETE CASCADE,
    INDEX idx_id_item (id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. EMBLEMS TABLE
CREATE TABLE IF NOT EXISTS emblems (
    id_emblem INT PRIMARY KEY AUTO_INCREMENT,
    nama_emblem VARCHAR(100) NOT NULL UNIQUE,
    tipe VARCHAR(50),
    icon_url TEXT,
    deskripsi VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tipe (tipe)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MATCH & DRAFT TABLES
-- ============================================

-- 10. TOURNAMENTS TABLE
CREATE TABLE IF NOT EXISTS tournaments (
    id_tournament INT PRIMARY KEY AUTO_INCREMENT,
    nama_tournament VARCHAR(100) NOT NULL,
    season VARCHAR(50),
    start_date DATE,
    end_date DATE,
    tipe VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_season (season),
    INDEX idx_tanggal (start_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. MATCHES TABLE
CREATE TABLE IF NOT EXISTS matches (
    id_match INT PRIMARY KEY AUTO_INCREMENT,
    id_tournament INT,
    id_team_1 INT NOT NULL,
    id_team_2 INT NOT NULL,
    score_team_1 INT DEFAULT 0,
    score_team_2 INT DEFAULT 0,
    pemenang VARCHAR(50),
    match_date DATETIME NOT NULL,
    game_number INT,
    id_patch INT,
    game_duration INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tournament) REFERENCES tournaments(id_tournament) ON DELETE SET NULL,
    FOREIGN KEY (id_team_1) REFERENCES teams(id_team) ON DELETE RESTRICT,
    FOREIGN KEY (id_team_2) REFERENCES teams(id_team) ON DELETE RESTRICT,
    FOREIGN KEY (id_patch) REFERENCES patches(id_patch) ON DELETE SET NULL,
    INDEX idx_id_tournament (id_tournament),
    INDEX idx_id_team_1 (id_team_1),
    INDEX idx_id_team_2 (id_team_2),
    INDEX idx_match_date (match_date),
    INDEX idx_pemenang (pemenang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. MATCH_PLAYERS TABLE
CREATE TABLE IF NOT EXISTS match_players (
    id_match_player INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    id_player INT NOT NULL,
    id_hero INT NOT NULL,
    id_team INT NOT NULL,
    lane VARCHAR(20),
    id_emblem INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (id_player) REFERENCES players(id_player) ON DELETE RESTRICT,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE RESTRICT,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE RESTRICT,
    FOREIGN KEY (id_emblem) REFERENCES emblems(id_emblem) ON DELETE SET NULL,
    UNIQUE KEY unique_match_player (id_match, id_player),
    INDEX idx_id_match (id_match),
    INDEX idx_id_player (id_player),
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_team (id_team),
    INDEX idx_lane (lane)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. DRAFTS TABLE
CREATE TABLE IF NOT EXISTS drafts (
    id_draft INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    id_patch INT,
    id_team INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (id_patch) REFERENCES patches(id_patch) ON DELETE SET NULL,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE RESTRICT,
    UNIQUE KEY unique_draft (id_match, id_team),
    INDEX idx_id_match (id_match),
    INDEX idx_id_team (id_team)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. DRAFT_ACTIONS TABLE
CREATE TABLE IF NOT EXISTS draft_actions (
    id_action INT PRIMARY KEY AUTO_INCREMENT,
    id_draft INT NOT NULL,
    id_hero INT NOT NULL,
    id_team INT NOT NULL,
    action_number INT,
    action_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_draft) REFERENCES drafts(id_draft) ON DELETE CASCADE,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE RESTRICT,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE RESTRICT,
    INDEX idx_id_draft (id_draft),
    INDEX idx_action_type (action_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MATCH STATISTICS & OBJECTIVES TABLES
-- ============================================

-- 15. PLAYER_MATCH_STATS TABLE
CREATE TABLE IF NOT EXISTS player_match_stats (
    id_match_stat INT PRIMARY KEY AUTO_INCREMENT,
    id_match_player INT NOT NULL,
    id_match INT NOT NULL,
    kills INT DEFAULT 0,
    deaths INT DEFAULT 0,
    assists INT DEFAULT 0,
    golds DECIMAL(10,2) DEFAULT 0,
    dmg_taken INT DEFAULT 0,
    hero_damage INT DEFAULT 0,
    creep_gold INT DEFAULT 0,
    turret_damage INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match_player) REFERENCES match_players(id_match_player) ON DELETE CASCADE,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    INDEX idx_id_match_player (id_match_player),
    INDEX idx_id_match (id_match)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. OBJECTIVES TABLE
CREATE TABLE IF NOT EXISTS objectives (
    id_objective INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    deskripsi VARCHAR(100),
    is_contested TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    INDEX idx_id_match (id_match)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. TURRETS TABLE
CREATE TABLE IF NOT EXISTS turrets (
    id_turret INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    team_id INT NOT NULL,
    lane VARCHAR(50),
    destroyed TINYINT(1) DEFAULT 0,
    destroyed_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id_team) ON DELETE RESTRICT,
    INDEX idx_id_match (id_match),
    INDEX idx_team_id (team_id),
    INDEX idx_lane (lane)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 18. LORDS TABLE
CREATE TABLE IF NOT EXISTS lords (
    id_lord INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    team_id INT NOT NULL,
    captured_at DATETIME,
    is_contested TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id_team) ON DELETE RESTRICT,
    INDEX idx_id_match (id_match),
    INDEX idx_team_id (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- HERO META & ANALYSIS TABLES
-- ============================================

-- 19. HERO_STATS TABLE
CREATE TABLE IF NOT EXISTS hero_stats (
    id_hero_stat INT PRIMARY KEY AUTO_INCREMENT,
    id_hero INT NOT NULL,
    id_patch INT NOT NULL,
    pick_count INT DEFAULT 0,
    ban_count INT DEFAULT 0,
    win_rate DECIMAL(5,2) DEFAULT 0,
    pick_rate DECIMAL(5,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    FOREIGN KEY (id_patch) REFERENCES patches(id_patch) ON DELETE CASCADE,
    UNIQUE KEY unique_hero_patch (id_hero, id_patch),
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_patch (id_patch)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 20. HERO_COUNTERS TABLE
CREATE TABLE IF NOT EXISTS hero_counters (
    id_counter INT PRIMARY KEY AUTO_INCREMENT,
    id_hero INT NOT NULL,
    id_counter_hero INT NOT NULL,
    counter_score DECIMAL(5,2),
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    FOREIGN KEY (id_counter_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    UNIQUE KEY unique_counter (id_hero, id_counter_hero),
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_counter_hero (id_counter_hero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 21. HERO_SYNERGIES TABLE
CREATE TABLE IF NOT EXISTS hero_synergies (
    id_synergy INT PRIMARY KEY AUTO_INCREMENT,
    id_hero INT NOT NULL,
    id_partner_hero INT NOT NULL,
    synergy_score DECIMAL(5,2),
    radius TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    FOREIGN KEY (id_partner_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    UNIQUE KEY unique_synergy (id_hero, id_partner_hero),
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_partner_hero (id_partner_hero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ROTATION & MACRO TABLES
-- ============================================

-- 22. PLAYER_POSITIONS TABLE
CREATE TABLE IF NOT EXISTS player_positions (
    id_position INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    id_player INT NOT NULL,
    game_time TIME,
    x INT,
    y INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (id_player) REFERENCES players(id_player) ON DELETE CASCADE,
    INDEX idx_id_match (id_match),
    INDEX idx_id_player (id_player)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 23. ROTATIONS TABLE
CREATE TABLE IF NOT EXISTS rotations (
    id_rotation INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    id_player INT NOT NULL,
    game_time TIME,
    start_time TIME,
    end_time TIME,
    from_area VARCHAR(100),
    to_area VARCHAR(100),
    area VARCHAR(100),
    purpose VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (id_player) REFERENCES players(id_player) ON DELETE CASCADE,
    INDEX idx_id_match (id_match),
    INDEX idx_id_player (id_player)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TEAM & PLAYER SCOUTING TABLES
-- ============================================

-- 24. TEAM_SCOUTING TABLE
CREATE TABLE IF NOT EXISTS team_scouting (
    id_scouting INT PRIMARY KEY AUTO_INCREMENT,
    id_team INT NOT NULL,
    id_match INT NOT NULL,
    analyst_id INT,
    scout_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE CASCADE,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    INDEX idx_id_team (id_team),
    INDEX idx_id_match (id_match),
    INDEX idx_scout_date (scout_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 25. TEAM_PATTERNS TABLE
CREATE TABLE IF NOT EXISTS team_patterns (
    id_pattern INT PRIMARY KEY AUTO_INCREMENT,
    id_team INT NOT NULL,
    id_player INT NOT NULL,
    pattern_type VARCHAR(50),
    weakness TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE CASCADE,
    FOREIGN KEY (id_player) REFERENCES players(id_player) ON DELETE CASCADE,
    INDEX idx_id_team (id_team),
    INDEX idx_id_player (id_player),
    INDEX idx_pattern_type (pattern_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 26. PLAYER_SCOUTING TABLE
CREATE TABLE IF NOT EXISTS player_scouting (
    id_player_scout INT PRIMARY KEY AUTO_INCREMENT,
    id_team INT NOT NULL,
    id_player INT NOT NULL,
    scout_date DATE,
    weakness TEXT,
    playstyle VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_team) REFERENCES teams(id_team) ON DELETE CASCADE,
    FOREIGN KEY (id_player) REFERENCES players(id_player) ON DELETE CASCADE,
    INDEX idx_id_team (id_team),
    INDEX idx_id_player (id_player),
    INDEX idx_scout_date (scout_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- VOD & GAME PLAN TABLES
-- ============================================

-- 27. VOD_REVIEWS TABLE
CREATE TABLE IF NOT EXISTS vod_reviews (
    id_vod INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    review_date DATETIME,
    reviewer_id INT,
    review_link TEXT,
    summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    INDEX idx_id_match (id_match),
    INDEX idx_review_date (review_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 28. VOD_EVENTS TABLE
CREATE TABLE IF NOT EXISTS vod_events (
    id_event INT PRIMARY KEY AUTO_INCREMENT,
    id_vod INT NOT NULL,
    game_time TIME,
    event_type VARCHAR(50),
    description VARCHAR(255),
    timestamp DATETIME,
    category VARCHAR(50),
    title VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_vod) REFERENCES vod_reviews(id_vod) ON DELETE CASCADE,
    INDEX idx_id_vod (id_vod),
    INDEX idx_event_type (event_type),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 29. ANALYST_NOTES TABLE
CREATE TABLE IF NOT EXISTS analyst_notes (
    id_note INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    analyst_id INT,
    note_date DATETIME,
    review_date DATETIME,
    summary TEXT,
    counter_strategy VARCHAR(250),
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    INDEX idx_id_match (id_match),
    INDEX idx_note_date (note_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 30. HERO_PATCH_CHANGES TABLE
CREATE TABLE IF NOT EXISTS hero_patch_changes (
    id_patch_change INT PRIMARY KEY AUTO_INCREMENT,
    id_hero INT NOT NULL,
    id_patch INT NOT NULL,
    changes_type VARCHAR(50),
    description TEXT,
    importance VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_hero) REFERENCES heroes(id_hero) ON DELETE CASCADE,
    FOREIGN KEY (id_patch) REFERENCES patches(id_patch) ON DELETE CASCADE,
    INDEX idx_id_hero (id_hero),
    INDEX idx_id_patch (id_patch),
    INDEX idx_importance (importance)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 31. GAME_PLANS TABLE
CREATE TABLE IF NOT EXISTS game_plans (
    id_game_plan INT PRIMARY KEY AUTO_INCREMENT,
    id_match INT NOT NULL,
    team_id INT NOT NULL,
    plan_type VARCHAR(100),
    description TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_match) REFERENCES matches(id_match) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id_team) ON DELETE RESTRICT,
    INDEX idx_id_match (id_match),
    INDEX idx_team_id (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 32. GAME_PLAN_PRIORITIES TABLE
CREATE TABLE IF NOT EXISTS game_plan_priorities (
    id_priority INT PRIMARY KEY AUTO_INCREMENT,
    id_game_plan INT NOT NULL,
    priority_level INT,
    early_game_plan TEXT,
    mid_game_plan TEXT,
    late_game_plan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_game_plan) REFERENCES game_plans(id_game_plan) ON DELETE CASCADE,
    INDEX idx_id_game_plan (id_game_plan)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INDEXES UNTUK PERFORMA QUERY
-- ============================================

-- Performance indexes untuk queries umum
CREATE INDEX idx_matches_tournament_date ON matches(id_tournament, match_date);
CREATE INDEX idx_match_players_team_hero ON match_players(id_team, id_hero);
CREATE INDEX idx_player_stats_kda ON player_match_stats(kills, deaths, assists);
CREATE INDEX idx_hero_stats_winrate ON hero_stats(win_rate, pick_rate);
CREATE INDEX idx_scouting_date_range ON team_scouting(scout_date, id_team);

-- ============================================
-- VIEWS UNTUK ANALISIS
-- ============================================

-- View untuk Player Performance Overview
CREATE VIEW v_player_performance AS
SELECT 
    p.id_player,
    p.nama_player,
    p.nickname,
    t.nama_tim,
    COUNT(DISTINCT mp.id_match) as matches_played,
    AVG(pms.kills) as avg_kills,
    AVG(pms.deaths) as avg_deaths,
    AVG(pms.assists) as avg_assists,
    AVG(pms.golds) as avg_gold,
    SUM(pms.hero_damage) as total_hero_damage,
    AVG(pms.hero_damage) as avg_hero_damage
FROM players p
LEFT JOIN match_players mp ON p.id_player = mp.id_player
LEFT JOIN player_match_stats pms ON mp.id_match_player = pms.id_match_player
LEFT JOIN teams t ON p.id_team = t.id_team
GROUP BY p.id_player, p.nama_player, p.nickname, t.nama_tim;

-- View untuk Team Match Summary
CREATE VIEW v_team_match_summary AS
SELECT 
    m.id_match,
    m.match_date,
    t1.nama_tim as team_1,
    t2.nama_tim as team_2,
    m.score_team_1,
    m.score_team_2,
    m.pemenang,
    m.game_duration,
    tor.nama_tournament
FROM matches m
LEFT JOIN teams t1 ON m.id_team_1 = t1.id_team
LEFT JOIN teams t2 ON m.id_team_2 = t2.id_team
LEFT JOIN tournaments tor ON m.id_tournament = tor.id_tournament;

-- View untuk Hero Meta Analysis
CREATE VIEW v_hero_meta AS
SELECT 
    h.id_hero,
    h.nama_hero,
    h.tipe,
    hs.id_patch,
    p.nama_patch,
    hs.pick_count,
    hs.ban_count,
    hs.win_rate,
    hs.pick_rate,
    (hs.pick_count + hs.ban_count) as total_picks_bans
FROM heroes h
LEFT JOIN hero_stats hs ON h.id_hero = hs.id_hero
LEFT JOIN patches p ON hs.id_patch = p.id_patch
WHERE hs.id_patch IS NOT NULL
ORDER BY hs.pick_rate DESC;

-- ============================================
-- END OF DATABASE SCHEMA
-- ============================================
