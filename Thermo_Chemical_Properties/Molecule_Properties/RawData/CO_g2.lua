-- Collater: Daniel F. Potter
-- Date: 15 July 2012

-- 5th (A1) to 13th (H) excited state of carbon monoxide

CO_g2 = {}
CO_g2.M = {
   value = 28.010100e-3,
   units = 'kg/mol',
   description = 'molecular mass',
   reference = 'Periodic table'
}
CO_g2.atomic_constituents = {C=1,O=1}
CO_g2.charge = 0
CO_g2.CEA_coeffs = {
   { T_low  = 200.0,
     T_high = 1000.0,
     coeffs = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 }
   },
  ref="none"
}

-- Nonequilibrium data

CO_g2.species_type = "polar diatomic"
CO_g2.s_0 = {
   value = 0.0,
   units = 'J/kg-K',
   description = 'Dummy standard state entropy at 1 bar',
   reference = 'none'
}
CO_g2.I = {
   value = 0.0,
   units = 'J/kg',
   description = 'Dummy ionization energy',
   reference = 'none'
}
CO_g2.h_f = {
   value = 23846558.21,
   units = 'J/kg',
   description = 'Heat of formation',
   reference = 'from CEA2::thermo.inp'
}
CO_g2.Z = {
   value = 0,
   units = 'ND',
   description = 'Charge number',
   reference = 'NA'
}
CO_g2.electronic_levels = {
   n_levels = 9,
   ref = 'Spradian07::diatom.dat',
   -- ===========================================================================================================================================================
   --   n     Te         re       g   dzero      we         wexe      weye        weze        be        alphae      de          betae       spn-orb     l   s  
   -- ===========================================================================================================================================================
   ilev_0 = {     0.00,  1.2353,  2,  24740.00,  1518.240,  19.4000,  7.660E-01,  0.000E+00,  1.61150,  2.325E-02,  7.330E-06,  1.000E-07,  0.000E+00,  1,  1 },
   ilev_1 = {     8.63,  1.3911,  1,  24940.00,  1092.220,  10.7040,  5.540E-02,  0.000E+00,  1.27050,  1.848E-02,  9.000E-06,  0.000E+00,  0.000E+00,  0,  1 },
   ilev_2 = {   852.23,  1.3990,  2,  24100.00,  1094.000,  10.2000,  0.000E+00,  0.000E+00,  1.25700,  1.700E-02,  0.000E+00,  0.000E+00,  0.000E+00,  2,  1 },
   ilev_3 = { 18738.23,  1.1130,  3,  25000.00,  2199.300,   0.0000,  0.000E+00,  0.000E+00,  1.98600,  4.200E-02,  0.000E+00,  0.000E+00,  0.000E+00,  0,  3 },
   ilev_4 = { 21869.43,  1.1197,  1,  50000.00,  2112.700,  15.2200,  0.000E+00,  0.000E+00,  1.96120,  2.610E-02,  7.100E-06,  0.000E+00,  0.000E+00,  0,  1 },
   ilev_5 = { 26894.23,  1.1070,  1,  50000.00,  2175.900,  14.7600,  0.000E+00,  0.000E+00,  1.95330,  1.960E-02,  5.700E-06,  0.000E+00,  0.000E+00,  0,  1 },
   ilev_6 = { 27854.23,  1.1188,  2,  50000.00,  2134.900,  14.7600,  0.000E+00,  0.000E+00,  1.96440,  0.000E+00,  6.500E-06,  0.000E+00,  0.000E+00,  1,  1 },
   ilev_7 = { 34654.23,  1.1500,  2,  35000.00,  2112.000, 198.0000,  1.000E-01,  0.000E+00,  1.87150,  2.300E-02,  6.500E-06,  0.000E+00,  0.000E+00,  0,  1 },
   ilev_8 = { 40674.23,  1.1190,  2,  35000.00,  1097.000,  11.0000,  0.000E+00,  0.000E+00,  1.96300,  0.000E+00,  7.000E-06,  0.000E+00,  0.000E+00,  1,  1 },
   -- ===========================================================================================================================================================
}
