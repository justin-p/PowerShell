```sql
CREATE TABLE student( first_name VARCHAR(30) NOT NULL, last_name VARCHAR(30) NOT NULL, email VARCHAR(60) NULL, street VARCHAR(50) NOT NULL, city VARCHAR(50) NOT NULL, state CHAR(2) NOT NULL DEFAULT "PA", zip MEDIUMINT UNSIGNED NOT NULL, phone VARCHAR(20) NOT NULL, birth_date DATE NOT NULL, sex ENUM('M','F') NOT NULL, date_entered TIMESTAMP, lunch_cost FLOAT NULL, student_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY);

DESCRIBE student;
+--------------+-----------------------+------+-----+---------+----------------+
| Field        | Type                  | Null | Key | Default | Extra          |
+--------------+-----------------------+------+-----+---------+----------------+
| first_name   | varchar(30)           | NO   |     | NULL    |                |
| last_name    | varchar(30)           | NO   |     | NULL    |                |
| email        | varchar(60)           | YES  |     | NULL    |                |
| street       | varchar(50)           | NO   |     | NULL    |                |
| city         | varchar(50)           | NO   |     | NULL    |                |
| state        | char(2)               | NO   |     | PA      |                |
| zip          | mediumint(8) unsigned | NO   |     | NULL    |                |
| phone        | varchar(20)           | NO   |     | NULL    |                |
| birth_date   | date                  | NO   |     | NULL    |                |
| sex          | enum('M','F')         | NO   |     | NULL    |                |
| date_entered | timestamp             | YES  |     | NULL    |                |
| lunch_cost   | float                 | YES  |     | NULL    |                |
| student_id   | int(10) unsigned      | NO   | PRI | NULL    | auto_increment |
+--------------+-----------------------+------+-----+---------+----------------+
13 rows in set (0.00 sec)
```

```powershell
Function RandomStudentData {
    param (
        $Count = 5
    )
    $Counter = 0
    While ($counter -ne $count) {
        $Random=Get-Random -Maximum 3 -Minimum 1
        if ($Random -eq 1) {
            $FirstName  = ig "[Person Male first]"
            $LastName   = ig "[Person Male last]"
            $Sex        = "M"
        } ElseIf ($random -eq 2) {
            $FirstName  = ig "[Person Female first]"
            $LastName   = ig "[Person Female last]"
            $Sex        = "F"            
        }
        $mail       = $($($Firstname.Substring(0,1)) + $($LastName) + '@' + $(ig "[synonym domain]") + "." + $(ig "??"))
        $street     = ig "[address]"
        $city       = ig "[syllable][syllable][syllable][syllable][syllable][syllable][syllable]"
        $state      = ig "[alpha][alpha]"
        $zip        = ig "[numeric][numeric][numeric][numeric][numeric]"
        $phone      = ig "[numeric][numeric][numeric][numeric][numeric][numeric][numeric][numeric][numeric]"
        $birth_date = ig "[randomdate 1/1/1990 12/31/2005 'yyyy-MM-dd']"
        $counter++
        write-output ("INSERT INTO student VALUE ('$FirstName', '$LastName', '$mail', '$street', '$city', '$state', $zip, '$phone','$birth_date', '$Sex', NOW(), 3.50, NULL);")
    }
}
```

```powershell
RandomStudentData -c 23

INSERT INTO student VALUE ('Paityn', 'Montoya', 'PMontoya@orbit.ru', '834 Kexibpof Mill', 'johaqsoxpidotuhov', 'me', 49423, '539682636','1990-06-28', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Kaylin', 'Moore', 'KMoore@set.ux', '393 Vanlixugke Keys', 'rijouwtujiqzuem', 'yn', 71350, '424132922','1993-11-02', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Tyler', 'Morales', 'TMorales@knowledgedomain.cx', '8579 Fogisi Camp', 'fuyiokpijimbuqzi', 'ry', 97673, '302304793','2004-08-27', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Kayleigh', 'Simon', 'KSimon@world.oc', '749 Quulxi Parkways', 'ohacigsollefpaweq', 'nh', 60614, '123172539','1994-08-16', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Laylah', 'Hobbs', 'LHobbs@socialclass.hq', '1437 Iced Loop', 'kirosibaoqovfum', 'kr', 08920, '679854194','1994-11-07', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Deja', 'Hayes', 'DHayes@environment.sd', '98426 Ujmoqilhav Blvd', 'oniqxukofuyjapqaw', 'tx', 60044, '447233408','2003-12-10', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Kenya', 'Park', 'KPark@area.fz', '185 Zokudvopatij Parkway', 'edogulsurjeckusuf', 'sg', 76047, '871513405','1996-07-11', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Araceli', 'Gould', 'AGould@area.fr', '3368 Fufotbox Cen', 'waheizpoxcevkavi', 'ww', 12783, '621070090','1996-10-02', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Karley', 'Roman', 'KRoman@knowledgebase.nt', '34851 Cado Div', 'rezqitogewidcuug', 'mn', 80814, '439918943','1996-12-24', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Marcos', 'Mitchell', 'MMitchell@knowledgedomain.lg', '4222 Maloqtos Vdct', 'naynoricvievabay', 'xj', 56932, '751499446','1999-10-29', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Celeste', 'Wilson', 'CWilson@class.pr', '25126 Cuelcihaaz Lks', 'sinalibdokahogab', 'ql', 15900, '666595689','2005-10-16', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Arnav', 'Savage', 'ASavage@socialclass.fi', '85211 Camos Lk', 'duvlerlamaxjirpaxig', 'nc', 80386, '331903501','1990-01-08', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Annabella', 'Nixon', 'ANixon@class.dd', '8488 Hizuv Manors', 'tulurayaqneqwaog', 'os', 40968, '530059557','1995-12-27', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Yasmine', 'Lawson', 'YLawson@sphere.tx', '249 Mahuxaxvopuy Field', 'yetnamsidnivyeufco', 'ra', 05282, '029204366','1996-03-19', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Jaron', 'Clements', 'JClements@socio-economicclass.qi', '229 Ibdihuppa Corners', 'beyoywunuhafaszoz', 'te', 64500, '826429976','2005-04-21', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Meadow', 'Johnson', 'MJohnson@field.qw', '48153 Zenep Knls', 'enohesmiukqulor', 'fd', 49337, '059778665','2005-07-12', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Killian', 'Cortez', 'KCortez@class.qi', '338 Kafogilgopin Rue', 'radvevoawtugiol', 'eb', 98044, '728227849','1995-07-02', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Paxton', 'Kerr', 'PKerr@arena.hy', '397 Ofjizrahug Courts', 'yikmavxekonqoqpanul', 'uc', 16606, '309686612','1991-03-18', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Aaden', 'Valentine', 'AValentine@orbit.mk', '3160 Upwize Plains', 'haeyowbigoqvikip', 'vb', 55361, '309153983','1997-03-05', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Greyson', 'Riley', 'GRiley@arena.sa', '30144 Uppolef Hllw', 'yuzpiigpakpeopdu', 'df', 28425, '196939960','1999-08-20', 'M', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Penelope', 'Chase', 'PChase@environment.ip', '66584 Heuloksiag Mews', 'werkupexifquqmezza', 'kb', 93629, '366168953','1998-06-19', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Aspen', 'Velez', 'AVelez@field.lu', '639 Etawrum Ht', 'otyugiqoqazkimdo', 'va', 00383, '267034936','2004-06-07', 'F', NOW(), 3.50, NULL);
INSERT INTO student VALUE ('Kole', 'Sanders', 'KSanders@knowledgebase.ne', '910 Yilervexga Key', 'tejaqbitutnerain', 'yi', 76699, '226461450','2000-08-24', 'M', NOW(), 3.50, NULL);
```

```sql
mysql> select * from student;
+------------+-----------+----------------------------------+--------------------------+---------------------+-------+-------+-------------+------------+-----+---------------------+------------+------------+
| first_name | last_name | email                            | street                   | city                | state | zip   | phone       | birth_date | sex | date_entered        | lunch_cost | student_id |
+------------+-----------+----------------------------------+--------------------------+---------------------+-------+-------+-------------+------------+-----+---------------------+------------+------------+
| Dale       | Cooper    | dcooper@oal.com                  | 123 Main St              | Yakima              | WA    | 98901 | 012345678   | 1959-02-22 | M   | 2019-09-18 12:33:03 |        3.5 |          1 |
| Siena      | Herring   | SHerring@arena.mn                | 9533 Efnoznofa Glen      | meifowbekucifxa     | tv    | 77276 | 528427952   | 1994-06-30 | F   | 2019-09-18 13:08:12 |        3.5 |          2 |
| Paityn     | Montoya   | PMontoya@orbit.ru                | 834 Kexibpof Mill        | johaqsoxpidotuhov   | me    | 49423 | 539682636   | 1990-06-28 | F   | 2019-09-18 13:09:04 |        3.5 |          3 |
| Kaylin     | Moore     | KMoore@set.ux                    | 393 Vanlixugke Keys      | rijouwtujiqzuem     | yn    | 71350 | 424132922   | 1993-11-02 | F   | 2019-09-18 13:09:04 |        3.5 |          4 |
| Tyler      | Morales   | TMorales@knowledgedomain.cx      | 8579 Fogisi Camp         | fuyiokpijimbuqzi    | ry    | 97673 | 302304793   | 2004-08-27 | M   | 2019-09-18 13:09:04 |        3.5 |          5 |
| Kayleigh   | Simon     | KSimon@world.oc                  | 749 Quulxi Parkways      | ohacigsollefpaweq   | nh    | 60614 | 123172539   | 1994-08-16 | F   | 2019-09-18 13:09:04 |        3.5 |          6 |
| Laylah     | Hobbs     | LHobbs@socialclass.hq            | 1437 Iced Loop           | kirosibaoqovfum     | kr    |  8920 | 679854194   | 1994-11-07 | F   | 2019-09-18 13:09:04 |        3.5 |          7 |
| Deja       | Hayes     | DHayes@environment.sd            | 98426 Ujmoqilhav Blvd    | oniqxukofuyjapqaw   | tx    | 60044 | 447233408   | 2003-12-10 | F   | 2019-09-18 13:09:04 |        3.5 |          8 |
| Kenya      | Park      | KPark@area.fz                    | 185 Zokudvopatij Parkway | edogulsurjeckusuf   | sg    | 76047 | 871513405   | 1996-07-11 | F   | 2019-09-18 13:09:04 |        3.5 |          9 |
| Araceli    | Gould     | AGould@area.fr                   | 3368 Fufotbox Cen        | waheizpoxcevkavi    | ww    | 12783 | 621070090   | 1996-10-02 | F   | 2019-09-18 13:09:04 |        3.5 |         10 |
| Karley     | Roman     | KRoman@knowledgebase.nt          | 34851 Cado Div           | rezqitogewidcuug    | mn    | 80814 | 439918943   | 1996-12-24 | F   | 2019-09-18 13:09:04 |        3.5 |         11 |
| Marcos     | Mitchell  | MMitchell@knowledgedomain.lg     | 4222 Maloqtos Vdct       | naynoricvievabay    | xj    | 56932 | 751499446   | 1999-10-29 | M   | 2019-09-18 13:09:04 |        3.5 |         12 |
| Celeste    | Wilson    | CWilson@class.pr                 | 25126 Cuelcihaaz Lks     | sinalibdokahogab    | ql    | 15900 | 666595689   | 2005-10-16 | F   | 2019-09-18 13:09:04 |        3.5 |         13 |
| Arnav      | Savage    | ASavage@socialclass.fi           | 85211 Camos Lk           | duvlerlamaxjirpaxig | nc    | 80386 | 331903501   | 1990-01-08 | M   | 2019-09-18 13:09:04 |        3.5 |         14 |
| Annabella  | Nixon     | ANixon@class.dd                  | 8488 Hizuv Manors        | tulurayaqneqwaog    | os    | 40968 | 530059557   | 1995-12-27 | F   | 2019-09-18 13:09:04 |        3.5 |         15 |
| Yasmine    | Lawson    | YLawson@sphere.tx                | 249 Mahuxaxvopuy Field   | yetnamsidnivyeufco  | ra    |  5282 | 029204366   | 1996-03-19 | F   | 2019-09-18 13:09:04 |        3.5 |         16 |
| Jaron      | Clements  | JClements@socio-economicclass.qi | 229 Ibdihuppa Corners    | beyoywunuhafaszoz   | te    | 64500 | 826429976   | 2005-04-21 | M   | 2019-09-18 13:09:04 |        3.5 |         17 |
| Meadow     | Johnson   | MJohnson@field.qw                | 48153 Zenep Knls         | enohesmiukqulor     | fd    | 49337 | 059778665   | 2005-07-12 | F   | 2019-09-18 13:09:04 |        3.5 |         18 |
| Killian    | Cortez    | KCortez@class.qi                 | 338 Kafogilgopin Rue     | radvevoawtugiol     | eb    | 98044 | 728227849   | 1995-07-02 | M   | 2019-09-18 13:09:04 |        3.5 |         19 |
| Paxton     | Kerr      | PKerr@arena.hy                   | 397 Ofjizrahug Courts    | yikmavxekonqoqpanul | uc    | 16606 | 309686612   | 1991-03-18 | M   | 2019-09-18 13:09:04 |        3.5 |         20 |
| Aaden      | Valentine | AValentine@orbit.mk              | 3160 Upwize Plains       | haeyowbigoqvikip    | vb    | 55361 | 309153983   | 1997-03-05 | M   | 2019-09-18 13:09:04 |        3.5 |         21 |
| Greyson    | Riley     | GRiley@arena.sa                  | 30144 Uppolef Hllw       | yuzpiigpakpeopdu    | df    | 28425 | 196939960   | 1999-08-20 | M   | 2019-09-18 13:09:04 |        3.5 |         22 |
| Penelope   | Chase     | PChase@environment.ip            | 66584 Heuloksiag Mews    | werkupexifquqmezza  | kb    | 93629 | 366168953   | 1998-06-19 | F   | 2019-09-18 13:09:04 |        3.5 |         23 |
| Aspen      | Velez     | AVelez@field.lu                  | 639 Etawrum Ht           | otyugiqoqazkimdo    | va    |   383 | 267034936   | 2004-06-07 | F   | 2019-09-18 13:09:04 |        3.5 |         24 |
| Kole       | Sanders   | KSanders@knowledgebase.ne        | 910 Yilervexga Key       | tejaqbitutnerain    | yi    | 76699 | 226461450   | 2000-08-24 | M   | 2019-09-18 13:09:05 |        3.5 |         25 |
+------------+-----------+----------------------------------+--------------------------+---------------------+-------+-------+-------------+------------+-----+---------------------+------------+------------+
25 rows in set (0.00 sec)
```


