USE LAB211;
GO

SELECT TOP 30
    pv.variantId,
    p.productId,
    p.name AS productName,
    pv.color,
    pv.size,
    pv.stock,
    pv.priceVariant
FROM ProductVariant pv
JOIN Product p ON pv.productId = p.productId
WHERE pv.stock > 0
ORDER BY pv.stock DESC, pv.variantId ASC;
