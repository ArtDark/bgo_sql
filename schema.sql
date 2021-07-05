
CREATE TABLE clients
(
    id        BIGSERIAL PRIMARY KEY,
    login     TEXT      NOT NULL UNIQUE,
    password  TEXT      NOT NULL,
    full_name TEXT      NOT NULL,
    passport  TEXT      NOT NULL,
    birthday  DATE      NOT NULL,
    status    TEXT      NOT NULL DEFAULT 'INACTIVE' CHECK (status IN ('INACTIVE', 'ACTIVE')),
    created   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cards
(
    id       BIGSERIAL PRIMARY KEY,
    number   TEXT      NOT NULL,
    balance  BIGINT    NOT NULL DEFAULT 0,
    issuer   TEXT      NOT NULL CHECK ( issuer IN ('Visa', 'MasterCard', 'MIR') ),
    holder   TEXT      NOT NULL,
    owner_id BIGINT    NOT NULL REFERENCES clients,
    status   TEXT      NOT NULL DEFAULT 'INACTIVE' CHECK (status IN ('INACTIVE', 'ACTIVE')),
    created  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name     TEXT      NOT NULL
);

CREATE TABLE icons

(   pic      BYTEA     NOT NULL default 'some picture',
    name     TEXT      NOT NULL PRIMARY KEY,
    status   TEXT      NOT NULL DEFAULT 'Fail' CHECK (status IN ('Fail', 'Ok')),
    created  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transactions
(
    id                 BIGSERIAL PRIMARY KEY, --ID транзакции
    card_name          TEXT      NOT NULL,
    bill               BIGINT    NOT NULL,
    transaction_type   TEXT      NOT NULL,
    owner_id           BIGINT    NOT NULL REFERENCES cards,
    icon               TEXT      NOT NULL REFERENCES icons,
    status             TEXT      NOT NULL DEFAULT 'Fail' CHECK (status IN ('Fail', 'Ok')),
    created            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
