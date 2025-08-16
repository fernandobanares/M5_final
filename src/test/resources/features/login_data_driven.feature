# language: es
@Login @DataDriven @Regression
Característica: Login con múltiples combinaciones de datos
  Como administrador del sistema
  Quiero probar el login con diferentes combinaciones de credenciales
  Para asegurar que el sistema maneja correctamente todos los casos posibles

  Narrativa:
    Es fundamental probar el sistema de login con múltiples combinaciones
    de datos para identificar vulnerabilidades y asegurar que la validación
    funciona correctamente en todos los escenarios posibles.

  Antecedentes:
    Dado que el usuario está en la página de login
    Y la página de login está completamente cargada

  @ValidCredentials @SmokeTest
  Esquema del escenario: Login con diferentes credenciales válidas
    Dado que el usuario tiene credenciales válidas
    Cuando el usuario ingresa "<usuario>" como nombre de usuario
    Y el usuario ingresa "<contraseña>" como contraseña
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería ser redirigido al dashboard principal
    Y debería ver el mensaje de bienvenida "<mensaje_esperado>"
    Pero no debería ver mensajes de error

    Ejemplos:
      | usuario    | contraseña  | mensaje_esperado        |
      | admin      | password123 | Bienvenido, admin       |
      | tomsmith   | password123 | Bienvenido, tomsmith    |
      | testuser   | password123 | Bienvenido, testuser    |

  @InvalidCredentials @Security
  Esquema del escenario: Login fallido con credenciales inválidas
    Dado que el usuario tiene credenciales inválidas
    Cuando el usuario ingresa "<usuario>" como nombre de usuario
    Y el usuario ingresa "<contraseña>" como contraseña
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería permanecer en la página de login
    Y debería ver el mensaje de error "<mensaje_error>"
    Pero no debería ser redirigido al dashboard

    Ejemplos:
      | usuario        | contraseña        | mensaje_error                |
      | usuario_falso  | contraseña_falsa  | Your username is invalid!    |
      | admin          | contraseña_mala   | Your password is invalid!    |
      | ""             | password123       | Username is required         |
      | admin          | ""                | Password is required         |

  @BoundaryTesting @Validation
  Esquema del escenario: Pruebas de límites en campos de login
    Dado que el usuario está probando los límites del sistema
    Cuando el usuario ingresa "<usuario>" como nombre de usuario
    Y el usuario ingresa "<contraseña>" como contraseña
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el sistema debería mostrar "<resultado_esperado>"
    Y debería manejar correctamente el caso "<tipo_prueba>"

    Ejemplos:
      | usuario                          | contraseña                       | resultado_esperado    | tipo_prueba           |
      | a                               | p                                | Error de validación   | Campos muy cortos     |
      | usuario_muy_largo_123456789     | contraseña_muy_larga_123456789   | Error de validación   | Campos muy largos     |
      | usuario@especial#               | contraseña$especial%             | Error de validación   | Caracteres especiales |
      | USUARIO_MAYUSCULAS              | CONTRASEÑA_MAYUSCULAS            | Error de validación   | Solo mayúsculas       |

  @PerformanceTesting @Load
  Esquema del escenario: Pruebas de rendimiento con múltiples intentos
    Dado que el usuario realiza múltiples intentos de login
    Cuando el usuario intenta hacer login "<numero_intentos>" veces
    Y con el usuario "<usuario>" y contraseña "<contraseña>"
    Entonces el sistema debería "<comportamiento_esperado>"
    Y debería registrar "<accion_seguridad>" en los logs

    Ejemplos:
      | numero_intentos | usuario    | contraseña      | comportamiento_esperado | accion_seguridad        |
      | 3               | admin      | password_mala   | Bloquear temporalmente  | Intento de fuerza bruta |
      | 5               | hacker     | password123     | Bloquear permanente     | Actividad sospechosa    |
      | 1               | admin      | password123     | Permitir acceso         | Login exitoso           |
