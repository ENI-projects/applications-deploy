CREATE SCHEMA armadacar;
CREATE TABLE armadacar.courses (
    id integer NOT NULL,
    date_debut timestamp with time zone NOT NULL,
    date_fin timestamp with time zone NOT NULL,
    lieu_depart text NOT NULL,
    lieu_arrivee text NOT NULL,
    remarque text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_voiture integer NOT NULL
);
CREATE SEQUENCE armadacar.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE armadacar.courses_id_seq OWNED BY armadacar.courses.id;
CREATE TABLE armadacar.entreprises (
    id integer NOT NULL,
    departement text NOT NULL,
    ville text NOT NULL,
    code_postal text NOT NULL,
    adresse text NOT NULL,
    responsable text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    nom text NOT NULL
);
CREATE SEQUENCE armadacar.entreprises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE armadacar.entreprises_id_seq OWNED BY armadacar.entreprises.id;
CREATE TABLE armadacar.lieux_de_stockage (
    id integer NOT NULL,
    libelle text NOT NULL,
    id_entreprise integer NOT NULL,
    adresse text NOT NULL,
    ville text NOT NULL,
    departement text NOT NULL,
    code_postal text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE armadacar.lieux_de_stockage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE armadacar.lieux_de_stockage_id_seq OWNED BY armadacar.lieux_de_stockage.id;
CREATE TABLE armadacar.utilisateurs (
    id text NOT NULL,
    id_entreprise integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE armadacar.utilisateurs_courses (
    id integer NOT NULL,
    id_utilisateur text NOT NULL,
    id_course integer NOT NULL,
    createur boolean NOT NULL
);
CREATE TABLE armadacar.voitures (
    id integer NOT NULL,
    marque text NOT NULL,
    modele text NOT NULL,
    nombre_de_places integer NOT NULL,
    immatriculation text NOT NULL,
    energie text NOT NULL,
    id_lieux_de_stockage integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_entreprise integer NOT NULL
);
CREATE SEQUENCE armadacar.voitures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE armadacar.voitures_id_seq OWNED BY armadacar.voitures.id;
ALTER TABLE ONLY armadacar.courses ALTER COLUMN id SET DEFAULT nextval('armadacar.courses_id_seq'::regclass);
ALTER TABLE ONLY armadacar.entreprises ALTER COLUMN id SET DEFAULT nextval('armadacar.entreprises_id_seq'::regclass);
ALTER TABLE ONLY armadacar.lieux_de_stockage ALTER COLUMN id SET DEFAULT nextval('armadacar.lieux_de_stockage_id_seq'::regclass);
ALTER TABLE ONLY armadacar.voitures ALTER COLUMN id SET DEFAULT nextval('armadacar.voitures_id_seq'::regclass);
ALTER TABLE ONLY armadacar.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.entreprises
    ADD CONSTRAINT entreprises_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.lieux_de_stockage
    ADD CONSTRAINT lieux_de_stockage_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.utilisateurs_courses
    ADD CONSTRAINT utilisateurs_courses_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.voitures
    ADD CONSTRAINT voitures_pkey PRIMARY KEY (id);
ALTER TABLE ONLY armadacar.courses
    ADD CONSTRAINT courses_id_voiture_fkey FOREIGN KEY (id_voiture) REFERENCES armadacar.voitures(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.lieux_de_stockage
    ADD CONSTRAINT lieux_de_stockage_id_entreprise_fkey FOREIGN KEY (id_entreprise) REFERENCES armadacar.entreprises(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.utilisateurs_courses
    ADD CONSTRAINT utilisateurs_courses_id_course_fkey FOREIGN KEY (id_course) REFERENCES armadacar.courses(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.utilisateurs_courses
    ADD CONSTRAINT utilisateurs_courses_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES armadacar.utilisateurs(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.utilisateurs
    ADD CONSTRAINT utilisateurs_id_entreprise_fkey FOREIGN KEY (id_entreprise) REFERENCES armadacar.entreprises(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.voitures
    ADD CONSTRAINT voitures_id_entreprise_fkey FOREIGN KEY (id_entreprise) REFERENCES armadacar.entreprises(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY armadacar.voitures
    ADD CONSTRAINT voitures_id_lieux_de_stockage_fkey FOREIGN KEY (id_lieux_de_stockage) REFERENCES armadacar.lieux_de_stockage(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
