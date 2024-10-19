function m3_per_kg = sv_to_m3_per_kg(sv)
    % Converts Sverdrups (Sv) to cubic meters per kilogram (m³/kg/s)
    seawater_density = 1025;  % kg/m³
    m3_per_kg = (sv * 1e6) / seawater_density;
end