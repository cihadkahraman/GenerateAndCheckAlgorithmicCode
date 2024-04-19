Kodlar MSSQL'de yeni bir sayfaya yapıştırılıp "execute" butonuna basılarak iki stored procedure de ayrı ayrı oluşturulur.

Kod üretmek için örnek: EXEC GenerateCustomCodes 5 (burada 5 adet kod üretilip size gösterilir. İsterseniz üretilecek kod sayısını değiştirebilirsiniz.)

Üretilen kodları kontrol etmek için örnek : EXEC CheckCodeValidity 'LNCEGRC4' (burada da kod kısmına istediğiniz kodu yazarak kontrol edebilirsiniz.)

Şifreleme Algoritması Kuralları:
1-) Kod; 8 haneli ve sadece "ACDEFGHKLMNPRTXYZ234579" karakterlerinden oluşabilir.
2-) Kodun 1. ve 6. hanesindeki karakterlerin ASCII değerlerinin çarpımının 15 ile bölümünden kalan 7 olmalıdır.
3-) 6.hanedeki karakterin ASCII değeri her zaman 1.karakterinkinden büyük olmalı. Böyleci bu karakterlerin yeri değiştirilerek yeni bir kod üretilemez. 
Aynı şekilde 2. karakter 8.karakterden, 5.karakter 3.karakterden, 4.karakter de 7. karakterden ASCII değeri olarak büyük olmalıdır.
4-) 2.karakter ile 8. karakterin ASCII değerleri toplamının karesinin 15 ile bölümünden kalan 10 olmalıdır.
5-) 3. ve 5. karakterlerin ASCII değerlerinin çarpımının 15 ile bölümünden kalan 2 olmalıdır.
6-) 4. ve 7. karakterlerin ASCII değerlerninin çarpımı 3'e tan bölünebilmelidir.

Algoritma oluşturulurken çarpma ve bölmenin kullanılmasındaki sebep, toplama ve çıkarma işlemlerinde ilişkili karakterlerden birinin azaltılıp ötekinin artırılması ile yeni bir kod çok rahat üretilebiliyordu. Bu da istenmeyen bir durum.
