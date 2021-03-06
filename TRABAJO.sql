--Borramos las tablas
DROP TABLE FOTOVEHICULOS;
DROP TABLE DESCUENTOS;
DROP TABLE PROPIEDADESVEHICULOS;
DROP TABLE PROPIEDADES;
DROP TABLE TIPOPROPIEDADES;
DROP TABLE VEHICULOS;
DROP TABLE FINANCIACIONES;
DROP TABLE TIPOVEHICULOS;
DROP TABLE Cliente;
DROP TABLE Citas;
DROP TABLE Concesionario;





--Borramos las secuencias
drop sequence seq_fotosVehiculos;
drop sequence seq_propiedades;
drop sequence seq_tipopropiedades;
drop sequence seq_vehiculo;
drop sequence seq_financiacion;
drop sequence seq_descuento;
drop sequence seq_tipovehiculos;
drop sequence seq_cliente;
drop sequence seq_citas;
drop sequence seq_concesionario;




--Creamos las secuencias
create sequence seq_fotosVehiculos;
create sequence seq_tipovehiculos;
create sequence seq_financiacion;
create sequence seq_vehiculo;
create sequence seq_tipopropiedades;
create sequence seq_propiedades;
create sequence seq_descuento;
create sequence seq_cliente;
create sequence seq_citas;
create sequence seq_concesionario;



--Creación de tabla Financiacion
CREATE TABLE TIPOVEHICULOS(
    id_tveh number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);


--Creación de tabla Financiacion
CREATE TABLE FINANCIACIONES(
    id_fin number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);

--Creación de tabla Tipo Propiedades
CREATE TABLE TIPOPROPIEDADES(
    id_tpro number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);

--Creación de tabla Vehículo
CREATE TABLE VEHICULOS(
    id_veh number(10) primary key,
    matricula varchar2(7) not null,
    fechaAlta date not null,
    nombre varchar(80) not null,
    descripcion varchar(400) not null,
    precio number(10,2) not null,
    disponible number(1) not null,
    UNIQUE (matricula)
);

--Creación de tabla Propiedades
CREATE TABLE PROPIEDADES(
    id_pro number(10) primary key,
    id_tpro number(10),
    nombre varchar2(40) not null ,
    unique(nombre),
    foreign key (id_tpro) REFERENCES TIPOPROPIEDADES
);

--Creación de tabla relación propiedades y vehículo
CREATE TABLE PROPIEDADESVEHICULOS(
    id_tpro number(10),
    id_pro number(10),
    id_veh number(10),
    PRIMARY KEY (id_tpro,id_pro,id_veh),
    foreign key (id_veh) REFERENCES TIPOPROPIEDADES,
    foreign key (id_pro) REFERENCES PROPIEDADES,
    foreign key (id_veh) REFERENCES VEHICULOS
);

--Creación de tabla Descuento
CREATE TABLE DESCUENTOS(
    id_des number(10) primary key,
    id_fin number(10),
    nombre varchar2(40) not null ,
    unique(nombre),
    foreign key (id_fin) REFERENCES FINANCIACIONES
);

--Creación de tabla Foto Vehículo
CREATE TABLE FOTOVEHICULOS(
    id_ft number(12) primary key,
    id_veh number(10),
    posicion number(12),
    unique(id_veh,posicion),
    foreign key(id_veh) references vehiculos
);

--Creación Tabla de Cliente
Create table Cliente(
   id_cli number(10) primary key,
   email varchar2(50) not null,
   dni varchar2(9) not null,
   nombre varchar(40) not null,
   telef number(9) not null,
   movil number(9) not null,
   FechAlta date not null,
   unique(dni, email)
);

--Creación Tabla Citas
Create table Citas(
   id_cit number(10) primary key,
   Fecha date not null,
   Hora number(2) not null, check ((Hora = 10) or (Hora=12) or (Hora = 16) or (Hora = 18))
);

--Creación Tabla Concesionario
Create table Concesionario(
   id_conces number(10) primary key,
   Nombre varchar(40) not null,
   Direccion varchar2(40) not null,
   Telef number(9) not null,
   Email varchar2(50) not null,
   NoCitas number(10) not null, check (NoCitas!=0)
);




    --Creación de Trigger Financiación (secuencia)
    create or replace trigger Sec_FI_
    before insert on FINANCIACIONES
    for each row
    begin
        :new.id_fin := seq_financiacion.nextval;    
    end;
    /
    
    --Creación de Trigger Tipo Propiedades (secuencia)
    create or replace trigger Sec_TP_
    before insert on TIPOPROPIEDADES
    for each row
    begin
        :new.id_tpro := seq_tipopropiedades.nextval;    
    end;
    /
    
    --Creación de Trigger Propiedades (secuencia)
    create or replace trigger Sec_P_
    before insert on PROPIEDADES
    for each row
    begin
        :new.id_pro := seq_propiedades.nextval;
    end;
    / 
    
    --Creación de Trigger Vehículo (secuencia)
    create or replace trigger Sec_V_
    before insert on VEHICULOS
    for each row
    begin
        :new.id_veh := seq_vehiculo.nextval;   
    end;
    / 
    
    
        --Creación de Trigger Vehículo (secuencia)
    create or replace trigger Sec_FV_
    before insert on FOTOVEHICULOS
    for each row
    begin
        :new.id_ft := seq_fotosVehiculos.nextval;   
    end;
    / 
    
    
    --Creación de Trigger Descuento(secuencia)
    create or replace trigger Sec_DE_
    before insert on DESCUENTOS
    for each row
    begin
        :new.id_des := seq_descuento.nextval;    
    end;
    /
    
    --Creación de Trigger Cliente (secuencia)
    create or replace trigger Sec_Cl_
    before insert on Cliente
    for each row
    begin
    :new.id_cli := seq_cliente.nextval;
    end;
    /
    
    --Creación de Trigger Citas (secuencia)
    create or replace trigger Sec_Ci_
    before insert on Citas
    for each row
    begin
    :new.id_cit := seq_citas.nextval;
    end;
    /
    
    --Creación de Trigger Concesionario (secuencia)
    create or replace trigger Sec_Con_
    before insert on Concesionario
    for each row
    begin
    :new.id_conces := seq_concesionario.nextval;
    end;
    /

    
    

    insert into tipopropiedades(nombre) values ('Nº Puertas');
    insert into tipopropiedades(nombre) values ('Color');
    insert into tipopropiedades(nombre) values ('Combustible');
    insert into tipopropiedades(nombre) values ('Etiqueta Eficiencia');
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0178ZQJ',TO_DATE(SYSDATE),'COCHE C3 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',8500,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0179ZQJ',TO_DATE(SYSDATE),'COCHE C3 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',8000,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0171ZQJ',TO_DATE(SYSDATE),'COCHE C4 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',7400,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0172ZQJ',TO_DATE(SYSDATE),'COCHE C4 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',9400,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0173ZQJ',TO_DATE(SYSDATE),'COCHE C5 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',9800,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0174ZQJ',TO_DATE(SYSDATE),'COCHE C5 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',12000,1);
    insert into propiedades(id_tpro,nombre) values (2,'Negro');
    insert into propiedades(id_tpro,nombre) values (2,'Blanco');
    insert into propiedades(id_tpro,nombre) values (1,'3 Puertas');
    insert into propiedades(id_tpro,nombre) values (1,'4 Puertas');
    insert into propiedades(id_tpro,nombre) values (1,'5 Puertas');
    insert into propiedades(id_tpro,nombre) values (3,'Gasolina');
    insert into propiedades(id_tpro,nombre) values (3,'Diesel');
    insert into propiedades(id_tpro,nombre) values (3,'Híbrido');
    insert into propiedades(id_tpro,nombre) values (3,'Eléctrico');
    insert into propiedades(id_tpro,nombre) values (4,'0 Emisiones');
    insert into propiedades(id_tpro,nombre) values (4,'Eco');
    insert into propiedades(id_tpro,nombre) values (4,'C');
    insert into propiedades(id_tpro,nombre) values (4,'B');
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,2,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,3,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (4,12,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,1,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,3,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,9,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (4,10,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,1,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,4,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,2,4);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,4,4);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,4);
    insert into Cliente (email,dni,nombre,telef,movil,FechAlta) 
    values ('prueba@prueba.com','66606660w','Juan',666666666,999999999,TO_DATE('12/12/2012'));
    insert into Cliente (email,dni,nombre,telef,movil,FechAlta) 
    values ('prueba2@prueba2.com','66606660T','Juon',666606666,999909999,TO_DATE('12/2/2012'));
    insert into Citas (Fecha, Hora) values (TO_DATE('12/12/2020'),13);
    insert into Citas (Fecha, Hora) values (TO_DATE('12/12/2020'),13);
    insert into Concesionario (Nombre, Direccion, Telef, Email, NoCitas) 
    values ('Con','calle',756493498,'prueba@prueba.com',10);
    insert into Concesionario (Nombre, Direccion, Telef, Email, NoCitas) 
    values ('Con2','calle2',756493499,'prueba2@prueba2',11);
    
   
   
   
   
    SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=1;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=2;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=3;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=4;

