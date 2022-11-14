create or replace procedure spv_valida_reset_params wrapped 
a000000
369
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
2e6 288
VgSC6zUD1nIs9qIMjyLNplWCXvcwgzIJr0gFfHRVrQ+vhPuwhGnSHIrIG4NvVi2y2vpK4e/r
Jny6wOmtuv54+KdztBG/r2UOPa8O+sb+hUlD6WHDChBrqZgDIgsL1Xc3dVG5fHDZS9E4ZftX
fQFhrr/IucQo5XWuGyj863ukxWODTUPL1JvSc2LY60yfNww6C/d57rheizpRVH493JTx5JKT
9F04LTEKNcrXOQbXYMVt9UQmj0Y56PQpHfgOOxJYVqO78ZMGmBG6+LesSBDp+lmDQLelXowL
Z+8mooNR1GdNk8jxMKI/5JbuqzzmoUUza5XO0Oh7/LuvYGu7rHjbWVa4+jxhQr0FYHgZz/0G
1E/SLWT2npvvBkqzdAvAwNosVfooI8yn5bQuuyTkMgGfJJiijMkJ08iCGaGqpcvbOpqdoxiv
gnqBNv+EVetp9xP0tFvYGqzdANYEhmyZ7/coM5Gkl4m/aVAxZTkOOTnJwGGbafNuIFP9ZKeR
hDA5kXu9C3BFEfDD0moYidZgieLB88Z5eddXrwOlLfMKFBs3ZqJ6l+rD4rpgvDwDfurupon3
o/UA3x0JpZBwlSHWv+roQwJ6FJAQWBs6/ZtkMODP55FRVkn90JHFTNeac/s53YH/

/
show errors
set serveroutput on
exec spv_print_header
host sha256sum &&p_script_validador
Prompt El validador reiniciará la instancia para realizar la validación
pause  Presionar Enter para continuar,  Ctrl -C para cancelar.
Prompt deteniendo la instancia
shutdown immediate
Prompt Iniciando instancia
startup
pause Instancia iniciada, presionar Enter para iniciar
connect sys/&&p_sys_password as sysdba
set serveroutput on
host sha256sum &&p_script_validador
exec spv_print_ok('Iniciando la validación - restauración de parámetros');
exec spv_valida_reset_params 
exec spv_print_ok('Validación concluida');
exit