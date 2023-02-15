-- introdução a lingugagem SQL

-- DDL - Linguagem de definição de dados

-- Criando tabelas 
--Sintaxe:
    create table nome_tabela
    (nome_coluna1 tipo_dados(tamanho) [regra]
    ......,
    nome_colunaN tipo_dados(tamanho) [regra];
    
    
tipo de dados: char(n), campo alfanumerico de tamanho fixo
                varchar(n), campo alfanumerico de tamanho variavel
                number(x,y) campo numerico inteiro ou real
                date, campo tipo data
                
n = tamanho
x = parte inteira
y = parte real casas decimais

Regras/Constraints
Pk - primary key, campo unico, preenchimento obrigatorio, relacionamento
FK - foreign key, relacionamento lado n da cardinalidade, recebe dados
    previamente cadastrados na Pk
Nn - not null, campo de preenchimento obrigatorio
Uk - unique, campo com restrição de dados repetidos
Ck - check, capo com lista de dados  para validação

Exemplificando

1 criando uma tabela sem regras:
create table cargo10
(cd_cargo number(3),
nm_cargo varchar2(25),
salario number(8,2));

vizualizando a estrutura de uma tabela
desc cargo10

deletando uma tabela
drop table nome_tabela
exemplo: drop table cargo10

2- criando uma tabela com regras, sem personalização:
create table cargo10
(cd_cargo number(3) primary key,
nm_cargo varchar2(25) not null unique,
salario number(8,2));

select object_name from user_objects where object_type = 'TABLE';

visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO10'

3- criando uma tabela com regras, com personalização:
drop table cargo10

create table cargo10
(cd_cargo number(3) constraint cargo_cd_pk primary key,
nm_cargo varchar2(25) constraint cargo_nome_nn not null
                        constraint cargo_nome_uk unique,
salario number(8,2));

select object_name from user_objects where object_type = 'TABLE';

visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO10'

criando o relacionamento 

1 - 1 - pk + FK_Uk
1 - N - pk + FK
N - N - não existe em codigo sql

desc cargo10
create table funcionario10
(cd_fun number(3) constraint fun_cd_pk primary key,
nm_fun varchar(30) constraint fun_nm_nn not null,
dt_adm date constraint fun_dt_nn not null,
uf_fun char(2) constraint fun_uf_nn not null,
cargo_fk number(3) constraint fun_cargo_fk references cargo10)

desc funcionario10

create table funcionario11
(cd_fun number(3) constraint fun_cd_pk primary key,
nm_fun varchar(30) constraint fun_nm_nn not null,
dt_adm date constraint fun_dt_nn not null,
uf_fun char(2) constraint fun_uf_nn not null,
cargo_fk references cargo10)

15/02/2023

Criação de tabelas: n_fiscal e produto

create table n_fiscal
(n_nf number(5) primary key,
dt_nf date not null,
total_nf number(10,2));

desc n_fiscal

select constraint_name from user_constraints where table_name = 'N_FISCAL'

create table produto
(cd_pro number(5) constraint prod_cd_pk primary key,
nm_prod varchar2(30) constraint prod_mn_nn not null
constraint prod_nm_uk unique,
preco number(10,2))

select constraint_name from user_constraints where table_name = 'PRODUTO'

create table tem
(fk_nota number(5) constraint tem_nf_ references n_fiscal,
fk_prod number(5) constraints tem_prod_fk references produto)

inserindo dados
Comando DML - data manipulation Language
Novas linhas:
insert into nome_tabela values
(valor1, valor2,...., valorN)

Obs: campos: char, varchar ou varchar2 e date precisam de apostrofe

exemplo 1
conhecendo ou visuzliando  a estrutura
desc n_fiscal

inserindo uma linha
insert into n_fiscal values(1,'10-jan-00',5000);
insert into n_fiscal values(2,'10-dec-00',5000);

verificando a inserção
select * from n_fiscal

descobrindo padrão da data
select sysdate from dual

gravando dados fisicamente
commit;

(cd_pro number(5) constraint prod_cd_pk primary key,
nm_prod varchar2(30) constraint prod_mn_nn not null
constraint prod_nm_uk unique,
preco number(10,2))




create table cliente
(cod_cli number(4) constraint cli_cd_pk primary key,
prenome varchar(50) constraint cli_pn_nn not null,
sobrenome varchar(50) constraint cli_sn_nn not null,
endereco varchar(70) constraint cli_en_nn not null,
telefone varchar(20) constraint cli_tl_nn not null);


create table aluga
(fk_dtret date constraint alg_dtret references cliente,
fk_dev date constraint alg_dtdev references dvd);

create table dvd
(n_dvd number(4) constraint dvd_ndvd_pk primary key,
tipo char(1));

create table categoria
(cod_categ number(4) constraint cg_categ_pk primary key,
descricao varchar(50) constraint cg_des_nn not null)
