SELECT * FROM adv.adventureworksdwbuildversion;

/*Connettiti al db aziendale o esegui il restore del db*/
/*Server -> Data Import -> Import from Self-Contained File -> Selezionare il db -> Star Import > Set As Default Schema sul db aziendale*/

/*Esplora la tabelle dei prodotti (DimProduct)*/
SELECT 
    *
FROM
    DimProduct;

/*Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, 
EnglishProductName, Color, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias 
se lo ritieni opportuno.*/
SELECT 
    ProductKey AS ID_Prodotto,
    ProductAlternateKey AS ID_Alternativo,
    EnglishProductName,
    Color AS colore,
    StandardCost AS costo,
    FinishedGoodsFlag AS ProdottoFinito
FROM
    DimProduct;

/*Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo 
FinishedGoodsFlag è uguale a 1.*/
SELECT 
    ProductKey AS codiceProdotto,
    ProductAlternateKey AS codiceModello,
    EnglishProductName,
    Color AS colore,
    StandardCost AS costoStandart,
    FinishedGoodsFlag AS ProdottoFinito
FROM
    DimProduct
WHERE
    FinishedGoodsFlag = 1;

/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e 
il prezzo di listino (ListPrice).*/
SELECT 
    DimProduct.ProductAlternateKey,
    DimProduct.ProductKey AS codiceProdotto,
    DimProduct.ProductAlternateKey AS codiceModello,
    EnglishProductName AS nomeProdotto,
    DimProduct.StandardCost AS costoStandard,
    DimProduct.ListPrice AS prezzoListino
FROM
    DimProduct
WHERE
    ProductAlternateKey LIKE 'FR%'
        OR ProductAlternateKey LIKE 'BK%';

/*Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)*/
SELECT 
    DimProduct.ProductAlternateKey,
    DimProduct.ProductKey AS codiceProdotto,
    DimProduct.ProductAlternateKey AS codiceModello,
    EnglishProductName AS nomeProdotto,
    DimProduct.StandardCost AS costoStandard,
    DimProduct.ListPrice AS prezzoListino,
    (DimProduct.ListPrice - DimProduct.StandardCost) AS Markup
FROM
    DimProduct
WHERE
    ProductAlternateKey LIKE 'FR%'
        OR ProductAlternateKey LIKE 'BK%';

/*Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.*/
SELECT 
    DimProduct.FinishedGoodsFlag, DimProduct.ListPrice
FROM
    DimProduct
WHERE
    DimProduct.ListPrice BETWEEN 1000 AND 2000;

/*Esplora la tabella degli impiegati aziendali (DimEmployee)*/
SELECT 
    *
FROM
    DimEmployee AS ImpiegatiAziendali;

/*Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo 
SalespersonFlag è uguale a 1.*/
SELECT 
    *
FROM
    DimEmployee AS ImpiegatiAziendali
WHERE
    ImpiegatiAziendali.SalespersonFlag = 1;

/*Interroga la tabella delle vendite (FactResellerSales). Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 
2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/
SELECT 
    *, FRS.SalesAmount - FRS.TotalProductCost AS Profitto
FROM
    FactResellerSales AS FRS
WHERE
    FRS.ShipDate > '2020-01-01'
        AND FRS.ProductKey IN (597 , 598, 477, 214); 


