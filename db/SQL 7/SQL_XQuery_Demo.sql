----------------------------------------------
---------- Languagre XQuery Test -------------
----------------------------------------------
IF OBJECT_ID('XQuery') IS NOT NULL
	DROP DATABASE XQuery;

CREATE DATABASE XQuery;
GO

USE XQuery
GO

DECLARE @xml XML
SET @xml = '
<menu>
  <food>
    <name>Belgian Waffles</name>
    <price>$5.95</price>
    <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
    <calories>650</calories>
  </food>
  <food>
    <name>Strawberry Belgian Waffles</name>
    <price>$7.95</price>
    <description>Light Belgian waffles covered with strawberries and whipped cream</description>
    <calories>900</calories>
  </food>
  <food>
    <name>Berry-Berry Belgian Waffles</name>
    <price>$8.95</price>
    <description>Light Belgian waffles covered with an assortment of fresh berries and whipped cream</description>
    <calories>900</calories>
  </food>
  <food>
    <name>French Toast</name>
    <price>$4.50</price>
    <description>Thick slices made from our homemade sourdough bread</description>
    <calories>600</calories>
  </food>
  <food>
    <name>Homestyle Breakfast</name>
    <price>$6.95</price>
    <description>Two eggs, bacon or sausage, toast, and our ever-popular hash browns</description>
    <calories>950</calories>
  </food>
</menu>'

SELECT @xml.query('
for $f in /menu/food
where $f/calories > 800
order by $f/price[1] ascending
return ($f)
');
GO