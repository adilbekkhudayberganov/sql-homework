Data bu-Ma’lumot.  Raqamlar,nomlar va har qanday belgi bu alohida ma'lumot.
 Database Ma’lumotlar bazasi – bu ma’lumotlarni tartibli ravishda saqlaydigan joy (odatda kompyuterda).
 Masalan, maktab ma’lumotlar bazasida o‘quvchilarning ismi, yoshi, va baholari saqlanadi.
 Relational Database - Bu turdagi bazada ma’lumotlar jadvallarda saqlanadi va bu jadvallar bir-biriga bog‘langan bo‘ladi.
 Misol: Bitta jadvalda talabaning shaxsiy ma’lumotlari (ism, yosh, ID)
 Ikkinchi jadvalda talabaning imtihon natijalari. Ular "ID" orqali bog‘langan bo‘ladi. 
 Shunday qilib, talabaning barcha baholarini osongina topish mumkin.
 Table, Jadval – bu ustunlar va qatorlardan iborat tuzilma (excelga o‘xshaydi), va bir turdagi ma’lumotlar shu yerda saqlanadi.


 List five key features of SQL Server.
 (Relational Database Management) ma'lumotlar bazasini boshqarish tizimi bo‘lib, katta hajmdagi ma’lumotlarni saqlash, izlash va boshqarishni osonlashtiradi.)
  (Security) XavfsizlikFoydalanuvchi huquqlarini nazorat qilish, ma’lumotlarni shifrlash va xavfsizlik siyosatlari orqali ma’lumotlar himoyasini ta’minlaydi.
 (Backup and Restore) Zaxira va tiklash Ma’lumotlar yo‘qolishini oldini olish uchun avtomatik zaxiralash va kerak bo‘lsa, tiklash imkoniyatlarini beradi.
 (Transaction Support)Transaksiyalarni qo‘llab-quvvatlash. ACID tamoyillariga asoslangan transaksiyalarni boshqarish orqali ma’lumotlar yaxlitligini saqlaydi.
 (Analytics and Reporting Tools)Analitik va hisobot vositalari. SQL Server Reporting Services (SSRS) va SQL Server Integration Services (SSIS) orqali tahlil qilish va hisobotlar tayyorlash imkoniyatlarini beradi.
 

What are the different authentication modes available when connecting to SQL Server? (Give at least 2) 
SQL Server'ga ulanishda quyidagi ikki asosiy autentifikatsiya (tasdiqlash) usuli mavjud:
1) Windows autentifikatsiyasi (Windows Authentication)Foydalanuvchi o‘zining Windows tizimidagi akkaunti orqali SQL Server’ga ulanadi.
Bu usul xavfsizroq hisoblanadi, chunki parol kiritish talab qilinmaydi (Windows sessiyasi orqali tasdiqlanadi).
2) SQL Server autentifikatsiyasi (SQL Server Authentication) Foydalanuvchi SQL Server’da yaratilgan login va parol orqali tizimga ulanadi.
Windows akkaunti bo‘lmagan foydalanuvchilar uchun mos keladi. Bu usulda foydalanuvchi nomi va paroli qo‘lda kiritiladi.



Create database SchoolDB
create table Students (StudentID INT PRIMARY KEY, Name VARCHAR(50),  Age INT);
Select * from Students


Describe the differences between SQL Server, SSMS, and SQL.
SQL Server Bu — Microsoft tomonidan yaratilgan ma’lumotlar bazasini boshqarish dasturi/tizimi.
SSMS (SQL Server Management Studio)Bu — SQL Server bilan ishlash uchun mo‘ljallangan grafik interfeysli dastur.
SQL (Structured Query Language) ma’lumotlar bazasi bilan ishlash uchun yaratilgan maxsus dasturlash tili.


Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
1. DQL – Ma’lumotlarni So‘rash Tili (Data Query Language)
Maqsadi: Ma’lumotlar bazasidan ma’lumotlarni so‘rash va ko‘rish. Asosiy buyruq: SELECT
Misol:  SELECT * FROM Students;
2. DML – Ma’lumotlar bilan Ishlash Tili (Data Manipulation Language)
Maqsadi: Jadvaldagi ma’lumotlarni qo‘shish, o‘zgartirish yoki o‘chirish.
Buyruqlar: INSERT, UPDATE, DELETE  Misol: INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Ali', 20);
3. DDL – Ma’lumotlar Tuzilmasi Tili (Data Definition Language) 
Maqsadi: Jadval, ustun, baza kabi ob'ektlarning strukturasi bilan ishlash.
Buyruqlar: CREATE, ALTER, DROP, TRUNCATE  Misol: CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT);
4. DCL – Ma’lumotlar Nazorati Tili (Data Control Language)
Maqsadi: Foydalanuvchilarga ruxsat berish yoki olib tashlash. Buyruqlar: GRANT, REVOKE
Misol: GRANT SELECT ON Students TO user_name;
5. TCL – Tranzaksiyani Boshqarish Tili (Transaction Control Language)
Maqsadi: Tranzaksiyalarni boshqarish, ya’ni bir nechta DML buyruqlarni guruhlab bajarish yoki bekor qilish.
Buyruqlar: COMMIT, ROLLBACK, SAVEPOINT

INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'Ali', 20),
(2, 'Dilshod', 21),
(3, 'Malika', 19);
Select * from Students
