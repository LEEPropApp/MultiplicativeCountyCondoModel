##### Condo Values For January 1st 2018 ######



##### Original Set of Data #####
library(RODBC)


myConn <- odbcConnect("cama_stateroll")  #creating connection to database
## importing the data from a sql query
GlobalModelLocOrig<- sqlQuery(myConn,"
             SELECT  CD.*
              , sale.Amount 
              , sale.Instrument
              ,Sale.Date AS 'SaleDate'
              , 12 * (YEAR(SAle.Date) -2014) + MONTH(sale.date) AS 'TimeToSale'
              ,2018 - CD.ActualYearBuilt AS 'ActAge'
              , 2018 - CD.EffYearBuilt AS 'EffAge'   
              ,Sale.TransferCodeDOR 
              ,sale.TransferOverRideDOR
              ,CASE WHEN CD.floor = 1
              THEN 1
              ELSE 0
              END AS  'Floor1' 
              ,CASE WHEN CD.floor = 2
              THEN 1
              ELSE 0
              END AS  'Floor2'
              ,CASE WHEN CD.floor = 3
              THEN 1
              ELSE 0
              END AS  'Floor3'
              ,CASE WHEN CD.floor = 4
              THEN 1
              ELSE 0
              END AS  'Floor4'
              ,CASE WHEN CD.floor = 5
              THEN 1
              ELSE 0
              END AS  'Floor5'
              ,CASE WHEN CD.floor = 6
              THEN 1
              ELSE 0
              END AS  'Floor6'
              ,CASE WHEN CD.floor = 7
              THEN 1
              ELSE 0
              END AS  'Floor7'
              ,CASE WHEN CD.floor = 8
              THEN 1
              ELSE 0
              END AS  'Floor8'
              ,CASE WHEN CD.floor = 9
              THEN 1
              ELSE 0
              END AS  'Floor9'
              ,CASE WHEN CD.floor = 10
              THEN 1
              ELSE 0
              END AS  'Floor10'
              ,CASE WHEN CD.floor = 11
              THEN 1
              ELSE 0
              END AS  'Floor11'
              ,CASE WHEN CD.floor = 12
              THEN 1
              ELSE 0
              END AS  'Floor12'
              ,CASE WHEN CD.floor = 13
              THEN 1
              ELSE 0
              END AS  'Floor13'
              ,CASE WHEN CD.floor = 14
              THEN 1
              ELSE 0
              END AS  'Floor14'
              ,CASE WHEN CD.floor = 15
              THEN 1
              ELSE 0
              END AS  'Floor15'
              ,CASE WHEN CD.floor = 16
              THEN 1
              ELSE 0
              END AS  'Floor16'
              ,CASE WHEN CD.floor = 17
              THEN 1
              ELSE 0
              END AS  'Floor17'
              ,CASE WHEN CD.floor = 18
              THEN 1
              ELSE 0
              END AS  'Floor18'
              ,CASE WHEN CD.floor = 19
              THEN 1
              ELSE 0
              END AS  'Floor19'
              ,CASE WHEN CD.floor >= 20
              THEN 1
              ELSE 0
              END AS  'Floor20More' 
              ,S.centerx
              ,S.centery                  
              ,CASE WHEN CD.Quality = 0
              THEN 1
              ELSE 0
              END AS 'BelowAverage'                  
              ,CASE WHEN CD.Quality =1 
              THEN 1
              ELSE 0
              END AS 'AverageQuality'
              ,CASE WHEN CD.Quality =2 
              THEN 1
              ELSE 0
              END AS 'AboveAverageQuality'
              ,CASE WHEN CD.Quality =3 
              THEN 1
              ELSE 0
              END AS 'ExcellentQuality'
              ,CASE WHEN CD.Quality =6 
              THEN 1
              ELSE 0
              END AS 'FairQuality',
              CASE WHEN CD.ImpComplex IN ('10')
              THEN 1
              ELSE 0
              END AS 'LowRise',
              CASE WHEN CD.ImpComplex IN ('6','06')
              THEN 1
              ELSE 0
              END AS 'MidRise',
              CASE WHEN CD.ImpComplex IN ('11')
              THEN 1
              ELSE 0
              END AS 'HighRise',
              CASE WHEN CD.ImpComplex IN ('12')
              THEN 1
              ELSE 0
              END AS 'TownHouse',
              CASE WHEN CD.ImpComplex IN ('31')
              THEN 1
              ELSE 0
              END AS 'Villa',
              CASE WHEN CD.ImpComplex IN ('33')
              THEN 1
              ELSE 0
              END AS 'SingleFamily',
              CASE WHEN CD.ImpComplex IN ('34')
              THEN 1
              ELSE 0
              END AS 'Duplex',
              CASE WHEN CD.ImpComplex IN ('48')
              THEN 1
              ELSE 0
              END AS 'luxuryHighRise',
              CASE WHEN CD.ImpComplex IN ('51')
              THEN 1
              ELSE 0
              END AS 'Commercial',
              CASE WHEN CD.ImpComplex IN ('67')
              THEN 1
              ELSE 0
              END AS 'Rackominium',
              CASE WHEN CD.ImpComplex IN ('76')
              THEN 1
              ELSE 0
              END AS 'Multiplex',
              CASE WHEN CD.ImpComplex IN ('77')
              THEN 1
              ELSE 0
              END AS 'Hotel',
              Area.PorchArea,
              Area.PoolCage2Area,
              Area.PoolCageCustomArea,
              Area.SpaArea,
              Area.BaseArea,
              Area.PoolCage1Area,
              Area.PatioArea,
              Area.GarageArea,
              Area.Screen1Area,
              Area.CBalconyArea,
              Area.LaniaArea,
              Area.BalconyArea,
              CT.BalconyDesc,
              
              Feat.UnitsBTHSEO,
              FEat.UnitPriceBTHSEO,
              Feat.NewCostBTHSEO,
              Feat.UnitsCCPTA,
              Feat.UnitPriceCCPTA,
              Feat.NewCostCCPTA,
              Feat.UnitsCCPTB ,
              Feat.UnitPriceCCPTB,
              Feat.NewCostCCPTB,
              Feat.UnitsCCPTC ,
              Feat.UnitPriceCCPTC,
              Feat.NewCostCCPTC,
              Feat.UnitsFPLCB ,
              Feat.UnitPriceFPLCB,
              Feat.NewCostFPLCB,
              Feat.UnitsFPLCC,
              Feat.UnitPriceFPLCC,
              Feat.NewCostFPLCC,
              Feat.UnitsCFPLB ,
              Feat.UnitPriceCFPLB,
              Feat.NewCostCFPLB,
              Feat.UnitsCFPLC ,
              Feat.UnitPriceCFPLC,
              Feat.NewCostCFPLC,
              Feat.UnitsCBDOCKA ,
              Feat.UnitPriceCBDOCKA,
              Feat.NewCostCBDOCKA,
              Feat.UnitsCBDOCKB ,
              Feat.UnitPriceCBDOCKB,
              Feat.NewCostCBDOCKB,
              Feat.UnitsCBDOCKC ,
              Feat.UnitPriceCBDOCKC,
              Feat.NewCostCBDOCKC,
              Feat.UnitsCBDOCKD ,
              Feat.UnitPriceCBDOCKD,
              Feat.NewCostCBDOCKD,
              Feat.UnitsCBDOCKE ,
              Feat.UnitPriceCBDOCKE,
              Feat.NewCostCBDOCKE,
              Feat.UnitsCBDOCKF ,
              Feat.UnitPriceCBDOCKF,
              Feat.NewCostCBDOCKF,
              Feat.UnitsCBDOCKG ,
              Feat.UnitPriceCBDOCKG,
              Feat.NewCostCBDOCKG,
              Feat.UnitsCBDOCKH ,
              Feat.UnitPriceCBDOCKH,
              Feat.NewCostCBDOCKH,
              Feat.UnitsCBDOCKI ,
              Feat.UnitPriceCBDOCKI,
              Feat.NewCostCBDOCKI,
              Feat.UnitsBOATLFT ,
              Feat.UnitPriceBOATLFT,
              Feat.NewCostBOATLFT,
              Feat.UnitsCOOPSLP ,
              Feat.UnitPriceCOOPSLP,
              Feat.NewCostCOOPSLP,		
              Feat.UnitsCCABANA ,
              Feat.UnitPriceCCABANA,
              Feat.NewCostCCABANA,
              Feat.UnitsCCABANB ,
              Feat.UnitPriceCCABANB,
              Feat.NewCostCCABANB,
              Feat.UnitsCCABAND ,
              Feat.UnitPriceCCABAND,
              Feat.NewCostCCABAND,
              Feat.UnitsCCABANR ,
              Feat.UnitPriceCCABANR,
              Feat.NewCostCCABANR,
              Feat.UnitsCCABANC ,
              Feat.UnitPriceCCABANC,
              Feat.NewCostCCABANC,
              Feat.UnitsCGARA ,
              Feat.UnitPriceCGARA,
              Feat.NewCostCGARA,
              Feat.UnitsCGARC ,
              Feat.UnitPriceCGARC,
              Feat.NewCostCGARC,
              Feat.UnitsCGARD ,
              Feat.UnitPriceCGARD,
              Feat.NewCostCGARD,
              Feat.UnitsCGARE ,
              Feat.UnitPriceCGARE,
              Feat.NewCostCGARE,
              Feat.UnitsCGARJ ,
              Feat.UnitPriceCGARJ,
              Feat.NewCostCGARJ,
              Feat.UnitsCGARL ,
              Feat.UnitPriceCGARL,
              Feat.NewCostCGARL,
              Feat.UnitsCGARM ,
              Feat.UnitPriceCGARM,
              Feat.NewCostCGARM,
              Feat.UnitsCGAREF ,
              Feat.UnitPriceCGAREF,
              Feat.NewCostCGAREF,
              Feat.UnitsCELVEA ,
              Feat.UnitPriceCELVEA,
              Feat.NewCostCELVEA,
              Feat.UnitsCELVEB ,
              Feat.UnitPriceCELVEB,
              Feat.NewCostCELVEB,
              Feat.UnitsELEVF ,
              Feat.UnitPriceELEVF,
              Feat.NewCostELEVF,
              Feat.UnitsELEVP ,
              Feat.UnitPriceELEVP,
              Feat.NewCostELEVP,
              Feat.UnitsCANOPY ,
              Feat.UnitPriceCANOPY,
              Feat.NewCostCANOPY,
              Feat.UnitsCMOORL ,
              Feat.UnitPriceCMOORL,
              Feat.NewCostCMOORL,
              Feat.UnitsCMOORS ,
              Feat.UnitPriceCMOORS,
              Feat.NewCostCMOORS,
              Feat.UnitsCSUMKPA ,
              Feat.UnitPriceCSUMKPA,
              Feat.NewCostCSUMKPA,
              Feat.UnitsCSUMKPB ,
              Feat.UnitPriceCSUMKPB,
              Feat.NewCostCSUMKPB,
              Feat.UnitsCACSTOM ,
              Feat.UnitPriceCACSTOM,
              Feat.NewCostCACSTOM,
              Feat.UnitsCACSTOS ,
              Feat.UnitPriceCACSTOS,
              Feat.NewCostCACSTOS,
              Feat.UnitsCACSTOL ,
              Feat.UnitPriceCACSTOL,
              Feat.NewCostCACSTOL,
              Feat.UnitsOHDORL ,
              Feat.UnitPriceOHDORL,
              Feat.NewCostOHDORL,
              Feat.UnitsOHDORS ,
              Feat.UnitPriceOHDORS,
              Feat.NewCostOHDORS,
              Feat.UnitsOSH ,
              Feat.UnitPriceOSH,
              Feat.NewCostOSH,
              Feat.UnitsSHEDMT ,
              Feat.UnitPriceSHEDMT,
              Feat.NewCostSHEDMT,
              Feat.UnitsPIT ,
              Feat.UnitPricePIT,
              Feat.NewCostPIT,
              S.centerx,
              S.centery
              FROM property.dbo.SaleView AS sale
              INNER JOIN Appraisal.dbo.condominium AS CT on CT.folioid = sale.FolioID
              LEFT JOIN tempstuff.dbo.conodobuildingdata AS CD ON CD.FolioID = sale.FolioID
              LEFT JOIN appraisal.dbo.CondoMaster AS CM ON CM.ComplexID = CD.ComplexID
              LEFT JOIN property.dbo.FolioView AS S On S.FolioID = CT.FolioID
              LEFT JOIN (
              SELECT Condo.FolioID,
              ISNULL(Porch.PorchArea,0) AS 'PorchArea',
              ISNULL(Pool2.PoolCage2Area,0) AS 'PoolCage2Area',
              ISNULL(PoolC.PoolCageCustomArea,0) AS 'PoolCageCustomArea',
              ISNULL(Spa.SpaArea,0) AS 'SpaArea',
              ISNULL(Pool.PoolArea,0) AS 'PoolArea',
              ISNULL(BASE.BaseArea ,0 ) AS 'BaseArea',
              ISNULL(Pool1.PoolCage1Area,0) AS 'PoolCage1Area',
              ISNULL(Patio.PatioArea ,0) AS 'PatioArea',
              ISNULL(Garage.GarageArea,0) AS 'GarageArea',
              ISNULL(Screen1.[1StoryScreenEnclosureArea],0) AS 'Screen1Area',
              ISNULL(Balcony.CBalconyArea ,0) AS 'CBalconyArea',
              ISNULL(Lanai.LaniaArea,0) AS 'LaniaArea',
              ISNULL(Balcony2.BalconyArea,0) AS 'BalconyArea'
              
              FROM Appraisal.dbo.Condominium AS Condo
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PorchArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO PORCH')
              GROUP BY FolioID 
              ) AS Porch On Porch.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PoolCage2Area'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO POOL CAGE 2 STORY')
              GROUP BY FolioID
              ) AS Pool2 On Pool2.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PoolCageCustomArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO POOL CAGE CUSTOM')
              GROUP BY FolioID
              ) AS PoolC ON PoolC.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'SpaArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO SPA')
              GROUP BY FolioID
              ) AS Spa ON Spa.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PoolArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO POOL')
              GROUP BY FolioID
              ) AS Pool ON Pool.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'BaseArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO BASE')
              GROUP BY FolioID
              ) AS BASE ON BASE.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PoolCage1Area'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO POOL CAGE 1 STORY')
              GROUP BY FolioID
              ) AS Pool1 ON Pool1.folioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'PatioArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO PATIO')
              GROUP BY FolioID
              ) AS Patio ON Patio.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'GarageArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO GARAGE')
              GROUP BY FolioID
              ) AS Garage ON Garage.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS '1StoryScreenEnclosureArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('1 STORY SCREEN ENCL')
              GROUP BY FolioID
              ) AS Screen1 On Screen1.FolioID = Condo.folioid
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'CBalconyArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO BALCONY')
              GROUP BY FolioID
              ) AS Balcony ON Balcony.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'LaniaArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('CONDO LANAI')
              GROUP BY FolioID
              ) AS Lanai ON Lanai.FolioID = Condo.FolioID
              LEFT JOIN (
              SELECT FolioID ,SUM(ActualArea) AS 'BalconyArea'
              FROM appraisal.dbo.Subarea
              WHERE description IN ('BALCONY')
              GROUP BY FolioID
              ) AS Balcony2 ON Balcony2.FolioID = Condo.FolioID
              ) AS Area ON Area.FolioID = Sale.FolioID
              LEFT JOIN (
              SELECT Con.FolioID,
              ISNULL(BTHSEO.units,0) AS 'UnitsBTHSEO' ,
              ISNULL(BTHSEO.UnitPrice,0) AS 'UnitPriceBTHSEO',
              ISNULL(	BTHSEO.NewCost ,0)AS 'NewCostBTHSEO',
              ISNULL(CCPTA.units ,0)AS 'UnitsCCPTA' ,
              ISNULL(CCPTA.UnitPrice,0) AS 'UnitPriceCCPTA',
              ISNULL(CCPTA.NewCost ,0)AS 'NewCostCCPTA',
              ISNULL(CCPTB.units ,0)AS 'UnitsCCPTB' ,
              ISNULL(CCPTB.UnitPrice,0) AS 'UnitPriceCCPTB',
              ISNULL(CCPTB.NewCost,0) AS 'NewCostCCPTB',
              ISNULL(CCPTC.units ,0)AS 'UnitsCCPTC' ,
              ISNULL(CCPTC.UnitPrice ,0)AS 'UnitPriceCCPTC',
              ISNULL(CCPTC.NewCost ,0)AS 'NewCostCCPTC',
              ISNULL(FPLCB.units ,0)AS 'UnitsFPLCB' ,
              ISNULL(FPLCB.UnitPrice,0) AS 'UnitPriceFPLCB',
              ISNULL(FPLCB.NewCost ,0)AS 'NewCostFPLCB',
              ISNULL(FPLCC.units ,0)AS 'UnitsFPLCC' ,
              ISNULL(FPLCC.UnitPrice,0) AS 'UnitPriceFPLCC',
              ISNULL(FPLCC.NewCost,0) AS 'NewCostFPLCC',
              ISNULL(CFPLB.units ,0)AS 'UnitsCFPLB' ,
              ISNULL(CFPLB.UnitPrice,0) AS 'UnitPriceCFPLB',
              ISNULL(CFPLB.NewCost,0) AS 'NewCostCFPLB',
              ISNULL(CFPLC.units ,0)AS 'UnitsCFPLC' ,
              ISNULL(CFPLC.UnitPrice,0) AS 'UnitPriceCFPLC',
              ISNULL(CFPLC.NewCost ,0)AS 'NewCostCFPLC',
              ISNULL(CBDOCKA.units ,0)AS 'UnitsCBDOCKA' ,
              ISNULL(CBDOCKA.UnitPrice ,0)AS 'UnitPriceCBDOCKA',
              ISNULL(CBDOCKA.NewCost ,0)AS 'NewCostCBDOCKA',
              ISNULL(CBDOCKB.units ,0)AS 'UnitsCBDOCKB' ,
              ISNULL(CBDOCKB.UnitPrice,0) AS 'UnitPriceCBDOCKB',
              ISNULL(CBDOCKB.NewCost ,0)AS 'NewCostCBDOCKB',
              ISNULL(CBDOCKC.units ,0)AS 'UnitsCBDOCKC' ,
              ISNULL(CBDOCKC.UnitPrice,0) AS 'UnitPriceCBDOCKC',
              ISNULL(CBDOCKC.NewCost ,0)AS 'NewCostCBDOCKC',
              ISNULL(CBDOCKD.units ,0)AS 'UnitsCBDOCKD' ,
              ISNULL(CBDOCKD.UnitPrice,0) AS 'UnitPriceCBDOCKD',
              ISNULL(CBDOCKD.NewCost ,0)AS 'NewCostCBDOCKD',
              ISNULL(CBDOCKE.units ,0)AS 'UnitsCBDOCKE' ,
              ISNULL(CBDOCKE.UnitPrice,0) AS 'UnitPriceCBDOCKE',
              ISNULL(CBDOCKE.NewCost ,0)AS 'NewCostCBDOCKE',
              ISNULL(CBDOCKF.units ,0)AS 'UnitsCBDOCKF' ,
              ISNULL(CBDOCKF.UnitPrice,0) AS 'UnitPriceCBDOCKF',
              ISNULL(CBDOCKF.NewCost ,0)AS 'NewCostCBDOCKF',
              ISNULL(CBDOCKG.units ,0)AS 'UnitsCBDOCKG' ,
              ISNULL(CBDOCKG.UnitPrice,0) AS 'UnitPriceCBDOCKG',
              ISNULL(CBDOCKG.NewCost ,0)AS 'NewCostCBDOCKG',
              ISNULL(CBDOCKH.units ,0)AS 'UnitsCBDOCKH' ,
              ISNULL(CBDOCKH.UnitPrice,0) AS 'UnitPriceCBDOCKH',
              ISNULL(CBDOCKH.NewCost ,0)AS 'NewCostCBDOCKH',
              ISNULL(CBDOCKI.units ,0)AS 'UnitsCBDOCKI' ,
              ISNULL(CBDOCKI.UnitPrice ,0)AS 'UnitPriceCBDOCKI',
              ISNULL(CBDOCKI.NewCost ,0)AS 'NewCostCBDOCKI',
              ISNULL(BOATLFT.units ,0)AS 'UnitsBOATLFT' ,
              ISNULL(BOATLFT.UnitPrice,0) AS 'UnitPriceBOATLFT',
              ISNULL(BOATLFT.NewCost ,0)AS 'NewCostBOATLFT',
              ISNULL(COOPSLP.units ,0)AS 'UnitsCOOPSLP' ,
              ISNULL(COOPSLP.UnitPrice,0) AS 'UnitPriceCOOPSLP',
              ISNULL(COOPSLP.NewCost ,0)AS 'NewCostCOOPSLP',		
              ISNULL(CCABANA.units ,0)AS 'UnitsCCABANA' ,
              ISNULL(CCABANA.UnitPrice,0) AS 'UnitPriceCCABANA',
              ISNULL(CCABANA.NewCost ,0)AS 'NewCostCCABANA',
              ISNULL(CCABANB.units ,0)AS 'UnitsCCABANB' ,
              ISNULL(CCABANB.UnitPrice,0) AS 'UnitPriceCCABANB',
              ISNULL(CCABANB.NewCost ,0)AS 'NewCostCCABANB',
              ISNULL(CCABAND.units,0) AS 'UnitsCCABAND' ,
              ISNULL(CCABAND.UnitPrice,0) AS 'UnitPriceCCABAND',
              ISNULL(CCABAND.NewCost,0) AS 'NewCostCCABAND',
              ISNULL(CCABANR.units,0) AS 'UnitsCCABANR' ,
              ISNULL(CCABANR.UnitPrice,0) AS 'UnitPriceCCABANR',
              ISNULL(CCABANR.NewCost,0) AS 'NewCostCCABANR',
              ISNULL(CCABANC.units,0) AS 'UnitsCCABANC' ,
              ISNULL(CCABANC.UnitPrice,0) AS 'UnitPriceCCABANC',
              ISNULL(CCABANC.NewCost ,0)AS 'NewCostCCABANC',
              ISNULL(CGARA.units ,0)AS 'UnitsCGARA' ,
              ISNULL(CGARA.UnitPrice,0) AS 'UnitPriceCGARA',
              ISNULL(CGARA.NewCost ,0)AS 'NewCostCGARA',
              ISNULL(CGARC.units ,0)AS 'UnitsCGARC' ,
              ISNULL(CGARC.UnitPrice,0) AS 'UnitPriceCGARC',
              ISNULL(CGARC.NewCost,0) AS 'NewCostCGARC',
              ISNULL(CGARD.units ,0)AS 'UnitsCGARD' ,
              ISNULL(CGARD.UnitPrice,0) AS 'UnitPriceCGARD',
              ISNULL(CGARD.NewCost ,0)AS 'NewCostCGARD',
              ISNULL(CGARE.units,0) AS 'UnitsCGARE' ,
              ISNULL(CGARE.UnitPrice,0) AS 'UnitPriceCGARE',
              ISNULL(CGARE.NewCost ,0)AS 'NewCostCGARE',
              ISNULL(CGARJ.units,0) AS 'UnitsCGARJ' ,
              ISNULL(CGARJ.UnitPrice,0) AS 'UnitPriceCGARJ',
              ISNULL(CGARJ.NewCost,0) AS 'NewCostCGARJ',
              ISNULL(CGARL.units,0) AS 'UnitsCGARL' ,
              ISNULL(CGARL.UnitPrice,0) AS 'UnitPriceCGARL',
              ISNULL(CGARL.NewCost,0) AS 'NewCostCGARL',
              ISNULL(CGARM.units ,0)AS 'UnitsCGARM' ,
              ISNULL(CGARM.UnitPrice,0) AS 'UnitPriceCGARM',
              ISNULL(CGARM.NewCost,0) AS 'NewCostCGARM',
              ISNULL(CGAREF.units ,0)AS 'UnitsCGAREF' ,
              ISNULL(CGAREF.UnitPrice,0) AS 'UnitPriceCGAREF',
              ISNULL(CGAREF.NewCost ,0)AS 'NewCostCGAREF',
              ISNULL(CELVEA.units ,0) AS 'UnitsCELVEA' ,
              ISNULL(CELVEA.UnitPrice,0) AS 'UnitPriceCELVEA',
              ISNULL(CELVEA.NewCost,0) AS 'NewCostCELVEA',
              ISNULL(CELVEB.units,0) AS 'UnitsCELVEB' ,
              ISNULL(CELVEB.UnitPrice ,0)AS 'UnitPriceCELVEB',
              ISNULL(CELVEB.NewCost ,0)AS 'NewCostCELVEB',
              ISNULL(ELEVF.units,0) AS 'UnitsELEVF' ,
              ISNULL(ELEVF.UnitPrice,0) AS 'UnitPriceELEVF',
              ISNULL(ELEVF.NewCost,0) AS 'NewCostELEVF',
              ISNULL(ELEVP.units,0) AS 'UnitsELEVP' ,
              ISNULL(ELEVP.UnitPrice ,0)AS 'UnitPriceELEVP',
              ISNULL(ELEVP.NewCost,0) AS 'NewCostELEVP',
              ISNULL(CANOPY.units ,0) AS 'UnitsCANOPY' ,
              ISNULL(CANOPY.UnitPrice,0) AS 'UnitPriceCANOPY',
              ISNULL(CANOPY.NewCost ,0) AS 'NewCostCANOPY',
              ISNULL(CMOORL.units,0) AS 'UnitsCMOORL' ,
              ISNULL(CMOORL.UnitPrice,0) AS 'UnitPriceCMOORL',
              ISNULL(CMOORL.NewCost,0) AS 'NewCostCMOORL',
              ISNULL(CMOORS.units,0) AS 'UnitsCMOORS' ,
              ISNULL(CMOORS.UnitPrice,0) AS 'UnitPriceCMOORS',
              ISNULL(CMOORS.NewCost ,0) AS 'NewCostCMOORS',
              ISNULL(CSUMKCA.units,0) AS 'UnitsCSUMKPA' ,
              ISNULL(CSUMKCA.UnitPrice,0) AS 'UnitPriceCSUMKPA',
              ISNULL(CSUMKCA.NewCost,0) AS 'NewCostCSUMKPA',
              ISNULL(CSUMKPB.units,0) AS 'UnitsCSUMKPB' ,
              ISNULL(CSUMKPB.UnitPrice,0) AS 'UnitPriceCSUMKPB',
              ISNULL(CSUMKPB.NewCost,0) AS 'NewCostCSUMKPB',
              ISNULL(CACSTOM.units,0) AS 'UnitsCACSTOM' ,
              ISNULL(CACSTOM.UnitPrice,0) AS 'UnitPriceCACSTOM',
              ISNULL(CACSTOM.NewCost,0) AS 'NewCostCACSTOM',
              ISNULL(CACSTOS.units,0) AS 'UnitsCACSTOS' ,
              ISNULL(CACSTOS.UnitPrice,0) AS 'UnitPriceCACSTOS',
              ISNULL(CACSTOS.NewCost,0) AS 'NewCostCACSTOS',
              ISNULL(CACSTOL.units ,0)AS 'UnitsCACSTOL' ,
              ISNULL(CACSTOL.UnitPrice,0) AS 'UnitPriceCACSTOL',
              ISNULL(CACSTOL.NewCost,0) AS 'NewCostCACSTOL',
              ISNULL(OHDORL.units ,0)AS 'UnitsOHDORL' ,
              ISNULL(OHDORL.UnitPrice,0) AS 'UnitPriceOHDORL',
              ISNULL(OHDORL.NewCost ,0)AS 'NewCostOHDORL',
              ISNULL(OHDORS.units,0) AS 'UnitsOHDORS' ,
              ISNULL(OHDORS.UnitPrice ,0)AS 'UnitPriceOHDORS',
              ISNULL(OHDORS.NewCost,0) AS 'NewCostOHDORS',
              ISNULL(OSH.units,0) AS 'UnitsOSH' ,
              ISNULL(OSH.UnitPrice,0) AS 'UnitPriceOSH',
              ISNULL(OSH.NewCost,0) AS 'NewCostOSH',
              ISNULL(SHEDMT.units,0) AS 'UnitsSHEDMT' ,
              ISNULL(SHEDMT.UnitPrice,0) AS 'UnitPriceSHEDMT',
              ISNULL(SHEDMT.NewCost,0) AS 'NewCostSHEDMT',
              ISNULL(PIT.units,0) AS 'UnitsPIT' ,
              ISNULL(PIT.UnitPrice,0) AS 'UnitPricePIT',
              ISNULL(PIT.NewCost,0) AS 'NewCostPIT'
              
              
              FROM appraisal.dbo.Condominium AS con
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCPT C'
              GROUP BY F.FolioID
              ) AS CCPTC ON CCPTC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CFPL B'
              GROUP BY F.FolioID
              ) AS CFPLB ON CFPLB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKF'
              GROUP BY F.FolioID
              ) AS CBDOCKF ON CBDOCKF.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKE'
              GROUP BY F.FolioID
              ) AS CBDOCKE ON CBDOCKE.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CFPL C'
              GROUP BY F.FolioID
              ) AS CFPLC ON CFPLC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKC'
              GROUP BY F.FolioID
              ) AS CBDOCKC ON CBDOCKC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'BOATLFT'
              GROUP BY F.FolioID
              ) AS BOATLFT ON BOATLFT.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCABANA'
              GROUP BY F.FolioID
              ) AS CCABANA ON CCABANA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR E'
              GROUP BY F.FolioID
              ) AS CGARE ON CGARE.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCABANB'
              GROUP BY F.FolioID
              ) AS CCABANB ON CCABANB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCABAND'
              GROUP BY F.FolioID
              ) AS CCABAND ON CCABAND.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCABANR'
              GROUP BY F.FolioID
              ) AS CCABANR ON CCABANR.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CELVE B'
              GROUP BY F.FolioID
              ) AS CELVEB ON CELVEB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKA'
              GROUP BY F.FolioID
              ) AS CBDOCKA ON CBDOCKA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKB'
              GROUP BY F.FolioID
              ) AS CBDOCKB ON CBDOCKB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKD'
              GROUP BY F.FolioID
              ) AS CBDOCKD ON CBDOCKD.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CANOPY'
              GROUP BY F.FolioID
              ) AS CANOPY ON CANOPY.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CMOORL'
              GROUP BY F.FolioID
              ) AS CMOORL ON CMOORL.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKG'
              GROUP BY F.FolioID
              ) AS CBDOCKG ON CBDOCKG.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKI'
              GROUP BY F.FolioID
              ) AS CBDOCKI ON CBDOCKI.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR D'
              GROUP BY F.FolioID
              ) AS CGARD ON CGARD.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CBDOCKH'
              GROUP BY F.FolioID
              ) AS CBDOCKH ON CBDOCKH.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCPT B'
              GROUP BY F.FolioID
              ) AS CCPTB ON CCPTB .folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'FPLC B'
              GROUP BY F.FolioID
              ) AS FPLCB ON FPLCB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CMOORS'
              GROUP BY F.FolioID
              ) AS CMOORS ON CMOORS.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCPT A'
              GROUP BY F.FolioID
              ) AS CCPTA ON CCPTA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'ELEV P'
              GROUP BY F.FolioID
              ) AS ELEVP ON ELEVP.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR J'
              GROUP BY F.FolioID
              ) AS CGARJ ON CGARJ.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR A'
              GROUP BY F.FolioID
              ) AS CGARA ON CGARA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CSUMKPB'
              GROUP BY F.FolioID
              ) AS CSUMKPB ON CSUMKPB.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CELVE A'
              GROUP BY F.FolioID
              ) AS CELVEA ON CELVEA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'COOPSLP'
              GROUP BY F.FolioID
              ) AS COOPSLP ON COOPSLP.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'BTHSEO'
              GROUP BY F.FolioID
              ) AS BTHSEO ON BTHSEO.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR C'
              GROUP BY F.FolioID
              ) AS CGARC ON CGARC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR L'
              GROUP BY F.FolioID
              ) AS CGARL ON CGARL.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAR M'
              GROUP BY F.FolioID
              ) AS CGARM ON CGARM.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CSUMKCA'
              GROUP BY F.FolioID
              ) AS CSUMKCA ON CSUMKCA.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID , SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'FPLC C'
              GROUP BY F.FolioID
              ) AS FPLCC ON FPLCC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'OHDOR L'
              GROUP BY F.FolioID
              ) AS OHDORL ON OHDORL.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CGAREF'
              GROUP BY F.FolioID
              ) AS CGAREF ON CGAREF.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CCABANC'
              GROUP BY F.FolioID
              ) AS CCABANC ON CCABANC.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CACSTOM'
              GROUP BY F.FolioID
              ) AS CACSTOM ON CACSTOM.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CACSTOS'
              GROUP BY F.FolioID
              ) AS CACSTOS ON CACSTOS.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'CACSTOL'
              GROUP BY F.FolioID
              ) AS CACSTOL ON CACSTOL.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'OHDOR S'
              GROUP BY F.FolioID
              ) AS OHDORS ON OHDORS.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'ELEV F'
              GROUP BY F.FolioID
              ) AS ELEVF ON ELEVF.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'OSH'
              GROUP BY F.FolioID
              ) AS OSH ON OSH.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'SHED MT'
              GROUP BY F.FolioID
              ) AS SHEDMT ON SHEDMT.folioid = Con.FolioID
              LEFT JOIN (
              SELECT F.FolioID ,  SUM(F.units) AS 'units' ,SUM(F.UnitPrice) AS 'UnitPrice', SUM(F.NewCost) AS 'NewCost'
              FROM Appraisal.dbo.extrafeature AS F
              WHERE F.code = 'PIT'
              GROUP BY F.FolioID
              ) AS PIT ON PIT.folioid = Con.FolioID
              
              ) AS Feat ON Feat.FolioID =Sale.FolioID 
              WHERE SUBSTRING(CM.NbhdCode,1,1) != '5' AND CD.UnitImpCode != 13 AND 
              SAle.TransferCodeDOR IN ('01','02') AND SAle.TransferOverRideDOR IN ('01','02') 
              -- AND SQRT(POWER((750571 - centerx),2)+ POWER((725479 - centery),2)  )  < 5480
              AND YEAR(sale.Date) >= 2014
              ORDER BY  sale.Date
                              ")
odbcClose(myConn)





### Creating a clean data set with no missing floor plans or odd complex or unit improvment codes ##
hold1 <- subset(GlobalModelLocOrig, BaseArea != 0 & ImpComplex != 67 & ImpComplex != 33 & UnitImpCode != 51 )

## Making sure All complex names are upper case ##
hold1$ComplexID  <- toupper(hold1$ComplexID) 

### To Add In Complex Variables using sql type structures ###
library(sqldf)


#### Removing Bad Sales ####
hold1 <- subset(hold1, Instrument !=2017000070820  ##Assignment
                & Instrument != 2016000161141 ## Very very odd sale
                & Instrument != 2015000000088 ## Assignment
                & Instrument != 'P125440900000' ## very low sale
                & Instrument != '2017000231859' ## Low Sale
                & Instrument != '2017000126257' ## Low Sale
                & Instrument != '2017000021475' ## Possible just transfer of Ownership  
                & Instrument != '2016000059283' ## Very Low Sale 
                & Instrument != '2016000195701' ## Low Sale Amount 
                & Instrument != '2017000097606' ## Low Sale
                & Instrument != '2016000065069' ## Sale Much Lower than Rest of Complex
                & Instrument != '2014000142528' ## SAys not marketed and low sale
                & Instrument != '2017000156741' ## Abnormal low sale
)



### Creating Variable for Boat dock
hold1$UnitBoatDock <- ( hold1$UnitsCBDOCKA
                           + hold1$UnitsCBDOCKB     
                           + hold1$UnitsCBDOCKC        ## Found Insignificant
                           + hold1$UnitsCBDOCKD        ## Found Insignificant
                           + hold1$UnitsCBDOCKE
                           + hold1$UnitsCBDOCKF       ### Found Insignificant R
                           + hold1$UnitsCBDOCKG     ## Found Insignificant 
                           + hold1$UnitsCBDOCKH     ## Found Insignificant 
                           + hold1$UnitsCBDOCKI)

## Creating combined cabanna variable ##
hold1$CCABAN <- (          hold1$UnitsCCABANA    
                          + hold1$UnitsCCABANB        
                          + hold1$UnitsCCABANC   
                          + hold1$UnitsCCABAND    
                          + hold1$UnitsCCABANR    )

## Creating a combined garage variable ##
hold1$unitsGarage <- (    hold1$UnitsCGARA      ## No Sale Data
                             + hold1$UnitsCGARC      ## Found Insignificant
                             + hold1$UnitsCGARD      ## Found insignificant up FUS
                             + hold1$UnitsCGARE      
                             + hold1$UnitsCGARJ     
                             + hold1$UnitsCGARL      
                             + hold1$UnitsCGARM      
                             + hold1$UnitsCGAREF  )

## Creating a combined elevator variable ##
hold1$Elev <- (   
                  hold1$UnitsCELVEA     
                  + hold1$UnitsCELVEB     
                  + hold1$UnitsELEVP      
                  
                )

## Creating combined condo carport variable ##
hold1$CCPT  <- (hold1$UnitsCCPTA       
                   + hold1$UnitsCCPTB       
                  #+ hold1UnitsCCPTC   
                )

## Creating combined fire place variable ##
hold1$FPLC <- (         
                  hold1$UnitsFPLCB       ## No Sale Data
                  + hold1$UnitsFPLCC       ## No Sale Data
                  + hold1$UnitsCFPLB       ## Found Insignificant       
                  + hold1$UnitsCFPLC  
                )

## Combining all moore variables into one ##
hold1$Moor    <- (
                    hold1$UnitsCMOORL     
                    + hold1$UnitsCMOORS
                  )

## Combining all into one variable ##
hold1$SUMKP   <- (
                      hold1$UnitsCSUMKPA    
                      + hold1$UnitsCSUMKPB 
                    )

## Combining all into one variable ##
hold1$CACSTO      <- (
                          hold1$UnitsCACSTOM    
                          + hold1$UnitsCACSTOS    
                          + hold1$UnitsCACSTOL    
                        )

##Multiplicative form ###
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(PorchArea + 1 )
                + log(GarageArea +1 )
                + log(LaniaArea + 1  )
                + log(CBalconyArea + 1  )
                + log(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                + log(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(ActAge + 1)
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + GULFView1
                + BayView1 
                + GOLFCOURSEView1
                ## IMprovment type ##
                + MidRise
                + HighRise
                + luxuryHighRise
                + TownHouse
                + Villa
                + Duplex
                + Multiplex
                + Hotel 
                ## Parking ##
                + OpenParking
                + MinimalCarPortParking 
                + I(GarageParking + UnderBuildingGarageParking) 
                + UnderBuildingParking    
                ## Quality ##
                + BelowAverage
                + AboveAverageQuality
                + ExcellentQuality
                + FairQuality
                ##Floor   ##
                + I(Floor2 )
                + Floor3
                + I(Floor4 + Floor5 + Floor6)
                + I(Floor7 +Floor8  + Floor9 +Floor10)
                + I(Floor11 +Floor12 +Floor13 + Floor14 + Floor15)
                + I(Floor16 + Floor17 +Floor18 +Floor19 )
                + Floor20More
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                +I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                + OpenBalcony 
                #  + EnclosedBalcony ## Found insignificant 
                #  + AcrilyicBalcony   
                + GLassBalcony
                + VinylBalcony     
                
                ## Features ##
                #   + UnitsBTHSEO      ## No Sale Data
                #   + UnitsCCPTA       ## Found Insognificant
                #   + UnitsCCPTB       ## Found Insignificant
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                , data = hold1)

### Summary of the model ###
summary(GlobalMul)



### Removing Certain instruments that were determined to be ad sales

hold1 <- subset(hold1, Instrument !=2017000070820  ##Assignment
                & Instrument != 2016000161141 ## Very very odd sale
                & Instrument != 2015000000088 ## Assignment
                & Instrument != 'P125440900000' ## very low sale
                & Instrument != '2017000231859' ## Low Sale
                & Instrument != '2017000126257' ## Low Sale
                & Instrument != '2017000021475' ## Possible just transfer of Ownership  
                & Instrument != '2016000059283' ## Very Low Sale 
                & Instrument != '2016000195701' ## Low Sale Amount 
                & Instrument != '2017000097606' ## Low Sale
                & Instrument != '2016000065069' ## Sale Much Lower than Rest of Complex
                & Instrument != '2014000142528' ## SAys not marketed and low sale
                & Instrument != '2017000156741' ## Abnormal low sale
)





### Moving data set over to hold with predicted value 
hold <- hold1
hold$ComplexID <- as.character(hold$ComplexID) ###making complex ID not a factor
hold$resid <- residuals(GlobalMul)
hold$pred <- predict(GlobalMul)



####Creating clustering based on x,y and the residual of the global model ####


## This creates a table of the average residual based on complex 
complexresid <- data.frame("complexid" = character() , "AverageResid" = double(),
                           "size" = integer(), 'CenterX' = double() , 
                           'CenterY' = double(),
                           stringsAsFactors = FALSE)


### This for loop populates the table 
for( i in unique(as.character(hold$ComplexID))){
  hold2 <- subset(hold, ComplexID == i)
  complexresid[NROW(complexresid)+1,]<- c(as.character(i), 
                                          sum(hold2$resid)/ NROW(hold2), 
                                          NROW(hold2),median(hold2$centerx), 
                                          median(hold2$centery))  
  
}



### Using the K means to determine the cluster form optimalNumberofGroups.R ###
      ###the optimal groups was determined to be 3 but went with 4 ###

### Scaling the desired variables
Grouping.Scaled =complexresid[,c(4,5,2)]
Grouping.Scaled$CenterX <- as.numeric(Grouping.Scaled$CenterX )
Grouping.Scaled$CenterY <- as.numeric(Grouping.Scaled$CenterY )
Grouping.Scaled$AverageResid <- as.numeric(Grouping.Scaled$AverageResid )
Grouping.Scaled = scale(Grouping.Scaled)

library(classInt)
bins <- classIntervals(as.numeric(complexresid$AverageResid) , 10, style = "quantile")

binLabels <- character()

for(i in 2:11) {
  
  binLabels[i - 1] <- paste0("$", formatC(bins$brks[i - 1], format = "f", digits = 0, big.mark = ","),
                             
                             " - $",
                             
                             formatC(bins$brks[i], format = "f", digits = 0, big.mark = ","))
  
}

par(mar=c(5.1, 4.1, 4.1, 11.1), xpd=TRUE)

plot(complexresid$CenterX, complexresid$CenterY, pch = 15, col = rainbow(11)[cut(as.numeric(complexresid$AverageResid), breaks = bins$brks)],
     
     main = "Condominium Mean Previous Unit Values By Location", xlab = "Florida State Plane X Coordinate", ylab = "Florida State Plane Y Coordinate")

legend("topright", inset= c(-0.18, 0), legend = binLabels, col = rainbow(11), pch = 15, title = "Mean Previous Value" )

rm(binLabels, i, bins)

dev.off()





# ---- Calculate optimal number of time groups -----
library(vegan)

euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

initialKMeansStartingPoints <- function(x, n = 10) {
  
  points <- numeric()
  
  dTable <- NULL
  
  points[1] <- which.min(apply(x, 1, function(c)
    
  { 
    
    euc.dist(c, rep(0, ncol(x)))
    
  }))
  
  for(i in 2:n)
    
  {
    
    dTable <- cbind(dTable, apply(x, 1, function(c) { euc.dist(c, x[points[i - 1],])}))
    
    points[i] <- which.max(apply(dTable, 1, min))
    
  }
  
  points
  
}


initial.points <- initialKMeansStartingPoints(Grouping.Scaled, 20)



plot(complexresid[,c(4, 5)])

points(complexresid[initial.points, c(4, 5)], pch = 16, col = rainbow(length(initial.points)), cex = 5)

text(complexresid[initial.points, c(4, 5)],  labels = 1:length(initial.points))








#----------- Optimum Cluster Count ------------

cfit <- cascadeKM(Grouping.Scaled, 1, length(initial.points), iter = 1000)

plot(cfit, sortg = TRUE, grpmts.plot = TRUE)

calinski.best <- as.numeric(which.max(cfit$results[2,]))

cat("Calinski criterion optimal number of clusters:", calinski.best, "\n")

rm(cfit)

#-------------------------------------------


## Suggested number of grops applied ##
complexresid$GroupId = kmeans(Grouping.Scaled, centers = Grouping.Scaled[initial.points[1:calinski.best],])$cluster
### Manually Overiding to four groups ###
complexresid$GroupId = kmeans(Grouping.Scaled, centers = Grouping.Scaled[initial.points[1: 4],])$cluster

# Assign group numbers from map left to right for consistency

x <- aggregate(CenterX ~ GroupId, data = complexresid, min)

x <- data.frame(newGroupId = 1:nrow(x), GroupId = x[order(x$CenterX), "GroupId"])

complexresid <- merge(complexresid, x, by = "GroupId")
## Removing place holder ##
rm(x)

complexresid$GroupId <- NULL

colnames(complexresid)[colnames(complexresid) == "newGroupId"] <- "GroupId"

complexresid$Cluster <- complexresid$GroupId

## Checking to make sure cluster and Group ID match ##
test1 <- subset(complexresid, GroupId != Cluster )
## Removing the test data set 
rm(test1)


### This adds the groups into the data of the global modelLoc  ###
library(sqldf)



### Connecting in the groups to data with temporary data set ###
hold1comp <- sqldf("
               SELECT h.*,
               CASE WHEN C.Cluster = 1
               THEN 1
               ELSE 0
               END AS 'Group1',
               CASE WHEN C.Cluster = 2
               THEN 1
               ELSE 0
               END AS 'Group2',
               CASE WHEN C.Cluster = 3
               THEN 1
               ELSE 0
               END AS 'Group3',
               CASE WHEN C.Cluster = 4
               THEN 1
               ELSE 0
               END AS 'Group4'

               FROm hold1 AS h
               LEFT JOIN complexresid AS C On C.complexid = h.ComplexID 
               
               ")

### Transferring into original data set ####
hold1<-hold1comp

## Removing temporary Data set ###
rm(hold1comp)


### Adding in Geographical Regions to the model ###
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(PorchArea + 1 )
                + log(GarageArea +1 )
                + log(LaniaArea + 1  )
                + log(CBalconyArea + 1  )
                + log(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                + log(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(ActAge + 1)
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + GULFView1
                + BayView1 
                + GOLFCOURSEView1
                ## IMprovment type ##
                + MidRise
                + HighRise
                + luxuryHighRise
                + TownHouse
                + Villa
                + Duplex
                + Multiplex
                + Hotel 
                ## Parking ##
                + OpenParking
                + MinimalCarPortParking 
                + I(GarageParking + UnderBuildingGarageParking) 
                + UnderBuildingParking    
                ## Quality ##
                + BelowAverage
                + AboveAverageQuality
                + ExcellentQuality
                + FairQuality
                ##Floor   ##
                + I(Floor2 )
                + Floor3
                + I(Floor4 + Floor5 + Floor6)
                + I(Floor7 +Floor8  + Floor9 +Floor10)
                + I(Floor11 +Floor12 +Floor13 + Floor14 + Floor15)
                + I(Floor16 + Floor17 +Floor18 +Floor19 )
                + Floor20More
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                + OpenBalcony 
                #  + EnclosedBalcony ## Found insignificant 
                #  + AcrilyicBalcony   
                + GLassBalcony
                + VinylBalcony     

                #   + RecIceCreamParlor
                #   + RecCoffeeShop     
                ## Features ##
                #   + UnitsBTHSEO      ## No Sale Data
                #   + UnitsCCPTA       ## Found Insognificant
                #   + UnitsCCPTB       ## Found Insignificant
                + UnitsCCPTC       
                #   + UnitsFPLCB       ## No Sale Data
                #   + UnitsFPLCC       ## No Sale Data
                #   + UnitsCFPLB       ## Found Insignificant       
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)

summary(GlobalMul)






### Looking to linearize the Floor ### 

## Creating data frame to hold the floor information 
FloorLinearization<- data.frame("Floor" = integer(), "Average" = double() , 'SampleSize' = integer()
)

## for loop to populate the floor information table.
for( i in unique(hold1$floor)){
  print(paste(mean(subset(hold1,floor == i )$Amount), "'    '", i))
  FloorLinearization[NROW(FloorLinearization) +1 ,] <- c(i, mean(subset(hold1,floor== i)$Amount)
                                                         , NROW(subset(hold1,floor == i)))
}

### Now calculating the factor to be applied and ordering by floor to see overall relationship
FloorLinearization$NewValue <- FloorLinearization$Average / min(FloorLinearization$Average)
FloorLinearization <- FloorLinearization[order(FloorLinearization$Floor),]

## Making data set to store all data temporarily 
holdcomb <- hold1

### Adding floor linearization data to the data frame and regenerating
hold1 <- sqldf("
               SELECT h.*,
                  CASE 
                 WHEN h.Balcony in (1,2) THEN 1.00
                 WHEN h.Balcony in (3,4) THEN 1.871319
                 WHEN h.Balcony in (5) THEN 1.684657
                 WHEN h.Balcony in (6) THEN 2.247232
                 WHEN h.Balcony in (7) THEN 1.01 
                 END AS 'LinearizedBalcony',
                 CASE 
                 WHEN h.Parking in (1,0) THEN 1.00
                 WHEN h.Parking in (2) THEN 1.01
                 WHEN h.Parking in (3) THEN 1.118852
                 WHEN h.Parking in (4) THEN 1.120950
                 WHEN h.Parking in (5) THEN 1.868922
                 WHEN h.Parking in (6) THEN 2.434506
                 WHEN h.Parking in (7) THEN 2.482060
                 END AS 'LinearizedPaking',
                 CASE 
                 WHEN h.Quality in (6) THEN .8 /.8
                 WHEN h.Quality in (0) THEN 1.471598 /.8
                 WHEN h.Quality in (1) THEN 3.025489 /.8
                 WHEN h.Quality in (2) THEN 4.094189 /.8
                 WHEN h.Quality in (3) THEN 11.352862 / .8
                 END AS 'LinearizedQuality',
                 CASE 
                 WHEN h.floor = 1 THEN 1
                 WHEN h.floor = 2 THEN 1.140255
                 WHEN h.floor = 3 THEN 1.476413
                 WHEN h.floor = 4 THEN 1.618216
                 WHEN h.floor = 5 THEN 1.872194 
                 WHEN h.floor = 6 THEN 2.201791
                 WHEN h.floor = 7 THEN 2.454949 
                 WHEN h.floor = 8 THEN 2.701616 
                 WHEN h.floor = 9  THEN 2.751634 
                 WHEN h.floor = 10 THEN 2.910144 
                 WHEN h.floor = 11 THEN 3.028641 --3.228641
                 WHEN h.floor = 12 THEN 3.034295
                 WHEN h.floor = 13 THEN 3.04       -- 2.017628
                 WHEN h.floor = 14 THEN 3.25 --3.689367 
                 WHEN h.floor = 15 THEN 3.520619 
                 WHEN h.floor = 16 THEN 3.576019
                 WHEN h.floor = 17 THEN 3.731921
                 WHEN h.floor = 18 THEN 3.792348
                 WHEN h.floor = 19 THEN 4.447019
                 WHEN h.floor = 20 THEN 5.533964 
                 WHEN h.floor = 21 THEN 5.754604
                 WHEN h.floor = 22 THEN 5.76 -- 5.164162
                 WHEN h.floor = 23 THEN 5.78 -- 5.153343
                 WHEN h.floor = 24 THEN 5.79 -- 3.669506
                 WHEN h.floor = 25 THEN 5.80 -- 3.566834 
                 WHEN h.floor = 26 THEN 5.81 -- 4.470856
                 WHEN h.floor = 27 THEN 5.82 -- 1.673948 
                 WHEN h.floor = 28 THEN 5.83 -- 1.534501
                 WHEN h.floor = 29 THEN 5.84 -- 1.458756 
                 WHEN h.floor = 30 THEN 5.85 -- 1.582735
                 WHEN h.floor = 31 THEN 5.86 -- 2.074982
                 WHEN h.floor = 32 THEN 5.87 -- 2.062668 
                 WHEN h.floor = 33 THEN 5.88 -- 2.507440 
                 END AS 'FloorLinearization'
               FROm holdcomb AS h
               ")
## Removing Temporary Data set ##
rm(holdcomb)

### Adding in Linearized variables  to the model ###
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
              ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
              ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(ActAge +1 )
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + GULFView1
                + BayView1 
                + GOLFCOURSEView1
                ## IMprovment type ##
                + MidRise
                + HighRise
                + luxuryHighRise
                + TownHouse
                + Villa
                + Duplex
                + Multiplex
                + Hotel 
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                + LinearizedQuality
                ##Floor   ##
                +FloorLinearization
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                +I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    

                ## Features ##
      
               ## + UnitsCCPTC       
      
              ##  + UnitsCFPLC
              + UnitBoatDock     
              + CCABAN
              + unitsGarage 
              + Elev 
              +  Moor     
              + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)
## Summary from the model ###
summary(GlobalMul)

### creating data frame to hold data and results from the model including 
### the predicted amounts
hold <- hold1
hold$resid <- residuals(GlobalMul)
hold$pred <- predict(GlobalMul)
hold$Predc <- 10^(predict(GlobalMul))



### Now creating floor data frame to hopld results of the model on floor 
### By the sale ratio 
FloorLinearizationAfter<- data.frame("Floor" = integer(), "Average" = double() , 'SampleSize' = integer())


###  loop to populate the abovedata frame  this allows to see if linearization correct ####
for( i in unique(hold$floor)){
  hold4 <- subset(hold,floor == i )
  mn <- mean(hold4$Predc / hold4$Amount )      
  print(paste(mn, "'    '", i))
  FloorLinearizationAfter[NROW(FloorLinearizationAfter) +1 ,] <- c(i, mn 
                                                                   , NROW(subset(hold1,floor == i)))
  rm(hold4)
}




### Trying to create seperate variables for the FUS in a condo unit  ##


myConn <- odbcConnect("cama_stateroll")  #creating connection to database
## importing the data from a sql query
IndvidualFloor<- sqlQuery(myConn,"
                          SELECT Main.*,
                          ISNULL(( SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                          FROM appraisal.dbo.SubareaTable AS s
                          WHERE s.FolioID = Main.FolioID AND  s.description IN ('CON')
                          AND s.Floor != Main.MainFloorNumber 
                          GROUP BY s.FolioID
                          ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'SecondaryFloorArea'
                          FROM (
                          SELECT c. folioid,
                          ISNULL((  SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                          FROM appraisal.dbo.SubareaTable AS s
                          WHERE s.FolioID = c.FolioID AND  s.description IN ('CON') 
                          GROUP BY s.Floor 
                          ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'MainFloorArea',
                          ISNULL((  SELECT  TOP 1  s.Floor
                          FROM appraisal.dbo.SubareaTable AS s
                          WHERE s.FolioID = c.FolioID AND  s.description IN ('CON') 
                          GROUP BY s.Floor 
                          ORDER BY SUM(s.ActualArea ) DESC   ),0) AS 'MainFloorNumber'
                          FROM appraisal.dbo.Condominium AS c
                          --where c.FolioID = '10546172'
                          )  AS Main  ")
odbcClose(myConn)

### Creating data frame to use as a hold for sql df ###
  ### since cannot write to data frame using ###
hold1comb <- hold1

## Combining floor information with other data ##
hold1 <- sqldf("
                SELECT h.* 
                ,Age.AgeBuilt
                ,CASE WHEN h.UnitImpCode = '06'
                THEN 1
                ELSE 0
                END AS 'UnitMidRise'
                ,CASE WHEN h.UnitImpCode = '10'
                THEN 1
                ELSE 0
                END AS 'UnitLowRise'
                ,CASE WHEN h.UnitImpCode = '11'
                THEN 1
                ELSE 0
                END AS 'UnitHighRise'
                ,CASE WHEN h.UnitImpCode = '12'
                THEN 1
                ELSE 0
                END AS 'UnitTownHouse'
                ,CASE WHEN h.UnitImpCode = '48'
                THEN 1
                ELSE 0
                END AS 'UnitLuxuryHighRise'
                ,CASE WHEN h.UnitImpCode = '77'
                THEN 1
                ELSE 0
                END AS 'UnitHotel'
                , Living.MainFloorArea
                , Living.SecondaryFloorArea
                FROM hold1comb AS h
                LEFT JOIN AgeProxy AS age ON Age.FolioID = h.FolioID
                LEFT JOIN IndvidualFloor AS Living ON Living.FolioID  = h.FolioID
                "
)


## Removing the temporary data set ##
rm(hold1comb)

### TO Keep the hotels in the analysis ###
hold1 <- subset(hold1, UnitImpCode != 31 & UnitImpCode != 33 & UnitImpCode != 34
                 & UnitImpCode != 76 )

## Adding Secondary Floor to the model ##
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorArea +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(AgeBuilt )
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + GULFView1
                + BayView1 
                + GOLFCOURSEView1
                ## IMprovment type ##
                + MidRise
                + HighRise
                + luxuryHighRise
                + TownHouse
                + Villa
                + Duplex
                + Multiplex
                + Hotel 
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                + LinearizedQuality
                ##Floor   ##
                +FloorLinearization
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)
## Summary of the condo model ##
summary(GlobalMul)

### Creating data frame to use as a hold for sql df ###
### since cannot write to data frame using ###
hold1comb <- hold1


## Combining the current data with the new view information ##
hold1 <- sqldf("SELECT Orig.*
                       ,CASE WHEN NV.NewView = 'Inferior'
                       THEN 1
                       ELSE 0
                       END AS  'InferiorView'
                       ,CASE WHEN NV.NewView = 'Neutral'
                       THEN 1
                       ELSE 0
                       END AS  'NeutralView'
                       ,CASE WHEN NV.NewView = 'Superior'
                       THEN 1
                       ELSE 0
                       END AS  'SuperiorView'
                       , CASE WHEN NV.Obstructed = 0
                       THEN 1
                       ELSE 0
                       END AS  'UnObstructed'
                       , cASE WHEN NV.Obstructed = 1
                       THEN 1
                       ELSE 0
                       END AS  'Obstructed'
                       ,CASE WHEN NV.NewView = 'Inferior' AND  NV.Obstructed = 0
                       THEN 1
                       ELSE 0
                       END AS  'InferiorUnobstructedView'
                       ,CASE WHEN NV.NewView = 'Neutral' AND  NV.Obstructed = 0
                       THEN 1
                       ELSE 0
                       END AS  'NeutralUnobstructedView'
                       ,CASE WHEN NV.NewView = 'Superior' AND  NV.Obstructed = 0
                       THEN 1
                       ELSE 0
                       END AS  'SuperiorUnobstructedView'
                       ,CASE WHEN NV.NewView = 'Inferior' AND  NV.Obstructed = 1
                       THEN 1
                       ELSE 0
                       END AS  'InferiorObstructedView'
                       ,CASE WHEN NV.NewView = 'Neutral' AND  NV.Obstructed = 1
                       THEN 1
                       ELSE 0
                       END AS  'NeutralObstructedView'
                       ,CASE WHEN NV.NewView = 'Superior' AND  NV.Obstructed = 1
                       THEN 1
                       ELSE 0
                       END AS  'SuperiorObstructedView'
                       
                       
                       FROM hold1comb AS Orig 
                       LEFT JOIN NewCondoViews AS 
                       NV ON NV.FolioID = Orig.FolioID"
) 

### Removing temporary data set ###
rm(hold1comb)


## Adding new view into the model ##
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorArea +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(AgeBuilt)
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + InferiorUnobstructedView
                #    + InferiorObstructedView    # None
                #    + NeutralUnobstructedView   #Reference Group
                + NeutralObstructedView
                + SuperiorUnobstructedView
                + SuperiorObstructedView 
                ## IMprovment type ##
                + UnitMidRise  
                + UnitHighRise 
                + UnitTownHouse 
                + UnitLuxuryHighRise
                + UnitHotel
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                + LinearizedQuality
                ##Floor   ##
                +FloorLinearization
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                +I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)
## Summary of the model with new view information ##
summary(GlobalMul)

### Getting information on Penthouse information ###
myConn <- odbcConnect("cama_stateroll")  #creating connection to database
## importing the data from a sql query
PentVar<- sqlQuery(myConn,"
                   select T.FolioID,
                   CASE WHEN T.UnitType LIKE '%P%' OR   T.UnitType LIKE '%p%'
                   THEN 1
                   ELSE 0
                   END AS 'PentHouse',
                   CASE WHEN C.floor != 0 
                   THEN 
                   cast (C.floor AS numeric (5,2))/cast( (
                   SELECT MAX(cm.floor) 
                   FROM appraisal.dbo.Condominium AS cm
                   WHERE cm.ComplexID =T.ComplexID
                   GROUP BY cm.ComplexID
                   ) AS  numeric(5,2))
                   ELSE 0  
                   END AS 'PercentHeight'
                   FROM appraisal.dbo.CondominiumTable AS T
                   INNER JOIN appraisal.dbo.condominium AS C  ON 
                   C.FolioID =T.FolioID AND C.ComplexID = T.ComplexID                          
                   ")
## Closing Connection to not hog up cama
odbcClose(myConn)

### Moving data into a temporary storage to combine ###
hold1comb <- hold1

### Attaching Penthouse info to Our current data ###
hold1<- sqldf("
                           SELECT NV.* , PV.PentHouse , PV.PercentHeight
                           FROM hold1comb AS NV
                           LEFT JOIN PentVar AS PV ON 
                           PV.FolioID = NV.FolioID 

                           ")
### Dropping temporary data set to hold the information ###
rm(hold1comb)
## Adding penthouse variable to the market ##
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorArea +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(AgeBuilt)
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + InferiorUnobstructedView
                #    + InferiorObstructedView    # None
                #    + NeutralUnobstructedView   #Reference Group
                + NeutralObstructedView
                + SuperiorUnobstructedView
                + SuperiorObstructedView 
                ## IMprovment type ##
                + UnitMidRise  
                + UnitHighRise 
                + UnitTownHouse 
                + UnitLuxuryHighRise
                + UnitHotel
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                + LinearizedQuality
                ##Floor   ##
                +FloorLinearization
                ## Pent House ##
                + PentHouse
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                +I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)

## summary of model with the pent house variable added ##
summary(GlobalMul)




### Establishing connection with Cama to gather more information ###
myConn <- odbcConnect("cama_stateroll")  #creating connection to database
## importing the data from a sql query
FloorTwo<- sqlQuery(myConn,"
                    SELECT Main.*,
                    ISNULL(( SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                    FROM appraisal.dbo.SubareaTable AS s
                    WHERE s.FolioID = Main.FolioID AND  s.description IN ('CON')
                    AND s.Floor != Main.MainFloorNumber 
                    GROUP BY s.FolioID
                    ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'SecondaryFloorArea',
                    ISNULL(( SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                    FROM appraisal.dbo.SubareaTable AS s
                    WHERE s.FolioID = Main.FolioID AND  s.description IN ('CON')
                    AND s.Floor > Main.MainFloorNumber 
                    GROUP BY s.FolioID
                    ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'SecondaryFloorAreaUpper',
                    ISNULL(( SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                    FROM appraisal.dbo.SubareaTable AS s
                    WHERE s.FolioID = Main.FolioID AND  s.description IN ('CON')
                    AND s.Floor < Main.MainFloorNumber 
                    GROUP BY s.FolioID
                    ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'SecondaryFloorAreaLower'
                    FROM (
                    SELECT c. folioid,
                    ISNULL((  SELECT  TOP 1  SUM(s.ActualArea ) AS 'Area'
                    FROM appraisal.dbo.SubareaTable AS s
                    WHERE s.FolioID = c.FolioID AND  s.description IN ('CON') 
                    GROUP BY s.Floor 
                    ORDER BY SUM(s.ActualArea ) DESC  ),0) AS 'MainFloorArea',
                    ISNULL((  SELECT  TOP 1  s.Floor
                    FROM appraisal.dbo.SubareaTable AS s
                    WHERE s.FolioID = c.FolioID AND  s.description IN ('CON') 
                    GROUP BY s.Floor 
                    ORDER BY SUM(s.ActualArea ) DESC   ),0) AS 'MainFloorNumber'
                    FROM appraisal.dbo.Condominium AS c
                    --where c.FolioID = '10546172'
                    )  AS Main 
                    
                    
                    
                    ")
### Closing Connection to not hog up Cama1 ##
odbcClose(myConn)

## Creating temporary data set to combine the data ##
hold1comb <- hold1 
## combining the upper and lower floor area information ##
hold1 <- sqldf("
                 SELECT h.*,
                 FT.SecondaryFloorAreaUpper,
                 FT.SecondaryFloorAreaLower
                 FROM hold1comb AS h
                 LEFT JOIN FloorTwo AS FT ON FT.FolioID = h.FolioID 
                 "
)
## Dropping temporary data set now that data has been combined ##
rm(hold1comb)
## breaking out secondary floor area with above and below ##
GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorAreaUpper  +1 )
                + log(SecondaryFloorAreaLower  +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                + log(AgeBuilt)
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + InferiorUnobstructedView
                #    + InferiorObstructedView    # None
                #    + NeutralUnobstructedView   #Reference Group
                + NeutralObstructedView
                + SuperiorUnobstructedView
                + SuperiorObstructedView 
                ## IMprovment type ##
                + UnitMidRise  
                + UnitHighRise 
                + UnitTownHouse 
                + UnitLuxuryHighRise
                + UnitHotel
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                + LinearizedQuality
                ##Floor   ##
                +FloorLinearization
                ## Pent House ##
                + PentHouse
                ## Time To Sale ##
                +log(TimeToSale)
                +I(log(TimeToSale) * log(TimeToSale))
                +I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                + FPLC
                + Group2
                + Group3
                + Group4
                
                , data = hold1)
### Summary of model with above and below secondary floor broken out
summary(GlobalMul)




#### Making complex adjustments for complexes with more #####  
####than 5 sales within the complex###
### Getting Complex Id's
x <- table(hold1$ComplexID)
### Keeping only the ones with more than 5 sales
x <- x[x > 5]
### Getting the Complex ID names
ComplexIdList <- names(x)
## Removing Old List
rm(x)
hold1$ComplexIDUpdated <- factor(hold1$ComplexID, levels = ComplexIdList)
NROW( hold1aNewView[is.na(hold1aNewView$ComplexIDUpdated), ])
hold1 <- subset(hold1 , !is.na(ComplexIDUpdated))

##### BREAKS OUT ALL THE COMPLEX ID's######

### Creating dummy variables for the different complex ID's
checkm <- model.matrix(~ComplexIDUpdated - 1 , data = hold1)
### Combing to old data
hold1 <- cbind(hold1 ,checkm )
## Removing the temporary variable ###
rm(checkm)
write.csv(hold1[1,c(401:1233)],'C:/Users/jorgensenj/OneDrive - Lee County Property Appraiser/my documents/Complexes2.csv')

GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorAreaUpper  +1 )
                + log(SecondaryFloorAreaLower  +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
               # + log(AgeBuilt)                  ## Non Sense
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + InferiorUnobstructedView
                #    + InferiorObstructedView    # None
                #    + NeutralUnobstructedView   #Reference Group
                + NeutralObstructedView
                + SuperiorUnobstructedView
                + SuperiorObstructedView 
                ## IMprovment type ##
                + UnitMidRise  
                + UnitHighRise 
                + UnitTownHouse 
              #  + UnitLuxuryHighRise
                + UnitHotel
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
              #  + LinearizedQuality ## Found Insignificant with addition of complexes
                ##Floor   ##
                +FloorLinearization
                ## Pent House ##
                + PentHouse
                ## Time To Sale ##
                +log(TimeToSale)
                + I(log(TimeToSale) * log(TimeToSale))
                + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
             #   + FPLC
                + Group2
                + Group3
                + Group4
             #    + ComplexIDUpdated0143220200000 ## Found Insignificant
                 + ComplexIDUpdated0143220300000
                 + ComplexIDUpdated0143220700000
                 + ComplexIDUpdated0143220800000
                 + ComplexIDUpdated0143221000000
                 + ComplexIDUpdated0143221200000
              #   + ComplexIDUpdated0143221600000 ## Found Insignificant
                 + ComplexIDUpdated0143221800000
               #  + ComplexIDUpdated0146230600000 ## Found Insignificant
                 + ComplexIDUpdated0146230900000
                 + ComplexIDUpdated0146232100000
                 + ComplexIDUpdated0146232600000
                 + ComplexIDUpdated0146240500000
                 + ComplexIDUpdated0146240600000
                 + ComplexIDUpdated0146240900000
                 + ComplexIDUpdated0146241200000
              #   + ComplexIDUpdated0146241300000 ## Found Insignificant
                 + ComplexIDUpdated0146241400000
                 + ComplexIDUpdated0146241700000
                 + ComplexIDUpdated0246222200000
                 + ComplexIDUpdated0246230900000
                 + ComplexIDUpdated0246231200000
                 + ComplexIDUpdated0246231800000
             #    + ComplexIDUpdated0246240400000  ## Found Insignificant
                 + ComplexIDUpdated0344250900000
                 + ComplexIDUpdated0346241000000
                 + ComplexIDUpdated0346241900000
                 + ComplexIDUpdated0444240300000
             #    + ComplexIDUpdated0546240400000  ## Found Insignificant
                 + ComplexIDUpdated0643230100000
                 + ComplexIDUpdated0643230300000
                 + ComplexIDUpdated0643230400000
                 + ComplexIDUpdated0643230500000
                 + ComplexIDUpdated0643230600000
                 + ComplexIDUpdated0643230700000
               #  + ComplexIDUpdated0643233300000  ## Found Insignificant
                 + ComplexIDUpdated0645262000000
                 + ComplexIDUpdated0645270800000
                 + ComplexIDUpdated0645270900000
                 + ComplexIDUpdated0646241200000
                 + ComplexIDUpdated0646241300000
                 + ComplexIDUpdated0646242000000
                 + ComplexIDUpdated0646242100000
             #    + ComplexIDUpdated0646243400000 ## Found Insignificant
                 + ComplexIDUpdated0646243500000
                 + ComplexIDUpdated0745261100000
                 + ComplexIDUpdated0745262800000
                 + ComplexIDUpdated0746251000000
                 + ComplexIDUpdated0746251100000
                 + ComplexIDUpdated0746251300000
                 + ComplexIDUpdated0846252100000
                 + ComplexIDUpdated0846255100000
                 + ComplexIDUpdated0944242000000
                 + ComplexIDUpdated0945270800000
                 + ComplexIDUpdated0946230100000
                 + ComplexIDUpdated0946230500000
                 + ComplexIDUpdated0946240600000
                 + ComplexIDUpdated0946240700000
                 + ComplexIDUpdated0946240900000
                 + ComplexIDUpdated0946242400000
                 + ComplexIDUpdated0946242500000
                 + ComplexIDUpdated1044241400000
                 + ComplexIDUpdated1044241900000
                 + ComplexIDUpdated1044242000000
                 + ComplexIDUpdated1044242500000
                 + ComplexIDUpdated1044244000000
                 + ComplexIDUpdated1044244400000
                 + ComplexIDUpdated1144241100000
                 + ComplexIDUpdated1144241200000
                 + ComplexIDUpdated1144241600000
                 + ComplexIDUpdated1144241700000
                 + ComplexIDUpdated1144242400000
                 + ComplexIDUpdated1144242600000
                 + ComplexIDUpdated1145243300000
                 + ComplexIDUpdated1146230100000
                 + ComplexIDUpdated1146250300000
                 + ComplexIDUpdated1146250700000
              #   + ComplexIDUpdated1147242700000  ## Found Insignificant
                 + ComplexIDUpdated1245242400000
                 + ComplexIDUpdated1245242500000
                 + ComplexIDUpdated1245242600000
                 + ComplexIDUpdated1245242700000
                 + ComplexIDUpdated1245242800000
                 + ComplexIDUpdated1246230700000
                 + ComplexIDUpdated1246240900000
                 + ComplexIDUpdated1246241000000
                 + ComplexIDUpdated1246241100000
                 + ComplexIDUpdated1246241400000
                 + ComplexIDUpdated1246241600000
                 + ComplexIDUpdated1246242700000
                 + ComplexIDUpdated1246242800000
                 + ComplexIDUpdated1246242900000
                 + ComplexIDUpdated1246243600000
                 + ComplexIDUpdated1246251700000
                 + ComplexIDUpdated1345243000000
                 + ComplexIDUpdated1345243200000
                 + ComplexIDUpdated1345243300000
                 + ComplexIDUpdated1346230600000
                 + ComplexIDUpdated1346230800000
               #  + ComplexIDUpdated1346231000000 ## Found Insignificant
                 + ComplexIDUpdated1346232000000
                 + ComplexIDUpdated1443200400000
                 + ComplexIDUpdated1445242000000
                 + ComplexIDUpdated1445243000000
                 + ComplexIDUpdated1445243100000
                 + ComplexIDUpdated1445245000000
                 + ComplexIDUpdated1445245100000
                 + ComplexIDUpdated1446250700000
                 + ComplexIDUpdated1446251100000
                 + ComplexIDUpdated1446251200000
                 + ComplexIDUpdated1446251400000
                 + ComplexIDUpdated1545242000000
                 + ComplexIDUpdated1545242900000
                 + ComplexIDUpdated1545243000000
                 + ComplexIDUpdated1545243100000
                 + ComplexIDUpdated1545243200000
                 + ComplexIDUpdated1545244400000
              #   + ComplexIDUpdated1545244900000 ## Found Insignificant
                 + ComplexIDUpdated1644220700000
                 + ComplexIDUpdated1644241200000
                 + ComplexIDUpdated1644241300000
                 + ComplexIDUpdated1644242000000
                 + ComplexIDUpdated1644242200000
                 + ComplexIDUpdated1644242300000
                 + ComplexIDUpdated1644243200000
                 + ComplexIDUpdated1644243400000
                 + ComplexIDUpdated1644243500000
                 + ComplexIDUpdated1645242100000
                 + ComplexIDUpdated1645242300000
                 + ComplexIDUpdated1645242400000
                 + ComplexIDUpdated1645242700000
                 + ComplexIDUpdated1645242800000
               #  + ComplexIDUpdated1645242900000 ## Found Insignificant
                 + ComplexIDUpdated1645243400000
                 + ComplexIDUpdated1645244100000
                 + ComplexIDUpdated1745251000000
                 + ComplexIDUpdated1745251100000
                 + ComplexIDUpdated1745251400000
                 + ComplexIDUpdated1746252000000
                 + ComplexIDUpdated1746252700000
                 + ComplexIDUpdated1845260600000
                 + ComplexIDUpdated1845260700000
                 + ComplexIDUpdated1845261000000
              #   + ComplexIDUpdated1845263700000 ## Found Insignificant
                 + ComplexIDUpdated1846252300000
              #   + ComplexIDUpdated1846252800000 ## Found Insignificant
                 + ComplexIDUpdated1945250800000
                 + ComplexIDUpdated1945251200000
                 + ComplexIDUpdated1945252200000
                 + ComplexIDUpdated1945252400000
                 + ComplexIDUpdated1946243800000
                 + ComplexIDUpdated2045242500000
                 + ComplexIDUpdated2045242600000
                 + ComplexIDUpdated2045242700000
                 + ComplexIDUpdated2045242900000
                 + ComplexIDUpdated2045250300000
                 + ComplexIDUpdated2045250500000
                 + ComplexIDUpdated2045250600000
                 + ComplexIDUpdated2045250700000
                 + ComplexIDUpdated2045251000000
                 + ComplexIDUpdated2045251100000
                 + ComplexIDUpdated2045251700000
                 + ComplexIDUpdated2045251800000
                 + ComplexIDUpdated2144242400000
                 + ComplexIDUpdated2144243000000
                 + ComplexIDUpdated2145240500000
                 + ComplexIDUpdated2145241200000
                 + ComplexIDUpdated2145241300000
                 + ComplexIDUpdated2145242000000
                # + ComplexIDUpdated2145242200000 ## Found Insignificant
                 + ComplexIDUpdated2145242700000
                 + ComplexIDUpdated2145243200000
                 + ComplexIDUpdated2145243300000
                 + ComplexIDUpdated2145244900000
                 + ComplexIDUpdated2245210200000
                 + ComplexIDUpdated2245212300000
                 + ComplexIDUpdated2245242000000
                 + ComplexIDUpdated2245242100000
                 + ComplexIDUpdated2245242300000
                 + ComplexIDUpdated2245242400000
                 + ComplexIDUpdated2245242800000
                 + ComplexIDUpdated2245243000000
                 + ComplexIDUpdated2245243100000
                 + ComplexIDUpdated2245243700000
             #    + ComplexIDUpdated2245251400000 ## Found Insignificant
                 + ComplexIDUpdated2343202000000
                 + ComplexIDUpdated2345242000000
                 + ComplexIDUpdated2345242300000
                 + ComplexIDUpdated2345242400000
                 + ComplexIDUpdated2345243600000
                 + ComplexIDUpdated2345244000000
                 + ComplexIDUpdated2345244200000
                 + ComplexIDUpdated2345244300000
                 + ComplexIDUpdated2345244500000
                 + ComplexIDUpdated2345245600000
              #   + ComplexIDUpdated2346250200000 ## Found Insignificant
                 + ComplexIDUpdated2445240700000 
               #  + ComplexIDUpdated2543210400000 ## Found Insignificant
                 + ComplexIDUpdated2543250100000
                 + ComplexIDUpdated2545233200000
                 + ComplexIDUpdated2545233300000
                 + ComplexIDUpdated2545233400000
                 + ComplexIDUpdated2545240700000
                 + ComplexIDUpdated2643202600000
                 + ComplexIDUpdated2643203000000
                 + ComplexIDUpdated2645212600000
                 + ComplexIDUpdated2645212700000
                 + ComplexIDUpdated2645213000000
                 + ComplexIDUpdated2645240200000
                 + ComplexIDUpdated2645240300000
                 + ComplexIDUpdated2645240800000
                 + ComplexIDUpdated2645240900000
                 + ComplexIDUpdated2744271700000
                 + ComplexIDUpdated2744272000000
                 + ComplexIDUpdated2744272500000
                 + ComplexIDUpdated2745242300000
                 + ComplexIDUpdated2745242600000
                 + ComplexIDUpdated2745242800000
                 + ComplexIDUpdated2745242900000
                 + ComplexIDUpdated2745243000000
                 + ComplexIDUpdated2745243100000
                 + ComplexIDUpdated2745243300000
                 + ComplexIDUpdated2745243400000
                 + ComplexIDUpdated2745243500000
                 + ComplexIDUpdated2745243700000
                 + ComplexIDUpdated2745243800000
                 + ComplexIDUpdated2745243900000
                 + ComplexIDUpdated2745244000000
                 + ComplexIDUpdated2745244100000
                 + ComplexIDUpdated2745244200000
                 + ComplexIDUpdated2745244300000
                 + ComplexIDUpdated2745244400000
                 + ComplexIDUpdated2745244500000
                 + ComplexIDUpdated2745244700000
                 + ComplexIDUpdated2745250400000
                 + ComplexIDUpdated2845241100000
                 + ComplexIDUpdated2845241300000
                 + ComplexIDUpdated2845241400000
                 + ComplexIDUpdated2845242000000
                 + ComplexIDUpdated2845242200000
                 + ComplexIDUpdated2845242900000
                 + ComplexIDUpdated2845243000000
                 + ComplexIDUpdated2845243100000
                 + ComplexIDUpdated2845243300000
                 + ComplexIDUpdated2845243900000
                 + ComplexIDUpdated2845250300000
                 + ComplexIDUpdated2845250400000
                 + ComplexIDUpdated2845251200000
                 + ComplexIDUpdated2845251400000
                 + ComplexIDUpdated2845251500000
                 + ComplexIDUpdated2845251700000
                 + ComplexIDUpdated2945240500000
                 + ComplexIDUpdated2945242000000
                 + ComplexIDUpdated2945242100000
                 + ComplexIDUpdated2945242200000
                 + ComplexIDUpdated2945242400000
                 + ComplexIDUpdated2945242600000
                 + ComplexIDUpdated2945242700000
                 + ComplexIDUpdated2945242800000
                 + ComplexIDUpdated2945242900000
                 + ComplexIDUpdated2945250300000
                 + ComplexIDUpdated2945250600000
                 + ComplexIDUpdated2945250800000
               #  + ComplexIDUpdated3043221400000 ## Found Insignificant
                 + ComplexIDUpdated3045241000000
              #   + ComplexIDUpdated3045241300000 ## Found Insignificant
               #  + ComplexIDUpdated3045242100000 ## Found Insignificant
                 + ComplexIDUpdated3045244300000
                 + ComplexIDUpdated3045244500000
                 + ComplexIDUpdated3143251400000
                 + ComplexIDUpdated3143251600000
                 + ComplexIDUpdated3143251700000
                 + ComplexIDUpdated3143251800000
                 + ComplexIDUpdated3143253100000
                 + ComplexIDUpdated3143260700000
                 + ComplexIDUpdated3144263000000
                 + ComplexIDUpdated3144263300000
                 + ComplexIDUpdated3144271800000
                 + ComplexIDUpdated3145240800000
                 + ComplexIDUpdated3145242000000
                 + ComplexIDUpdated3145242100000
                 + ComplexIDUpdated3145242400000
                 + ComplexIDUpdated3145243800000
                 + ComplexIDUpdated3145244500000
               #  + ComplexIDUpdated3145245000000 ## Found Insignificant
                 + ComplexIDUpdated3145245400000
                 + ComplexIDUpdated3145245500000
                 + ComplexIDUpdated3145245800000
               #  + ComplexIDUpdated3145246100000 ## Found Insignificant
                 + ComplexIDUpdated3145246200000
                 + ComplexIDUpdated3243262300000
                 + ComplexIDUpdated3244261200000
                 + ComplexIDUpdated3245250600000
                 + ComplexIDUpdated3245250900000
                 + ComplexIDUpdated3245251000000
                 + ComplexIDUpdated3345240100000
                 + ComplexIDUpdated3345241600000
               #  + ComplexIDUpdated3345241900000 ## Found Insignificant
                 + ComplexIDUpdated3345242100000
                 + ComplexIDUpdated3444272000000
                 + ComplexIDUpdated3444272500000
                 + ComplexIDUpdated3445240700000
                 + ComplexIDUpdated3445240800000
                 + ComplexIDUpdated3445240900000
                 + ComplexIDUpdated3445241700000
                 + ComplexIDUpdated3445242000000
                 + ComplexIDUpdated3543260400000
                 + ComplexIDUpdated3545222200000
                 + ComplexIDUpdated3545240600000
                 + ComplexIDUpdated3643242000000
                 + ComplexIDUpdated3643242100000
                 + ComplexIDUpdated3643242500000
                 + ComplexIDUpdated3643242600000
                 + ComplexIDUpdated3643242900000
                 + ComplexIDUpdated3643243200000
                 + ComplexIDUpdated3643250700000
                 + ComplexIDUpdated3645232100000
              #   + ComplexIDUpdated3645232300000 ## Found Insignificant
               # + ComplexIDUpdated3645233500000  ## Found Insignificant
                 + ComplexIDUpdated3645241000000
                 + ComplexIDUpdatedB103851000000
                 + ComplexIDUpdatedB103851100000
                 + ComplexIDUpdatedB103851200000
              #   + ComplexIDUpdatedB103851300000 ## Found Insignificant
                 + ComplexIDUpdatedB103851800000
                 + ComplexIDUpdatedB105860200000
                 + ComplexIDUpdatedB105860300000
              #   + ComplexIDUpdatedB106862400000  ## Found Insignificant
                 + ComplexIDUpdatedB117751700000
                 + ComplexIDUpdatedB117753600000
                 + ComplexIDUpdatedB117753700000
                 + ComplexIDUpdatedB121752200000
                 + ComplexIDUpdatedB123751100000
                 + ComplexIDUpdatedB123751900000
                 + ComplexIDUpdatedB123752100000
                 + ComplexIDUpdatedB123752300000
                 + ComplexIDUpdatedB125752800000
                 + ComplexIDUpdatedB126751200000
                 + ComplexIDUpdatedB127751200000
                 + ComplexIDUpdatedB129751400000
                 + ComplexIDUpdatedB129755200000
                 + ComplexIDUpdatedB129755400000
                 + ComplexIDUpdatedB129755700000
                 + ComplexIDUpdatedB129755800000
                 + ComplexIDUpdatedB129756200000
                 + ComplexIDUpdatedB132752300000
                 + ComplexIDUpdatedB133752500000
                 + ComplexIDUpdatedB134752700000
                 + ComplexIDUpdatedB136752000000
                # + ComplexIDUpdatedB201852700000 ## Found Insignificant
                 + ComplexIDUpdatedB201860400000
                # + ComplexIDUpdatedB201860500000 ## Found Insignificant
                 + ComplexIDUpdatedB202850100000
                 + ComplexIDUpdatedB204860700000
                 + ComplexIDUpdatedB204861000000
                 + ComplexIDUpdatedB206862700000
                # + ComplexIDUpdatedB217751300000 ## Found Isnignificant
                 + ComplexIDUpdatedB217751500000
                 + ComplexIDUpdatedB218750100000
                 + ComplexIDUpdatedB218750200000
                 + ComplexIDUpdatedB218753300000
                 + ComplexIDUpdatedB220750300000
                 + ComplexIDUpdatedB220753700000
              #   + ComplexIDUpdatedB221752000000 ## Found Insignificant
                 + ComplexIDUpdatedB221753400000
                 + ComplexIDUpdatedB225742000000
                 + ComplexIDUpdatedB225742100000
                 + ComplexIDUpdatedB225743200000
               #  + ComplexIDUpdatedB225743500000 ## Found Insignficant
                 + ComplexIDUpdatedB225743800000
                 + ComplexIDUpdatedB225744000000
                 + ComplexIDUpdatedB225744200000
                 + ComplexIDUpdatedB226751800000
                 + ComplexIDUpdatedB226752900000
                 + ComplexIDUpdatedB228751500000
                 + ComplexIDUpdatedB228751800000
                 + ComplexIDUpdatedB232751000000
                 + ComplexIDUpdatedB232752000000
                 + ComplexIDUpdatedB233753600000
                 + ComplexIDUpdatedB234755300000
                 + ComplexIDUpdatedB235752100000
                 + ComplexIDUpdatedB301851700000
                 + ComplexIDUpdatedB301851800000
                 + ComplexIDUpdatedB302851700000
                 + ComplexIDUpdatedB304852100000
                 + ComplexIDUpdatedB304852500000
                 + ComplexIDUpdatedB304852700000
                # + ComplexIDUpdatedB304853300000 ## Found Insignificant
                 + ComplexIDUpdatedB304853600000
                 + ComplexIDUpdatedB306860800000
                 + ComplexIDUpdatedB317751200000
                 + ComplexIDUpdatedB321753000000
                 + ComplexIDUpdatedB322750800000
                 + ComplexIDUpdatedB322751600000
              #   + ComplexIDUpdatedB324742900000 ## Found Insignificant
                 + ComplexIDUpdatedB324743000000
                 + ComplexIDUpdatedB324743300000
                 + ComplexIDUpdatedB327752000000
                 + ComplexIDUpdatedB327752500000
                 + ComplexIDUpdatedB327752600000
                 + ComplexIDUpdatedB329750400000
                 + ComplexIDUpdatedB331751000000
               #  + ComplexIDUpdatedB331751500000 ## Found Insignificant
                 + ComplexIDUpdatedB332753600000
                 + ComplexIDUpdatedB332753800000
                 + ComplexIDUpdatedB334753600000
                 + ComplexIDUpdatedB401852900000
                 + ComplexIDUpdatedB401860200000
                 + ComplexIDUpdatedB402740100000
                 + ComplexIDUpdatedB402740200000
                 + ComplexIDUpdatedB402740300000
                 + ComplexIDUpdatedB402851100000
                 + ComplexIDUpdatedB403850400000
               #  + ComplexIDUpdatedB404851300000 ## Found Insignificant
               #  + ComplexIDUpdatedB404851400000 ## Found Insignificant
               #  + ComplexIDUpdatedB404851900000 ## Found Insignificant
               #  + ComplexIDUpdatedB404852000000 ## Found Insignificant
              #   + ComplexIDUpdatedB404860200000 ## Found Insignificant
                 + ComplexIDUpdatedB406861800000
              #   + ComplexIDUpdatedB406862700000 ## Found Insignificant
                 + ComplexIDUpdatedB408754000000
                 + ComplexIDUpdatedB416751000000
                 + ComplexIDUpdatedB416751600000
                 + ComplexIDUpdatedB420753800000
                 + ComplexIDUpdatedB420754000000
                 + ComplexIDUpdatedB423750900000
                 + ComplexIDUpdatedB423751000000
                 + ComplexIDUpdatedB424743100000
                 + ComplexIDUpdatedB424743400000
                 + ComplexIDUpdatedB427751300000
                 + ComplexIDUpdatedB427751600000
                 + ComplexIDUpdatedB428750300000
                 + ComplexIDUpdatedB428750700000
                 + ComplexIDUpdatedB428750800000
               #  + ComplexIDUpdatedB428751000000 ## Found Insignificant
                 + ComplexIDUpdatedB428753100000
              #   + ComplexIDUpdatedB429750900000 ## Found Insignifcant
                 + ComplexIDUpdatedB429751300000
                 + ComplexIDUpdatedB429754400000
                 + ComplexIDUpdatedB429754600000
                 + ComplexIDUpdatedB430760300000
                 + ComplexIDUpdatedB430760400000
                 + ComplexIDUpdatedB433753800000
               #  + ComplexIDUpdatedC106543900000 ## Found Insignificant
                 + ComplexIDUpdatedC107542800000
                # + ComplexIDUpdatedC107545500000 ## Found Insignificant
                 + ComplexIDUpdatedC108540600000
                 + ComplexIDUpdatedC108540700000
                 + ComplexIDUpdatedC108540800000
                 + ComplexIDUpdatedC108541000000
                 + ComplexIDUpdatedC108541100000
                 + ComplexIDUpdatedC108541200000
                 + ComplexIDUpdatedC108541300000
                 + ComplexIDUpdatedC108541500000
                 + ComplexIDUpdatedC108541600000
                 + ComplexIDUpdatedC108541800000
                 + ComplexIDUpdatedC108541900000
                 + ComplexIDUpdatedC108542100000
                 + ComplexIDUpdatedC108542300000
                 + ComplexIDUpdatedC108542600000
                 + ComplexIDUpdatedC112533700000
                 + ComplexIDUpdatedC113530500000
                 + ComplexIDUpdatedC113530700000
                 + ComplexIDUpdatedC113530900000
                 + ComplexIDUpdatedC113531200000
                 + ComplexIDUpdatedC113531300000
                 + ComplexIDUpdatedC115531400000
                 + ComplexIDUpdatedC115531500000
                 + ComplexIDUpdatedC115531700000
                 + ComplexIDUpdatedC115531800000
                 + ComplexIDUpdatedC115532300000
                 + ComplexIDUpdatedC117540400000
                 + ComplexIDUpdatedC117540500000
                 + ComplexIDUpdatedC118540100000
                 + ComplexIDUpdatedC118540200000
                 + ComplexIDUpdatedC118540300000
                 + ComplexIDUpdatedC118540400000
                 + ComplexIDUpdatedC118540500000
                 + ComplexIDUpdatedC118540800000
                 + ComplexIDUpdatedC118540900000
                 + ComplexIDUpdatedC118541500000
                 + ComplexIDUpdatedC118541600000
                 + ComplexIDUpdatedC118541700000
               #  + ComplexIDUpdatedC118543000000  ## Found Insignificant
                 + ComplexIDUpdatedC119440100000
                 + ComplexIDUpdatedC119440200000
                 + ComplexIDUpdatedC123530100000
                 + ComplexIDUpdatedC123530200000
                 + ComplexIDUpdatedC127430100000
                 + ComplexIDUpdatedC127430300000
                 + ComplexIDUpdatedC129440300000
                 + ComplexIDUpdatedC129440400000
                 + ComplexIDUpdatedC132440200000
                 + ComplexIDUpdatedC132440300000
                 + ComplexIDUpdatedC207543000000
                 + ComplexIDUpdatedC207543200000
                 + ComplexIDUpdatedC207543700000
                 + ComplexIDUpdatedC207543900000
                 + ComplexIDUpdatedC207544300000
                 + ComplexIDUpdatedC208542800000
                 + ComplexIDUpdatedC208543000000
                 + ComplexIDUpdatedC208543700000
                 + ComplexIDUpdatedC208543900000
             #    + ComplexIDUpdatedC208544500000  ## Found Insignificant
                 + ComplexIDUpdatedC208544600000
                 + ComplexIDUpdatedC208545000000
                 + ComplexIDUpdatedC208545200000
                 + ComplexIDUpdatedC212534900000
                 + ComplexIDUpdatedC212535000000
                 + ComplexIDUpdatedC213531900000
                 + ComplexIDUpdatedC213532000000
                 + ComplexIDUpdatedC213532300000
                 + ComplexIDUpdatedC213532700000
                 + ComplexIDUpdatedC213532800000
                 + ComplexIDUpdatedC215530100000
                 + ComplexIDUpdatedC215530700000
                 + ComplexIDUpdatedC215530800000
                 + ComplexIDUpdatedC215531100000
                 + ComplexIDUpdatedC215532200000
                 + ComplexIDUpdatedC216530100000
                 + ComplexIDUpdatedC216531000000
                 + ComplexIDUpdatedC216531100000
                 + ComplexIDUpdatedC216531400000
                 + ComplexIDUpdatedC218430800000
                 + ComplexIDUpdatedC218440100000
                 + ComplexIDUpdatedC221341000000
                 + ComplexIDUpdatedC221530600000
                 + ComplexIDUpdatedC221530700000
               #  + ComplexIDUpdatedC221530800000 ## Found Insignificant
                 + ComplexIDUpdatedC222530600000
               #  + ComplexIDUpdatedC301321700000 ## Found Insignificant
                 + ComplexIDUpdatedC305440100000
                 + ComplexIDUpdatedC306543200000
                 + ComplexIDUpdatedC306543500000
                 + ComplexIDUpdatedC307543100000
                 + ComplexIDUpdatedC307543500000
                 + ComplexIDUpdatedC307543600000
                 + ComplexIDUpdatedC307544200000
                 + ComplexIDUpdatedC307544600000
                 + ComplexIDUpdatedC310530100000
                 + ComplexIDUpdatedC310530400000
                 + ComplexIDUpdatedC310530600000
                 + ComplexIDUpdatedC310531800000
                 + ComplexIDUpdatedC310532200000
                 + ComplexIDUpdatedC311530200000
                 + ComplexIDUpdatedC311530500000
                 + ComplexIDUpdatedC311530600000
                 + ComplexIDUpdatedC311530800000
                 + ComplexIDUpdatedC312530500000
                 + ComplexIDUpdatedC312530600000
                 + ComplexIDUpdatedC312531000000
                 + ComplexIDUpdatedC312531500000
                 + ComplexIDUpdatedC312531600000
                 + ComplexIDUpdatedC312531700000
                 + ComplexIDUpdatedC312535200000
                 + ComplexIDUpdatedC313532100000
                 + ComplexIDUpdatedC314430300000
                 + ComplexIDUpdatedC314431000000
               #  + ComplexIDUpdatedC316530300000 ## Found Insignificant
                 + ComplexIDUpdatedC316530500000
                 + ComplexIDUpdatedC324430100000
                 + ComplexIDUpdatedC327430600000
                 + ComplexIDUpdatedC329430400000
                 + ComplexIDUpdatedC404441200000
                 + ComplexIDUpdatedC404441800000
                 + ComplexIDUpdatedC404530200000
                 + ComplexIDUpdatedC406540900000
                 + ComplexIDUpdatedC406541500000
                 + ComplexIDUpdatedC406541700000
                 + ComplexIDUpdatedC406541800000
                 + ComplexIDUpdatedC406541900000
                 + ComplexIDUpdatedC406542800000
                 + ComplexIDUpdatedC406543100000
                 + ComplexIDUpdatedC407440800000
                 + ComplexIDUpdatedC407540800000
                 + ComplexIDUpdatedC407541300000
                 + ComplexIDUpdatedC407541700000
                 + ComplexIDUpdatedC407541900000
                 + ComplexIDUpdatedC407542400000
                 + ComplexIDUpdatedC408544100000
                 + ComplexIDUpdatedC408545000000
                 + ComplexIDUpdatedC410530900000
                 + ComplexIDUpdatedC410531000000
                 + ComplexIDUpdatedC410531300000
                 + ComplexIDUpdatedC410532100000
                 + ComplexIDUpdatedC411531400000
                 + ComplexIDUpdatedC412534400000
                 + ComplexIDUpdatedC412534500000
                 + ComplexIDUpdatedC418440700000
                 + ComplexIDUpdatedC418440900000
                 + ComplexIDUpdatedC422530800000
                 + ComplexIDUpdatedC429340100000
                 + ComplexIDUpdatedC432440500000
                 + ComplexIDUpdatedE103751300000
                 + ComplexIDUpdatedE104753100000
                 + ComplexIDUpdatedE109752300000
                 + ComplexIDUpdatedE109753000000
                 + ComplexIDUpdatedE110750600000
                 + ComplexIDUpdatedE121650500000
                 + ComplexIDUpdatedE128651300000
                 + ComplexIDUpdatedE132653000000
               #  + ComplexIDUpdatedE134652100000 ## Found Insignificant
                 + ComplexIDUpdatedE203751200000
                 + ComplexIDUpdatedE204752900000
                 + ComplexIDUpdatedE204753200000
                 + ComplexIDUpdatedE209754000000
               #  + ComplexIDUpdatedE211752900000 ## Found Isnignificant
                 + ComplexIDUpdatedE221650700000
                 + ComplexIDUpdatedE225651700000
                 + ComplexIDUpdatedE229651200000
                 + ComplexIDUpdatedE229651300000
                 + ComplexIDUpdatedE229651400000
                 + ComplexIDUpdatedE229652000000
                 + ComplexIDUpdatedE229652700000
                 + ComplexIDUpdatedE229660300000
                 + ComplexIDUpdatedE230660200000
               #  + ComplexIDUpdatedE230660500000 ## Found Insignificant
               #  + ComplexIDUpdatedE231650800000 ## Found Insignificant
                 + ComplexIDUpdatedE231650900000
               #  + ComplexIDUpdatedE232650600000 ## Found Insignificant
                 + ComplexIDUpdatedE236651500000
                 + ComplexIDUpdatedE302753100000
                 + ComplexIDUpdatedE304753800000
          ##       + ComplexIDUpdatedE309754800000  ## Reference Group
                 + ComplexIDUpdatedE310750300000
                 + ComplexIDUpdatedE310751500000
              #   + ComplexIDUpdatedE311751600000 ## Found Insignificant
                 + ComplexIDUpdatedE311752100000
              #   + ComplexIDUpdatedE311752200000 ## Found isnignificant
              #   + ComplexIDUpdatedE311753300000 ## Found Insignificant
                 + ComplexIDUpdatedE320651400000
                 + ComplexIDUpdatedE321651100000
                 + ComplexIDUpdatedE327650700000
                 + ComplexIDUpdatedE331653200000
                 + ComplexIDUpdatedE332650400000
                 + ComplexIDUpdatedE332651200000
                 + ComplexIDUpdatedE332652900000
                 + ComplexIDUpdatedE404752700000
                 + ComplexIDUpdatedE408753100000
                 + ComplexIDUpdatedE408753300000
                 + ComplexIDUpdatedE408753500000
                 + ComplexIDUpdatedE408753700000
                 + ComplexIDUpdatedE408753800000
                 + ComplexIDUpdatedE409753300000
                 + ComplexIDUpdatedE410750400000
                 + ComplexIDUpdatedE410750500000
                 + ComplexIDUpdatedE410751100000
                 + ComplexIDUpdatedE410751600000
                # + ComplexIDUpdatedE411753100000 ## Found Isnignificant
                 + ComplexIDUpdatedE425651800000
                 + ComplexIDUpdatedE425652500000
                 + ComplexIDUpdatedE433650500000
               #  + ComplexIDUpdatedE433652700000 ## Found Insignificant
                 + ComplexIDUpdatedE436650100000
                 + ComplexIDUpdatedP102551800000
                 + ComplexIDUpdatedP104550400000
                 + ComplexIDUpdatedP104550600000
                 + ComplexIDUpdatedP104551200000
                 + ComplexIDUpdatedP111543700000
                 + ComplexIDUpdatedP118451800000
                 + ComplexIDUpdatedP118453700000
                 + ComplexIDUpdatedP118454200000
                 + ComplexIDUpdatedP125440900000
                 + ComplexIDUpdatedP131451900000
                 + ComplexIDUpdatedP135452400000
                 + ComplexIDUpdatedP136440100000
                 + ComplexIDUpdatedP136441800000
                 + ComplexIDUpdatedP202540500000
                 + ComplexIDUpdatedP203551000000
                 + ComplexIDUpdatedP203551900000
                 + ComplexIDUpdatedP204551600000
                 + ComplexIDUpdatedP205551500000
                 + ComplexIDUpdatedP208452500000
                 + ComplexIDUpdatedP213440100000
                 + ComplexIDUpdatedP213440300000
                 + ComplexIDUpdatedP213443000000
                 + ComplexIDUpdatedP213443300000
                 + ComplexIDUpdatedP213443400000
               #  + ComplexIDUpdatedP213553500000 ## Found Insignificant
                 + ComplexIDUpdatedP214550900000
                 + ComplexIDUpdatedP214551000000
                 + ComplexIDUpdatedP214552800000
                 + ComplexIDUpdatedP223440100000
                 + ComplexIDUpdatedP223440200000
                 + ComplexIDUpdatedP223441100000
                 + ComplexIDUpdatedP223442500000
                 + ComplexIDUpdatedP223442600000
                 + ComplexIDUpdatedP223442900000
                 + ComplexIDUpdatedP225440600000
                 + ComplexIDUpdatedP231452000000
                 + ComplexIDUpdatedP235451900000
                 + ComplexIDUpdatedP236441600000
              #   + ComplexIDUpdatedP302550500000 ## Found Insignificant
                 + ComplexIDUpdatedP302552100000
                 + ComplexIDUpdatedP305551400000
                 + ComplexIDUpdatedP305551800000
                 + ComplexIDUpdatedP307450200000
                 + ComplexIDUpdatedP309550200000
               #  + ComplexIDUpdatedP312553400000  ## Found Insignificant
                 + ComplexIDUpdatedP313440900000
                 + ComplexIDUpdatedP314443000000
                 + ComplexIDUpdatedP326440300000
                 + ComplexIDUpdatedP326442000000
                 + ComplexIDUpdatedP329450700000
                 + ComplexIDUpdatedP331451300000
                 + ComplexIDUpdatedP331452300000
                 + ComplexIDUpdatedP333450600000
                 + ComplexIDUpdatedP335450900000
                 + ComplexIDUpdatedP401552300000
                 + ComplexIDUpdatedP401554300000
                 + ComplexIDUpdatedP402551200000
                 + ComplexIDUpdatedP402551300000
                 + ComplexIDUpdatedP408452000000
                 + ComplexIDUpdatedP413442900000
               #  + ComplexIDUpdatedP414550700000 ## Found Insignificant
                 + ComplexIDUpdatedP431452600000
                 + ComplexIDUpdatedP435443300000
                 + ComplexIDUpdatedP435452200000
                 + ComplexIDUpdatedP436440600000
                 + ComplexIDUpdatedP436441000000
                 + ComplexIDUpdatedP436441900000
                 + ComplexIDUpdatedT112610400000
                 + ComplexIDUpdatedT112610700000
               #  + ComplexIDUpdatedT120630300000 ## Found Insignificant
                 + ComplexIDUpdatedT120630600000
                 + ComplexIDUpdatedT121630100000
                 + ComplexIDUpdatedT129630200000
                 + ComplexIDUpdatedT129630300000
                 + ComplexIDUpdatedT129630400000
                 + ComplexIDUpdatedT129630500000
                 + ComplexIDUpdatedT129630600000
                 + ComplexIDUpdatedT129630700000
                 + ComplexIDUpdatedT134620100000
                 + ComplexIDUpdatedT134620300000
                 + ComplexIDUpdatedT134620400000
                 + ComplexIDUpdatedT135620200000
                 + ComplexIDUpdatedT135620400000
                 + ComplexIDUpdatedT135620600000
                 + ComplexIDUpdatedT135622200000
                 + ComplexIDUpdatedT211611000000
                 + ComplexIDUpdatedT230630600000
                 + ComplexIDUpdatedT230631500000
                 + ComplexIDUpdatedT230631600000
                 + ComplexIDUpdatedT234621200000
                 + ComplexIDUpdatedT234621300000
                 + ComplexIDUpdatedT235621000000
                 + ComplexIDUpdatedT235621100000
                 + ComplexIDUpdatedT235621200000
                 + ComplexIDUpdatedT235621400000
                 + ComplexIDUpdatedT235621600000
                 + ComplexIDUpdatedT236620700000
                 #+ ComplexIDUpdatedT319630800000 ## Found Insignificant
                 #+ ComplexIDUpdatedT320632300000 ## Found Insignificant
                 #+ ComplexIDUpdatedT320632500000 ## Found Insignificant
                 + ComplexIDUpdatedT320632800000
              #   + ComplexIDUpdatedT325621300000 ## FOund Insignificant
                 + ComplexIDUpdatedT325621700000
                 + ComplexIDUpdatedT330631400000
                 + ComplexIDUpdatedT330632600000
                 + ComplexIDUpdatedT418620300000
                 + ComplexIDUpdatedT430632100000
                 + ComplexIDUpdatedT430632400000
                 + ComplexIDUpdatedT430633100000
                 + ComplexIDUpdatedW103742300000
                 + ComplexIDUpdatedW103742800000
                 + ComplexIDUpdatedW103742900000
                 + ComplexIDUpdatedW103743400000
               # + ComplexIDUpdatedW103743600000  ## Found Insignificant
                 + ComplexIDUpdatedW103743700000
                 + ComplexIDUpdatedW103744200000
               #  + ComplexIDUpdatedW103745100000 ## Found Insignificant
                 + ComplexIDUpdatedW103745500000
                 + ComplexIDUpdatedW103745600000
                 + ComplexIDUpdatedW103746100000
                 + ComplexIDUpdatedW103746300000
                 + ComplexIDUpdatedW103746400000
                 + ComplexIDUpdatedW103746900000
                 + ComplexIDUpdatedW103747600000
                 + ComplexIDUpdatedW103748400000
                 + ComplexIDUpdatedW124632100000
                 + ComplexIDUpdatedW124632300000
                 + ComplexIDUpdatedW124632700000
                 + ComplexIDUpdatedW124633300000
                 + ComplexIDUpdatedW124633600000
                 + ComplexIDUpdatedW124633700000
                 + ComplexIDUpdatedW124633800000
                 + ComplexIDUpdatedW124634000000
                 #+ ComplexIDUpdatedW124634100000 ## Found Insignificant
                 + ComplexIDUpdatedW133643600000
                 + ComplexIDUpdatedW203743000000
                 + ComplexIDUpdatedW203744600000
                 + ComplexIDUpdatedW203744800000
                 + ComplexIDUpdatedW230642800000
                 + ComplexIDUpdatedW233642200000
                 + ComplexIDUpdatedW303742600000
                 + ComplexIDUpdatedW303743300000
                 + ComplexIDUpdatedW303744500000
                 + ComplexIDUpdatedW303744700000
               #  + ComplexIDUpdatedW303745800000 ## Found Insignificant
                  + ComplexIDUpdatedW303747900000
                # + ComplexIDUpdatedW303748000000 ## Found Insignificant
                 + ComplexIDUpdatedW303748300000
                 + ComplexIDUpdatedW303748600000
                 + ComplexIDUpdatedW319642000000
                 + ComplexIDUpdatedW319642100000
                 + ComplexIDUpdatedW319642900000
                 + ComplexIDUpdatedW319644000000
                 + ComplexIDUpdatedW324634200000
                 + ComplexIDUpdatedW329643000000
                 + ComplexIDUpdatedW333642000000
                 + ComplexIDUpdatedW333642100000
                 + ComplexIDUpdatedW333643400000
                 + ComplexIDUpdatedW403742100000
                 + ComplexIDUpdatedW403744000000
                 + ComplexIDUpdatedW403744300000
                 + ComplexIDUpdatedW403744400000
                 + ComplexIDUpdatedW403744900000
                 + ComplexIDUpdatedW403746200000
                 + ComplexIDUpdatedW403748100000
                 + ComplexIDUpdatedW403748200000
                 + ComplexIDUpdatedW419642200000
                 + ComplexIDUpdatedW419642700000
                # + ComplexIDUpdatedW419643100000 ## Found Insignificant
                # + ComplexIDUpdatedW424632200000 ## Found Insignificant
                 + ComplexIDUpdatedW428642000000
                 + ComplexIDUpdatedW428642100000
                 + ComplexIDUpdatedW428642300000
                 + ComplexIDUpdatedW428642600000
               #  + ComplexIDUpdatedW434641300000 ## Found Insignificant
                 + ComplexIDUpdatedW434642100000
               #  + ComplexIDUpdatedW434642300000 ## Found Insignificant
                 + ComplexIDUpdatedW434642500000
                , data = hold1)

summary(GlobalMul)



lmOut(GlobalMul, file="CondoresultsNovemberNineteenUpdated.csv",ndigit = 6)

head(hold1$AgeBuilt)

library(penalized)






##### Checking Time #####



GlobalMul <- lm(log(Amount) ~ 
                  ## Area ##
                  log(BaseArea  )
                + log(SecondaryFloorAreaUpper  +1 )
                + log(SecondaryFloorAreaLower  +1 )
                +  PorchArea 
                + log(GarageArea +1 )
                + LaniaArea 
                + log(CBalconyArea + 1  )
                ##  + log10(PoolCage1Area  + 1 )
                #  + log10(PoolCage2Area + 1)      ## Found Insignificant
                ##  + log10(PoolCageCustomArea + 1)                
                ## AGE ## 
                 + log(AgeBuilt)                  ## Non Sense
                #  + log10(EffAge +1 )             ## Actual Age Used
                ## View ## 
                + InferiorUnobstructedView
                #    + InferiorObstructedView    # None
                #    + NeutralUnobstructedView   #Reference Group
                + NeutralObstructedView
                + SuperiorUnobstructedView
                + SuperiorObstructedView 
                ## IMprovment type ##
             #   + UnitMidRise  
            #    + UnitHighRise 
            #    + UnitTownHouse 
                #  + UnitLuxuryHighRise
                + UnitHotel
                ## Parking ##
                +LinearizedPaking   
                ## Quality ##
                #  + LinearizedQuality ## Found Insignificant with addition of complexes
                ##Floor   ##
                +FloorLinearization
                ## Pent House ##
                + PentHouse
                ## Time To Sale ##
                +log(TimeToSale)
                + I(log(TimeToSale) * log(TimeToSale))
                + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
              #  + I(log(TimeToSale) * log(TimeToSale) * log(TimeToSale) * log(TimeToSale))
                ## BalconyType ##
                +LinearizedBalcony    
                
                ## Features ##
                
                ## + UnitsCCPTC       
                
                ##  + UnitsCFPLC
                + UnitBoatDock     
                + CCABAN
                + unitsGarage 
                + Elev 
                +  Moor     
                #   + FPLC
                + Group2
                + Group3
                + Group4

                , data = hold1 )

summary(GlobalMul)





plot(log(Amount) ~ log(AgeBuilt), data = hold1)
abline(lm(log(Amount) ~ log(AgeBuilt), data = hold1))
summary(lm(log(Amount) ~ log(AgeBuilt), data = hold1))
