USE Universitate;
GO


-- 5. Să se afișeze numărul de orașe din provincie.
SELECT COUNT(*) AS 'Orase provincie' FROM Orase  WHERE Denumire <> 'București' ;

-- 6. Să se afișeze numărul de materii la care s-au susținut examene.

SELECT COUNT(DISTINCT MaterieDenumire) AS 'Materii Distincte' FROM Note ;


-- 7. Să se afișeze studenții în ordine alfabetică.

SELECT * FROM Student ORDER BY Nume ASC;

-- 8. Să se afișeze studenții cu 2 prenume (prenumele conține caracterul blanc sau - ( liniuță) ).

SELECT Prenume FROM Student WHERE Prenume LIKE '%-%' OR Prenume LIKE '% %';

-- 9. Să se afișeze studenții din provincie.

SELECT Nume,Prenume FROM Student where OrasDenumire IN
		(SELECT Denumire FROM Orase  WHERE Denumire <> 'București');

-- 10. Să se afișeze orașele care nu au nici un student încris.

SELECT Denumire FROM Orase WHERE Denumire NOT IN (SELECT DISTINCT OrasDenumire FROM Student);

-- 11. Să se afișeze grupele care au cel puțin 5 studenți.

SELECT GrupaDenumire  FROM Student GROUP BY GrupaDenumire HAVING COUNT(*) >= 5;

-- 12. Să se afișeze numele grupei care are cei mai mulți studenți.

SELECT TOP 1 GrupaDenumire  FROM Student GROUP BY GrupaDenumire ORDER BY Count(*) DESC

-- 13. Să se afișeze materiile la care nu s-a dat niciodată examen.

SELECT Nume FROM Materie WHERE Nume NOT IN 
				(SELECT DISTINCT MaterieDenumire FROM Note )

-- 14. Să se afișeze studenții care au urmat și cursuri opționale ( au notă la mai mult de 3 materii ).

SELECT Nume,Prenume FROM Student s CROSS APPLY ultimeleNote(s.Id) n WHERE (n.StudentId = s.Id) GROUP BY s.Nume,s.Prenume HAVING COUNT(*)>3;

-- 15. Să se calculeze media generală a fiecărui student ( vezi ** ).

SELECT s.Nume,s.Prenume,AVG(CAST(n.NotaObtinuta as FLOAT)) FROM Student s CROSS APPLY
							ultimeleNote(s.Id) n WHERE (n.StudentId = s.Id) GROUP BY s.Nume,s.Prenume ;

-- 16. Să se afișeze grupa care are media generală cea mai mare.

SELECT TOP 1 s.GrupaDenumire,AVG(CAST(n.NotaObtinuta as FLOAT)) as Medie FROM Student s CROSS APPLY
							ultimeleNote(s.Id) n WHERE (n.StudentId = s.Id) GROUP BY s.GrupaDenumire ORDER BY Medie DESC;

-- 17. Să se afișeze studenții bursieri ( care au media generală cel puțin 8,50 ).

SELECT s.Nume,s.Prenume FROM Student s CROSS APPLY ultimeleNote(s.Id) n WHERE (n.StudentId = s.Id)
			GROUP BY s.Nume,s.Prenume HAVING AVG(CAST(n.NotaObtinuta AS float))>=8.50;

-- 18. Să se afișeze studenții care nu au promovat materia "Chimie" de la prima examinare, dar au promovat ulterior.

WITH promovatiChimie as (SELECT DISTINCT n1.StudentId FROM Note n1 WHERE n1.MaterieDenumire = 'Chimie' AND n1.NotaObtinuta < 5 
							AND NOT EXISTS (
										SELECT * FROM Note n2 WHERE n2.MaterieDenumire = 'Chimie' 
									    AND n2.StudentId = n1.StudentId AND n2.Id < n1.Id AND n2.NotaObtinuta > 5 ))
SELECT s.Nume,s.Prenume FROM Student s JOIN promovatiChimie p ON (s.Id=p.StudentId);


-- 19. Să se afișeze studentul care a susținut cele mai multe examinări la aceeași materie.

SELECT TOP 1 s.Nume, s.Prenume  FROM Student s JOIN Note n ON s.Id = n.StudentId
		GROUP BY  s.Nume, s.Prenume, n.MaterieDenumire ORDER BY COUNT(*) DESC;

-- 20. Să se afișeze studenții și numărul de examinări la fiecare materie în parte.

SELECT s.Nume, s.Prenume,n.MaterieDenumire ,COUNT(*) as 'Numar Examinari'  FROM Student s JOIN Note n ON s.Id = n.StudentId
		GROUP BY s.Nume, s.Prenume, n.MaterieDenumire;

-- 21. Să se afișeze studenții repetenți (au picat cel puțin o materie ).

SELECT DISTINCT s.Nume,s.Prenume FROM Student s CROSS APPLY ultimeleNote(s.Id) n WHERE n.NotaObtinuta < 5 AND n.StudentId = s.Id ;

-- 22. Să se mute toți repetenții într-o grupă nouă, grupa E. ( vezi pct. anterior)

INSERT INTO Grupa(Denumire)
VALUES ('E');

UPDATE Student
SET GrupaDenumire = 'E'
WHERE Id IN (SELECT s.Id FROM Student s CROSS APPLY ultimeleNote(s.Id) n WHERE n.NotaObtinuta < 5 AND n.StudentId = s.Id );

-- 23. Cel mai slab student este exmatriculat. Să se șteargă studentul din baza de date.


DELETE FROM Student 
WHERE Id = (SELECT TOP 1 s.Id FROM Student s CROSS APPLY
					ultimeleNote(s.Id) n WHERE (n.StudentId = s.Id) GROUP BY s.Id ORDER BY AVG(CAST(n.NotaObtinuta as FLOAT)));

-- 24. Să se afișeze toți studenții care fac parte din aceeași familie ( au același nume de familie ), după modelul:

SELECT Nume 'Familia' , STRING_AGG(Prenume, ', ') 'Frații' FROM Student GROUP BY Nume HAVING COUNT(*) > 1;
