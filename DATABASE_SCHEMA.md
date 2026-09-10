# MLBB Analyst Database - Entity Relationship Diagram
## Dokumentasi Lengkap dengan Foreign Key Relationships

---

## 📋 MASTER DATA

### 1. **teams**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_team | INT | PK | - |
| nama_tim | VARCHAR(100) | NOT NULL | - |
| singkatan | VARCHAR(50) | - | - |
| logo_url | VARCHAR(255) | - | - |
| negara | VARCHAR(50) | - | - |
| aktif | TINYINT(1) | - | - |
| created_at | TIMESTAMP | DEFAULT NOW() | - |

**Relasi Keluar:**
- `teams.id_team` ← `players.id_team` (One-to-Many)
- `teams.id_team` ← `matches.id_team_1` (One-to-Many)
- `teams.id_team` ← `matches.id_team_2` (One-to-Many)
- `teams.id_team` ← `draft_actions.id_team` (One-to-Many)
- `teams.id_team` ← `player_scouting.id_team` (One-to-Many)
- `teams.id_team` ← `player_positions.id_match` (One-to-Many)
- `teams.id_team` ← `match_players.id_team` (One-to-Many)

---

### 2. **players**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_player | INT | PK | - |
| nama_player | VARCHAR(100) | NOT NULL | - |
| nickname | VARCHAR(50) | - | - |
| role | VARCHAR(20) | - | - |
| tanggal_lahir | DATE | - | - |
| negara | VARCHAR(50) | - | - |
| aktif | TINYINT(1) | - | - |
| created_at | TIMESTAMP | DEFAULT NOW() | - |

**Relasi Keluar:**
- `players.id_player` ← `match_players.id_player` (One-to-Many)
- `players.id_player` ← `hero_stats.id_hero_stat` (One-to-Many)
- `players.id_player` ← `player_scouting.id_player` (One-to-Many)
- `players.id_player` ← `player_positions.id_player` (One-to-Many)
- `players.id_player` ← `team_patterns.id_player` (One-to-Many)

---

### 3. **roles**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_role | INT | PK | - |
| nama_role | VARCHAR(50) | NOT NULL | - |
| deskripsi | TEXT | - | - |
| icon_url | VARCHAR(255) | - | - |
| aktif | TINYINT(1) | - | - |
| created_at | TIMESTAMP | DEFAULT NOW() | - |

**Relasi Keluar:**
- `roles.id_role` ← `hero_roles.id_role` (One-to-Many)

---

### 4. **heroes**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_hero | INT | PK | - |
| nama_hero | VARCHAR(50) | NOT NULL | - |
| tipe | VARCHAR(50) | - | - |
| kesulitan | INT | - | - |
| icon_url | VARCHAR(255) | - | - |
| deskripsi | TEXT | - | - |
| release_date | DATE | - | - |
| aktif | TINYINT(1) | - | - |
| created_at | TIMESTAMP | DEFAULT NOW() | - |

**Relasi Keluar:**
- `heroes.id_hero` ← `hero_roles.id_hero` (One-to-Many)
- `heroes.id_hero` ← `match_players.id_hero` (One-to-Many)
- `heroes.id_hero` ← `items.id_hero` (One-to-Many)
- `heroes.id_hero` ← `hero_stats.id_hero` (One-to-Many)
- `heroes.id_hero` ← `hero_synergies.id_hero` (One-to-Many)
- `heroes.id_hero` ← `hero_counters.id_hero` (One-to-Many)

---

### 5. **hero_roles**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_hero_role | INT | PK | - |
| id_hero | INT | FK | heroes.id_hero |
| id_role | INT | FK | roles.id_role |

**Relasi:**
- `hero_roles.id_hero` → `heroes.id_hero` (Many-to-One)
- `hero_roles.id_role` → `roles.id_role` (Many-to-One)

---

### 6. **items**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_item | INT | PK | - |
| nama_item | VARCHAR(100) | NOT NULL | - |
| tipe | VARCHAR(50) | - | - |
| harga | INT | - | - |
| deskripsi | TEXT | - | - |
| icon_url | VARCHAR(255) | - | - |
| id_hero | INT | FK | heroes.id_hero |

**Relasi:**
- `items.id_hero` → `heroes.id_hero` (Many-to-One)
- `items.id_item` ← `item_components.id_item` (One-to-Many)

---

### 7. **item_components**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_component | INT | PK | - |
| id_item | INT | FK | items.id_item |
| nama_komponen | VARCHAR(100) | - | - |
| deskripsi | TEXT | - | - |

**Relasi:**
- `item_components.id_item` → `items.id_item` (Many-to-One)

---

### 8. **emblems**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_emblem | INT | PK | - |
| nama_emblem | VARCHAR(100) | NOT NULL | - |
| tipe | VARCHAR(50) | - | - |
| icon_url | TEXT | - | - |
| deskripsi | VARCHAR(255) | - | - |

**Relasi:**
- `emblems.id_emblem` ← `match_players.id_emblem` (One-to-Many)

---

### 9. **patches**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_patch | INT | PK | - |
| nama_patch | VARCHAR(50) | NOT NULL | - |
| tanggal | DATE | - | - |
| icon_url | TEXT | - | - |
| icon_uri | VARCHAR(255) | - | - |

**Relasi:**
- `patches.id_patch` ← `matches.id_patch` (One-to-Many)

---

### 10. **lords**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_lord | INT | PK | - |
| nama_lord | VARCHAR(100) | NOT NULL | - |
| id_match | INT | FK | matches.id_match |
| team_id | INT | FK | teams.id_team |
| is_contested | TINYINT(1) | DEFAULT 0 | - |

**Relasi:**
- `lords.id_match` → `matches.id_match` (Many-to-One)
- `lords.team_id` → `teams.id_team` (Many-to-One)

---

## 🎮 MATCH & DRAFT

### 11. **tournaments**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_tournament | INT | PK | - |
| nama_tournament | VARCHAR(100) | NOT NULL | - |
| season | VARCHAR(50) | - | - |
| start_date | DATE | - | - |
| end_date | DATE | - | - |
| tipe | VARCHAR(50) | - | - |
| match_date | DATETIME | - | - |
| game_duration | INT | - | - |

**Relasi Keluar:**
- `tournaments.id_tournament` ← `matches.id_tournament` (One-to-Many)

---

### 12. **matches**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_match | INT | PK | - |
| id_tournament | INT | FK | tournaments.id_tournament |
| id_team_1 | INT | FK | teams.id_team |
| id_team_2 | INT | FK | teams.id_team |
| score_team_1 | INT | - | - |
| score_team_2 | INT | - | - |
| pemenang | VARCHAR(50) | - | - |
| match_date | DATETIME | - | - |
| game_number | INT | - | - |
| id_patch | INT | FK | patches.id_patch |

**Relasi:**
- `matches.id_tournament` → `tournaments.id_tournament` (Many-to-One)
- `matches.id_team_1` → `teams.id_team` (Many-to-One)
- `matches.id_team_2` → `teams.id_team` (Many-to-One)
- `matches.id_patch` → `patches.id_patch` (Many-to-One)
- `matches.id_match` ← `match_players.id_match` (One-to-Many)
- `matches.id_match` ← `drafts.id_match` (One-to-Many)
- `matches.id_match` ← `lords.id_match` (One-to-Many)
- `matches.id_match` ← `player_positions.id_match` (One-to-Many)
- `matches.id_match` ← `player_scouting.id_team` (One-to-Many)
- `matches.id_match` ← `rotations.id_match` (One-to-Many)

---

### 13. **match_players**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_match_player | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| id_player | INT | FK | players.id_player |
| id_hero | INT | FK | heroes.id_hero |
| id_team | INT | FK | teams.id_team |
| lane | VARCHAR(20) | - | - |
| id_emblem | INT | FK | emblems.id_emblem |

**Relasi:**
- `match_players.id_match` → `matches.id_match` (Many-to-One)
- `match_players.id_player` → `players.id_player` (Many-to-One)
- `match_players.id_hero` → `heroes.id_hero` (Many-to-One)
- `match_players.id_team` → `teams.id_team` (Many-to-One)
- `match_players.id_emblem` → `emblems.id_emblem` (Many-to-One)

---

### 14. **drafts**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_draft | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| id_patch | INT | FK | patches.id_patch |
| id_team | INT | FK | teams.id_team |

**Relasi:**
- `drafts.id_match` → `matches.id_match` (Many-to-One)
- `drafts.id_patch` → `patches.id_patch` (Many-to-One)
- `drafts.id_team` → `teams.id_team` (Many-to-One)
- `drafts.id_draft` ← `draft_actions.id_draft` (One-to-Many)

---

### 15. **draft_actions**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_action | INT | PK | - |
| id_draft | INT | FK | drafts.id_draft |
| id_hero | INT | FK | heroes.id_hero |
| id_team | INT | FK | teams.id_team |
| action_number | INT | - | - |
| action_type | VARCHAR(50) | - | - |
| id_hero | INT | FK | heroes.id_hero |

**Relasi:**
- `draft_actions.id_draft` → `drafts.id_draft` (Many-to-One)
- `draft_actions.id_hero` → `heroes.id_hero` (Many-to-One)
- `draft_actions.id_team` → `teams.id_team` (Many-to-One)

---

## 📊 MATCH STATISTICS & OBJECTIVES

### 16. **player_match_stats**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_match_stat | INT | PK | - |
| id_match_player | INT | FK | match_players.id_match_player |
| id_match | INT | FK | matches.id_match |
| ed_match_player | INT | FK | match_players.id_match_player |
| kills | INT | - | - |
| deaths | INT | - | - |
| assists | INT | - | - |
| golds | DECIMAL(8,2) | - | - |
| dmg_taken | INT | - | - |
| herp_damage | INT | - | - |
| crep_gold | INT | - | - |
| dng_taken | INT | - | - |

**Relasi:**
- `player_match_stats.id_match_player` → `match_players.id_match_player` (Many-to-One)
- `player_match_stats.id_match` → `matches.id_match` (Many-to-One)

---

### 17. **objectives**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_objective | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| deskripsi | VARCHAR(100) | - | - |
| is_contested | TINYINT(1) | - | - |

**Relasi:**
- `objectives.id_match` → `matches.id_match` (Many-to-One)

---

### 18. **turrets**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_turret | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| team_id | INT | FK | teams.id_team |
| lane | VARCHAR(50) | - | - |
| destroyed | TINYINT(1) | - | - |

**Relasi:**
- `turrets.id_match` → `matches.id_match` (Many-to-One)
- `turrets.team_id` → `teams.id_team` (Many-to-One)

---

## 🧬 HERO META & ANALYSIS

### 19. **hero_stats**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_hero_stat | INT | PK | - |
| id_hero | INT | FK | heroes.id_hero |
| id_patch | INT | FK | patches.id_patch |
| pick_count | INT | - | - |
| ban_count | INT | - | - |
| win_rate | DECIMAL(5,2) | - | - |
| pick_rate | DECIMAL(5,2) | - | - |

**Relasi:**
- `hero_stats.id_hero` → `heroes.id_hero` (Many-to-One)
- `hero_stats.id_patch` → `patches.id_patch` (Many-to-One)

---

### 20. **hero_counters**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_counter | INT | PK | - |
| id_hero | INT | FK | heroes.id_hero |
| id_counter_hero | INT | FK | heroes.id_hero |
| counter_score | TEXT | - | - |
| reason | TEXT | - | - |

**Relasi:**
- `hero_counters.id_hero` → `heroes.id_hero` (Many-to-One)
- `hero_counters.id_counter_hero` → `heroes.id_hero` (Many-to-One)

---

### 21. **hero_synergies**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_synergy | INT | PK | - |
| id_hero | INT | FK | heroes.id_hero |
| id_partner_hero | INT | FK | heroes.id_hero |
| synergy_score | TEXT | - | - |
| radius | TEXT | - | - |

**Relasi:**
- `hero_synergies.id_hero` → `heroes.id_hero` (Many-to-One)
- `hero_synergies.id_partner_hero` → `heroes.id_hero` (Many-to-One)

---

## 🔄 ROTATION & MACRO

### 22. **player_positions**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_position | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| id_player | INT | FK | players.id_player |
| game_time | TIME | - | - |
| x | INT | - | - |
| y | INT | - | - |

**Relasi:**
- `player_positions.id_match` → `matches.id_match` (Many-to-One)
- `player_positions.id_player` → `players.id_player` (Many-to-One)

---

### 23. **rotations**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_rotation | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| id_player | INT | FK | players.id_player |
| game_time | TIME | - | - |
| start_time | TIME | - | - |
| end_time | TIME | - | - |
| from_area | VARCHAR(100) | - | - |
| to_area | VARCHAR(100) | - | - |
| area | VARCHAR(100) | - | - |
| purpose | VARCHAR(100) | - | - |

**Relasi:**
- `rotations.id_match` → `matches.id_match` (Many-to-One)
- `rotations.id_player` → `players.id_player` (Many-to-One)

---

## 👁️ TEAM & PLAYER SCOUTING

### 24. **team_scouting**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_scouting | INT | PK | - |
| id_team | INT | FK | teams.id_team |
| id_match | INT | FK | matches.id_match |
| analyst_id | INT | - | - |
| scout_date | DATE | - | - |

**Relasi:**
- `team_scouting.id_team` → `teams.id_team` (Many-to-One)
- `team_scouting.id_match` → `matches.id_match` (Many-to-One)

---

### 25. **team_patterns**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_pattern | INT | PK | - |
| id_team | INT | FK | teams.id_team |
| id_player | INT | FK | players.id_player |
| pattern_type | VARCHAR(50) | - | - |
| weakness | TEXT | - | - |
| notes | TEXT | - | - |

**Relasi:**
- `team_patterns.id_team` → `teams.id_team` (Many-to-One)
- `team_patterns.id_player` → `players.id_player` (Many-to-One)

---

### 26. **player_scouting**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_player_scout | INT | PK | - |
| id_team | INT | FK | teams.id_team |
| id_player | INT | FK | players.id_player |
| scout_date | DATE | - | - |
| weakness | TEXT | - | - |
| playstyle | VARCHAR(100) | - | - |
| notes | TEXT | - | - |

**Relasi:**
- `player_scouting.id_team` → `teams.id_team` (Many-to-One)
- `player_scouting.id_player` → `players.id_player` (Many-to-One)

---

## 📹 VOD & GAME PLAN

### 27. **vod_reviews**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_vod | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| review_date | DATETIME | - | - |
| reviewer_id | INT | - | - |
| review_link | TEXT | - | - |
| summary | TEXT | - | - |

**Relasi:**
- `vod_reviews.id_match` → `matches.id_match` (Many-to-One)
- `vod_reviews.id_vod` ← `vod_events.id_vod` (One-to-Many)

---

### 28. **vod_events**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_event | INT | PK | - |
| id_vod | INT | FK | vod_reviews.id_vod |
| game_time | TIME | - | - |
| event_type | VARCHAR(50) | - | - |
| description | VARCHAR(255) | - | - |
| timestamp | DATETIME | - | - |
| category | VARCHAR(50) | - | - |
| title | VARCHAR(100) | - | - |

**Relasi:**
- `vod_events.id_vod` → `vod_reviews.id_vod` (Many-to-One)

---

### 29. **analyst_notes**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_note | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| analyst_id | INT | - | - |
| note_date | DATETIME | - | - |
| review_date | DATETIME | - | - |
| summary | TEXT | - | - |
| counter_strategy | VARCHAR(250) | - | - |
| description | VARCHAR(255) | - | - |

**Relasi:**
- `analyst_notes.id_match` → `matches.id_match` (Many-to-One)

---

### 30. **hero_patch_changes**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_patch_change | INT | PK | - |
| id_hero | INT | FK | heroes.id_hero |
| id_patch | INT | FK | patches.id_patch |
| changes_type | VARCHAR(50) | - | - |
| description | TEXT | - | - |
| importance | VARCHAR(50) | - | - |

**Relasi:**
- `hero_patch_changes.id_hero` → `heroes.id_hero` (Many-to-One)
- `hero_patch_changes.id_patch` → `patches.id_patch` (Many-to-One)

---

## 🎮 GAME PLAN & PATCH

### 31. **game_plans**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_game_plan | INT | PK | - |
| id_match | INT | FK | matches.id_match |
| team_id | INT | FK | teams.id_team |
| plan_type | VARCHAR(100) | - | - |
| description | TEXT | - | - |
| notes | TEXT | - | - |

**Relasi:**
- `game_plans.id_match` → `matches.id_match` (Many-to-One)
- `game_plans.team_id` → `teams.id_team` (Many-to-One)
- `game_plans.id_game_plan` ← `game_plan_priorities.id_game_plan` (One-to-Many)

---

### 32. **game_plan_priorities**
| Field | Type | Constraint | FK Reference |
|-------|------|-----------|--------------|
| id_priority | INT | PK | - |
| id_game_plan | INT | FK | game_plans.id_game_plan |
| priority_level | INT | - | - |
| early_game_plan | TEXT | - | - |
| mid_game_plan | TEXT | - | - |
| late_game_plan | TEXT | - | - |

**Relasi:**
- `game_plan_priorities.id_game_plan` → `game_plans.id_game_plan` (Many-to-One)

---

## 📝 RELATIONSHIP SUMMARY

### Primary Key (PK) Constraints
- Setiap tabel memiliki primary key yang unik mengidentifikasi setiap record

### Foreign Key (FK) Relationships

| From Table | From Field | To Table | To Field | Relationship |
|-----------|-----------|---------|---------|--------------|
| players | id_team | teams | id_team | Many-to-One |
| match_players | id_match | matches | id_match | Many-to-One |
| match_players | id_player | players | id_player | Many-to-One |
| match_players | id_hero | heroes | id_hero | Many-to-One |
| match_players | id_team | teams | id_team | Many-to-One |
| match_players | id_emblem | emblems | id_emblem | Many-to-One |
| matches | id_tournament | tournaments | id_tournament | Many-to-One |
| matches | id_team_1 | teams | id_team | Many-to-One |
| matches | id_team_2 | teams | id_team | Many-to-One |
| matches | id_patch | patches | id_patch | Many-to-One |
| drafts | id_match | matches | id_match | Many-to-One |
| drafts | id_patch | patches | id_patch | Many-to-One |
| drafts | id_team | teams | id_team | Many-to-One |
| draft_actions | id_draft | drafts | id_draft | Many-to-One |
| draft_actions | id_hero | heroes | id_hero | Many-to-One |
| draft_actions | id_team | teams | id_team | Many-to-One |
| hero_roles | id_hero | heroes | id_hero | Many-to-One |
| hero_roles | id_role | roles | id_role | Many-to-One |
| hero_counters | id_hero | heroes | id_hero | Many-to-One |
| hero_counters | id_counter_hero | heroes | id_hero | Many-to-One |
| hero_synergies | id_hero | heroes | id_hero | Many-to-One |
| hero_synergies | id_partner_hero | heroes | id_hero | Many-to-One |
| items | id_hero | heroes | id_hero | Many-to-One |
| item_components | id_item | items | id_item | Many-to-One |
| player_positions | id_match | matches | id_match | Many-to-One |
| player_positions | id_player | players | id_player | Many-to-One |
| rotations | id_match | matches | id_match | Many-to-One |
| rotations | id_player | players | id_player | Many-to-One |
| team_scouting | id_team | teams | id_team | Many-to-One |
| team_patterns | id_team | teams | id_team | Many-to-One |
| team_patterns | id_player | players | id_player | Many-to-One |
| player_scouting | id_team | teams | id_team | Many-to-One |
| player_scouting | id_player | players | id_player | Many-to-One |
| vod_reviews | id_match | matches | id_match | Many-to-One |
| vod_events | id_vod | vod_reviews | id_vod | Many-to-One |
| analyst_notes | id_match | matches | id_match | Many-to-One |
| hero_stats | id_hero | heroes | id_hero | Many-to-One |
| hero_stats | id_patch | patches | id_patch | Many-to-One |
| hero_patch_changes | id_hero | heroes | id_hero | Many-to-One |
| hero_patch_changes | id_patch | patches | id_patch | Many-to-One |
| game_plans | id_match | matches | id_match | Many-to-One |
| game_plans | team_id | teams | id_team | Many-to-One |
| game_plan_priorities | id_game_plan | game_plans | id_game_plan | Many-to-One |
| objectives | id_match | matches | id_match | Many-to-One |
| turrets | id_match | matches | id_match | Many-to-One |
| turrets | team_id | teams | id_team | Many-to-One |
| lords | id_match | matches | id_match | Many-to-One |
| lords | team_id | teams | id_team | Many-to-One |

---

## 🏗️ Database Design Principles

1. **Normalization**: Semua tabel sudah dalam bentuk 3NF (Third Normal Form)
2. **Referential Integrity**: Setiap FK menunjuk ke PK yang valid
3. **Scalability**: Desain mendukung pertumbuhan data dan query yang kompleks
4. **Performance**: Indexed keys untuk query yang cepat
5. **Data Integrity**: NOT NULL constraints pada field kritis
6. **Auditability**: Timestamp tracking untuk setiap record

---

*Dokumentasi ini dibuat untuk MLBB Analyst Database System - 2026*
