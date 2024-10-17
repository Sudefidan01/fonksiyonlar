--Functions (FOnksiyonlar)
--Sql sorgu dili i�erisinde , C# da oldu�u gibi kendini tekrarlayan komut sat�rlar�n� bir paket sistemi haline getirmek i�in kullan�lan yap�lard�r
--Sql sorgu dili i�erisinde bir sorgu komutunu birden fazla kez kullanacak isek fonksiyon mant��� kullan�l�r

--Fonksiyonlar�n , SP(Store Procedure)'lerden en b�y�k fark� sorgu i�erisinde kullan�labilmeleridir


-- 1) Geriye D�nd�ren fonksiyonlar

--Syntax
--Create Function <fonksiyonAd�> (<Parametre'ler>)
--returns <geriyed�necekveritipi>
--as
--begin
--return<deger>
--end


--�rnek
-- 2 Say�y� Toplay�p sonucu geriye d�nd�ren bir fonksiyon yazal�m
Create FUnction fnTopla (@sayi1 int , @sayi2 int)
returns int
as
begin
	return (@sayi1 + @sayi2)
end

--�a��rma i�leminden �nce �ema ad� sonra fonksiyon ad� yaz�l�r
Select dbo.fnTopla(5,3) as Toplam

-- 2)Geriye Sorgu D�nd�ren Fonksiyonlar
-- Kendi i�erisinde i�lemlere ba�l� kalarak bir select sorgusu d�nd�rebilirsiniz

--Syntax
--Create Function <FOnksiyonAd�> (<parametre'ler>)
--returns table
--as
--return
--(
--  <geriyeD�necekOlanSqlSorgusu>
--)

--�rnek
--M��teri Id bilgisine g�re sipari�leri listeleyen bir fonksiyon yaz�p �a��ral�m
use NORTHWND
Go
create function MusteriyeGoreSiparis (@musteriID nchar(5))
returns table
as
return 
(
	select * from Orders where CustomerID=@musteriID
)

--M��teri Id bilgisi 'FAMIA' olan sipari�leri listeleyelim
select * from dbo.MusteriyeGoreSiparis('FAMIA')

--ALTER FUNCTION
--Taraf�n�zdan olu�turulmu� olan fonksiyonlar� d�zenlemek i�in kullan�lan bir yap�d�r.Fonksiyonun ismi hari� t�m i�leyi�ini bu yap� ile de�i�tirebiliriz
--Tek yapman�z gereken fonksiyon olu�turma a�amas�ndaki suntax'in birebir ayn�s�n� Create ifadesi yerine Alter ifadesiyle yazmak

--�rnek
--dbo.Topla fonksiyonun i�eri�ini de�i�tirelim
alter function fnTopla(@s1 float , @s2 float , @s3 float)
returns float
as
begin
	return(@s1 + @s2+ @s3)
end

select dbo.fnTopla(10.3 , 5.2 , 6.4) as Toplam

--Drop Function
--OLu�turulmu� oldu�umuz fonksiyonu silme i�in kullan�lan bir yap�d�r
--Syntax
--Drop FUnction <sema>.<fonksiyonAd�>
drop function dbo.fnTopla