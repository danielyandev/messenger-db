-- Create user details view including mostly used columns
-- and additional is_online column which will be true
-- if the user was updated in the last 15 minutes
CREATE VIEW user_details_view AS
SELECT 
    id,
    email,
    first_name,
    last_name,
    is_user_online(id) AS is_online
FROM 
    users;