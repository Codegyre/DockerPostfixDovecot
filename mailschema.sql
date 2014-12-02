CREATE TABLE `mail_virtual_domains` (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mail_virtual_users` (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  domain_id INT(11) NOT NULL,
  user VARCHAR(40) NOT NULL,
  password VARCHAR(32) NOT NULL,
CONSTRAINT UNIQUE_EMAIL UNIQUE (domain_id,user),
FOREIGN KEY (domain_id) REFERENCES mail_virtual_domains(id) ON DELETE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mail_virtual_aliases` (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  domain_id INT(11) NOT NULL,
  source VARCHAR(40) NOT NULL,
  destination VARCHAR(80) NOT NULL,
FOREIGN KEY (domain_id) REFERENCES mail_virtual_domains(id) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE VIEW mail_view_users AS
SELECT CONCAT(mail_virtual_users.user, '@', mail_virtual_domains.name) AS email,
  mail_virtual_users.password
FROM mail_virtual_users
LEFT JOIN mail_virtual_domains ON mail_virtual_users.domain_id=mail_virtual_domains.id;

CREATE VIEW mail_view_aliases AS
SELECT CONCAT(mail_virtual_aliases.source, '@', mail_virtual_domains.name) AS email,
  destination
FROM mail_virtual_aliases
LEFT JOIN mail_virtual_domains ON mail_virtual_aliases.domain_id=mail_virtual_domains.id; 
