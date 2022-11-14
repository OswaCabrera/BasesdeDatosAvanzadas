--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:  Validador  ejercicio práctico 04 -03


--Modificar las siguientes 2 variables en caso de ser necesario.
--En scripts reales no deben incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del alumno empleado como prefijo para crear usuarios en la BD
--
define p_nombre='jorge'

--
-- Password del usuario creado en este ejercicio práctico.
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
Prompt Iniciando validador - Ejercicio práctico 04 - 04
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contrario editar el script s-04-validador-main.sql
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================

define p_num=0404
define p_script_validador='s-07p-validador-ejercicios.plb'

accept p_nombre default '&&p_nombre' prompt 'Prefijo empleado para crear usuarios (nombre del alumno) [&&p_nombre]: '
accept p_usr_password default '&&p_usr_password' prompt 'Password del usuario &&p_nombre&&p_num [Configurado en script]: ' hide
accept p_sys_password default '&&p_sys_password' prompt 'Proporcionar el password de sys [Configurado en script]: ' hide

define p_username=&&p_nombre&&p_num

Prompt Creando procedimientos para validar.

connect sys/&&p_sys_password as sysdba
set serveroutput on
@s-00-funciones-validacion.plb
Prompt invocando script para validar
@&&p_script_validador

exit