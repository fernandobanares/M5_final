# language: es
@Login @SmokeTest
Característica: Funcionalidad de Login
  Como usuario de la aplicación web
  Quiero poder iniciar sesión con mis credenciales
  Para acceder a las funcionalidades del sistema y gestionar mi información personal

  Narrativa:
    El sistema de login es fundamental para la seguridad de la aplicación.
    Los usuarios deben poder autenticarse de manera segura y recibir
    retroalimentación clara sobre el estado de su intento de login.

  Antecedentes:
    Dado que el usuario está en la página de login
    Y la página de login está completamente cargada

  @ValidLogin @Regression
  Escenario: Login exitoso con credenciales válidas
    Dado que el usuario tiene credenciales válidas
    Cuando el usuario ingresa "admin" como nombre de usuario
    Y el usuario ingresa "password123" como contraseña
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería ser redirigido al dashboard principal
    Y debería ver el mensaje de bienvenida "Bienvenido, admin"
    Pero no debería ver mensajes de error

  @InvalidLogin @Regression
  Escenario: Login fallido con credenciales inválidas
    Dado que el usuario tiene credenciales inválidas
    Cuando el usuario ingresa "usuario_inexistente" como nombre de usuario
    Y el usuario ingresa "contraseña_incorrecta" como contraseña
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería permanecer en la página de login
    Y debería ver el mensaje de error "Your username is invalid!"
    Pero no debería ser redirigido al dashboard

  @EmptyCredentials @SmokeTest
  Escenario: Login fallido con campos vacíos
    Dado que el usuario no ha ingresado credenciales
    Cuando el usuario deja el campo de nombre de usuario vacío
    Y el usuario deja el campo de contraseña vacío
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería permanecer en la página de login
    Y los campos de entrada deberían mostrar indicadores de validación
    Pero no debería ver mensajes de éxito

  @PartialCredentials @Regression
  Escenario: Login fallido con solo nombre de usuario
    Dado que el usuario ha ingresado solo el nombre de usuario
    Cuando el usuario ingresa "admin" como nombre de usuario
    Y el usuario deja el campo de contraseña vacío
    Y el usuario hace clic en el botón de iniciar sesión
    Entonces el usuario debería permanecer en la página de login
    Y debería ver una indicación de que la contraseña es requerida
    Pero no debería acceder al sistema
