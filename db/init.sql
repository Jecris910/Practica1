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
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- Original series - Season 1
INSERT INTO teams (name, category, school_or_country) VALUES
('Raimon', 'Original Season 1', 'Raimon Junior High'),
('Royal Academy', 'Original Season 1', 'Royal Academy'),
('Zeus', 'Original Season 1', 'Zeus Junior High'),
('Occult', 'Original Season 1', 'Occult Junior High'),
('Wild', 'Original Season 1', 'Wild Junior High');

-- Original series - Season 2
INSERT INTO teams (name, category, school_or_country) VALUES
('Gemini Storm', 'Original Season 2', 'Alius Academy'),
('Epsilon', 'Original Season 2', 'Alius Academy'),
('Diamond Dust', 'Original Season 2', 'Alius Academy'),
('Prominence', 'Original Season 2', 'Alius Academy'),
('Genesis', 'Original Season 2', 'Alius Academy');

-- Original series - Season 3
INSERT INTO teams (name, category, school_or_country) VALUES
('Inazuma Japan', 'Original Season 3', 'Japan'),
('Fire Dragon', 'Original Season 3', 'South Korea'),
('Knights of Queen', 'Original Season 3', 'England'),
('The Empire', 'Original Season 3', 'Argentina'),
('Little Gigant', 'Original Season 3', 'Cotarl');

-- Inazuma Eleven GO - Season 1
INSERT INTO teams (name, category, school_or_country) VALUES
('Raimon GO', 'GO Season 1', 'Raimon Junior High'),
('Royal Academy GO', 'GO Season 1', 'Royal Academy'),
('Kirkwood GO', 'GO Season 1', 'Kirkwood Junior High'),
('Alpine GO', 'GO Season 1', 'Alpine Junior High'),
('Dragonlink', 'GO Season 1', 'Fifth Sector');

-- Inazuma Japan starting eleven
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Mark Evans', 'Goalkeeper', 'Mountain', 'God Hand', 'Majin The Hand', 11),
('Jack Wallside', 'Defender', 'Mountain', 'The Wall', 'The Mountain', 11),
('Nathan Swift', 'Defender', 'Wind', 'Flurry Dash', 'Hurricane Arrow', 11),
('Hurley Kane', 'Defender', 'Wind', 'Tsunami Boost', 'Whale Guard', 11),
('Scotty Banyan', 'Defender', 'Forest', 'Clone Defense', 'Perfect Tower', 11),
('Jude Sharp', 'Midfielder', 'Forest', 'Emperor Penguin No. 2', 'Death Zone 2', 11),
('Caleb Stonewall', 'Midfielder', 'Fire', 'Killer Fields', 'Emperor Penguin No. 3', 11),
('Shawn Froste', 'Midfielder', 'Wind', 'Eternal Blizzard', 'Wolf Legend', 11),
('Axel Blaze', 'Forward', 'Fire', 'Fire Tornado', 'Maximum Fire', 11),
('Xavier Foster', 'Forward', 'Fire', 'Meteor Blade', 'Grand Fire', 11),
('Austin Hobbes', 'Forward', 'Forest', 'Tiger Drive', 'Gladius Arch', 11);

-- Original Season 1 - Raimon
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Mark Evans', 'Goalkeeper', 'Mountain', 'God Hand', 'Majin The Hand', 1),
('Nathan Swift', 'Defender', 'Wind', 'Flurry Dash', 'Spinning Cut', 1),
('Jack Wallside', 'Defender', 'Mountain', 'The Wall', 'The Mountain', 1),
('Jim Wraith', 'Defender', 'Forest', 'Coil Turn', 'Spinning Cut', 1),
('Tod Ironside', 'Defender', 'Fire', 'Dash Storm', 'Quick Draw', 1),
('Steve Grim', 'Midfielder', 'Forest', 'Grenade Shot', 'Rolling Kick', 1),
('Tim Saunders', 'Midfielder', 'Forest', 'Kung Fu Attack', 'Whirlwind Force', 1),
('Sam Kincaid', 'Midfielder', 'Mountain', 'Grenade Shot', 'Quick Draw', 1),
('Maxwell Carson', 'Midfielder', 'Wind', 'Cross Drive', 'Quick Draw', 1),
('Axel Blaze', 'Forward', 'Fire', 'Fire Tornado', 'Inazuma Break', 1),
('Kevin Dragonfly', 'Forward', 'Forest', 'Dragon Crash', 'Dragon Tornado', 1);

-- Original Season 1 - Royal Academy
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Joseph King', 'Goalkeeper', 'Mountain', 'Power Shield', 'Beast Fang', 2),
('Jude Sharp', 'Midfielder', 'Forest', 'Illusion Ball', 'Emperor Penguin No. 2', 2),
('David Samford', 'Forward', 'Forest', 'Emperor Penguin No. 2', 'Emperor Penguin No. 1', 2),
('Daniel Hatch', 'Forward', 'Fire', 'Twin Boost', 'Death Zone', 2),
('Ben Simmons', 'Defender', 'Mountain', 'Killer Slide', 'Power Charge', 2);

-- Original Season 1 - Zeus
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Paul Siddon', 'Goalkeeper', 'Mountain', 'Gigant Wall', 'Divine Shield', 3),
('Apollo Light', 'Defender', 'Fire', 'Divine Arrow', 'Heaven Time', 3),
('Artie Mishman', 'Midfielder', 'Forest', 'Heaven Time', 'Divine Strike', 3),
('Jonas Demetrius', 'Forward', 'Mountain', 'Divine Strike', 'God Knows', 3),
('Byron Love', 'Forward', 'Wind', 'God Knows', 'Heaven Time', 3);

-- Original Season 1 - Occult
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Nathan Jones', 'Goalkeeper', 'Wind', 'Phantom Hand', 'Ghost Pull', 4),
('Russell Walk', 'Defender', 'Forest', 'Ghost Pull', 'Phantom Shot', 4),
('Jason Jones', 'Defender', 'Wind', 'Ghost Pull', 'Phantom Shot', 4),
('Johan Tassman', 'Midfielder', 'Forest', 'Ghost Lock', 'Phantom Shot', 4),
('Burt Wolf', 'Forward', 'Fire', 'Phantom Shot', 'Ghost Lock', 4);

-- Original Season 1 - Wild
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Charlie Boardfield', 'Goalkeeper', 'Mountain', 'Tarzan Kick', 'Wild Claw', 5),
('Hugo Talgeese', 'Midfielder', 'Fire', 'Spinning Cut', 'Bird of Fire', 5),
('Cham Lion', 'Midfielder', 'Forest', 'Chameleon Shot', 'Wild Claw', 5),
('Gary Lancaster', 'Forward', 'Mountain', 'Monkey Turn', 'Wild Claw', 5),
('Adrian Speed', 'Forward', 'Wind', 'Cheetah Sprint', 'Wild Claw', 5);

-- Original Season 2 - Gemini Storm
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Jordan Greenway', 'Midfielder', 'Wind', 'Astro Break', 'Cosmic Blast', 6),
('Janus', 'Forward', 'Wind', 'Astro Break', 'Universe Blast', 6),
('Io', 'Defender', 'Mountain', 'Gravitational Force', 'Meteor Shower', 6),
('Ganymede', 'Midfielder', 'Forest', 'Meteor Shower', 'Cosmic Blast', 6),
('Callisto', 'Goalkeeper', 'Mountain', 'Black Hole', 'Gravitational Force', 6);

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

-- Original Season 2 - Prominence
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Torch', 'Forward', 'Fire', 'Atomic Flare', 'Burning Phase', 9),
('Heat', 'Midfielder', 'Fire', 'Burning Phase', 'Atomic Flare', 9),
('Bomber', 'Defender', 'Mountain', 'Flame Dance', 'Fire Wall', 9),
('Nepper', 'Midfielder', 'Forest', 'Fire Blizzard', 'Flame Dance', 9),
('Grent', 'Goalkeeper', 'Mountain', 'Fire Wall', 'Burning Catch', 9);

-- Original Season 2 - Genesis
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Xavier Foster', 'Forward', 'Fire', 'Meteor Blade', 'Supernova', 10),
('Bellatrix', 'Midfielder', 'Forest', 'Space Penguin', 'Supernova', 10),
('Wheeze', 'Defender', 'Wind', 'Celestial Smash', 'Space Penguin', 10),
('Quill', 'Midfielder', 'Mountain', 'Gaia Break', 'Supernova', 10),
('Nero', 'Goalkeeper', 'Mountain', 'Procyon Net', 'Black Hole', 10);

-- Original Season 3 - Fire Dragon
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Jung-soo Jo', 'Goalkeeper', 'Mountain', 'Burning Catch', 'Power Shield', 12),
('Chang-soo Choi', 'Midfielder', 'Forest', 'Dragon Slayer', 'Perfect Zone Press', 12),
('Byron Love', 'Forward', 'Wind', 'God Knows', 'Heaven Time', 12),
('Torch', 'Forward', 'Fire', 'Atomic Flare', 'Chaos Break', 12),
('Gazelle', 'Forward', 'Wind', 'Northern Impact', 'Chaos Break', 12);

-- Original Season 3 - Knights of Queen
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Freddie McQueen', 'Goalkeeper', 'Mountain', 'Galatyn', 'Paladin Guard', 13),
('Johnny Gascoigne', 'Defender', 'Mountain', 'Stone Prison', 'Paladin Strike', 13),
('David Buckingham', 'Defender', 'Forest', 'Paladin Strike', 'Stone Prison', 13),
('Lance Rotten', 'Defender', 'Fire', 'Ultra Moon', 'Paladin Guard', 13),
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
('Ade Kebe', 'Midfielder', 'Wind', 'Water Whirl', 'Quick Dash', 16),
('Arion Sherwind', 'Midfielder', 'Wind', 'Easy Breezy', 'Mach Wind', 16),
('Riccardo Di Rigo', 'Midfielder', 'Forest', 'Fortissimo Foot', 'Harmonics', 16),
('Victor Blade', 'Forward', 'Fire', 'Doom Sword', 'Death Drop', 16),
('Michael Ballzack', 'Forward', 'Mountain', 'Sidewinder', 'Power Spike', 16),
('Ryoma Nishiki', 'Midfielder', 'Fire', 'Acrobat Keep', 'Samurai Strike', 16),
('Aitor Cazador', 'Defender', 'Forest', 'Hunter Net', 'Propulsion Defense', 16);

-- GO Season 1 - Royal Academy GO
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Preston Princeton', 'Goalkeeper', 'Mountain', 'Power Clear', 'Force Save', 17),
('Rex Remington', 'Forward', 'Mountain', 'Emperor Penguin No. 7', 'Crow Fury', 17),
('Oxford', 'Defender', 'Wind', 'Grand Whirlwind', 'Explosive Cross', 17),
('Cornell', 'Midfielder', 'Forest', 'Grand Whirlwind', 'Explosive Cross', 17),
('Stanford', 'Forward', 'Fire', 'Explosive Cross', 'Power Shot', 17);

-- GO Season 1 - Kirkwood GO
INSERT INTO players (name, position, element, best_move_1, best_move_2, team_id) VALUES
('Bay Laurel', 'Forward', 'Forest', 'Tiger Drive', 'Tiger Storm', 18),
('Bradford Ash', 'Midfielder', 'Fire', 'Cutting Pincers', 'Tiger Drive', 18),
('Langford Ash', 'Defender', 'Mountain', 'Power Defense', 'Cutting Pincers', 18),
('Dock Hickory', 'Goalkeeper', 'Mountain', 'Wooden Wall', 'Power Catch', 18),
('Beck Heath', 'Midfielder', 'Wind', 'Tiger Attack', 'Quick Dash', 18);

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
