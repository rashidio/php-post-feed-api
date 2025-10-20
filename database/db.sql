DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS user_views;

CREATE TABLE posts (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  hotness INT UNSIGNED NOT NULL,
  views_count INT UNSIGNED NOT NULL DEFAULT 0,
  INDEX idx_hotness (hotness DESC, id DESC)
);

CREATE TABLE user_views (
  user_id BIGINT UNSIGNED NOT NULL,
  post_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, post_id),
  INDEX idx_user_id (user_id),
  INDEX idx_post_id (post_id)
);
