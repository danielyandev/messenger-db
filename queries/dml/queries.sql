-- Insert sample data into the 'users' table
INSERT INTO users (email, password, first_name, last_name) VALUES
('user1@example.com', 'password1', 'John', 'Doe'),
('user2@example.com', 'password2', 'Jane', 'Smith');

-- Insert sample data into the 'chats' table
INSERT INTO chats (name, admin_id) VALUES
('General Chat', 1),
('Tech Talk', 2);

-- Insert sample data into the 'messages' table
INSERT INTO messages (user_id, chat_id, text) VALUES
(1, 1, 'Hello, everyone!'),
(2, 1, 'Hi John!'),
(1, 2, 'Any tech updates?');

-- Insert sample data into the 'chat_participants' table
INSERT INTO chat_participants (user_id, chat_id) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2);


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