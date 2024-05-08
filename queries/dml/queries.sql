-- Insert sample data into the 'users' table
INSERT INTO users (email, password, first_name, last_name) VALUES
('user3@example.com', 'password3', 'Alice', 'Johnson'),
('user4@example.com', 'password4', 'Bob', 'Williams'),
('user5@example.com', 'password5', 'Eva', 'Brown'),
('user6@example.com', 'password6', 'Michael', 'Davis'),
('user7@example.com', 'password7', 'Olivia', 'Martinez');

-- Insert sample data into the 'chats' table
INSERT INTO chats (name, admin_id) VALUES
('Music Lovers', 1),
('Book Club', 1),
('Travel Enthusiasts', 2),
('Fitness Group', 2),
('Foodies Corner', 3);

-- Insert sample data into the 'messages' table
INSERT INTO messages (user_id, chat_id, text) VALUES
(1, 1, 'Any new songs?'),
(2, 1, 'Yes, I found a great playlist!'),
(1, 2, 'Which book are we discussing next?'),
(3, 3, 'Best travel destinations?'),
(4, 3, 'Planning a hiking trip!'),
(3, 3, 'Food recommendations for travel?'),
(2, 4, 'Workout routines?'),
(1, 4, 'Fitness challenges!'),
(3, 4, 'Healthy recipes?'),
(1, 5, 'New restaurant reviews?'),
(3, 5, 'Cooking experiments!'),
(1, 5, 'Food photography tips?');

-- Insert sample data into the 'chat_participants' table
INSERT INTO chat_participants (user_id, chat_id) VALUES
(3, 1),
(4, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(5, 4),
(6, 4),
(7, 5),
(5, 5),
(6, 5);

-- Insert sample data into the 'access_tokens' table
INSERT INTO access_tokens (user_id, token) VALUES
(3, 'token3'),
(4, 'token4'),
(5, 'token5'),
(6, 'token6'),
(7, 'token7');

-- Insert sample data into the 'sessions' table
INSERT INTO sessions (token_id, device, browser, version) VALUES
(1, 'Mobile', 'Chrome', '98.0'),
(2, 'Desktop', 'Firefox', '97.0'),
(3, 'Mobile', 'Safari', '15.0'),
(4, 'Desktop', 'Chrome', '98.0'),
(5, 'Mobile', 'Firefox', '97.0');



-- Update the 'users' table
UPDATE users SET first_name = 'Johnny' WHERE id = 1;

-- Update the 'chats' table
UPDATE chats SET name = 'Casual Chat' WHERE id = 1;

-- Update the 'messages' table
UPDATE messages SET is_read = TRUE WHERE id = 1;

-- Update the 'chat_participants' table
UPDATE chat_participants SET joined_at = NOW() WHERE user_id = 2 AND chat_id = 1;


-- Select all users
SELECT * FROM users;

-- Select users by email
SELECT * FROM users WHERE email = 'user1@example.com';

-- Select all chats
SELECT * FROM chats;

-- Select messages by user_id
SELECT * FROM messages WHERE user_id = 1;

-- Select participants in a chat
SELECT * FROM chat_participants WHERE chat_id = 1;



-- Delete a user
DELETE FROM users WHERE id = 2;

-- Delete a chat
DELETE FROM chats WHERE id = 2;

-- Delete messages older than a specific date
DELETE FROM messages WHERE created_at < '2024-01-01';

-- Remove a participant from a chat
DELETE FROM chat_participants WHERE user_id = 1 AND chat_id = 2;


-- Invalidate Access Token
UPDATE access_tokens SET is_valid = FALSE WHERE id = <token_id>;

-- Get Valid Tokens for a User
SELECT * FROM access_tokens WHERE user_id = <user_id> AND is_valid = TRUE;

-- Get User's Active Sessions
SELECT * FROM sessions WHERE token_id IN (SELECT id FROM access_tokens WHERE user_id = <user_id> AND is_valid = TRUE);

-- Insert New Access Token
INSERT INTO access_tokens (user_id, token) VALUES (<user_id>, '<new_token_value>');

-- Update Token Expiry Time
UPDATE access_tokens SET expiry_time = NOW() + INTERVAL 1 HOUR WHERE id = <token_id>;

-- Delete Expired Tokens
DELETE FROM access_tokens WHERE expiry_time < NOW();

-- Delete All Tokens for a User
DELETE FROM access_tokens WHERE user_id = <user_id>;

-- Update Token Status on Logout
UPDATE access_tokens SET is_valid = FALSE WHERE token = '<token_value>';

-- Find users who have active sessions
SELECT u.id, u.email
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM sessions s
    JOIN access_tokens at ON s.token_id = at.id
    WHERE at.user_id = u.id AND at.is_valid = 1
);

-- Count the number of messages per chat
SELECT c.id, c.name, COUNT(m.id) AS message_count
FROM chats c
LEFT JOIN messages m ON c.id = m.chat_id
GROUP BY c.id, c.name;

-- Users who have participated in multiple chats
SELECT u.id, u.email
FROM users u
JOIN chat_participants cp ON u.id = cp.user_id
GROUP BY u.id, u.email
HAVING COUNT(DISTINCT cp.chat_id) > 1;

-- Users with invalid access tokens
SELECT u.id, u.email
FROM users u
JOIN access_tokens at ON u.id = at.user_id
WHERE at.is_valid = 0;