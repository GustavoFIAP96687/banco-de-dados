

create table cliente
(cod_clie number(4) constraint cli_cd_pk primary key,
nome_clie varchar(20) constraint cli_nome_nn not null,
endereco varchar(30) constraint cli_end_nn not null,
cidade varchar (15) constraint cli_cid_nn not null,
cep char(8) constraint cli_cep_nn not null,
uf char(2) constraint cli_uf_nn not null,
cnpj char(16) constraint cli_cnpj_nn not null,
ie char(12) constraint cli_ie_nn not null);

create table vendedor
(cod_ven number(4) constraint ven_cd_pk primary key,
nome_ven varchar(20) constraint ven_nome_nn not null,
salario_fixo number(10,2) constraint ven_sal_nn not null,
comissao char(1) constraint ven_com_nn not null)

create table produto
(cod_prod number(4) constraint prod_cd_pk primary key,
unidade char(3) constraint prod_uni_nn not null,
descricao char(20) constraint prod_desc_nn not null,
val_unit number(8,2) constraint prod_val_nn not null)


create table pedido
(num_pedido number(4) constraint ped_num_pk primary key,
pr_entrega number(3) constraint ped_entr_nn not null,
cod_clie constraint ped_cdCli_fk references cliente,
cod_ven constraint ped_cdVen_fk references vendedor)
--drop table pedido cascade constraints

create table item_pedido
(num_pedido constraint ite_num_fk references pedido,
cod_prod constraint ite_codP_fk references produto,
quant number (8,2)constraint ite_quant_nn not null)
