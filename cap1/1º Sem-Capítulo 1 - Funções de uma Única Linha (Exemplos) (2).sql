-- DUAL é uma tabela fictícia que pode ser usada para exibir resultados de functions e cálculos.

--Slide 12
SELECT LOWER('SQL COUSE') "Maiúsculo", 
       UPPER('sql couse') "Minúsculo",
       INITCAP('SQL COUSE') "Inicial Maiúsculo",

--Slide 13   
SELECT employee_id, last_name, department_id
FROM   employees
WHERE  last_name = 'higgins';

SELECT employee_id, last_name, department_id
FROM   employees
WHERE  LOWER(last_name) = 'higgins';

--Slide 14
SELECT 
        LPAD(salary,10,'*'), --Preenche o valor do caractere à direita
        RPAD(salary, 10, '*') --Preenche o valor do caractere à equerda
FROM EMPLOYEES;

SELECT 
        CONCAT('Hello', 'World'), --Une valores (Você está limitado a usar dois parâmetros com CONCAT.)
        SUBSTR('HelloWorld',1,5), --Extrai uma string de tamanho determinado
        LENGTH('HelloWorld'), --Mostra o tamanho de uma string como um valor numérico
        INSTR('HelloWorld', 'W'), --Localiza a posição numérica de um caractere nomeado
        REPLACE('JACK and JUE','J','BL'), --Preenche o valor do caractere à direita
        TRIM('H' FROM 'HelloWorld') --Reduz os caracteres à direita ou à esquerda (ou nas duas direções) 
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
    ROUND(45.926, 2), --Arredonda o valor até o decimal especificado
    TRUNC(45.926, 2), --Trunca o valor até o decimal especificado
    MOD(1600, 300) --Retorna o resto da divisão
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
        to_char(sysdate,'fmDAY Month YEAR') -- fm remove o espaço
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
       TO_CHAR(salary, 'L99,999.00') SALARY,-- ,Imprime uma vírgula como indicador de milhar
       TO_CHAR(salary, 'L99999999') SALARY-- Usa o símbolo da moeda local flutuante
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
       (salary*12) + (salary*12*commission_pct) AN_SAL, -- Funcionários sem comissão não terão salário
       (salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees;

--Slide 47
SELECT last_name,  
       salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income ,
       -- A function NVL2 examina a primeira expressão. 
       -- Se a primeira expressão NÃO FOR NULA, a function NVL2 retornará a segunda expressão. 
       -- Se a primeira expressão for nula, a terceira expressão será retornada. 
       NVL2(commission_pct,  -- Argumento 1
            ((salary*12) + salary*12*commission_pct), -- Argumento 2
            (salary*12))  AN_SAL -- Argumento 3
FROM   employees ;

--Slide 48
SELECT first_name, LENGTH(first_name) "expr1", 
       last_name,  LENGTH(last_name)  "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result 
       -- NULLIF compara duas expressões.
       -- Se elas forem IGUAIS, a function retornará um valor nulo. 
       -- Se elas forem DIFERENTES , a function retornará a PRIMEIRA expressão. 
       -- Não é possível especificar o literal NULL para a primeira expressão.
 FROM   employees;
      
SELECT e.last_name, NULLIF(e.job_id, j.job_id) "Old Job ID"
   FROM employees e JOIN job_history j
   ON  e.employee_id = j.employee_id
   ORDER BY last_name, "Old Job ID";
   
   /* Funcionários que foram promovidos, conforme indicado por um job_id na tabela job_history diferente do job_id atual na 
      tabela employees */

SELECT EMPLOYEE_ID,JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID=101;

-- Slide 50
SELECT last_name, 
       COALESCE(manager_id,commission_pct, -1) comm -- COALESCE retorna a primeira expressão não nula da lista.
FROM   employees 
ORDER BY commission_pct; 
/* Se o valor de MANAGER_ID não for nulo, ele será exibido. 
   Se o valor de MANAGER_ID for nulo, COMMISSION_PCT será exibido. 
   Se os valores de MANAGER_ID e COMMISSION_PCT forem nulos, será exibido o valor –1. */
   
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

