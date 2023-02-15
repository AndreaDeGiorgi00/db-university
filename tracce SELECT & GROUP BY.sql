-- ---------------------------------------  QUERY CON SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT `name`, `date_of_birth` FROM `students` WHERE `date_of_birth` LIKE '1990%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT `name`, `cfu` FROM `courses` WHERE `cfu` > '10';
-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT `name` , `date_of_birth` FROM `students` WHERE YEAR(`date_of_birth`) < '1993';

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT `period` , `year` , `name` FROM `courses` WHERE `period` = 'I semestre' AND `year` = 1;
-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT `hour` , `location` , `date` FROM `exams` WHERE `hour` > '14:00:00' AND `date` = '2020/06/20';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT `level`, `name` FROM `degrees` WHERE `level` = 'magistrale';
-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(`name`) FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT `name` , `phone` FROM `teachers` WHERE `phone` IS NULL;

-- ------------------------------------------ QUERY CON GROUP BY


-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS 'totale studenti' , YEAR(`enrolment_date`) FROM `students` GROUP BY (YEAR(`enrolment_date`));

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS 'numero insegnanti' , `office_address` FROM `teachers` GROUP BY(`office_address`);

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT ROUND(AVG(`vote`)) , `exam_id` FROM `exam_student`GROUP BY (`exam_id`);

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*) AS 'totale corsi', `department_id` FROM `degrees` GROUP BY (`department_id`);

-----------------------------------------------     QUERY JOIN

-- 1 Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name` , `degrees`.`name` FROM `students` JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id` WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

--2 . Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `courses`.`name` , `degrees`.`name` , `departments`.`name` FROM `departments` JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id` JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id` WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';
--3 Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`name`,`teachers`.`surname`, `courses`.`name` FROM `teachers` JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id` JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id` WHERE `teachers`.`id` = 44;
---4 Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

--5 Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `teachers`.`name` , `departments`.`name` , `courses`.`name` FROM `teachers` JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id` JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id` JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`;
--- 6 Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica
SELECT `teachers`.`name` , `teachers`.`surname`, `departments`.`name` FROM `teachers` JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id` JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id` JOIN `departments` ON `departments`.`id` = `degrees`.`department_id` WHERE `departments`.`name` = 'Dipartimento di Matematica';