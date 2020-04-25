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
-- Name: unemployments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.unemployments (
    id_unemployments integer NOT NULL,
    country character varying(100) NOT NULL,
    period character varying(100) NOT NULL,
    "values" double precision NOT NULL,
    unit character varying(100) NOT NULL,
    previous_values double precision NOT NULL
);


ALTER TABLE public.unemployments OWNER TO postgres;

--
-- Name: unemployments_id_unemployments_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unemployments_id_unemployments_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unemployments_id_unemployments_seq OWNER TO postgres;

--
-- Name: unemployments_id_unemployments_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unemployments_id_unemployments_seq OWNED BY public.unemployments.id_unemployments;


--
-- Name: id_unemployments; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unemployments ALTER COLUMN id_unemployments SET DEFAULT nextval('public.unemployments_id_unemployments_seq'::regclass);


--
-- Data for Name: unemployments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unemployments (id_unemployments, country, period, "values", unit, previous_values) FROM stdin;
12		мар.2020	4.4000000000000004	%	3.5
13		мар.2020	4.7000000000000002	%	4.5999999999999996
14		фев.2020	2.3999999999999999	%	2.3999999999999999
15		мар.2020	6.2000000000000002	%	5.2000000000000002
16		мар.2020	5.2000000000000002	%	5.0999999999999996
\.


--
-- Name: unemployments_id_unemployments_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unemployments_id_unemployments_seq', 16, true);


--
-- Name: unemployments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.unemployments
    ADD CONSTRAINT unemployments_pk PRIMARY KEY (id_unemployments);


--
-- Name: unemployments_id_unemployments_uindex; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unemployments_id_unemployments_uindex ON public.unemployments USING btree (id_unemployments);


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

