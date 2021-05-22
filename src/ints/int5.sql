.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS DoctorHospital;

CREATE View DoctorHospital AS
SELECT healthProfessionalCC AS doctorCC, type as doctorType, hospitalName
FROM Doctor JOIN EmployedAt ON (Doctor.healthProfessionalCC = EmployedAt.healthProfessional) JOIN Hospital ON (Hospital.name = EmployedAt.hospitalName);

SELECT internCount, doctorCount, (CAST(internCount AS REAL)/doctorCount) as ratio, hospitalName
FROM(
    SELECT count(doctorCC) AS internCount, hospitalName
    FROM DoctorHospital
    WHERE doctorType = "intern"
    GROUP BY hospitalName
) AS InternCounter JOIN (
    SELECT count(doctorCC) AS doctorCount, hospitalName
    FROM DoctorHospital
    GROUP BY hospitalName
) AS DoctorCounter using(hospitalName);




