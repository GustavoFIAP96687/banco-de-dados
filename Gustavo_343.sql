-- introdu��o a lingugagem SQL

-- DDL - Linguagem de defini��o de dados

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
Uk - unique, campo com restri��o de dados repetidos
Ck - check, capo com lista de dados  para valida��o

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

2- criando uma tabela com regras, sem personaliza��o:
create table cargo10
(cd_cargo number(3) primary key,
nm_cargo varchar2(25) not null unique,
salario number(8,2));

select object_name from user_objects where object_type = 'TABLE';

visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO10'

3- criando uma tabela com regras, com personaliza��o:
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
N - N - n�o existe em codigo sql

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

Cria��o de tabelas: n_fiscal e produto

Aula 03 01/03/2023

Alterando ou corrigindo uma estrutura
alter table nome_tabela
opções
add column      - nova coluna
add constraint  - nova regra
modify          - modifica tipo e/ou tamanho de uma coluna
drop column     - elimina coluna
drop constraint - elimina

create table tb_teste
(codigo number(2),
nome number(10));

incluindo uma nova coluna
alter table tb_teste add dt_nasc date

incluindo uma coluna com regra
alter table tb_teste add cep char(8)not null

incluindo a pk na coluna codigo
alter table tb_teste add constraint pk_codigo primary key (codigo)

modificando apenas o tipo de dados
alter table tb_teste modify nome varchar(10

modificando apenas os tamanhos da colunas
alter table tb_teste modify nome varchar(50)

modificando tamanho e tipo ao mesmo tempo
alter table tb_teste modify nome number(10)

eliminando uma regra
alter table tb_teste drop constraint pk_codigo 
desc tb_teste
desc user_constraints

select constraint_name from user_constraints where table_name = 'TB_TESTE'

eliminando uma coluna
alter table tb_teste drop column nome

renomeando coluna
alter table tb_teste rename column codigo to cod_cliente

alter table tb_teste rename constraint sys_C003509439 to fiap
desc tb_teste

eliminadno uma tabela 
drop table nome_tabela
drop table tb_teste

select * from funcionario

create table tb_teste1
(codigo number(1) primary key)

create table tb_teste2
(codigo number(1) references tb_teste1)

insert into tb_teste1 values(1)
insert into tb_teste2 values(1)

drop table tb_teste1 cascade constraints
uso do cascade permite eliminar o relacionamento e depois dropar a tabela

Atualizando dados

update

operadores: aritmeticos: + - * / ()
            relacionais: > >= < <= != ou <>
            logicos: and or not
            
update nome_tablea set nome_coluna = novo_valor

update nome_tablea set nome_coluna = novo_valor
where condição


create table produto_tb 
(cod_prod number(4) constraint prod_cod_pk primary key, 
unidade varchar2(3),descricao varchar2(20),val_unit number(10,2))

 

insert into produto_tb values ('25','KG','Queijo','0.97');
insert into produto_tb values ('31','BAR','Chocolate','0.87');
insert into produto_tb values ('78','L','Vinho','2.00');
insert into produto_tb values ('22','M','Linho','0.11');
insert into produto_tb values ('30','SAC','Acucar','0.30');
insert into produto_tb values ('53','M','Linha','1.80');
insert into produto_tb values ('13','G','Ouro','6.18');
insert into produto_tb values ('45','M','Madeira','0.25');
insert into produto_tb values ('87','M','Cano','1.97');
insert into produto_tb values ('77','M','Papel','1.05');
commit;

select * from produto_tb

atualizar em 15% o preço dos produtos de codigo maior que 30.
atualizar o nome do produto queijo para queijo de minas
para os produtos açucar, madeira e linha zerar o seu preço

update produto_tb set cod_prod = 15
where cod_prod = 30
rollback
