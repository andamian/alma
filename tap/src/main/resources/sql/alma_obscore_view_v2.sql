CREATE OR REPLACE FORCE VIEW obscore (
    dataproduct_type,
    calib_level,
    obs_collection,
    obs_id,
    obs_publisher_did,
    access_url,
    access_format,
    target_name,
    s_ra,
    s_dec,
    s_fov,
    s_region,
    footprint,
    s_resolution,
    t_min,
    t_max,
    t_exptime,
    t_resolution,
    em_min,
    em_max,
    em_res_power,
    o_ucd,
    pol_states,
    facility_name,
    instrument_name,
    proposal_id,
    data_rights,
    gal_longitude,
    gal_latitude,
    band_list,
    em_resolution,
    bandwidth,
    antenna_arrays,
    is_mosaic,
    obs_release_date,
    spatial_resolution,
    frequency_support,
    frequency,
    velocity_resolution,
    obs_creator_name,
    pub_title,
    first_author,
    authors,
    pub_abstract,
    publication_year,
    proposal_abstract,
    schedblock_name,
    proposal_authors,
    sensitivity_10kms,
    cont_sensitivity_bandwidth,
    pwv,
    group_ous_uid,
    member_ous_uid,
    asdm_uid,
    obs_title,
    type,
    scan_intent,
    science_observation,
    spatial_scale_max,
    qa2_passed,
    bib_reference,
    science_keyword,
    scientific_category,
    collections,
    lastModified
 ) AS SELECT
    CASE WHEN energy.channel_num > 128 THEN 'cube'
         ELSE 'image' END,
    CASE WHEN science.product_type = 'MOUS' THEN 2
         WHEN science.product_type = 'GOUS' THEN 3
         ELSE null END,
    'ALMA',
    science.asa_ous_id,
    'ADS/JAO.ALMA#' || asap.code,
    'http://almascience.org/aq?member_ous_id=' || science.member_ouss_id,
    'text/html',
    science.source_name,
    science.ra,
    science.dec,
    (science.fov / 3600),
    science.spatial_bounds,
    science.footprint,
    science.spatial_scale_min,
    ts2mjd(science.start_date),
    ts2mjd(science.end_date),
    science.int_time,
    science.int_time,
    (0.299792458 / energy.frequency_max),
    (0.299792458 / energy.frequency_min),
    energy.resolving_power_max,
    'phot.flux.density;phys.polarization',
    -- Special case where the pol_products that include all of the states but omit the YX value.
    CASE WHEN LTRIM(RTRIM(energy.pol_product)) = 'XX XY YY' THEN '/XX/XY/YX/YY/' ELSE '/' || REGEXP_REPLACE(LTRIM(RTRIM(energy.pol_product)), '\s', '/') || '/' END,
    'JAO',
    'ALMA',
    science.project_code,
    CASE WHEN SYSDATE >= ads.release_date THEN 'Public' ELSE 'Proprietary' END,
    science.gal_longitude,
    science.gal_latitude,
    science.band_list,
    -- Convert frequency_resolution to metres as per ObsCore expectations.
    CASE WHEN science.frequency_resolution IS NOT NULL THEN (science.frequency_resolution * 2.99792458e+11) ELSE NULL END,
    energy.bandwidth,
    science.antennas,
    CASE WHEN science.is_mosaic = 'Y' THEN 'T' ELSE 'F' END,
    CASE WHEN ads.release_date is null THEN TO_TIMESTAMP('3000-01-01T00:00:00.000Z', 'YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"')
         ELSE CAST(ads.release_date AS TIMESTAMP) END,
    science.spatial_resolution,
    science.frequency_support,
    science.frequency,
    science.velocity_resolution,
    asap.pi_name,
    (SELECT LISTAGG(title, ' ') WITHIN GROUP (ORDER BY title) AS title FROM (SELECT DISTINCT aab.title FROM asa_bibliography aab JOIN asa_project_bibliography aapb ON aab.bibcode = aapb.bibcode WHERE aapb.project_code = science.project_code)),
    (SELECT LISTAGG(first_author, ' ') WITHIN GROUP (ORDER BY first_author) AS first_author FROM (SELECT DISTINCT aab.first_author FROM asa_bibliography aab JOIN asa_project_bibliography aapb ON aab.bibcode = aapb.bibcode WHERE aapb.project_code = science.project_code)),
    (SELECT LISTAGG(authors, ' ' ON OVERFLOW TRUNCATE) WITHIN GROUP (ORDER BY authors) AS authors FROM (SELECT DISTINCT aab.authors FROM asa_bibliography aab JOIN asa_project_bibliography aapb ON aab.bibcode = aapb.bibcode WHERE aapb.project_code = science.project_code)),
    (SELECT LISTAGG(abstract, ' ' ON OVERFLOW TRUNCATE) WITHIN GROUP (ORDER BY abstract) AS abstract FROM(SELECT DISTINCT aab.abstract FROM asa_bibliography aab JOIN asa_project_bibliography aapb ON aab.bibcode = aapb.bibcode WHERE aapb.project_code = science.project_code)),
    (SELECT DISTINCT aab.publication_year FROM asa_bibliography aab JOIN asa_project_bibliography aapb ON aab.bibcode = aapb.bibcode WHERE aapb.project_code = science.project_code AND ROWNUM < 2),
    asap.proposal_abstract,
    science.schedblock_name,
    asap.coi_name,
    energy.sensitivity_10kms,
    science.cont_sensitivity_bandwidth,
    science.pwv,
    science.group_ouss_id,
    science.member_ouss_id,
    science.asdm_uid,
    asap.title,
    asap.type,
    science.scan_intent,
    CASE WHEN science.scan_intent LIKE '%TARGET%' THEN 'T' ELSE 'F' END,
    science.spatial_scale_max,
    CASE WHEN ads.qa2_passed = 'Y' THEN 'T' ELSE 'F' END,
    (SELECT LISTAGG(bibcode, ' ') WITHIN GROUP (ORDER BY bibcode) AS bibcode FROM (SELECT DISTINCT bibcode FROM asa_project_bibliography WHERE project_code = science.project_code)),
    asap.science_keyword,
    asap.scientific_category,
    (SELECT LISTAGG(collection, ' ') WITHIN GROUP (ORDER BY collection) AS collection FROM (SELECT DISTINCT collection FROM ALMA.asa_product_files WHERE asa_ous_id = science.member_ouss_id)),
    science.last_updated
FROM asa_science science
INNER JOIN asa_energy energy ON upper(energy.asa_dataset_id) = upper(science.dataset_id)
INNER JOIN asa_project asap ON asap.code = science.project_code
LEFT OUTER JOIN asa_delivery_asdm_ous adao ON science.asdm_uid = adao.asdm_uid
LEFT OUTER JOIN asa_delivery_status ads ON adao.delivery_id = ads.id
WHERE nvl(science.product_type, '0') = 'MOUS';
