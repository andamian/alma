DELETE FROM TAP_SCHEMA.key_columns11;

DELETE FROM TAP_SCHEMA.keys11;

DELETE FROM TAP_SCHEMA.columns11
  WHERE table_name = 'ivoa.obscore'
  OR table_name LIKE 'tap_schema.%';

DELETE FROM TAP_SCHEMA.tables11
  WHERE table_name = 'ivoa.obscore'
  OR schema_name = 'tap_schema';

DELETE FROM TAP_SCHEMA.schemas11
  WHERE schema_name = 'ivoa'
  OR schema_name = 'tap_schema';

INSERT INTO TAP_SCHEMA.schemas11 (schema_name, utype, description, schema_index) VALUES ('ivoa', null, 'IVOA tables', 10);
INSERT INTO TAP_SCHEMA.schemas11 (schema_name, utype, description, schema_index) VALUES ('tap_schema', null, 'Special schema to describe TAP-1.1 tablesets', 20);

INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('ivoa', 'ivoa.obscore', 'view', null, 'ObsCore-1.1 observation view', null);
INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('tap_schema', 'tap_schema.schemas', 'table', null, 'Schemas in tableset', null);
INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('tap_schema', 'tap_schema.tables', 'table', null, 'Tables in tableset', null);
INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('tap_schema', 'tap_schema.columns', 'table', null, 'Columns in tableset', null);
INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('tap_schema', 'tap_schema.keys', 'table', null, 'Foreign Keys in tableset', null);
INSERT INTO TAP_SCHEMA.tables11 (schema_name, table_name, table_type, utype, description, table_index) VALUES ('tap_schema', 'tap_schema.key_columns', 'table', null, 'Foreign Key columns in tableset', null);


CREATE SEQUENCE TAP_SCHEMA.COL_IDX_SEQ START WITH 1;

INSERT ALL
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.schemas', 'schema_name', 'schema name for reference to tap_schema.schemas', NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.schemas', 'utype', 'lists the utypes of schemas in the tableset', NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0,TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.tables', 'table_name', 'the fully qualified table name',                    NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.tables', 'table_type', 'one of: table view',                                NULL, NULL, NULL, 'char', '8*', NULL, 8, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.tables', 'utype', 'lists the utype of tables in the tableset',              NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.tables', 'description', 'describes tables in the tableset',                 NULL, NULL, NULL, 'char', '512*', NULL, 512,1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.tables', 'table_index', 'recommended sort order when listing tables',       NULL, NULL, NULL, 'int', NULL, NULL, NULL, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'table_name', 'the table this column belongs to',                 NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'column_name', 'the column name',                                 NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'utype', 'lists the utypes of columns in the tableset',           NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'ucd', 'lists the UCDs of columns in the tableset',               NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'unit', 'lists the unit used for column values in the tableset',  NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'description', 'describes the columns in the tableset',           NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'datatype', 'lists the ADQL datatype of columns in the tableset', NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'arraysize', 'lists the size of variable-length columns in the tableset', NULL, NULL, NULL, 'int', NULL, NULL, NULL, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'xtype', 'a DALI or custom extended type annotation',             NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', '"size"', 'deprecated: use arraysize', NULL, NULL, NULL, 'int', NULL, NULL, NULL, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'principal', 'a principal column; 1 means 1, 0 means 0',      NULL, NULL, NULL, 'int', NULL, NULL, NULL,1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'indexed', 'an indexed column; 1 means 1, 0 means 0',         NULL, NULL, NULL, 'int', NULL, NULL, NULL,1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'std', 'a standard column; 1 means 1, 0 means 0',             NULL, NULL, NULL, 'int', NULL, NULL, NULL,1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.columns', 'column_index', 'recommended sort order when listing columns of a table',  NULL, NULL, NULL, 'int', NULL, NULL, NULL,1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.keys', 'key_id', 'unique key to join to tap_schema.key_columns',            NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.keys', 'from_table', 'the table with the foreign key',                      NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.keys', 'target_table', 'the table with the primary key',                    NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.keys', 'utype', 'lists the utype of keys in the tableset',              NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.keys', 'description', 'describes keys in the tableset',                 NULL, NULL, NULL, 'char', '512*', NULL, 512, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.key_columns', 'key_id', 'key to join to tap_schema.keys',                   NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.key_columns', 'from_column', 'column in the from_table',                    NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ( 'tap_schema.key_columns', 'target_column', 'column in the target_table',                NULL, NULL, NULL, 'char', '64*', NULL, 64, 1,0,0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_publisher_did', 'obscore:Curation.PublisherDID', 'meta.ref.url;meta.curation', null, 'publisher dataset identifier', 'char', '33*', null, 33, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_collection', 'obscore:DataID.Collection', 'meta.id', null, 'short name for the data collection', 'char', '4', null, 4, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'facility_name', 'obscore:Provenance.ObsConfig.Facility.name', 'meta.id;instr.tel', null, 'telescope name', 'char', '3', null, 3, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'instrument_name', 'obscore:Provenance.ObsConfig.Instrument.name', 'meta.id;instr', null, 'instrument name', 'char', '4', null, 4, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_id', 'obscore:DataID.observationID', 'meta.id', null, 'internal dataset identifier', 'char', '64*', null, 64, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'dataproduct_type', 'obscore:ObsDataset.dataProductType', 'meta.id', null, 'type of product', 'char', '5*', null, 5, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'calib_level', 'obscore:ObsDataset.calibLevel', 'meta.code;obs.calib', null, 'calibration level (2 or 3). 2 if product_type = MOUS, 3 if product_type = GOUS', 'int', null, null, null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'target_name', 'obscore:Target.Name', 'meta.id;src', null, 'name of intended target', 'char', '256*', null, 256, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 's_ra', 'obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C1', 'pos.eq.ra', 'deg', 'RA of central coordinates', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 's_dec', 'obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C2', 'pos.eq.dec', 'deg', 'DEC of central coordinates', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 's_fov', 'obscore:Char.SpatialAxis.Coverage.Bounds.Extent.diameter', 'phys.angSize;instr.fov', 'deg', 'size of the region covered (~diameter of minimum bounding circle)', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 's_region', 'obscore:Char.SpatialAxis.Coverage.Support.Area', 'phys.outline;obs.field', 'deg', 'region bounded by observation', 'char', '*', 'adql:REGION', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 's_resolution', 'obscore:Char.SpatialAxis.Resolution.refval.value', 'pos.angResolution', 'deg', 'typical spatial resolution', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 't_min', 'obscore:Char.TimeAxis.Coverage.Bounds.Limits.StartTime', 'time.start;obs.exposure', 'd', 'start time of observation (MJD)', 'double', NULL, 'adql:DOUBLE', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 't_max', 'obscore:Char.TimeAxis.Coverage.Bounds.Limits.StopTime', 'time.end;obs.exposure', 'd', 'end time of observation (MJD)', 'double', NULL, 'adql:DOUBLE', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 't_exptime', 'obscore:Char.TimeAxis.Coverage.Support.Extent', 'time.duration;obs.exposure', 's', 'exposure time of observation', 'double', NULL, 'adql:DOUBLE', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 't_resolution', 'obscore:Char.TimeAxis.Resolution.refval.value', 'time.resolution', 's', 'typical temporal resolution', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'em_min', 'obscore:Char.SpectralAxis.Coverage.Bounds.Limits.LoLimit', 'em.wl;stat.min', 'm', 'start spectral coordinate value', 'double', NULL, 'adql:DOUBLE', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'em_max', 'obscore:Char.SpectralAxis.Coverage.Bounds.Limits.HiLimit', 'em.wl;stat.max', 'm', 'stop spectral coordinate value', 'double', NULL, 'adql:DOUBLE', null, 1, 1, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'em_res_power', 'obscore:Char.SpectralAxis.Resolution.ResolPower.refval', 'spect.resolution', null, 'typical spectral resolution', 'double', NULL, 'adql:DOUBLE', null, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'pol_states', 'obscore:Char.PolarizationAxis.stateList', 'meta.code;phys.polarization', null, 'polarization states present in the data', 'char', '64*', null, 64, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'o_ucd', 'obscore:Char.ObservableAxis.ucd', 'meta.ucd', null, 'UCD describing the observable axis (pixel values)', 'char', '35', null, 35, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'access_url', 'obscore:Access.Reference', 'meta.ref.url', null, 'URL to download the data', 'char', '72*', 'clob', 72, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'access_format', 'obscore:Access.Format', 'meta.code.mime', null, 'Content format of the data', 'char', '9', null, 9, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'proposal_id', NULL, NULL, NULL,'Identifier of proposal to which NO observation belongs.', 'char', '64*', 'adql:VARCHAR', 64, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'data_rights', NULL, NULL, NULL, 'Access to data.', 'char', '11', 'adql:VARCHAR', 11, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'gal_longitude', NULL, 'pos.galactic.lon', 'deg', 'Galactic longitude of the observation for RA/Dec. Estimated using PyEphem and RA/Dec.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'gal_latitude', NULL, 'pos.galactic.lat', 'deg', 'Galactic latitude of the observation for RA/Dec. Estimated using PyEphem and RA/Dec.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'band_list', NULL, NULL, NULL, 'Space delimited list of bands', 'char', '30*', 'adql:VARCHAR', 30, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'em_resolution', 'obscore:Char.SpectralAxis.Resolution.refval', 'spect.resolution', 'm', 'Estimated frequency resolution from all the spectral windows, using median values of channel widths.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'bandwidth', 'obscore:Char.SpectralAxis.Coverage.Bounds.Extent', 'em.freq;instr.bandpass', 'GHz', 'Total Bandwidth', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'antenna_arrays', NULL, 'meta.code.member;instr.setup', NULL, 'Blank-separated list of Pad:Antenna pairs, i.e., A109:DV09 J504:DV02 J505:DV05 for antennas DV09, DV02 and DV05 sitting on pads A109, J504, and J505, respectively.', 'char', '660*', 'adql:VARCHAR', 660, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'is_mosaic', NULL, NULL, NULL, 'Flag to indicate if this ASDM represents a mosaic or not.', 'char', '1', 'adql:CHAR', 1, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_release_date', 'obscore:Curation.releaseDate', 'time.release_date', NULL, 'timestamp of date the data becomes publicly available', 'char', '*', 'adql:TIMESTAMP', NULL, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'spatial_resolution', NULL, NULL, 'arcsec', 'Average of the maximum and minimum spatial resolution values of all spectral windows', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'frequency_support', 'obscore:Char.SpectralAxis.Coverage.Location.support', 'em.freq;obs;meta.main', 'GHz', 'All frequency ranges used by the field', 'char', '4000*', 'adql:VARCHAR', 4000, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'frequency', 'obscore:Char.SpectralAxis.Coverage.Location.refval', 'em.freq;obs;meta.main', 'GHz', 'Observed (tuned) reference frequency on the sky.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'velocity_resolution', 'obscore:Char.VelocityAxis.Resolution.refval', 'phys.veloc;spect.resolution', 'm/s', 'Estimated velocity resolution from all the spectral windows, from frequency resolution.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_creator_name', NULL, 'meta.id.PI', NULL, 'case-insensitive partial match over the full PI name. Wildcards can be used', 'char', '256*', 'adql:VARCHAR', 256, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'pub_title', NULL, NULL, NULL, 'Case insensitive search through the title of the publication.', 'char', '256*', 'adql:VARCHAR', 256, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'first_author', NULL, NULL, NULL, 'The first author as provided by <a href="http://telbib.eso.org">telbib.eso.org</a>.', 'char', '256*', 'adql:VARCHAR', 256, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'authors', NULL, NULL, NULL, 'Full list of first author and all co-authors', 'char', '4000*', 'adql:VARCHAR', 4000, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'pub_abstract', NULL, NULL, NULL, 'Case insensitive text search through the abstract of the publication.', 'char', '4000*', 'adql:VARCHAR', 4000, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'publication_year', NULL, NULL, NULL, 'The year the publication did appear in the printed version of the refereed journal.', 'int', NULL, NULL, NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'proposal_abstract', NULL, 'meta.abstract', NULL, 'Text search on the proposal abstract. Only abstracts will be returned which contain the given text. The search is case-insensitive.', 'char', '4000*', 'adql:VARCHAR', 4000, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'schedblock_name', NULL, 'meta.code;obs;instr.setup', NULL, 'Name of the Scheduling Block used as a template for executing the ASDM containing this Field.', 'char', '128*', 'adql:VARCHAR', 128, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'proposal_authors', NULL, 'meta.id.CoI', NULL, 'Full name of CoIs .', 'char', '2000*', 'adql:VARCHAR', 2000, 0, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'sensitivity_10kms', NULL, NULL, 'mJy/beam', 'Estimated noise in an nominal 10km/s bandwidth. Note this is an indication only, it does not include the effects of flagging or Hanning smoothing, and a 10km/s bandwidth may not be achievable with the data as taken.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'cont_sensitivity_bandwidth', NULL, NULL, 'mJy/beam', 'Estimated noise in the aggregated continuum bandwidth. Note this is an indication only, it does not include the effects of flagging or dynamic range limitations.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'pwv', NULL, 'obs.atmos.extinction', 'mm', 'Estimated precipitable water vapour from the XML_CALWVR_ENTITIES table.', 'float', NULL, 'adql:FLOAT', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'group_ous_uid', NULL, NULL, NULL, 'Group OUS ID', 'char', '64*', 'adql:VARCHAR', 64, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'member_ous_uid', NULL, NULL, NULL, 'Member OUS ID', 'char', '64*', 'adql:VARCHAR', 64, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'asdm_uid', NULL, 'meta.id', NULL, 'UID of the ASDM containing this Field.', 'char', '32*', 'adql:VARCHAR', 32, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'obs_title', NULL, 'meta.title;obs.proposal', NULL, 'Case-insensitive search over the project title', 'char', '256*', 'adql:VARCHAR', 256, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'type', NULL, NULL, NULL, 'Type flags.', 'char', '16*', 'adql:VARCHAR', 16, 1, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'scan_intent', NULL, 'meta.code.class;obs', NULL, 'Scan intent list for the observed field.', 'char', '256*', 'adql:VARCHAR', 256, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'science_observation', NULL, 'meta.code.class;obs', NULL, 'Flag to indicate whether this is a science observation.', 'char', '1', 'adql:VARCHAR', 1, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'spatial_scale_max', 'obscore:Characterisation.SpatialAxis.Coverage.Bounds.limits.Interval.HiLim', 'pos.angResolution;stat.max', 'arcsec', 'Due to the fact that radio antennas can not be placed infinitely close, measurements do have a smallest separation which translates into a maximal angular distance beyond which features can not be resolved reliably any more. Adding observations with the ALMA Total Power array can add those missing largest scales.', 'double', NULL, 'adql:DOUBLE', NULL, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'qa2_passed', NULL, 'meta.flag', NULL, 'Quality Assessment 2 status: does the Member / Group OUS fulfil the PI''s requirements?', 'char', '1', 'adql:CHAR', 1, 0, 1, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'bib_reference', NULL, NULL, NULL, 'Bibliography code', 'char', '4000*', 'adql:VARCHAR', 4000, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'science_keyword', NULL, NULL, NULL, NULL, 'char', '200*', 'adql:VARCHAR', 200, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'scientific_category', NULL, NULL, NULL, NULL, 'char', '200*', 'adql:VARCHAR', 200, 0, 0, 0, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
    INTO TAP_SCHEMA.columns11 (table_name, column_name, utype, ucd, unit, description, datatype, arraysize, xtype, "size", principal, indexed, std, column_index, id) VALUES ('ivoa.obscore', 'lastModified', null, null, null, 'Time stamp of last modification of the metadata', 'char', '*', 'adql:TIMESTAMP', 32, 1, 0, 1, TAP_SCHEMA.COL_IDX_SEQ.NEXTVAL, null)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k1','tap_schema.tables','tap_schema.schemas',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k2','tap_schema.columns','tap_schema.tables',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k3','tap_schema.keys','tap_schema.tables',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k4','tap_schema.keys','tap_schema.tables',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k5','tap_schema.key_columns','tap_schema.keys',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k6','tap_schema.key_columns','tap_schema.columns',null,null)
    INTO TAP_SCHEMA.keys11 (key_id,from_table,target_table,utype,description) VALUES ('k7','tap_schema.key_columns','tap_schema.columns',null,null)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k1','schema_name','schema_name')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k2','table_name','table_name')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k3','from_table','table_name')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k4','target_table','table_name')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k5','key_id','key_id')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k6','from_column','column_name')
    INTO TAP_SCHEMA.key_columns11 (key_id,from_column,target_column) VALUES ('k7','target_column','column_name')
SELECT 1 FROM DUAL;

DROP SEQUENCE TAP_SCHEMA.COL_IDX_SEQ;