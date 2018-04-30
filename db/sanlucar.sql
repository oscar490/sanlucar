------------------------------
-- Archivo de base de datos --
------------------------------

DROP TABLE IF EXISTS usuarios_id CASCADE;

CREATE TABLE usuarios_id
(
    id bigserial PRIMARY KEY
);

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios
(
    id         bigint       PRIMARY KEY REFERENCES usuarios_id (id)
  , email      varchar(255) NOT NULL UNIQUE
  , password   varchar(255) NOT NULL
  , nombre     varchar(255) NOT NULL
  , apellido   varchar(255) NOT NULL
  , biografia  varchar(255)
  , url_avatar varchar(255)
  , auth_key   varchar(255)
  , token_val  varchar(255) UNIQUE
  , token_pass varchar(255) UNIQUE
  , created_at timestamp(0) NOT NULL DEFAULT localtimestamp
  , updated_at timestamp(0)
);

DROP TABLE IF EXISTS trayectos CASCADE;

CREATE TABLE trayectos
(
    id           bigserial    PRIMARY KEY
  , origen       varchar(255) NOT NULL
  , destino      varchar(255) NOT NULL
  , conductor_id bigint       NOT NULL REFERENCES usuarios_id (id)
  , fecha        timestamp(0) NOT NULL
  , plazas       numeric(1)   NOT NULL
  , created_at   timestamp(0) NOT NULL DEFAULT localtimestamp
  , updated_at   timestamp(0)
);

DROP TABLE IF EXISTS coches CASCADE;

CREATE TABLE coches
(
    id         bigserial    PRIMARY KEY
  , marca      varchar(255) NOT NULL
  , modelo     varchar(255) NOT NULL
  , usuario_id bigint       NOT NULL REFERENCES usuarios_id (id)
  , plazas     numeric(1)   NOT NULL
  , created_at timestamp(0) NOT NULL DEFAULT localtimestamp
  , updated_at timestamp(0)
);

DROP TABLE IF EXISTS preferencias CASCADE;

CREATE TABLE preferencias
(
    id          bigserial    PRIMARY KEY
  , musica      boolean      NOT NULL
  , mascotas    boolean      NOT NULL
  , ninos       boolean      NOT NULL
  , fumar       boolean      NOT NULL
  , trayecto_id bigint       NOT NULL REFERENCES trayectos (id)
  , created_at  timestamp(0) NOT NULL DEFAULT localtimestamp
  , updated_at  timestamp(0)
);

INSERT INTO usuarios_id (id) VALUES (DEFAULT), (DEFAULT);

INSERT INTO usuarios (id, email, password, nombre, apellido, biografia, url_avatar)
    VALUES (1, 'rafa@rafa.com', crypt('rafa123', gen_salt('bf', 13)), 'Rafael', 'Bernal',
                'Me encanta conducir por Sanlúcar.',
                'https://www.dropbox.com/s/u52msq5uguwea2s/avatar-default.png?dl=1')
         , (2, 'pepe@pepe.com', crypt('pepe123', gen_salt('bf', 13)), 'Pepe', 'Romero',
                'Me gusta escuchar música mientras conduzco.',
                'https://www.dropbox.com/s/u52msq5uguwea2s/avatar-default.png?dl=1');

INSERT INTO trayectos (origen, destino, conductor_id, fecha, plazas)
    VALUES ('Calle San Nicolás', 'Calle Ancha', 1, localtimestamp + 'P1D'::interval, 4)
         , ('Calle Barrameda', 'Calle Ganado', 2, localtimestamp + 'P2D'::interval, 3);

INSERT INTO coches (marca, modelo, usuario_id, plazas)
    VALUES ('Opel', 'Corsa', 1, 5)
         , ('Nissan', 'Micra', 2, 7);

INSERT INTO preferencias (musica, mascotas, ninos, fumar, trayecto_id)
    VALUES (true, true, true, false, 1)
         , (true, false, true, false, 2);
