-- SORU 1 CEVABI

CREATE DATABASE MyDatabase;


CREATE TABLE birimler (
    birim_id INT PRIMARY KEY,
    birim_ad CHAR(25),
);

CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY,
    ad CHAR(25) NULL,
    soyad CHAR(25) NULL,
    maas INT NULL,
    katilmaTarihi DATETIME NULL,
	calisan_birim_id INT,
    FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);



CREATE TABLE ikramiye (
    ikramiye_calisan_id INT,
	ikramiye_ucret INT NULL,
	ikramiye_tarih DATETIME NULL,
	FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id)
);

CREATE TABLE unvan (
    unvan_calisan_id INT,
	unvan_calisan CHAR(25) NULL,
	unvan_tarih DATETIME NULL,
	FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id)
);

-- SORU 2 CEVABI


INSERT INTO birimler (birim_id, birim_ad) VALUES (1, 'Yaz�l�m');
INSERT INTO birimler (birim_id, birim_ad) VALUES (2, 'Donan�m');
INSERT INTO birimler (birim_id, birim_ad) VALUES (3, 'G�venlik');


INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (1, '�smail', '��eri', 100000, '2014-02-20', 1);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (2, 'Hami', 'Sat�lm��', 80000, '2014-06-11', 1);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (3, 'Durmu�', '�ahin', 300000, '2014-02-20', 2);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (4, 'Ka�an', 'Yazar', 500000, '2014-02-20', 3);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (5, 'Meryem', 'Soysald�', 500000, '2014-06-11', 3);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (6, 'Duygu', 'Ak�ehir', 200000, '2014-06-11', 2);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (7, 'K�bra', 'Seyhan', 75000, '2014-01-20', 1);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES (8, 'G�lcan', 'Y�ld�z', 90000, '2014-04-11', 3);


INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (1, 5000, '2016-02-20');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (2, 3000, '2016-06-11');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (3, 4000, '2016-02-20');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (1, 4500, '2016-02-20');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (2, 3500, '2016-06-11');


INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (1, 'Y�netici', '2016-02-20');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (2, 'Personel', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (8, 'Personel', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (5, 'M�d�r', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (4, 'Y�netici Yard�mc�s�', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (7, 'Personel', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (6, 'Tak�m Lideri', '2016-06-11');
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (3, 'Tak�m Lideri', '2016-06-11');

SELECT * FROM birimler
SELECT * FROM calisanlar
SELECT * FROM ikramiye
SELECT * FROM unvan


-- SORU 3 CEVABI

SELECT calisanlar.ad, calisanlar.soyad, calisanlar.maas
FROM calisanlar
INNER JOIN birimler ON calisanlar.calisan_birim_id = birimler.birim_id
WHERE birimler.birim_ad = 'Yaz�l�m' OR birimler.birim_ad = 'Donan�m';

-- SORU 4 CEVABI

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas = (SELECT MAX(maas) FROM calisanlar);

-- SORU 5 CEVABI

SELECT birimler.birim_ad AS birim_isimleri, COUNT(calisanlar.calisan_id) AS calisan_sayisi
FROM birimler
LEFT JOIN calisanlar ON birimler.birim_id = calisanlar.calisan_birim_id
GROUP BY birimler.birim_ad;

-- SORU 6 CEVABI

SELECT unvan_calisan AS unvan_isimleri, COUNT(unvan_calisan_id) AS calisan_sayisi
FROM unvan
GROUP BY unvan_calisan;

-- SORU 7 CEVABI

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas BETWEEN 50000 AND 100000;

-- SORU 8 CEVABI

SELECT c.ad, c.soyad, b.birim_ad AS birim, u.unvan_calisan AS unvan, i.ikramiye_ucret AS ikramiye_ucreti
FROM calisanlar AS c
INNER JOIN birimler AS b ON c.calisan_birim_id = b.birim_id
INNER JOIN unvan AS u ON c.calisan_id = u.unvan_calisan_id
INNER JOIN ikramiye AS i ON c.calisan_id = i.ikramiye_calisan_id;

-- SORU 9 CEVABI

SELECT calisanlar.ad, calisanlar.soyad, unvan.unvan_calisan AS unvan
FROM calisanlar
INNER JOIN unvan ON calisanlar.calisan_id = unvan.unvan_calisan_id
WHERE unvan.unvan_calisan IN ('Y�netici', 'M�d�r');

-- SORU 10 CEVABI

SELECT c.ad, c.soyad, c.maas
FROM calisanlar c
INNER JOIN (
    SELECT calisan_birim_id, MAX(maas) AS max_maas
    FROM calisanlar
    GROUP BY calisan_birim_id
) AS max_maas ON c.calisan_birim_id = max_maas.calisan_birim_id AND c.maas = max_maas.max_maas;





