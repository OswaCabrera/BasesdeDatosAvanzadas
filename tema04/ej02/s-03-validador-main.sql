--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:  Validador  ejercicio práctico 04


--Modificar las siguientes 2 variables en caso de ser necesario.
--En scripts reales no deben incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del alumno empleado como prefijo para crear usuarios en la BD
--
define p_nombre='jorge'

--
-- Password del usuario creado en este ejercicio 
--
define p_usr_password='jorge'


--
-- Password del usuario sys
--
define p_sys_password='system2'


--- ============= Las siguientes configuraciones ya no requieren cambiarse====

whenever sqlerror exit rollback
set verify off
set feedback off


Prompt =========================================================
Prompt Iniciando validador - Ejercicio práctico 04 - 02
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contrario editar el script s-04-validador-main.sql
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================

accept p_nombre default '&&p_nombre' prompt 'Nombre del alumno o prefijo empleado para crear al usuario <nombre>0402: [&&p_nombre]: '
accept p_usr_password default '&&p_usr_password' prompt 'Proporcionar el password del usuario <nombre>0402 [Configurado en script]: ' hide
accept p_sys_password default '&&p_sys_password' prompt 'Proporcionar el password de sys [Configurado en script]: ' hide

define p_script_validador='s-03p-validador-ejercicios.plb'

Prompt Creando procedimientos para validar.
connect sys/&&p_sys_password as sysdba
set serveroutput on
@s-00-funciones-validacion.plb

Prompt invocando script para validar
@&&p_script_validador

exit