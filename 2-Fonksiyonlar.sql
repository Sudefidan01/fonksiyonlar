--Functions (FOnksiyonlar)
--Sql sorgu dili içerisinde , C# da olduðu gibi kendini tekrarlayan komut satýrlarýný bir paket sistemi haline getirmek için kullanýlan yapýlardýr
--Sql sorgu dili içerisinde bir sorgu komutunu birden fazla kez kullanacak isek fonksiyon mantýðý kullanýlýr

--Fonksiyonlarýn , SP(Store Procedure)'lerden en büyük farký sorgu içerisinde kullanýlabilmeleridir


-- 1) Geriye Döndüren fonksiyonlar

--Syntax
--Create Function <fonksiyonAdý> (<Parametre'ler>)
--returns <geriyedönecekveritipi>
--as
--begin
--return<deger>
--end


--Örnek
-- 2 Sayýyý Toplayýp sonucu geriye döndüren bir fonksiyon yazalým
Create FUnction fnTopla (@sayi1 int , @sayi2 int)
returns int
as
begin
	return (@sayi1 + @sayi2)
end

--Çaðýrma iþleminden önce þema adý sonra fonksiyon adý yazýlýr
Select dbo.fnTopla(5,3) as Toplam

-- 2)Geriye Sorgu Döndüren Fonksiyonlar
-- Kendi içerisinde iþlemlere baðlý kalarak bir select sorgusu döndürebilirsiniz

--Syntax
--Create Function <FOnksiyonAdý> (<parametre'ler>)
--returns table
--as
--return
--(
--  <geriyeDönecekOlanSqlSorgusu>
--)

--Örnek
--Müþteri Id bilgisine göre sipariþleri listeleyen bir fonksiyon yazýp çaðýralým
use NORTHWND
Go
create function MusteriyeGoreSiparis (@musteriID nchar(5))
returns table
as
return 
(
	select * from Orders where CustomerID=@musteriID
)

--Müþteri Id bilgisi 'FAMIA' olan sipariþleri listeleyelim
select * from dbo.MusteriyeGoreSiparis('FAMIA')

--ALTER FUNCTION
--Tarafýnýzdan oluþturulmuþ olan fonksiyonlarý düzenlemek için kullanýlan bir yapýdýr.Fonksiyonun ismi hariç tüm iþleyiþini bu yapý ile deðiþtirebiliriz
--Tek yapmanýz gereken fonksiyon oluþturma aþamasýndaki suntax'in birebir aynýsýný Create ifadesi yerine Alter ifadesiyle yazmak

--Örnek
--dbo.Topla fonksiyonun içeriðini deðiþtirelim
alter function fnTopla(@s1 float , @s2 float , @s3 float)
returns float
as
begin
	return(@s1 + @s2+ @s3)
end

select dbo.fnTopla(10.3 , 5.2 , 6.4) as Toplam

--Drop Function
--OLuþturulmuþ olduðumuz fonksiyonu silme için kullanýlan bir yapýdýr
--Syntax
--Drop FUnction <sema>.<fonksiyonAdý>
drop function dbo.fnTopla