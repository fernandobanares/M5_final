# language: es
@Registro @CRUD
Característica: Funcionalidad de Registro de Usuarios
  Como visitante de la aplicación web
  Quiero poder registrarme con mis datos personales
  Para crear una cuenta y acceder a las funcionalidades del sistema

  Narrativa:
    El proceso de registro debe ser intuitivo y seguro, validando
    correctamente los datos del usuario y proporcionando retroalimentación
    clara sobre el éxito o fallo del proceso de registro.

  Antecedentes:
    Dado que el visitante está en la página de registro
    Y la página de registro está completamente cargada

  @ValidRegistration @SmokeTest
  Escenario: Registro exitoso con datos válidos
    Dado que el visitante tiene datos válidos para el registro
    Cuando el visitante ingresa "juan.perez" como nombre de usuario
    Y el visitante ingresa "juan.perez@email.com" como correo electrónico
    Y el visitante ingresa "MiPassword123!" como contraseña
    Y el visitante confirma "MiPassword123!" como confirmación de contraseña
    Y el visitante acepta los términos y condiciones
    Y el visitante hace clic en el botón de registrarse
    Entonces el visitante debería ver el mensaje de confirmación "Registro exitoso"
    Y debería recibir un correo de verificación
    Pero no debería ver mensajes de error

  @InvalidEmail @Regression
  Escenario: Registro fallido con correo electrónico inválido
    Dado que el visitante tiene un correo electrónico inválido
    Cuando el visitante ingresa "carlos.lopez" como nombre de usuario
    Y el visitante ingresa "correo-invalido" como correo electrónico
    Y el visitante ingresa "Password456!" como contraseña
    Y el visitante confirma "Password456!" como confirmación de contraseña
    Y el visitante hace clic en el botón de registrarse
    Entonces el visitante debería permanecer en la página de registro
    Y debería ver el mensaje de error "Formato de correo electrónico inválido"
    Pero no debería completarse el registro

  @WeakPassword @Security
  Escenario: Registro fallido con contraseña débil
    Dado que el visitante intenta usar una contraseña débil
    Cuando el visitante ingresa "maria.garcia" como nombre de usuario
    Y el visitante ingresa "maria.garcia@email.com" como correo electrónico
    Y el visitante ingresa "123" como contraseña
    Y el visitante confirma "123" como confirmación de contraseña
    Y el visitante hace clic en el botón de registrarse
    Entonces el visitante debería permanecer en la página de registro
    Y debería ver el mensaje de error "La contraseña debe tener al menos 8 caracteres"
    Y debería ver sugerencias para crear una contraseña segura
    Pero no debería completarse el registro

  @PasswordMismatch @Validation
  Escenario: Registro fallido con contraseñas que no coinciden
    Dado que el visitante ingresa contraseñas diferentes
    Cuando el visitante ingresa "ana.rodriguez" como nombre de usuario
    Y el visitante ingresa "ana.rodriguez@email.com" como correo electrónico
    Y el visitante ingresa "Password789!" como contraseña
    Y el visitante confirma "Password123!" como confirmación de contraseña
    Y el visitante hace clic en el botón de registrarse
    Entonces el visitante debería permanecer en la página de registro
    Y debería ver el mensaje de error "Las contraseñas no coinciden"
    Pero no debería completarse el registro

  @DuplicateUser @BusinessRule
  Escenario: Registro fallido con usuario existente
    Dado que ya existe un usuario registrado con el mismo nombre
    Y el visitante intenta registrarse con datos duplicados
    Cuando el visitante ingresa "admin" como nombre de usuario
    Y el visitante ingresa "admin@email.com" como correo electrónico
    Y el visitante ingresa "NewPassword123!" como contraseña
    Y el visitante confirma "NewPassword123!" como confirmación de contraseña
    Y el visitante hace clic en el botón de registrarse
    Entonces el visitante debería permanecer en la página de registro
    Y debería ver el mensaje de error "El nombre de usuario ya está en uso"
    Pero no debería completarse el registro
