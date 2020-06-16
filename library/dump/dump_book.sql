--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: book; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.book (
    id integer NOT NULL,
    _user_id integer,
    title character varying(255) NOT NULL,
    image character varying(500) NOT NULL,
    file character varying(500) NOT NULL,
    update_at timestamp(0) without time zone NOT NULL,
    author character varying(500) NOT NULL
);


ALTER TABLE public.book OWNER TO postgres;

--
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_id_seq OWNER TO postgres;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (id, _user_id, title, image, file, update_at, author) FROM stdin;
3	15	Стихотворение и сказки	205c2b177b1d6ab7de95e8001e102761.jpeg	2f0aab6489bb999e0bc727f8205ef24c.pdf	2020-06-16 21:44:20	А.С. Пушкин
4	15	Думай и богатей	b3f65d9822685a8c988ad6b5d812937d.jpeg	514fe1f09991b8e1ab3f092f08e55c51.pdf	2020-06-16 21:45:47	Наполен Хилл
5	15	Магия утра	1d966ee2ea32d4781e838581b8f470cc.jpeg	446c11293cc3da08e02caf10f546db10.pdf	2020-06-16 22:25:49	Хэл Элрод
\.


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 5, true);


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20200616093024	2020-06-16 12:30:32	130
DoctrineMigrations\\Version20200616112446	2020-06-16 14:24:55	2114
DoctrineMigrations\\Version20200616114836	2020-06-16 14:49:32	44
DoctrineMigrations\\Version20200616120228	2020-06-16 15:02:47	118
DoctrineMigrations\\Version20200616120700	2020-06-16 15:07:12	44
DoctrineMigrations\\Version20200616152455	2020-06-16 18:25:13	99
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, roles, password, name) FROM stdin;
15	admin@mail.ru	["ROLE_ADMIN"]	$argon2id$v=19$m=65536,t=4,p=1$nZeZrFwnkdbtA31tZRtN1A$7MjUXE2KSeqoe+qPM+opBaXk+6sI/4ldYOYYAGzch8Q	Admin
16	user@mail.ru	["ROLE_USER"]	$argon2id$v=19$m=65536,t=4,p=1$sxaQ1UqeSFKYs/hnVcfBhg$8r9idHaiOZBWxCoO61puUVziXwQ9z40qU9kCZqt6kaA	User
17	test@mail.ru	[]	$argon2id$v=19$m=65536,t=4,p=1$tWyR7AnbaxNwtuiGMeqLJA$fBnlh21gfkAAa6Fnq4ejDTW2aDxUgEljggjENUXEJi4	test
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 17, true);


--
-- Name: book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_cbe5a331d32632e8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_cbe5a331d32632e8 ON public.book USING btree (_user_id);


--
-- Name: uniq_8d93d649e7927c74; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uniq_8d93d649e7927c74 ON public."user" USING btree (email);


--
-- Name: fk_cbe5a331d32632e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT fk_cbe5a331d32632e8 FOREIGN KEY (_user_id) REFERENCES public."user"(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

