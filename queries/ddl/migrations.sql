-- Start a transaction
START TRANSACTION;

-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS messenger;
USE messenger;

-- Create 'users' table if it does not exist
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create 'access_tokens' table if it does not exist
CREATE TABLE IF NOT EXISTS access_tokens (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  token VARCHAR(1024) NOT NULL,
  is_valid BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create 'sessions' table if it does not exist
CREATE TABLE IF NOT EXISTS sessions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  token_id INT,
  device VARCHAR(255) NOT NULL,
  browser VARCHAR(255) NOT NULL,
  version VARCHAR(255) NOT NULL,
  FOREIGN KEY (token_id) REFERENCES access_tokens(id)
);

-- Create 'notifications' table if it does not exist
CREATE TABLE IF NOT EXISTS notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  type VARCHAR(255) NOT NULL,
  text VARCHAR(255) NOT NULL,
  is_delivered BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create 'chats' table if it does not exist
CREATE TABLE IF NOT EXISTS chats (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  admin_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (admin_id) REFERENCES users(id)
);

-- Create 'messages' table if it does not exist
CREATE TABLE IF NOT EXISTS messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  chat_id INT,
  text TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (chat_id) REFERENCES chats(id)
);

-- Create 'chat_participants' table if it does not exist
CREATE TABLE IF NOT EXISTS chat_participants (
  user_id INT,
  chat_id INT,
  joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, chat_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (chat_id) REFERENCES chats(id)
);

-- Commit the transaction to finalize the changes
COMMIT;
