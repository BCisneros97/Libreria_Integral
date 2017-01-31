ALTER TABLE Cliente DROP PRIMARY KEY;
DROP TABLE Cliente;
CREATE TABLE Cliente (
        id_cliente INTEGER DEFAULT AUTOINCREMENT PRIMARY KEY
        );

//**************************************************************************************************//

ALTER TABLE Persona_Juridica DROP PRIMARY KEY;
DROP TABLE Persona_Juridica;
CREATE TABLE Persona_Juridica (
        ruc             CHAR(11) PRIMARY KEY,
        id_cliente      INTEGER UNIQUE,
        razon_social    VARCHAR(50) NOT NULL,
        FOREIGN KEY id_cliente REFERENCES Cliente
        ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TRIGGER "tri_p_juridica" INSTEAD OF INSERT
ON "DBA"."Persona_Juridica"
REFERENCING NEW AS new_persona
FOR EACH ROW
BEGIN
	DECLARE @id_clie INTEGER;
    
    INSERT INTO Cliente (id_cliente) VALUES (null);
    
    SELECT TOP 1 Cliente.id_cliente
    INTO @id_clie
    FROM Cliente
    ORDER BY Cliente.id_cliente DESC;
    
    INSERT INTO Persona_Juridica
    VALUES (new_persona.ruc, @id_clie, new_persona.razon_social);
END;
    
INSERT INTO Persona_Juridica (ruc,razon_social) VALUES 
('20287695735','IKAME INDUSTRIAL SAC'),
('20518556399','IMECCORP INGENIEROS SRL'),
('20571476798','CMG MUSIC Y VIDEO SAC'),
('20103335637','PANADERIA SANTA RITA SAC'),
('20787519112','UNITED SPORTS SAC'),
('20556106909','POLIZONTES SAC'),
('10200517976','GRAÑA Y MONTERO'),
('10400001789','GRUPO WONG'),
('10072486892','GLENCORE'),
('20486760576','BELLEZA Y FASHION SAC'),
('10419415125','EDELNOR'),
('10438045894','MILPO'),
('20507058117','CONFECCIONES SAN JORGE SAC'),
('20445140016','COMERCIAL CATALINA HUANCA SRL'),
('10040642698','COSAPI'),
('20525455107','CARGA FACIOL SAC'),
('20522663272','IMAGINA TRAVEL SAC'),
('20535858501','TODO A UN SOLO PRECIO EIRL'),
('10430404976','IMPRENTA COMERCIAL'),
('20532406235','IMPORTACIONES Y EXPORTACIONES ORO VERDE SAC');

SELECT * FROM Persona_Juridica;
//**************************************************************************************************//

ALTER TABLE Persona_Natural DROP PRIMARY KEY;
DROP TABLE Persona_Natural;
CREATE TABLE Persona_Natural (
        dni_pn              CHAR(8) PRIMARY KEY,
        id_cliente      	INTEGER UNIQUE,
        primer_nombre_PN    VARCHAR(20) NOT NULL,
        segundo_nombre_PN   VARCHAR(20),
        apellido_paterno_PN VARCHAR(20) NOT NULL,
        apellido_materno_PN VARCHAR(20),
        FOREIGN KEY id_cliente REFERENCES Cliente
        ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TRIGGER "tri_p_natural" INSTEAD OF INSERT
ON "DBA"."Persona_Natural"
REFERENCING NEW AS new_persona
FOR EACH ROW
BEGIN
	DECLARE @id_clie INTEGER;
    
    INSERT INTO Cliente (id_cliente) VALUES (null);
    
    SELECT TOP 1 Cliente.id_cliente
    INTO @id_clie
    FROM Cliente
    ORDER BY Cliente.id_cliente DESC;
    
    INSERT INTO Persona_Natural
    VALUES (new_persona.dni_pn, @id_clie, new_persona.primer_nombre_PN,
            new_persona.segundo_nombre_PN,new_persona.apellido_paterno_PN,
            new_persona.apellido_materno_PN);
END;
    
INSERT INTO Persona_Natural (dni_pn,primer_nombre_PN,segundo_nombre_PN,apellido_paterno_PN,apellido_materno_PN) VALUES 
('40742372','EDITH','MIRIAM','QUIROZ','GRANADOS'),
('71504263','MARIA','LUCY','PEREZ','VENTURA'),
('32504896','MARIO',NULL,'PEREDA','ARANDA'),
('34157826','ANDREA','NEREA','VALVERDE','REYNA'),
('52148632','WILLIAM','IVAN','MINAYA','GARCIA'),
('72419653','CARLOS',NULL,'ARELLANO','IGLESIAS'),
('45871969','PEDRO','NICOLAS','MARTINEZ','VELARDE'),
('54163579','LILIANA','TERESA','LOPEZ','ALBUJAR'),
('62481972','LUCIA',NULL,'MANRIQUE','CHAVEZ'),
('35169876','PAULA','CASANDRA','FLORES','PEREZ'),
('64312875','CRISTINA','MIRIAM','QUIROZ','GRANADOS'),
('75194286','SARA',NULL,'GARCIA',NULL),
('61284973','ELENA','MICHELLE','GAMEZ','LOMAS'),
('48189768','CARLA',NULL,'CRUZ','CARRERA'),
('32382559','JAVIER',NULL,'FUENTES','NIETO'),
('46328748','RAUL','JONATHAN','CONTRERAS',NULL),
('64917328','DIEGO',NULL,'CASTILLO','VALERIO'),
('32382944','MARIELA','NANCY','MORALES','MARTINEZ'),
('75218736','MANUEL',NULL,'MENDEZ','MONTIEL'),
('32380891','VERONICA','DANIELA','VERA','QUIVERA'),
('41950896','ANA',NULL,'ACOSTA','AVILA'),
('30576685','MARIA','LAURA','DOLORES','VEGA'),
('40821826','FRANCISCO',NULL,'GONZALEZ','MARTIN'),
('41971896','MANUEL','JOAN','GIL','SERRANO'),
('44642799','CARMEN',NULL,'GARCIA','GUTIERREZ'),
('41571144','MARTA','EVA','PEREZ','DIAZ'),
('46941890','NURIA',NULL,'BLANCO','MOLINA'),
('40599153','JOSEP','FRANCISCO','TORRES','RAMOS'),
('35452535','ANTONI',NULL,'RAMOS',NULL),
('35440582','MARIA','CRISTINA','CASTRO','NAVARRO');

SELECT * FROM Persona_Natural;
//**************************************************************************************************//

ALTER TABLE Proveedor DROP PRIMARY KEY;
DROP TABLE Proveedor;
CREATE TABLE Proveedor (
        ruc_proveedor   CHAR(11) PRIMARY KEY,
        nombre_pv       VARCHAR(35) NOT NULL,
        telefono_pv     VARCHAR(9)
        );

INSERT INTO Proveedor ( ruc_proveedor,nombre_pv,telefono_pv) VALUES 
('20287695735','TAI LOY SAC','975148329'),
('20523714229','DISTRIBUIDORA NAVARRETE SAC','943128762'),
('20191881121','KURESA SAC','931487620'),
('20440246592','CONTINENTAL SAC','981473264');

SELECT * FROM Proveedor;
//**************************************************************************************************//

ALTER TABLE Categoria DROP PRIMARY KEY;
DROP TABLE Categoria;
CREATE TABLE Categoria (
        id_categoria    CHAR(4) PRIMARY KEY,
        nombre_c        VARCHAR(12) NOT NULL,
        descripcion     VARCHAR(30)
        );

INSERT INTO Categoria VALUES ('C001','CUADERNO',null);
INSERT INTO Categoria VALUES ('C002','CARTUCHERA',null);
INSERT INTO Categoria VALUES ('C003','COLORES',null);
INSERT INTO Categoria VALUES ('C004','CINTA',null);
INSERT INTO Categoria VALUES ('C005','CATALOGO',null);
INSERT INTO Categoria VALUES ('C006','CARGA',null);
INSERT INTO Categoria VALUES ('C007','CARTULINA',null);

SELECT * FROM Categoria;
//**************************************************************************************************//

ALTER TABLE Vendedor DROP PRIMARY KEY;
DROP TABLE Vendedor;
CREATE TABLE Vendedor (
        dni_v           CHAR(8) PRIMARY KEY,
        p_nombre_v      VARCHAR(20) NOT NULL,
        s_nombre_v      VARCHAR(20),
        apellido_p_v    VARCHAR(20) NOT NULL,
        apellido_m_v    VARCHAR(20) NOT NULL,
        telf_v          VARCHAR(9)
        );

INSERT INTO Vendedor (dni_v,p_nombre_v,s_nombre_v,apellido_p_v,apellido_m_v,telf_v) VALUES 
('75502148','LUANA','MARITZA','CHAVEZ','JUAREZ','931822560'),
('71365178','LUCY',NULL,'QUIÑONES','BARRETO','943187562'),
('72452791','ROXANA','MARIA','PEREZ','ESCOBEDO','978413650'),
('75364872','CLAUDIA',NULL,'RIVASPLATA','MORENO','975142863'),
('73417958','VERONICA','LUSMILA','TEJADA','FLORES',NULL),
('72914732','CARMEN','ANTONIA','CUELLAR','BILLAR',NULL),
('73821463','YORYANA',NULL,'SILVA','CABRERA','931822546'),
('73731492','JUANA','LISBETH','ULLOA','CHAVEZ','945721863'),
('75201354','MARIANA',NULL,'QUISPE','TELLO','948712063'),
('76314076','CAMILA','LADY','CAPRISTAN','NOVACHECK','943105060'),
('72301479','FABIOLA','MELANY','ANDRADE','ACOSTA','934815792'),
('73642870','PAULINA','MATILDE','RIVERA','MENDEZ','921487062'),
('74349104','SHIRLEY','ANTONIA','SANCHEZ','RAMOS','935862147'),
('72617263','ANDREA',NULL,'DUARTE','BERMUDEZ','975401826'),
('74505118','CECILIA','JULIETA','CASTILLO','MONTERO','941782653'),
('73234972','YAMILETH','MELODY','VERA ','GONZALEZ','943482336'),
('72417984','CLAUDIO','ALBERTO','MANTILLA','VACA','975498621'),
('71504963','RICARDO',NULL,'VIDAL','LUCIO','931497082'),
('74718293','LUIS','ANTONIO','PEREDA','TANTAQUILLA','947497955'),
('73548069','CARLOS','DANIEL','JUAREZ','CAMINO','948521632');

SELECT * FROM Vendedor;
//**************************************************************************************************//

ALTER TABLE Pedido DROP PRIMARY KEY;
DROP TABLE Pedido;
CREATE TABLE Pedido (
        id_pedido       INTEGER DEFAULT AUTOINCREMENT primary key,
        ruc_proveedor   char(11) NOT NULL,
        fecha           DATE NOT NULL,
        FOREIGN KEY ruc_proveedor REFERENCES Proveedor
        );

INSERT INTO Pedido (id_pedido,ruc_proveedor,fecha) VALUES 
(null,'20287695735','2017-01-25'),
(null,'20287695735','2017-01-26'),
(null,'20191881121','2017-01-25'),
(null,'20523714229','2016-12-29'),
(null,'20523714229','2017-01-25'),
(null,'20440246592','2017-01-12'),
(null,'20287695735','2017-01-27'),
(null,'20440246592','2017-01-18'),
(null,'20191881121','2017-01-02'),
(null,'20287695735','2016-12-30'),
(null,'20287695735','2017-01-02'),
(null,'20523714229','2017-01-02'),
(null,'20191881121','2017-01-22'),
(null,'20440246592','2017-11-27'),
(null,'20191881121','2017-01-18'),
(null,'20440246592','2017-01-14'),
(null,'20287695735','2017-12-30'),
(null,'20523714229','2017-01-22');

SELECT * FROM Pedido;
//**************************************************************************************************//

ALTER TABLE Producto DROP PRIMARY KEY;
DROP TABLE Producto;
CREATE TABLE Producto (
        id_producto     INTEGER DEFAULT AUTOINCREMENT primary key,
        id_categoria    CHAR(4) NOT NULL,
        nombre_prod     VARCHAR(50) NOT NULL,
        precio_unidad   DECIMAL(5,2) NOT NULL CHECK (precio_unidad>0),
        precio_docena   DECIMAL(5,2) NOT NULL CHECK (precio_docena>0),
        marca           VARCHAR(25),
        stock           INTEGER DEFAULT 0 CHECK (stock>=0),
        FOREIGN KEY id_categoria REFERENCES Categoria
        );

INSERT INTO Producto (id_producto,id_categoria,nombre_prod,precio_unidad,precio_docena,marca,stock) VALUES 
(null,'C001','CUAD. DELUXE X80 H. SHARK NACIONAL',2.50,24.00,'SHARK',30), //-------------------1
(null,'C001','CUAD. DELUXE X100 H. NAVARRETE CHIKIS - JUVENIL',3,28,'NAVARRETE',35),//-------------------2
(null,'C001','CUAD. DELUXE X100 H. JUSTUS',3,29.5,'JUSTUS',40),//-------------------3
(null,'C001','CUAD. DELUXE X100 H. LORO',3.8,39.8,'LORO',41),//-------------------4
(null,'C001','CUAD. DELUXE X100 H. NORMA',5,52,'NORMA',36),//-------------------5
(null,'C001','CUAD. DELUXE X100 H. STANDFORD',5.2,55.8,'STANDFORD',39),//-------------------6
(null,'C002','CARTUCHERA CUERINA C/DISEÑO',5,46,null,20),//-------------------7
(null,'C002','CARTUCHERA PLASTICA SIMPLE',1.5,13.8,null,20),//-------------------8
(null,'C002','CARTUCHERA UN CIERRE C/DIBUJOS',2,19.6,null,18),//-------------------9
(null,'C002','CARTUCHERA DOBLE CIERRE C/DIBUJOS',2.5,24,null,23),//-------------------10
(null,'C002','CARTUCHERA TIPO PORTA',5,36.8,null,21),//-------------------11
(null,'C003','COLORES ARTESCO X12 LARGOS',4.8,51,'ARTESCO',32),//-------------------12
(null,'C003','COLORES FABER C. X12 CORTOS',3,29,'FABER CASTELL',33),//-------------------13
(null,'C003','COLORES FABER C. X12 LARGOS',5.5,57.8,'FABER CASTELL',32),//-------------------14
(null,'C003','COLORES FABER C. X12 LARGOS JUMBO',18.5,192.5,'FABER CASTELL',35),//-------------------15
(null,'C003','COLORES PEPS X12 CORTOS MAPED',5.5,32.8,'COLORPEPS',24),//-------------------16
(null,'C004','CINTA ADH. PEGAFAN PLUS 1/2" X 36 YD',2.5,25.8,'PEGAFAN',20),//-------------------17
(null,'C004','CINTA TRANSPARENTE SHURTAPE 1/2 X 36 YDS.',1.5,10,'SHURTAPE',23),//-------------------18
(null,'C004','CINTA MASKING TAPE 3M 12MM X 20 YD. (1/2")',1.2,10.8,'3M',25),//-------------------19
(null,'C004','CINTA MASKING TAPE PEGAFAN 12MM X 20 YD. (1/2")',1.2,10.8,'PEGAFAN',23),//-------------------20
(null,'C005','CATALOGO A4 X 10 DIVIS. ERICHKRAUSE',5.5,51.5,'ERICHKRAUSE',25),//-------------------21
(null,'C005','CATALOGO CHICAGO A-4 C/TORNILLO',6.5,68.8,'CHICAGO',25),//-------------------22
(null,'C006','CARGA PILOT G-1 T/LIQUID',3,31.8,'PILOT',50),//-------------------23
(null,'C006','CARGA TIPO PARKER',1,10.8,null,55),//-------------------24
(null,'C007','CARTULINA ESCOLAR',0.4,4,NULL,18),//-------------------25
(null,'C007','CARTON DUPLEX',0.4,4,NULL,20),//-------------------26
(null,'C007','CARTULINA PLASTIFICADA',0.7,8,'CLASSIC',19),//-------------------27
(null,'C007','CARTON FOLCOTE',1.3,13.5,NULL,18),//-------------------28
(null,'C007','CARTULINA CANSON',1.5,13.5,'VIVALDI',17),//-------------------29
(null,'C007','CARTULINA NEGRA',0.8,9,NULL,16),//-------------------30
(null,'C007','CARTULINA METALIZADA',3.5,36.8,NULL,18),//-------------------31
(null,'C007','CARTULINA FOSFORESCENTE',1.5,16,NULL,15),//-------------------32
(null,'C007','CARTON CORRUGADO',1.5,12.8,NULL,14),//-------------------33
(null,'C007','CARTULINA CORRUGADA',1.3,12.8,'EVAFLEX',16);//-------------------34

SELECT * FROM Producto;
//**************************************************************************************************//

ALTER TABLE Contiene DROP PRIMARY KEY;
DROP TABLE Contiene;
CREATE TABLE Contiene (
        id_producto     INTEGER NOT NULL,
        id_pedido       INTEGER NOT NULL,
        cantidad        INTEGER NOT NULL,
        precio_docena   DECIMAL(5,2) NOT NULL CHECK (precio_docena>0),
        PRIMARY KEY (id_producto, id_pedido),
        FOREIGN KEY id_producto REFERENCES Producto,
        FOREIGN KEY id_pedido REFERENCES Pedido
        );

INSERT INTO Contiene (id_producto,id_pedido,cantidad,precio_docena) VALUES 
('3','1','180','27'),
('5','2','180','48'),
('6','3','180','51'),
('8','4','24','10'),
('9','5','24','15.5'),
('12','6','60','48.2'),
('14','7','60','54.3'),
('15','8','48','188.8'),
('18','9','36','7.5'),
('20','10','48','48.5'),
('21','11','24','48.3'),
('22','12','24','62.5'),
('23','13','24','27.8'),
('26','14','60','2.7'),
('27','15','60','5.8'),
('29','16','96','11.2'),
('31','17','84','32.4'),
('33','18','84','9.5');

SELECT * FROM Contiene;
//**************************************************************************************************//

ALTER TABLE Comprobante DROP PRIMARY KEY;
DROP TABLE Comprobante;
CREATE TABLE Comprobante (
        numero_comp     INTEGER DEFAULT AUTOINCREMENT PRIMARY KEY,
        dni_v           CHAR(8) NOT NULL,
        id_cliente      INTEGER NOT NULL,
        fecha           DATE NOT NULL,
        monto_total     NUMERIC(5,2) CHECK (monto_total>0),
        FOREIGN KEY dni_v REFERENCES Vendedor,
        FOREIGN KEY id_cliente REFERENCES Cliente
        );

INSERT INTO Comprobante (numero_comp,dni_v,id_cliente,fecha,monto_total) VALUES 
(null,'71365178','16','2016/04/15','105.6'),
(null,'75502148','3','2016/12/18','35'),
(null,'72452791','9','2016/08/16','105.4'),
(null,'73642870','2','2016/07/31','19.5'),
(null,'74505118','10','2016/05/12','45.7'),
(null,'72914732','9','2016/04/24','135.8'),
(null,'75364872','15','2016/08/19','15'),
(null,'72452791','14','2016/11/10','74'),
(null,'73642870','2','2016/09/13','24.7'),
(null,'72914732','10','2016/08/18','156.5'),
(null,'74505118','16','2016/07/15','16.8'),
(null,'75502148','11','2016/06/03','16.4'),
(null,'75364872','10','2016/09/10','20'),
(null,'72914732','16','2016/12/17','9.1'),
(null,'73642870','13','2016/01/02','22'),
(null,'73821463','2','2016/02/19','55.7'),
(null,'72452791','16','2016/08/30','14.4'),
(null,'75364872','9','2016/11/14','45'),
(null,'75364872','9','2016/11/14','24'),
(null,'75201354','6','2016/10/08','15'),
(null,'73821463','12','2016/07/26','31.8'),
(null,'73731492','15','2016/09/04','45.7'),
(null,'75502148','17','2016/03/24','52.6'),
(null,'74505118','18','2016/05/08','29.8'),
(null,'73731492','11','2017/01/15','16.9'),
(null,'71365178','10','2016/04/01','71.3'),
(null,'73821463','14','2016/08/13','12'),
(null,'75201354','8','2016/11/12','9.2'),
(null,'72452791','9','2016/05/11','13.5'),
(null,'72914732','2','2016/03/16','22'),
(null,'73731492','5','2017/01/24','40.4');
//(null,'71365178','9','2016/10/15','442.5'),
//(null,'75502148','10','2016/09/25','442.5'),
//(null,'73642870','8','2016/04/16','442.5'),
//(null,'73731492','14','2016/02/10','442.5'),
//(null,'75201354','18','2016/07/09','442.5'),
//(null,'75364872','21','2016/11/14','442.5'),
//(null,'72452791','19','2016/03/07','442.5'),
//(null,'71365178','24','2017/01/21','442.5'),
//(null,'73821463','20','2016/04/05','442.5'),
//(null,'75364872','21','2016/08/23','442.5'),
//(null,'72452791','15','2016/06/27','442.5'),
//(null,'74505118','23','2016/11/04','442.5'),
//(null,'73821463','26','2016/05/16','442.5'),
//(null,'75502148','9','2016/02/28','442.5'),
//(null,'74505118','27','2016/07/03','442.5'),
//(null,'71365178','24','2016/09/18','442.5'),
//(null,'75201354','28','2016/11/14','442.5'),
//(null,'71365178','29','2016/05/29','442.5'),
//(null,'71365178','18','2016/11/19','442.5'),
//(null,'73731492','15','2016/06/07','442.5'),
//(null,'72452791','24','2016/07/12','442.5'),
//(null,'74349104','16','2016/12/17','442.5'),
//(null,'71365178','29','2016/01/14','442.5'),
//(null,'75364872','18','2016/03/08','442.5'),
//(null,'71365178','30','2016/06/13','442.5'),
//(null,'73642870','24','2016/04/21','442.5'),
//(null,'73731492','7','2016/09/02','442.5'),
//(null,'72452791','12','2016/11/14','442.5'),
//(null,'73731492','26','2016/07/29','442.5'),
//(null,'75364872','19','2016/02/21','442.5'),
//(null,'74349104','14','2016/06/16','442.5'),
//(null,'73642870','9','2016/05/04','442.5'),
//(null,'73821463','17','2016/11/14','442.5'),
//(null,'75201354','27','2016/03/03','442.5'),
//(null,'74505118','18','2017/01/28','442.5'),
//(null,'73642870','13','2016/03/30','442.5'),
//(null,'74349104','22','2016/06/19','442.5');

SELECT * FROM Comprobante;
//**************************************************************************************************//

ALTER TABLE Tiene DROP PRIMARY KEY;
DROP TABLE Tiene;
CREATE TABLE Tiene (
        id_producto     INTEGER NOT NULL,
        numero_comp     INTEGER NOT NULL,
        precio_venta    NUMERIC(5,2) NOT NULL CHECK (precio_venta>0),
        cantidad        INTEGER NOT NULL,
        PRIMARY KEY (id_producto, numero_comp),
        FOREIGN KEY id_producto REFERENCES Producto,
        FOREIGN KEY numero_comp REFERENCES Comprobante
        );

CREATE TRIGGER "tri_calcular_monto" AFTER INSERT, DELETE, UPDATE
ORDER 1 ON "DBA"."Tiene"
/* REFERENCING OLD AS old_name NEW AS new_name */
FOR EACH STATEMENT /* WHEN( search_condition ) */
BEGIN
    DECLARE @num_comp INTEGER;
    DECLARE @monto NUMERIC(5,2);
    
    DECLARE curs CURSOR FOR
        SELECT numero_comp, sum(precio_venta*cantidad)*1.18 /*incremento del 18% por IGV*/
        FROM Tiene
        GROUP BY numero_comp;
    OPEN curs;
    FETCH curs INTO @num_comp, @monto;
    
    WHILE (@@sqlstatus) != 2
    BEGIN 
        UPDATE Comprobante
        SET Comprobante.monto_total = @monto
        WHERE Comprobante.numero_comp = @num_comp;
        
        FETCH curs INTO @num_comp, @monto
    END;
    
    CLOSE curs;
END;
        
INSERT INTO Tiene (id_producto,numero_comp,cantidad,precio_venta) VALUES 
('3','1','8','24'),
('4','1','24','79.6'),
('24','1','2','2'),
('12','2','5','24'),
('16','2','2','11'),
('15','3','3','55.5'),
('18','3','18','27'),
('21','3','3','16.5'),
('30','3','8','6.4'),
('28','4','6','7.8'),
('34','4','9','11.7'),
('19','5','12','10.8'),
('7','5','2','10.9'),
('12','5','5','24'),
('4','6','18','59.7'),
('28','6','9','11.7'),
('2','6','24','56'),
('19','6','6','5.4'),
('24','6','3','3'),
('29','7','10','15'),
('15','8','4','74'),
('16','9','3','8.2'),
('27','9','18','12'),
('08','9','3','4.5'),
('30','10','9','7.2'),
('16','10','4','22'),
('31','10','12','36.8'),
('17','10','5','12.5'),
('5','10','18','78'),
('9','11','2','4'),
('12','11','3','12.8'),
('16','12','6','16.4'),
('5','13','4','20'),
('4','14','2','7.6'),
('18','14','1','1.5'),
('11','15','4','20'),
('24','15','2','2'),
('22','16','3','17.2'),
('13','16','6','14.5'),
('23','16','8','24'),
('16','17','2','11'),
('28','17','3','3.4'),
('14','18','4','22'),
('7','18','6','23'),
('3','19','8','24'),
('1','20','2','5'),
('17','20','4','10'),
('21','21','3','25.8'),
('19','21','5','6'),
('12','22','6','25.5'),
('8','22','2','3'),
('22','22','3','17.2'),
('4','23','7','26.6'),
('5','23','6','26'),
('17','24','7','17.5'),
('25','24','2','0.8'),
('7','24','3','11.5'),
('29','25','7','10.5'),
('30','25','8','6.4'),
('33','26','9','13.5'),
('6','26','4','20.8'),
('15','26','2','37'),
('10','27','6','12'),
('11','28','3','9.2'),
('18','29','9','13.5'),
('16','30','4','22'),
('19','31','6','5.4'),
('17','31','2','5');

SELECT * FROM Tiene;