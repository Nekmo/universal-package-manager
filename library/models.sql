CREATE TABLE branch (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    last_update INTEGER,
    change_date INTEGER
);

CREATE TABLE checksum_method (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE operating_system (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE architecture (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE arch (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    operating_system INTEGER, /* Véase operating_system */
    architecture INTEGER /* Véase architecture */
);

/* Paquetes locales */

CREATE TABLE local_group (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE local_package (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    branch INTEGER, /* Ver tabla branch */
    creation_date INTEGER NOT NULL, /* Fecha de creación del paquete  */
    revision REAL NOT NULL, /* Numeración de versiones/revisiones. <versión>.<revisión> */
    version, TEXT NOT NULL,
    install_datel INTEGER NOT NULL,
    arch INTEGER, /* Véase arch */
    checksum INTEGER,
    checksum_method INTEGER, /* Véase checksum_method */
    local_group INTEGER /* véase local_group */
);

CREATE TABLE local_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_dependence (
  local_package_id  int NOT NULL,
  local_dependence_id    int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_dependence_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_dependence_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_dependence_relation_ibfk_2
    FOREIGN KEY (local_dependence_id)
    REFERENCES local_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE local_conflict (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_conflict (
  local_package_id  int NOT NULL,
  local_conflict_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_conflict_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_conflict_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_conflict_relation_ibfk_2
    FOREIGN KEY (local_conflict_id)
    REFERENCES local_conflict(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE local_replace (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_replace (
  local_package_id  int NOT NULL,
  local_replace_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_replace_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_replace_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_replace_relation_ibfk_2
    FOREIGN KEY (local_replace_id)
    REFERENCES local_replace(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE local_make_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_make_dependence (
  local_package_id  int NOT NULL,
  local_make_dependence_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_make_dependence_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_make_dependence_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_make_dependence_relation_ibfk_2
    FOREIGN KEY (local_make_dependence_id)
    REFERENCES local_make_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE local_opt_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_opt_dependence (
  local_package_id  int NOT NULL,
  local_opt_dependence_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_opt_dependence_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_opt_dependence_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_opt_dependence_relation_ibfk_2
    FOREIGN KEY (local_opt_dependence_id)
    REFERENCES local_opt_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE local_provide (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE local_package_local_provide (
  local_package_id  int NOT NULL,
  local_provide_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (local_package_id, local_provide_id),
  /* Foreign keys */
  CONSTRAINT local_package_local_provide_relation_ibfk_1
    FOREIGN KEY (local_package_id)
    REFERENCES local_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT local_package_local_provide_relation_ibfk_2
    FOREIGN KEY (local_provide_id)
    REFERENCES local_provide(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

/* Paquetes servidor */
CREATE TABLE repo_group (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE repo_package (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    branch INTEGER,
    creation_date INTEGER NOT NULL, /* Fecha de creación del paquete  */
    revision REAL NOT NULL, /* Numeración de versiones/revisiones. <versión>.<revisión> */
    version TEXT NOT NULL,
    install_date INTEGER NOT NULL,
    arch INTEGER, /* Véase arch */
    checksum INTEGER,
    checksum_method INTEGER, /* Véase checksum_method */
    repo_group INTEGER /* véase repo_group */
);

CREATE TABLE repo_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_dependence (
  repo_package_id  int NOT NULL,
  repo_dependence_id    int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_dependence_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_dependence_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_dependence_relation_ibfk_2
    FOREIGN KEY (repo_dependence_id)
    REFERENCES repo_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE repo_conflict (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_conflict (
  repo_package_id  int NOT NULL,
  repo_conflict_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_conflict_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_conflict_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_conflict_relation_ibfk_2
    FOREIGN KEY (repo_conflict_id)
    REFERENCES repo_conflict(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE repo_replace (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_replace (
  repo_package_id  int NOT NULL,
  repo_replace_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_replace_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_replace_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_replace_relation_ibfk_2
    FOREIGN KEY (repo_replace_id)
    REFERENCES repo_replace(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE repo_make_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_make_dependence (
  repo_package_id  int NOT NULL,
  repo_make_dependence_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_make_dependence_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_make_dependence_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_make_dependence_relation_ibfk_2
    FOREIGN KEY (repo_make_dependence_id)
    REFERENCES repo_make_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE repo_opt_dependence (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_opt_dependence (
  repo_package_id  int NOT NULL,
  repo_opt_dependence_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_opt_dependence_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_opt_dependence_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_opt_dependence_relation_ibfk_2
    FOREIGN KEY (repo_opt_dependence_id)
    REFERENCES repo_opt_dependence(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

CREATE TABLE repo_provide (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    min_version TEXT,
    max_version TEXT,
    max_revision REAL,
    min_revision REAL
);

/* Many to Many */
CREATE TABLE repo_package_repo_provide (
  repo_package_id  int NOT NULL,
  repo_provide_id  int NOT NULL,
  /* Keys */
  PRIMARY KEY (repo_package_id, repo_provide_id),
  /* Foreign keys */
  CONSTRAINT repo_package_repo_provide_relation_ibfk_1
    FOREIGN KEY (repo_package_id)
    REFERENCES repo_package(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT, 
  CONSTRAINT repo_package_repo_provide_relation_ibfk_2
    FOREIGN KEY (repo_provide_id)
    REFERENCES repo_provide(id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);