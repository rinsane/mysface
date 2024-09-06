SHOW DATABASES;

SELECT user, host, plugin FROM mysql.user WHERE user = 'root';

CREATE DATABASE students;