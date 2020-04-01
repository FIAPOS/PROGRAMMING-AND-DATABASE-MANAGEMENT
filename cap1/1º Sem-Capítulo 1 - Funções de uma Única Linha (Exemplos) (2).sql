-- DUAL � uma tabela fict�cia que pode ser usada para exibir resultados de functions e c�lculos.

--Slide 12
SELECT LOWER('SQL COUSE') "Mai�sculo", 
       UPPER('sql couse') "Min�sculo",
       INITCAP('SQL COUSE') "Inicial Mai�sculo",

--Slide 13   
SELECT employee_id, last_name, department_id
FROM   employees
WHERE  last_name = 'higgins';

SELECT employee_id, last_name, department_id
FROM   employees
WHERE  LOWER(last_name) = 'higgins';

--Slide 14
SELECT 
        LPAD(salary,10,'*'), --Preenche o valor do caractere � direita
        RPAD(salary, 10, '*') --Preenche o valor do caractere � equerda
FROM EMPLOYEES;

SELECT 
        CONCAT('Hello', 'World'), --Une valores (Voc� est� limitado a usar dois par�metros com CONCAT.)
        SUBSTR('HelloWorld',1,5), --Extrai uma string de tamanho determinado
        LENGTH('HelloWorld'), --Mostra o tamanho de uma string como um valor num�rico
        INSTR('HelloWorld', 'W'), --Localiza a posi��o num�rica de um caractere nomeado
        REPLACE('JACK and JUE','J','BL'), --Preenche o valor do caractere � direita
        TRIM('H' FROM 'HelloWorld') --Reduz os caracteres � direita ou � esquerda (ou nas duas dire��es) 
        --de uma string de caracteres 
FROM DUAL;

-- Slide 15
SELECT employee_id, CONCAT(first_name, last_name) NAME, 
       job_id, LENGTH (last_name), 
       INSTR(last_name, 'a') "Contains 'a'?"
FROM   employees
WHERE  SUBSTR(job_id, 4) = 'REP';

-- Slide 16
SELECT 
    ROUND(45.926, 2), --Arredonda o valor at� o decimal especificado
    TRUNC(45.926, 2), --Trunca o valor at� o decimal especificado
    MOD(1600, 300) --Retorna o resto da divis�o
FROM DUAL;

-- Slide 17
SELECT ROUND(45.923,2), ROUND(45.923,0), ROUND(45.923,-1)
FROM   DUAL;

-- Slide 18
SELECT TRUNC(45.923,2), TRUNC(45.923),TRUNC(45.923,-1)
FROM   DUAL;

-- Slide 19
SELECT last_name, salary, MOD(salary, 5000) -- A function MOD localiza o resto do primeiro argumento dividido pelo segundo argumento
FROM   employees
WHERE  job_id = 'SA_REP';

-- Slide 20
SELECT last_name, hire_date
FROM employees
WHERE  hire_date < '01-FEV-88';

--Slide 22
SELECT SYSDATE
FROM DUAL;

--Slide 30
Select to_char(sysdate,'dd'),
       to_char(sysdate,'dd-mm-rrrr'),
       to_char(sysdate,'dy-mm-rrrr')
from dual;

SELECT  to_char(sysdate,'DAY-Month-rrrr'),
        to_char(sysdate,'fmDAY Month YEAR') -- fm remove o espa�o
FROM DUAL;

SELECT  to_char(sysdate,'Ddth'),
        to_char(sysdate,'Ddspth')
from dual;

--Slide 32
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS AM'),
       TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS')
FROM DUAL;

--Slide 34
SELECT last_name,
       TO_CHAR(hire_date, 'fmDD Month YYYY')
       AS HIREDATE
FROM   employees;

--Slide 35/37
SELECT salary,
       TO_CHAR(salary, '$99,999.00') SALARY, -- .Imprime uma casa decimal
       TO_CHAR(salary, 'L99,999.00') SALARY,-- ,Imprime uma v�rgula como indicador de milhar
       TO_CHAR(salary, 'L99999999') SALARY-- Usa o s�mbolo da moeda local flutuante
FROM   employees
WHERE  last_name = 'Ernst';

--Slide 38

SELECT TO_DATE(
    '25 Fevereiro, 2019, 11:00',
    'dd Month, RRRR, HH24:MI')
     FROM DUAL;
     
UPDATE employees SET salary = salary + 
   TO_NUMBER('100,00', '9G999D99')
   WHERE last_name = 'Perkins';
 
 select   TO_NUMBER('100,00', '9G999D99') from dual;  --(G) separador do grupo de milhares. (D) marcador decimal.

--Slide 41
SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY')
FROM  employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-RR');

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY') -- Incorreto
FROM  employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');


--Slide 43
SELECT last_name,
  UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US'))
FROM   employees
WHERE  department_id = 60;

--Slide 46
SELECT last_name, 
       salary, 
       NVL(commission_pct, 0), -- Convete um valor nulo em um valor real, use a function NVL. 
       (salary*12) + (salary*12*commission_pct) AN_SAL, -- Funcion�rios sem comiss�o n�o ter�o sal�rio
       (salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees;

--Slide 47
SELECT last_name,  
       salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income ,
       -- A function NVL2 examina a primeira express�o. 
       -- Se a primeira express�o N�O FOR NULA, a function NVL2 retornar� a segunda express�o. 
       -- Se a primeira express�o for nula, a terceira express�o ser� retornada. 
       NVL2(commission_pct,  -- Argumento 1
            ((salary*12) + salary*12*commission_pct), -- Argumento 2
            (salary*12))  AN_SAL -- Argumento 3
FROM   employees ;

--Slide 48
SELECT first_name, LENGTH(first_name) "expr1", 
       last_name,  LENGTH(last_name)  "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result 
       -- NULLIF compara duas express�es.
       -- Se elas forem IGUAIS, a function retornar� um valor nulo. 
       -- Se elas forem DIFERENTES , a function retornar� a PRIMEIRA express�o. 
       -- N�o � poss�vel especificar o literal NULL para a primeira express�o.
 FROM   employees;
      
SELECT e.last_name, NULLIF(e.job_id, j.job_id) "Old Job ID"
   FROM employees e JOIN job_history j
   ON  e.employee_id = j.employee_id
   ORDER BY last_name, "Old Job ID";
   
   /* Funcion�rios que foram promovidos, conforme indicado por um job_id na tabela job_history diferente do job_id atual na 
      tabela employees */

SELECT EMPLOYEE_ID,JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID=101;

-- Slide 50
SELECT last_name, 
       COALESCE(manager_id,commission_pct, -1) comm -- COALESCE retorna a primeira express�o n�o nula da lista.
FROM   employees 
ORDER BY commission_pct; 
/* Se o valor de MANAGER_ID n�o for nulo, ele ser� exibido. 
   Se o valor de MANAGER_ID for nulo, COMMISSION_PCT ser� exibido. 
   Se os valores de MANAGER_ID e COMMISSION_PCT forem nulos, ser� exibido o valor �1. */
   
-- Slide 53
SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                   WHEN 'ST_CLERK' THEN  1.15*salary
                   WHEN 'SA_REP'   THEN  1.20*salary
       ELSE      salary END     "REVISED_SALARY"
FROM   employees;


-- Slide 55
SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
              salary)
       REVISED_SALARY
FROM   employees;

-- Slide 56
SELECT last_name, salary,
       DECODE (TRUNC(salary/2000, 0),
                         0, 0.00,
                         1, 0.09,
                         2, 0.20,
                         3, 0.30,
                         4, 0.40,
                         5, 0.42,
                         6, 0.44,
                            0.45) TAX_RATE
FROM   employees
WHERE  department_id = 80;

