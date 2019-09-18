# Random SQL data

just me doing a refresher on SQL. To lazy to create data by hand so I created some powershell functions using NameIT to do that.

## Data gen
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


```sql
CREATE TABLE class(
    name VARCHAR(30) NOT NULL,
    class_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DESCRIBE class;
+----------+------------------+------+-----+---------+----------------+
| Field    | Type             | Null | Key | Default | Extra          |
+----------+------------------+------+-----+---------+----------------+
| name     | varchar(30)      | NO   |     | NULL    |                |
| class_id | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
+----------+------------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)

```


```powershell
Function RandomClassData {
    param (
        $Count = 5
    ) 
    $counter = 0
    While ($counter -ne $count) {
        $class = ig "[noun]"
        $counter++
        write-output ("INSERT INTO class VALUE ('$class', NULL);")
    }
}
```

```powershell
RandomClassData -c 10

INSERT INTO class VALUE ('Foot', NULL);
INSERT INTO class VALUE ('Cross', NULL);
INSERT INTO class VALUE ('Many', NULL);
INSERT INTO class VALUE ('Start', NULL);
INSERT INTO class VALUE ('Control', NULL);
INSERT INTO class VALUE ('Exercise', NULL);
INSERT INTO class VALUE ('Page', NULL);
INSERT INTO class VALUE ('Structure', NULL);
INSERT INTO class VALUE ('Dance', NULL);
INSERT INTO class VALUE ('Feature', NULL);
```

```sql
+-----------+----------+
| name      | class_id |
+-----------+----------+
| Control   |        1 |
| Foot      |        2 |
| Cross     |        3 |
| Many      |        4 |
| Start     |        5 |
| Exercise  |        6 |
| Page      |        7 |
| Structure |        8 |
| Dance     |        9 |
| Feature   |       10 |
+-----------+----------+
10 rows in set (0.00 sec)
```

```
CREATE TABLE test(
    date DATE NOT NULL,
    type ENUM('T','Q') NOT NULL,
    class_id INT UNSIGNED NOT NULL,
    test_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
);

mysql> DESCRIBE test;
+----------+------------------+------+-----+---------+----------------+
| Field    | Type             | Null | Key | Default | Extra          |
+----------+------------------+------+-----+---------+----------------+
| date     | date             | NO   |     | NULL    |                |
| type     | enum('T','Q')    | NO   |     | NULL    |                |
| class_id | int(10) unsigned | NO   |     | NULL    |                |
| test_id  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
+----------+------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

CREATE TABLE score(
    student_id INT UNSIGNED NOT NULL,
    event_id INT UNSIGNED NOT NULL,
    score INT NOT NULL,
    PRIMARY KEY(event_id, student_id)
);

mysql> DESCRIBE score;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| student_id | int(10) unsigned | NO   | PRI | NULL    |       |
| event_id   | int(10) unsigned | NO   | PRI | NULL    |       |
| score      | int(11)          | NO   |     | NULL    |       |
+------------+------------------+------+-----+---------+-------+
3 rows in set (0.00 sec)


CREATE TABLE absence(
    student_id INT UNSIGNED NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY(student_id, date)
);

describe absence;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| student_id | int(10) unsigned | NO   | PRI | NULL    |       |
| date       | date             | NO   | PRI | NULL    |       |
+------------+------------------+------+-----+---------+-------+
2 rows in set (0.00 sec)


ALTER TABLE test
add maxscore INT NOT NULL AFTER type;

describe test;
+----------+------------------+------+-----+---------+----------------+
| Field    | Type             | Null | Key | Default | Extra          |
+----------+------------------+------+-----+---------+----------------+
| date     | date             | NO   |     | NULL    |                |
| type     | enum('T','Q')    | NO   |     | NULL    |                |
| maxscore | int(11)          | NO   |     | NULL    |                |
| class_id | int(10) unsigned | NO   |     | NULL    |                |
| test_id  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
+----------+------------------+------+-----+---------+----------------+
```

```powershell
Function RandomTestData {
    param (
        $Count = 5
    ) 
    $counter = 0
    While ($counter -ne $count) {
        $date     = ig "[randomdate 1/1/2008 12/31/2019 'yyyy-MM-dd']"
        if($(get-random -Maximum 3 -Minimum 1) -eq 1){$type='Q'}else{$type='T'}
        if($(get-random -Maximum 3 -Minimum 1) -eq 1){$maxscore='15'}else{$maxscore='30'}
        $class_id = get-random -Maximum 11 -Minimum 1
        $counter++
        write-output ("INSERT INTO test VALUE ('$date', '$type', $maxscore, $class_id, NULL);")
    }
}
```

```powershell
RandomTestData -c 10
INSERT INTO test VALUE ('2009-08-29', 'Q', 15, 10, NULL);
INSERT INTO test VALUE ('2012-01-02', 'T', 15, 1, NULL);
INSERT INTO test VALUE ('2018-08-25', 'T', 15, 5, NULL);
INSERT INTO test VALUE ('2008-12-29', 'Q', 15, 6, NULL);
INSERT INTO test VALUE ('2015-08-22', 'T', 30, 2, NULL);
INSERT INTO test VALUE ('2010-04-16', 'T', 30, 7, NULL);
INSERT INTO test VALUE ('2012-08-18', 'Q', 15, 6, NULL);
INSERT INTO test VALUE ('2019-04-12', 'T', 30, 10, NULL);
INSERT INTO test VALUE ('2009-08-15', 'Q', 15, 2, NULL);
INSERT INTO test VALUE ('2018-03-25', 'T', 15, 9, NULL);
```


```
select * from test;
+------------+------+----------+----------+---------+
| date       | type | maxscore | class_id | test_id |
+------------+------+----------+----------+---------+
| 2009-08-29 | Q    |       15 |       10 |       1 |
| 2012-01-02 | T    |       15 |        1 |       2 |
| 2018-08-25 | T    |       15 |        5 |       3 |
| 2008-12-29 | Q    |       15 |        6 |       4 |
| 2015-08-22 | T    |       30 |        2 |       5 |
| 2010-04-16 | T    |       30 |        7 |       6 |
| 2012-08-18 | Q    |       15 |        6 |       7 |
| 2019-04-12 | T    |       30 |       10 |       8 |
| 2009-08-15 | Q    |       15 |        2 |       9 |
| 2018-03-25 | T    |       15 |        9 |      10 |
+------------+------+----------+----------+---------+
10 rows in set (0.00 sec)

```


```
ALTER TABLE score CHANGE event_id test_id INT UNSIGNED NOT NULL;

DESCRIBE score;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| student_id | int(10) unsigned | NO   | PRI | NULL    |       |
| test_id    | int(10) unsigned | NO   | PRI | NULL    |       |
| score      | int(11)          | NO   |     | NULL    |       |
+------------+------------------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```


```powershell
Function RandomScoreData {
    param (
        $Students = 25,
        $tests    = 10 
    ) 
    foreach($student_id in $(1..$Students)) {
        foreach ($test_id in $(1..$tests)) {
            $score = Get-Random -Minimum 1 -Maximum 16
            write-output ("INSERT INTO score VALUE ('$student_id', '$test_id', '$score' );")
        }
    }
}
```

```sqlINSERT INTO score VALUE ('1', '1', '3' );
INSERT INTO score VALUE ('1', '2', '2' );
INSERT INTO score VALUE ('1', '3', '4' );
INSERT INTO score VALUE ('1', '4', '8' );
INSERT INTO score VALUE ('1', '5', '10' );
INSERT INTO score VALUE ('1', '6', '9' );
INSERT INTO score VALUE ('1', '7', '10' );
INSERT INTO score VALUE ('1', '8', '15' );
INSERT INTO score VALUE ('1', '9', '9' );
INSERT INTO score VALUE ('1', '10', '13' );
INSERT INTO score VALUE ('2', '1', '1' );
INSERT INTO score VALUE ('2', '2', '6' );
INSERT INTO score VALUE ('2', '3', '3' );
INSERT INTO score VALUE ('2', '4', '2' );
INSERT INTO score VALUE ('2', '5', '10' );
INSERT INTO score VALUE ('2', '6', '10' );
INSERT INTO score VALUE ('2', '7', '6' );
INSERT INTO score VALUE ('2', '8', '14' );
INSERT INTO score VALUE ('2', '9', '10' );
INSERT INTO score VALUE ('2', '10', '14' );
INSERT INTO score VALUE ('3', '1', '6' );
INSERT INTO score VALUE ('3', '2', '9' );
INSERT INTO score VALUE ('3', '3', '1' );
INSERT INTO score VALUE ('3', '4', '3' );
INSERT INTO score VALUE ('3', '5', '11' );
INSERT INTO score VALUE ('3', '6', '7' );
INSERT INTO score VALUE ('3', '7', '8' );
INSERT INTO score VALUE ('3', '8', '5' );
INSERT INTO score VALUE ('3', '9', '14' );
INSERT INTO score VALUE ('3', '10', '7' );
INSERT INTO score VALUE ('4', '1', '2' );
INSERT INTO score VALUE ('4', '2', '4' );
INSERT INTO score VALUE ('4', '3', '2' );
INSERT INTO score VALUE ('4', '4', '5' );
INSERT INTO score VALUE ('4', '5', '10' );
INSERT INTO score VALUE ('4', '6', '8' );
INSERT INTO score VALUE ('4', '7', '15' );
INSERT INTO score VALUE ('4', '8', '12' );
INSERT INTO score VALUE ('4', '9', '12' );
INSERT INTO score VALUE ('4', '10', '6' );
INSERT INTO score VALUE ('5', '1', '13' );
INSERT INTO score VALUE ('5', '2', '1' );
INSERT INTO score VALUE ('5', '3', '3' );
INSERT INTO score VALUE ('5', '4', '10' );
INSERT INTO score VALUE ('5', '5', '12' );
INSERT INTO score VALUE ('5', '6', '10' );
INSERT INTO score VALUE ('5', '7', '7' );
INSERT INTO score VALUE ('5', '8', '1' );
INSERT INTO score VALUE ('5', '9', '3' );
INSERT INTO score VALUE ('5', '10', '12' );
INSERT INTO score VALUE ('6', '1', '8' );
INSERT INTO score VALUE ('6', '2', '13' );
INSERT INTO score VALUE ('6', '3', '9' );
INSERT INTO score VALUE ('6', '4', '11' );
INSERT INTO score VALUE ('6', '5', '10' );
INSERT INTO score VALUE ('6', '6', '9' );
INSERT INTO score VALUE ('6', '7', '6' );
INSERT INTO score VALUE ('6', '8', '5' );
INSERT INTO score VALUE ('6', '9', '11' );
INSERT INTO score VALUE ('6', '10', '14' );
INSERT INTO score VALUE ('7', '1', '9' );
INSERT INTO score VALUE ('7', '2', '5' );
INSERT INTO score VALUE ('7', '3', '6' );
INSERT INTO score VALUE ('7', '4', '14' );
INSERT INTO score VALUE ('7', '5', '5' );
INSERT INTO score VALUE ('7', '6', '8' );
INSERT INTO score VALUE ('7', '7', '9' );
INSERT INTO score VALUE ('7', '8', '2' );
INSERT INTO score VALUE ('7', '9', '12' );
INSERT INTO score VALUE ('7', '10', '2' );
INSERT INTO score VALUE ('8', '1', '8' );
INSERT INTO score VALUE ('8', '2', '1' );
INSERT INTO score VALUE ('8', '3', '5' );
INSERT INTO score VALUE ('8', '4', '15' );
INSERT INTO score VALUE ('8', '5', '8' );
INSERT INTO score VALUE ('8', '6', '4' );
INSERT INTO score VALUE ('8', '7', '12' );
INSERT INTO score VALUE ('8', '8', '6' );
INSERT INTO score VALUE ('8', '9', '4' );
INSERT INTO score VALUE ('8', '10', '7' );
INSERT INTO score VALUE ('9', '1', '11' );
INSERT INTO score VALUE ('9', '2', '8' );
INSERT INTO score VALUE ('9', '3', '7' );
INSERT INTO score VALUE ('9', '4', '3' );
INSERT INTO score VALUE ('9', '5', '7' );
INSERT INTO score VALUE ('9', '6', '8' );
INSERT INTO score VALUE ('9', '7', '12' );
INSERT INTO score VALUE ('9', '8', '1' );
INSERT INTO score VALUE ('9', '9', '7' );
INSERT INTO score VALUE ('9', '10', '15' );
INSERT INTO score VALUE ('10', '1', '8' );
INSERT INTO score VALUE ('10', '2', '6' );
INSERT INTO score VALUE ('10', '3', '15' );
INSERT INTO score VALUE ('10', '4', '2' );
INSERT INTO score VALUE ('10', '5', '11' );
INSERT INTO score VALUE ('10', '6', '8' );
INSERT INTO score VALUE ('10', '7', '5' );
INSERT INTO score VALUE ('10', '8', '10' );
INSERT INTO score VALUE ('10', '9', '11' );
INSERT INTO score VALUE ('10', '10', '7' );
INSERT INTO score VALUE ('11', '1', '6' );
INSERT INTO score VALUE ('11', '2', '4' );
INSERT INTO score VALUE ('11', '3', '2' );
INSERT INTO score VALUE ('11', '4', '5' );
INSERT INTO score VALUE ('11', '5', '7' );
INSERT INTO score VALUE ('11', '6', '15' );
INSERT INTO score VALUE ('11', '7', '7' );
INSERT INTO score VALUE ('11', '8', '9' );
INSERT INTO score VALUE ('11', '9', '12' );
INSERT INTO score VALUE ('11', '10', '8' );
INSERT INTO score VALUE ('12', '1', '1' );
INSERT INTO score VALUE ('12', '2', '9' );
INSERT INTO score VALUE ('12', '3', '3' );
INSERT INTO score VALUE ('12', '4', '5' );
INSERT INTO score VALUE ('12', '5', '9' );
INSERT INTO score VALUE ('12', '6', '11' );
INSERT INTO score VALUE ('12', '7', '13' );
INSERT INTO score VALUE ('12', '8', '15' );
INSERT INTO score VALUE ('12', '9', '4' );
INSERT INTO score VALUE ('12', '10', '4' );
INSERT INTO score VALUE ('13', '1', '8' );
INSERT INTO score VALUE ('13', '2', '4' );
INSERT INTO score VALUE ('13', '3', '8' );
INSERT INTO score VALUE ('13', '4', '8' );
INSERT INTO score VALUE ('13', '5', '15' );
INSERT INTO score VALUE ('13', '6', '13' );
INSERT INTO score VALUE ('13', '7', '15' );
INSERT INTO score VALUE ('13', '8', '12' );
INSERT INTO score VALUE ('13', '9', '7' );
INSERT INTO score VALUE ('13', '10', '14' );
INSERT INTO score VALUE ('14', '1', '10' );
INSERT INTO score VALUE ('14', '2', '6' );
INSERT INTO score VALUE ('14', '3', '13' );
INSERT INTO score VALUE ('14', '4', '14' );
INSERT INTO score VALUE ('14', '5', '5' );
INSERT INTO score VALUE ('14', '6', '5' );
INSERT INTO score VALUE ('14', '7', '8' );
INSERT INTO score VALUE ('14', '8', '2' );
INSERT INTO score VALUE ('14', '9', '13' );
INSERT INTO score VALUE ('14', '10', '4' );
INSERT INTO score VALUE ('15', '1', '7' );
INSERT INTO score VALUE ('15', '2', '5' );
INSERT INTO score VALUE ('15', '3', '5' );
INSERT INTO score VALUE ('15', '4', '10' );
INSERT INTO score VALUE ('15', '5', '7' );
INSERT INTO score VALUE ('15', '6', '12' );
INSERT INTO score VALUE ('15', '7', '1' );
INSERT INTO score VALUE ('15', '8', '11' );
INSERT INTO score VALUE ('15', '9', '11' );
INSERT INTO score VALUE ('15', '10', '7' );
INSERT INTO score VALUE ('16', '1', '1' );
INSERT INTO score VALUE ('16', '2', '4' );
INSERT INTO score VALUE ('16', '3', '12' );
INSERT INTO score VALUE ('16', '4', '9' );
INSERT INTO score VALUE ('16', '5', '3' );
INSERT INTO score VALUE ('16', '6', '13' );
INSERT INTO score VALUE ('16', '7', '4' );
INSERT INTO score VALUE ('16', '8', '10' );
INSERT INTO score VALUE ('16', '9', '15' );
INSERT INTO score VALUE ('16', '10', '6' );
INSERT INTO score VALUE ('17', '1', '4' );
INSERT INTO score VALUE ('17', '2', '2' );
INSERT INTO score VALUE ('17', '3', '12' );
INSERT INTO score VALUE ('17', '4', '15' );
INSERT INTO score VALUE ('17', '5', '9' );
INSERT INTO score VALUE ('17', '6', '5' );
INSERT INTO score VALUE ('17', '7', '15' );
INSERT INTO score VALUE ('17', '8', '12' );
INSERT INTO score VALUE ('17', '9', '3' );
INSERT INTO score VALUE ('17', '10', '6' );
INSERT INTO score VALUE ('18', '1', '1' );
INSERT INTO score VALUE ('18', '2', '13' );
INSERT INTO score VALUE ('18', '3', '14' );
INSERT INTO score VALUE ('18', '4', '2' );
INSERT INTO score VALUE ('18', '5', '12' );
INSERT INTO score VALUE ('18', '6', '5' );
INSERT INTO score VALUE ('18', '7', '14' );
INSERT INTO score VALUE ('18', '8', '4' );
INSERT INTO score VALUE ('18', '9', '1' );
INSERT INTO score VALUE ('18', '10', '5' );
INSERT INTO score VALUE ('19', '1', '1' );
INSERT INTO score VALUE ('19', '2', '3' );
INSERT INTO score VALUE ('19', '3', '8' );
INSERT INTO score VALUE ('19', '4', '15' );
INSERT INTO score VALUE ('19', '5', '10' );
INSERT INTO score VALUE ('19', '6', '15' );
INSERT INTO score VALUE ('19', '7', '6' );
INSERT INTO score VALUE ('19', '8', '7' );
INSERT INTO score VALUE ('19', '9', '7' );
INSERT INTO score VALUE ('19', '10', '2' );
INSERT INTO score VALUE ('20', '1', '8' );
INSERT INTO score VALUE ('20', '2', '3' );
INSERT INTO score VALUE ('20', '3', '11' );
INSERT INTO score VALUE ('20', '4', '13' );
INSERT INTO score VALUE ('20', '5', '8' );
INSERT INTO score VALUE ('20', '6', '15' );
INSERT INTO score VALUE ('20', '7', '5' );
INSERT INTO score VALUE ('20', '8', '14' );
INSERT INTO score VALUE ('20', '9', '5' );
INSERT INTO score VALUE ('20', '10', '6' );
INSERT INTO score VALUE ('21', '1', '10' );
INSERT INTO score VALUE ('21', '2', '5' );
INSERT INTO score VALUE ('21', '3', '11' );
INSERT INTO score VALUE ('21', '4', '15' );
INSERT INTO score VALUE ('21', '5', '8' );
INSERT INTO score VALUE ('21', '6', '10' );
INSERT INTO score VALUE ('21', '7', '5' );
INSERT INTO score VALUE ('21', '8', '5' );
INSERT INTO score VALUE ('21', '9', '9' );
INSERT INTO score VALUE ('21', '10', '15' );
INSERT INTO score VALUE ('22', '1', '7' );
INSERT INTO score VALUE ('22', '2', '11' );
INSERT INTO score VALUE ('22', '3', '14' );
INSERT INTO score VALUE ('22', '4', '6' );
INSERT INTO score VALUE ('22', '5', '2' );
INSERT INTO score VALUE ('22', '6', '5' );
INSERT INTO score VALUE ('22', '7', '4' );
INSERT INTO score VALUE ('22', '8', '6' );
INSERT INTO score VALUE ('22', '9', '13' );
INSERT INTO score VALUE ('22', '10', '15' );
INSERT INTO score VALUE ('23', '1', '7' );
INSERT INTO score VALUE ('23', '2', '10' );
INSERT INTO score VALUE ('23', '3', '4' );
INSERT INTO score VALUE ('23', '4', '1' );
INSERT INTO score VALUE ('23', '5', '9' );
INSERT INTO score VALUE ('23', '6', '12' );
INSERT INTO score VALUE ('23', '7', '1' );
INSERT INTO score VALUE ('23', '8', '4' );
INSERT INTO score VALUE ('23', '9', '2' );
INSERT INTO score VALUE ('23', '10', '5' );
INSERT INTO score VALUE ('24', '1', '15' );
INSERT INTO score VALUE ('24', '2', '6' );
INSERT INTO score VALUE ('24', '3', '6' );
INSERT INTO score VALUE ('24', '4', '8' );
INSERT INTO score VALUE ('24', '5', '5' );
INSERT INTO score VALUE ('24', '6', '1' );
INSERT INTO score VALUE ('24', '7', '15' );
INSERT INTO score VALUE ('24', '8', '4' );
INSERT INTO score VALUE ('24', '9', '1' );
INSERT INTO score VALUE ('24', '10', '9' );
INSERT INTO score VALUE ('25', '1', '11' );
INSERT INTO score VALUE ('25', '2', '9' );
INSERT INTO score VALUE ('25', '3', '5' );
INSERT INTO score VALUE ('25', '4', '7' );
INSERT INTO score VALUE ('25', '5', '12' );
INSERT INTO score VALUE ('25', '6', '2' );
INSERT INTO score VALUE ('25', '7', '1' );
INSERT INTO score VALUE ('25', '8', '7' );
INSERT INTO score VALUE ('25', '9', '12' );
INSERT INTO score VALUE ('25', '10', '7' );
```

```sql
select * from score;
+------------+---------+-------+
| student_id | test_id | score |
+------------+---------+-------+
|          1 |       1 |     3 |
|          2 |       1 |     1 |
|          3 |       1 |     6 |
|          4 |       1 |     2 |
|          5 |       1 |    13 |
|          6 |       1 |     8 |
|          7 |       1 |     9 |
|          8 |       1 |     8 |
|          9 |       1 |    11 |
|         10 |       1 |     8 |
|         11 |       1 |     6 |
|         12 |       1 |     1 |
|         13 |       1 |     8 |
|         14 |       1 |    10 |
|         15 |       1 |     7 |
|         16 |       1 |     1 |
|         17 |       1 |     4 |
|         18 |       1 |     1 |
|         19 |       1 |     1 |
|         20 |       1 |     8 |
|         21 |       1 |    10 |
|         22 |       1 |     7 |
|         23 |       1 |     7 |
|         24 |       1 |    15 |
|         25 |       1 |    11 |
|          1 |       2 |     2 |
|          2 |       2 |     6 |
|          3 |       2 |     9 |
|          4 |       2 |     4 |
|          5 |       2 |     1 |
|          6 |       2 |    13 |
|          7 |       2 |     5 |
|          8 |       2 |     1 |
|          9 |       2 |     8 |
|         10 |       2 |     6 |
|         11 |       2 |     4 |
|         12 |       2 |     9 |
|         13 |       2 |     4 |
|         14 |       2 |     6 |
|         15 |       2 |     5 |
|         16 |       2 |     4 |
|         17 |       2 |     2 |
|         18 |       2 |    13 |
|         19 |       2 |     3 |
|         20 |       2 |     3 |
|         21 |       2 |     5 |
|         22 |       2 |    11 |
|         23 |       2 |    10 |
|         24 |       2 |     6 |
|         25 |       2 |     9 |
|          1 |       3 |     4 |
|          2 |       3 |     3 |
|          3 |       3 |     1 |
|          4 |       3 |     2 |
|          5 |       3 |     3 |
|          6 |       3 |     9 |
|          7 |       3 |     6 |
|          8 |       3 |     5 |
|          9 |       3 |     7 |
|         10 |       3 |    15 |
|         11 |       3 |     2 |
|         12 |       3 |     3 |
|         13 |       3 |     8 |
|         14 |       3 |    13 |
|         15 |       3 |     5 |
|         16 |       3 |    12 |
|         17 |       3 |    12 |
|         18 |       3 |    14 |
|         19 |       3 |     8 |
|         20 |       3 |    11 |
|         21 |       3 |    11 |
|         22 |       3 |    14 |
|         23 |       3 |     4 |
|         24 |       3 |     6 |
|         25 |       3 |     5 |
|          1 |       4 |     8 |
|          2 |       4 |     2 |
|          3 |       4 |     3 |
|          4 |       4 |     5 |
|          5 |       4 |    10 |
|          6 |       4 |    11 |
|          7 |       4 |    14 |
|          8 |       4 |    15 |
|          9 |       4 |     3 |
|         10 |       4 |     2 |
|         11 |       4 |     5 |
|         12 |       4 |     5 |
|         13 |       4 |     8 |
|         14 |       4 |    14 |
|         15 |       4 |    10 |
|         16 |       4 |     9 |
|         17 |       4 |    15 |
|         18 |       4 |     2 |
|         19 |       4 |    15 |
|         20 |       4 |    13 |
|         21 |       4 |    15 |
|         22 |       4 |     6 |
|         23 |       4 |     1 |
|         24 |       4 |     8 |
|         25 |       4 |     7 |
|          1 |       5 |    10 |
|          2 |       5 |    10 |
|          3 |       5 |    11 |
|          4 |       5 |    10 |
|          5 |       5 |    12 |
|          6 |       5 |    10 |
|          7 |       5 |     5 |
|          8 |       5 |     8 |
|          9 |       5 |     7 |
|         10 |       5 |    11 |
|         11 |       5 |     7 |
|         12 |       5 |     9 |
|         13 |       5 |    15 |
|         14 |       5 |     5 |
|         15 |       5 |     7 |
|         16 |       5 |     3 |
|         17 |       5 |     9 |
|         18 |       5 |    12 |
|         19 |       5 |    10 |
|         20 |       5 |     8 |
|         21 |       5 |     8 |
|         22 |       5 |     2 |
|         23 |       5 |     9 |
|         24 |       5 |     5 |
|         25 |       5 |    12 |
|          1 |       6 |     9 |
|          2 |       6 |    10 |
|          3 |       6 |     7 |
|          4 |       6 |     8 |
|          5 |       6 |    10 |
|          6 |       6 |     9 |
|          7 |       6 |     8 |
|          8 |       6 |     4 |
|          9 |       6 |     8 |
|         10 |       6 |     8 |
|         11 |       6 |    15 |
|         12 |       6 |    11 |
|         13 |       6 |    13 |
|         14 |       6 |     5 |
|         15 |       6 |    12 |
|         16 |       6 |    13 |
|         17 |       6 |     5 |
|         18 |       6 |     5 |
|         19 |       6 |    15 |
|         20 |       6 |    15 |
|         21 |       6 |    10 |
|         22 |       6 |     5 |
|         23 |       6 |    12 |
|         24 |       6 |     1 |
|         25 |       6 |     2 |
|          1 |       7 |    10 |
|          2 |       7 |     6 |
|          3 |       7 |     8 |
|          4 |       7 |    15 |
|          5 |       7 |     7 |
|          6 |       7 |     6 |
|          7 |       7 |     9 |
|          8 |       7 |    12 |
|          9 |       7 |    12 |
|         10 |       7 |     5 |
|         11 |       7 |     7 |
|         12 |       7 |    13 |
|         13 |       7 |    15 |
|         14 |       7 |     8 |
|         15 |       7 |     1 |
|         16 |       7 |     4 |
|         17 |       7 |    15 |
|         18 |       7 |    14 |
|         19 |       7 |     6 |
|         20 |       7 |     5 |
|         21 |       7 |     5 |
|         22 |       7 |     4 |
|         23 |       7 |     1 |
|         24 |       7 |    15 |
|         25 |       7 |     1 |
|          1 |       8 |    15 |
|          2 |       8 |    14 |
|          3 |       8 |     5 |
|          4 |       8 |    12 |
|          5 |       8 |     1 |
|          6 |       8 |     5 |
|          7 |       8 |     2 |
|          8 |       8 |     6 |
|          9 |       8 |     1 |
|         10 |       8 |    10 |
|         11 |       8 |     9 |
|         12 |       8 |    15 |
|         13 |       8 |    12 |
|         14 |       8 |     2 |
|         15 |       8 |    11 |
|         16 |       8 |    10 |
|         17 |       8 |    12 |
|         18 |       8 |     4 |
|         19 |       8 |     7 |
|         20 |       8 |    14 |
|         21 |       8 |     5 |
|         22 |       8 |     6 |
|         23 |       8 |     4 |
|         24 |       8 |     4 |
|         25 |       8 |     7 |
|          1 |       9 |     9 |
|          2 |       9 |    10 |
|          3 |       9 |    14 |
|          4 |       9 |    12 |
|          5 |       9 |     3 |
|          6 |       9 |    11 |
|          7 |       9 |    12 |
|          8 |       9 |     4 |
|          9 |       9 |     7 |
|         10 |       9 |    11 |
|         11 |       9 |    12 |
|         12 |       9 |     4 |
|         13 |       9 |     7 |
|         14 |       9 |    13 |
|         15 |       9 |    11 |
|         16 |       9 |    15 |
|         17 |       9 |     3 |
|         18 |       9 |     1 |
|         19 |       9 |     7 |
|         20 |       9 |     5 |
|         21 |       9 |     9 |
|         22 |       9 |    13 |
|         23 |       9 |     2 |
|         24 |       9 |     1 |
|         25 |       9 |    12 |
|          1 |      10 |    13 |
|          2 |      10 |    14 |
|          3 |      10 |     7 |
|          4 |      10 |     6 |
|          5 |      10 |    12 |
|          6 |      10 |    14 |
|          7 |      10 |     2 |
|          8 |      10 |     7 |
|          9 |      10 |    15 |
|         10 |      10 |     7 |
|         11 |      10 |     8 |
|         12 |      10 |     4 |
|         13 |      10 |    14 |
|         14 |      10 |     4 |
|         15 |      10 |     7 |
|         16 |      10 |     6 |
|         17 |      10 |     6 |
|         18 |      10 |     5 |
|         19 |      10 |     2 |
|         20 |      10 |     6 |
|         21 |      10 |    15 |
|         22 |      10 |    15 |
|         23 |      10 |     5 |
|         24 |      10 |     9 |
|         25 |      10 |     7 |
+------------+---------+-------+
250 rows in set (0.00 sec)
```

```
describe absence;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| student_id | int(10) unsigned | NO   | PRI | NULL    |       |
| date       | date             | NO   | PRI | NULL    |       |
+------------+------------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

```powershell
Function RandomAbsenceData {
    param (
        $NumberOfAbsence = 4,
        $Students = 25
    ) 
    foreach($Absence in $(1..$NumberOfAbsence)) {
        $Student = Get-Random -Minimum 1 -Maximum $Students
        $date    = ig "[randomdate 1/1/2008 12/31/2019 'yyyy-MM-dd']"
        write-output "INSERT INTO absence VALUES ($student, '$date');"
    }
}
```

```powershell
RandomAbsenceData
INSERT INTO absence VALUES (3, '2013-09-01');
INSERT INTO absence VALUES (5, '2010-04-12');
INSERT INTO absence VALUES (14, '2016-12-04');
INSERT INTO absence VALUES (13, '2019-04-08');
```
