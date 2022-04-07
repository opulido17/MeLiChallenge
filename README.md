# MeLiChallenge


Esta aplicación tiene como objetivo realizar búsqueda, filtro y visualización de productos disponibles en las API de Mercado Libre haciendo referencia en el sector colombiano.

- Lista de categorias
La aplicación cuenta con una lista de categorías como pantalla inicial y en la parte superior con un cuadro de búsqueda.
API:
https://api.mercadolibre.com/sites/MCO/categories

Esta es la API utilizada para obtener el listado de categorías con sus nombres y respectivos ID's. El consumo de esta API se hace mediante Alamofire
de la siguiente forma:

<img width="955" alt="image" src="https://user-images.githubusercontent.com/43083328/162270567-2624ddfe-d97e-4a9c-ae33-fe096373a337.png">

- Búsqueda de productos
Como se mencionó en el slide anterior, es posible hacer una búsqueda libre de los productos deseados limitados en una cantidad inicial de 10 productos por página. Al visualizar el ultimo producto y deslizar el scroll, se activará el paginador el cual cargará otros 10 productos, así repetir este proceso
de forma sucesiva hasta conseguir visualizar todos los productos deseados:
API:
https://api.mercadolibre.com/sites/MCO/search?q={search}&limit={limit}

Esta API se utiliza para obtener el resultado de búsqueda de acuerdo a las palabras claves ingresadas. El consumo de este enpoint al igual que todos los otros se hace mediante Alamofire de la siguiente forma:

<img width="987" alt="image" src="https://user-images.githubusercontent.com/43083328/162271717-0a6e6e72-c0e5-428f-a66e-73304a45f39b.png">

Como parámetros a reemplazar se encuentran las palabras claves y él limite el cual al hacer el consumo por primera vez siempre tendrá un valor inicial
de 10 pero al cargar el paginador tendrá un aumento de 10 a medida que se vaya activando.

- Lista de productos por categorías
A diferencia del campo de búsqueda, en esta vista se puede ver un listado de productos agrupados de acuerdo a una categoría seleccionada.
Se muestra en un listado de dos columnas
API:
https://api.mercadolibre.com/ites/MCO/search?category={categoryId}

Este servicio se consume de la siguiente forma:

<img width="982" alt="image" src="https://user-images.githubusercontent.com/43083328/162274997-e6b443d6-6c7c-48ba-a6ba-4f671036d8a6.png">

- Detalle o descripción del producto
El detalle o descripción del producto, utiliza un modelo de datos ya seteado en las vistas anteriores para mostrar estos datos de forma más detallada.
Pero ademas, en esta vista se consumen dos servicios adicionales los cuales son para obtener la descripción completa del producto y para traer la información el vendedor.
1. Descripción del producto:
API:
https://api.mercadolibre.com/items/{itemId}/description

<img width="1008" alt="image" src="https://user-images.githubusercontent.com/43083328/162273427-19cfdea4-5240-42c8-8689-38df441850eb.png">

2. Información del vendedor:
API:
https://api.mercadolibre.com/sites/MCO/search?seller_id={sellerId}&limit=15

<img width="975" alt="image" src="https://user-images.githubusercontent.com/43083328/162273660-a78fd3e4-3b1c-45f3-9742-dc35de7e7b5e.png">

Él limite que se indica en este servicio hace referencia a la lista retornado de productos referentes a este vendedor los cuales se puede visualizar en la parte final de esta vista.
