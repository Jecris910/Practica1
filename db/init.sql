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
