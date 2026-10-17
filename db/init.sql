USE practica1;

CREATE TABLE IF NOT EXISTS teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    school_or_country VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    element VARCHAR(20) NOT NULL,
    best_move_1 VARCHAR(100) NOT NULL,
    best_move_2 VARCHAR(100) NOT NULL,
    image_path VARCHAR(255),
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- Original series - Season 1
INSERT INTO teams (id, name, category, school_or_country) VALUES
(1, 'Raimon', 'Original Season 1', 'Raimon Junior High'),
(2, 'Royal Academy', 'Original Season 1', 'Royal Academy'),
(3, 'Zeus', 'Original Season 1', 'Zeus Junior High'),
(4, 'Occult', 'Original Season 1', 'Occult Junior High');

-- Original series - Season 2
INSERT INTO teams (id, name, category, school_or_country) VALUES
(6, 'Gemini Storm', 'Original Season 2', 'Alius Academy'),
(7, 'Epsilon', 'Original Season 2', 'Alius Academy'),
(8, 'Diamond Dust', 'Original Season 2', 'Alius Academy'),
(10, 'Genesis', 'Original Season 2', 'Alius Academy');

-- Original series - Season 3
INSERT INTO teams (id, name, category, school_or_country) VALUES
(11, 'Inazuma Japan', 'Original Season 3', 'Japan'),
(13, 'Knights of Queen', 'Original Season 3', 'England'),
(14, 'The Empire', 'Original Season 3', 'Argentina'),
(15, 'Little Gigant', 'Original Season 3', 'Cotarl');

-- Inazuma Eleven GO - Season 1
INSERT INTO teams (id, name, category, school_or_country) VALUES
(16, 'Raimon GO', 'GO Season 1', 'Raimon Junior High'),
(17, 'Royal Academy GO', 'GO Season 1', 'Royal Academy'),
(19, 'Alpine GO', 'GO Season 1', 'Alpine Junior High'),
(20, 'Dragonlink', 'GO Season 1', 'Fifth Sector');

-- Inazuma Japan starting eleven
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Hurley Kane', 'Defender', 'Wind', 'Tsunami Boost', 'Whale Guard', 11),
('Scotty Banyan', 'Defender', 'Forest', 'Clone Defense', 'Perfect Tower', 11),
('Caleb Stonewall', 'Midfielder', 'Fire', 'Killer Fields', 'Emperor Penguin No. 3', 11),
('Shawn Froste', 'Midfielder', 'Wind', 'Eternal Blizzard', 'Wolf Legend', 11),
('Xavier Foster', 'Forward', 'Fire', 'Meteor Blade', 'Grand Fire', 11),
('Austin Hobbes', 'Forward', 'Forest', 'Tiger Drive', 'Gladius Arch', 11);

-- Original Season 1 - Raimon
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Mark Evans', 'Goalkeeper', 'Mountain', 'God Hand', 'Majin The Hand', 1),
('Nathan Swift', 'Defender', 'Wind', 'Flurry Dash', 'Spinning Cut', 1),
('Jack Wallside', 'Defender', 'Mountain', 'The Wall', 'The Mountain', 1),
('Axel Blaze', 'Forward', 'Fire', 'Fire Tornado', 'Inazuma Break', 1),
('Kevin Dragonfly', 'Forward', 'Forest', 'Dragon Crash', 'Dragon Tornado', 1);

-- Original Season 1 - Royal Academy
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Joseph King', 'Goalkeeper', 'Mountain', 'Power Shield', 'Beast Fang', 2),
('Jude Sharp', 'Midfielder', 'Forest', 'Illusion Ball', 'Emperor Penguin No. 2', 2),
('David Samford', 'Forward', 'Forest', 'Emperor Penguin No. 2', 'Emperor Penguin No. 1', 2);

-- Original Season 1 - Zeus
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Byron Love', 'Forward', 'Wind', 'God Knows', 'Heaven Time', 3);

-- Original Season 1 - Occult

-- Original Season 2 - Gemini Storm
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Jordan Greenway', 'Midfielder', 'Wind', 'Astro Break', 'Cosmic Blast', 6);

-- Original Season 2 - Epsilon
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Dvalin', 'Goalkeeper', 'Mountain', 'Wormhole', 'Black Hole', 7),
('Desarm', 'Forward', 'Fire', 'Gungnir', 'Northern Impact', 7),
('Zell', 'Midfielder', 'Wind', 'Meteor Shower', 'Gaia Break', 7),
('Metron', 'Defender', 'Forest', 'Gravitational Force', 'Cosmic Blast', 7),
('Kormer', 'Midfielder', 'Mountain', 'Gaia Break', 'Meteor Shower', 7);

-- Original Season 2 - Diamond Dust
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Gazelle', 'Forward', 'Wind', 'Northern Impact', 'Frozen Steal', 8),
('Icer', 'Goalkeeper', 'Mountain', 'Frozen Wall', 'Ice Block', 8),
('Beluga', 'Defender', 'Wind', 'Frozen Steal', 'Ice Ground', 8),
('Gocker', 'Midfielder', 'Forest', 'Ice Ground', 'Northern Impact', 8),
('Clara', 'Midfielder', 'Wind', 'Frozen Steal', 'Ice Block', 8);

-- Original Season 2 - Genesis
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Bellatrix', 'Midfielder', 'Forest', 'Space Penguin', 'Supernova', 10),
('Wheeze', 'Defender', 'Wind', 'Celestial Smash', 'Space Penguin', 10),
('Quill', 'Midfielder', 'Mountain', 'Gaia Break', 'Supernova', 10),
('Nero', 'Goalkeeper', 'Mountain', 'Procyon Net', 'Black Hole', 10);

-- Original Season 3 - Knights of Queen
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Edgar Valtinas', 'Forward', 'Forest', 'Excalibur', 'Paladin Strike', 13);

-- Original Season 3 - The Empire
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Jorge Ortega', 'Goalkeeper', 'Mountain', 'Iron Wall', 'Million Hands', 14),
('Teles Torrue', 'Defender', 'Mountain', 'Iron Wall', 'Zigzag Spark', 14),
('Julio Acosta', 'Defender', 'Forest', 'Zigzag Spark', 'Rolling Slide', 14),
('Gordo Diaz', 'Midfielder', 'Mountain', 'Andes Antlion', 'Iron Wall', 14),
('Roberto Torres', 'Midfielder', 'Wind', 'Andes Antlion', 'Rolling Slide', 14);

-- Original Season 3 - Little Gigant
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Rococo Ulpa', 'Goalkeeper', 'Mountain', 'God Hand X', 'Tamashii The Hand', 15),
('Windy Fasta', 'Defender', 'Wind', 'Air Ride', 'Double Jaw', 15),
('Walter Mountain', 'Defender', 'Mountain', 'Ground Quake', 'Rock Wall Dam', 15),
('Ghoshu Flare', 'Forward', 'Fire', 'Double Jaw', 'X Blast', 15),
('Drago Hill', 'Forward', 'Mountain', 'X Blast', 'Double Jaw', 15);

-- GO Season 1 - Raimon GO
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Samguk Han', 'Goalkeeper', 'Fire', 'Burning Catch', 'Gaia Barrier', 16),
('Subaru Honda', 'Defender', 'Mountain', 'Full Steam', 'Power Defense', 16),
('Gabriel Garcia', 'Defender', 'Forest', 'The Mist', 'Mystic Mist', 16),
('Jean-Pierre Lapin', 'Defender', 'Mountain', 'Incandescent Jump', 'Air Steps', 16),
('Arion Sherwind', 'Midfielder', 'Wind', 'Easy Breezy', 'Mach Wind', 16),
('Riccardo Di Rigo', 'Midfielder', 'Forest', 'Fortissimo Foot', 'Harmonics', 16),
('Victor Blade', 'Forward', 'Fire', 'Doom Sword', 'Death Drop', 16),
('Ryoma Nishiki', 'Midfielder', 'Fire', 'Acrobat Keep', 'Samurai Strike', 16),
('Aitor Cazador', 'Defender', 'Forest', 'Hunter Net', 'Propulsion Defense', 16);

-- GO Season 1 - Royal Academy GO
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Preston Princeton', 'Goalkeeper', 'Mountain', 'Power Clear', 'Force Save', 17),
('Rex Remington', 'Forward', 'Mountain', 'Emperor Penguin No. 7', 'Crow Fury', 17),
('Oxford', 'Defender', 'Wind', 'Grand Whirlwind', 'Explosive Cross', 17),
('Cornell', 'Midfielder', 'Forest', 'Grand Whirlwind', 'Explosive Cross', 17),
('Stanford', 'Forward', 'Fire', 'Explosive Cross', 'Power Shot', 17);

-- GO Season 1 - Alpine GO
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Wolfe Whyte', 'Goalkeeper', 'Mountain', 'Ice Block', 'Frozen Wall', 19),
('Sascha Kotch', 'Defender', 'Mountain', 'Snow Fortress', 'Ice Ground', 19),
('Guy l''Acier', 'Defender', 'Forest', 'Frozen Steal', 'Ice Ground', 19),
('Art Tundra', 'Midfielder', 'Wind', 'Snowstorm', 'Frozen Steal', 19),
('Njord Snio', 'Forward', 'Wind', 'White Hurricane', 'Northern Impact', 19);

-- GO Season 1 - Dragonlink
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Senguuji Yamato', 'Goalkeeper', 'Mountain', 'King Fire', 'Titan Wall', 20),
('Gomaki Tetsurou', 'Defender', 'Mountain', 'Thousand Road', 'Power Defense', 20),
('Gouishi Senma', 'Defender', 'Fire', 'Thousand Road', 'Heavy Block', 20),
('Seijou Shougo', 'Forward', 'Wind', 'Thousand Road', 'Dragon Shot', 20),
('Godai Shingo', 'Forward', 'Fire', 'Dragon Shot', 'Power Spike', 20);

-- Original Season 3 - Orpheus
INSERT INTO teams (name, category, school_or_country) VALUES
('Orpheus', 'Original Season 3', 'Italy');

INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Gigi Blasi', 'Goalkeeper', 'Wind', 'Colosseum Guard', 'Catenaccio Counter', 21),
('Angelo Gabrini', 'Defender', 'Forest', 'Echo Ball', 'Catenaccio Counter', 21),
('Nakata Hidetoshi', 'Midfielder', 'Forest', 'Brave Shot', 'Catenaccio Counter', 21),
('Paolo Bianchi', 'Forward', 'Forest', 'Odin Sword', 'Brave Shot', 21),
('Raffaele Generani', 'Forward', 'Fire', 'Freeze Shot', 'Odin Sword', 21);
