CREATE OR REPLACE FORCE VIEW ALMA.obscore (
    dataproduct_type,
    calib_level,
    obs_collection,
    obs_id,
    obs_publisher_did,
    access_url,
    access_format,
    access_estsize,
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
    antenna_arrays,
    is_mosaic,
    obs_release_date,
    frequency_support,
    velocity_resolution,
    obs_creator_name,
    schedblock_name,
    coi_name,
    sensitivity_10kms,
    cont_sensitivity_bandwidth,
    pwv,
    group_ous_uid,
    member_ous_uid,
    asdm_uid,
    obs_title,
    type,
    scan_intent,
    spatial_scale_max,
    qa2_passed,
    bib_reference,
    science_keyword,
    scientific_category,
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
    (SELECT DISTINCT stored_size FROM ALMA.asa_product_files WHERE asa_energy_id = energy.asa_energy_id),
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
    energy.pol_product,
    'JAO',
    'ALMA',
    science.project_code,
    CASE WHEN SYSDATE >= ads.release_date THEN 'Public' ELSE 'Proprietary' END,
    science.gal_longitude,
    science.gal_latitude,
    science.band_list,
    science.frequency_resolution,
    science.antennas,
    science.is_mosaic,
    (case when ads.release_date is null then TO_TIMESTAMP('3000-01-01T00:00:00.000Z', 'YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"')
          else CAST(ads.release_date AS TIMESTAMP) end),
    science.frequency_support,
    science.velocity_resolution,
    asap.pi_name,
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
    science.spatial_scale_max,
    ads.qa2_passed,
    (SELECT DISTINCT bibcode FROM ALMA.asa_project_bibliography WHERE project_code = science.project_code),
    asap.science_keyword,
    asap.scientific_category,
    science.last_updated
FROM ALMA.asa_science science
INNER JOIN ALMA.asa_energy energy ON energy.asa_dataset_id = science.dataset_id
INNER JOIN ALMA.asa_project asap ON asap.code = science.project_code
LEFT OUTER JOIN alma.asa_delivery_asdm_ous adao ON science.asdm_uid = adao.asdm_uid
LEFT OUTER JOIN ALMA.asa_delivery_status ads ON adao.deliverable_name = ads.delivery_id
WHERE science.product_type = 'MOUS';
