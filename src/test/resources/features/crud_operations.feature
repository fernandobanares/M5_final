# language: es
@CRUD @Regression
Característica: Operaciones CRUD (Create, Read, Update, Delete)
  Como usuario autenticado del sistema
  Quiero poder realizar operaciones básicas de datos
  Para gestionar la información de manera efectiva

  Narrativa:
    Las operaciones CRUD son fundamentales en cualquier sistema de gestión.
    Los usuarios deben poder crear, leer, actualizar y eliminar registros
    de manera segura y eficiente, con validaciones apropiadas.

  Antecedentes:
    Dado que el usuario está autenticado en el sistema
    Y tiene permisos para realizar operaciones CRUD

  @Create @SmokeTest
  Escenario: Crear un nuevo registro exitosamente
    Dado que el usuario está en la página de creación de registros
    Cuando el usuario ingresa "Producto Test" como nombre
    Y el usuario ingresa "Descripción del producto de prueba" como descripción
    Y el usuario selecciona "Activo" como estado
    Y el usuario hace clic en el botón "Guardar"
    Entonces el sistema debería mostrar el mensaje "Registro creado exitosamente"
    Y el nuevo registro debería aparecer en la lista
    Pero no debería mostrar errores de validación

  @Read @SmokeTest
  Escenario: Leer y visualizar registros existentes
    Dado que existen registros en el sistema
    Cuando el usuario navega a la página de listado
    Entonces el usuario debería ver una lista de registros
    Y cada registro debería mostrar su información básica
    Y debería poder ver los detalles de un registro específico
    Pero no debería ver registros eliminados

  @Update @Regression
  Escenario: Actualizar un registro existente
    Dado que existe un registro con ID "123"
    Y el usuario está en la página de edición del registro
    Cuando el usuario modifica el nombre a "Producto Actualizado"
    Y el usuario cambia la descripción a "Descripción actualizada"
    Y el usuario hace clic en el botón "Actualizar"
    Entonces el sistema debería mostrar el mensaje "Registro actualizado exitosamente"
    Y los cambios deberían reflejarse en la base de datos
    Pero la fecha de creación no debería cambiar

  @Delete @Regression
  Escenario: Eliminar un registro existente
    Dado que existe un registro con ID "456"
    Y el usuario está en la página de detalles del registro
    Cuando el usuario hace clic en el botón "Eliminar"
    Y confirma la eliminación en el diálogo de confirmación
    Entonces el sistema debería mostrar el mensaje "Registro eliminado exitosamente"
    Y el registro no debería aparecer en la lista
    Pero debería mantenerse un log de la eliminación

  @Validation @CRUD
  Escenario: Validar campos requeridos al crear un registro
    Dado que el usuario está en la página de creación de registros
    Cuando el usuario deja el campo nombre vacío
    Y el usuario intenta guardar el registro
    Entonces el sistema debería mostrar el mensaje "El nombre es requerido"
    Y no debería crear el registro
    Pero debería mantener los otros datos ingresados

  @BusinessRule @CRUD
  Escenario: Prevenir eliminación de registros con dependencias
    Dado que existe un registro con ID "789" que tiene dependencias
    Y el usuario intenta eliminar el registro
    Cuando el usuario confirma la eliminación
    Entonces el sistema debería mostrar el mensaje "No se puede eliminar: el registro tiene dependencias"
    Y el registro debería permanecer en el sistema
    Pero debería sugerir alternativas al usuario

  @Pagination @CRUD
  Esquema del escenario: Navegación por páginas en listado de registros
    Dado que existen "<total_registros>" registros en el sistema
    Y la página muestra "<registros_por_pagina>" registros por página
    Cuando el usuario navega a la página "<numero_pagina>"
    Entonces debería ver "<registros_mostrados>" registros
    Y debería poder navegar a la "<accion_navegacion>"

    Ejemplos:
      | total_registros | registros_por_pagina | numero_pagina | registros_mostrados | accion_navegacion |
      | 25              | 10                   | 1             | 10                  | página siguiente  |
      | 25              | 10                   | 2             | 10                  | página anterior   |
      | 25              | 10                   | 3             | 5                   | primera página    |

  @Search @CRUD
  Esquema del escenario: Búsqueda y filtrado de registros
    Dado que existen múltiples registros en el sistema
    Cuando el usuario busca por "<criterio_busqueda>" con valor "<valor_busqueda>"
    Entonces debería ver "<resultados_esperados>" en los resultados
    Y los resultados deberían estar "<orden>" ordenados

    Ejemplos:
      | criterio_busqueda | valor_busqueda | resultados_esperados | orden        |
      | nombre            | Producto       | registros con nombre | alfabético   |
      | estado            | Activo         | registros activos    | fecha        |
      | descripción       | test           | registros de prueba  | relevancia   |

  @Performance @CRUD
  Escenario: Verificar rendimiento en operaciones masivas
    Dado que el usuario tiene permisos para operaciones masivas
    Cuando el usuario selecciona 100 registros
    Y ejecuta una operación de actualización masiva
    Entonces la operación debería completarse en menos de 30 segundos
    Y todos los registros deberían actualizarse correctamente
    Pero el sistema debería mantener la responsividad
