CREATE TABLE dog (
    id                    BIGSERIAL PRIMARY KEY,
    name                  VARCHAR(100),
    size                  VARCHAR(20)  NOT NULL,
    color                 VARCHAR(60)  NOT NULL,
    description           VARCHAR(1000),
    photo_filename        VARCHAR(255),
    initial_health_status VARCHAR(30)  NOT NULL,
    initial_area_label    VARCHAR(200),
    initial_latitude      DOUBLE PRECISION,
    initial_longitude     DOUBLE PRECISION,
    created_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_user (
    id            BIGSERIAL PRIMARY KEY,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    display_name  VARCHAR(100) NOT NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON app_user(email);

CREATE TABLE sighting (
    id             BIGSERIAL PRIMARY KEY,
    dog_id         BIGINT       NOT NULL,
    health_status  VARCHAR(30)  NOT NULL,
    note           VARCHAR(1000),
    area_label     VARCHAR(200),
    latitude       DOUBLE PRECISION,
    longitude      DOUBLE PRECISION,
    photo_filename VARCHAR(255),
    reporter_id    BIGINT,
    reported_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sighting_dog      FOREIGN KEY (dog_id)      REFERENCES dog(id)      ON DELETE CASCADE,
    CONSTRAINT fk_sighting_reporter FOREIGN KEY (reporter_id) REFERENCES app_user(id) ON DELETE SET NULL
);

CREATE INDEX idx_sighting_dog_id      ON sighting(dog_id);
CREATE INDEX idx_sighting_reported_at ON sighting(reported_at);
CREATE INDEX idx_sighting_reporter    ON sighting(reporter_id);