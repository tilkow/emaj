-- migExtLoggingGroup.sql : Migrate from E-Maj 0.10.1 to 0.11.1 while groups are in logging state.
-- Install E-Maj as an extension (for postgres version 9.1+ only)
--
-----------------------------
-- emaj update to 0.11.1
-----------------------------
\! cp /usr/local/pg912/share/postgresql/extension/emaj.control.0.11.1 /usr/local/pg912/share/postgresql/extension/emaj.control

-- check the extension is available
select * from pg_available_extension_versions where name = 'emaj';

-- process the extension migration
ALTER EXTENSION emaj UPDATE TO '0.11.1';

-- drop the extension after having detached all emaj objects from it
--\i ../../sql/emaj--0.10.1--unpackaged.sql
--DROP EXTENSION emaj;

-- process the common emaj migration 
--\i ../../sql/emaj-0.10.1-to-0.11.1.sql

-- transform emaj objects as extension 
--CREATE EXTENSION emaj FROM unpackaged;

-----------------------------
-- check installation
-----------------------------
-- check impact in catalog
select extname, extversion from pg_extension where extname = 'emaj';

-- check the emaj_param content
SELECT param_value_text FROM emaj.emaj_param WHERE param_key = 'emaj_version';
