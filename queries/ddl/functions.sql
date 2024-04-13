DELIMITER //

-- Count unread messages in chat
CREATE FUNCTION chat_unread_messages(chat_id INT) RETURNS INT
BEGIN
    DECLARE unread_count INT;

    SELECT COUNT(*) INTO unread_count
    FROM messages
    WHERE chat_id = chat_id AND is_read = FALSE;

    RETURN unread_count;
END//

-- Check if user is online with 15 min interval
CREATE FUNCTION is_user_online(user_id INT) RETURNS BOOLEAN
BEGIN
    DECLARE last_updated_at DATETIME;
    DECLARE is_online BOOLEAN;

    SET is_online = FALSE;

    SELECT updated_at INTO last_updated_at
    FROM users
    WHERE id = user_id;

    IF last_updated_at IS NOT NULL THEN
        IF TIMESTAMPDIFF(MINUTE, last_updated_at, NOW()) <= 15 THEN
            SET is_online = TRUE;
        END IF;
    END IF;

    RETURN is_online;
END//

DELIMITER ;
