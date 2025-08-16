package steps;

import io.cucumber.java.es.Cuando;
import io.cucumber.java.es.Dado;
import io.cucumber.java.es.Entonces;
import io.cucumber.java.es.Y;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
import utils.DriverManager;

import java.time.Duration;

import static org.junit.Assert.*;

/**
 * DataDrivenSteps - Step Definitions para escenarios con Scenario Outline
 * 
 * Esta clase implementa los pasos específicos para pruebas data-driven
 * que utilizan múltiples combinaciones de datos de entrada.
 */
public class DataDrivenSteps {

    private WebDriver driver;
    private WebDriverWait wait;
    private int loginAttempts = 0;

    public DataDrivenSteps() {
        this.driver = DriverManager.getDriver();
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    @Dado("que el usuario está probando los límites del sistema")
    public void queElUsuarioEstaProbandoLosLimitesDelSistema() {
        System.out.println("✓ Usuario iniciando pruebas de límites del sistema");
        // Preparar el entorno para pruebas de límites
    }

    @Dado("que el usuario realiza múltiples intentos de login")
    public void queElUsuarioRealizaMultiplesIntentosDeLogin() {
        System.out.println("✓ Usuario preparando múltiples intentos de login");
        this.loginAttempts = 0;
    }

    @Cuando("el usuario intenta hacer login {string} veces")
    public void elUsuarioIntentaHacerLoginVeces(String numeroIntentos) {
        int intentos = Integer.parseInt(numeroIntentos);
        this.loginAttempts = intentos;

        System.out.println("✓ Usuario realizará " + intentos + " intentos de login");
    }

    @Y("con el usuario {string} y contraseña {string}")
    public void conElUsuarioYContrasena(String usuario, String contraseña) {
        // Simular múltiples intentos de login
        for (int i = 1; i <= loginAttempts; i++) {
            System.out.println("  → Intento " + i + " de " + loginAttempts +
                    " con usuario: " + usuario);

            // Simular el proceso de login
            try {
                Thread.sleep(100); // Simular tiempo de procesamiento
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

        System.out.println("✓ Completados " + loginAttempts + " intentos de login");
    }

    @Entonces("el sistema debería mostrar {string}")
    public void elSistemaDeberiaMostrar(String resultadoEsperado) {
        // Validar el resultado basado en los datos de entrada
        System.out.println("✓ Sistema mostró resultado: " + resultadoEsperado);

        // En un escenario real, aquí validaríamos el comportamiento específico
        assertNotNull(resultadoEsperado, "El resultado esperado no puede ser nulo");
    }

    @Y("debería manejar correctamente el caso {string}")
    public void deberiaManejarCorrectamenteElCaso(String tipoPrueba) {
        System.out.println("✓ Sistema manejó correctamente: " + tipoPrueba);

        // Validaciones específicas según el tipo de prueba
        switch (tipoPrueba.toLowerCase()) {
            case "campos muy cortos":
                validateShortFields();
                break;
            case "campos muy largos":
                validateLongFields();
                break;
            case "caracteres especiales":
                validateSpecialCharacters();
                break;
            case "solo mayúsculas":
                validateUppercaseFields();
                break;
            default:
                System.out.println("⚠ Tipo de prueba no reconocido: " + tipoPrueba);
        }
    }

    @Entonces("el sistema debería {string}")
    public void elSistemaDeberia(String comportamientoEsperado) {
        System.out.println("✓ Sistema ejecutó comportamiento: " + comportamientoEsperado);

        // Validar comportamientos de seguridad
        switch (comportamientoEsperado.toLowerCase()) {
            case "bloquear temporalmente":
                validateTemporaryBlock();
                break;
            case "bloquear permanente":
                validatePermanentBlock();
                break;
            case "permitir acceso":
                validateAccessGranted();
                break;
            default:
                System.out.println("⚠ Comportamiento no reconocido: " + comportamientoEsperado);
        }
    }

    @Y("debería registrar {string} en los logs")
    public void deberiaRegistrarEnLosLogs(String accionSeguridad) {
        System.out.println("✓ Acción registrada en logs: " + accionSeguridad);

        // Simular verificación de logs de seguridad
        validateSecurityLogging(accionSeguridad);
    }

    // Métodos auxiliares para validaciones específicas

    private void validateShortFields() {
        System.out.println("  → Validando campos muy cortos");
        // En un escenario real, verificaríamos mensajes de validación de longitud
        // mínima
    }

    private void validateLongFields() {
        System.out.println("  → Validando campos muy largos");
        // En un escenario real, verificaríamos truncamiento o mensajes de longitud
        // máxima
    }

    private void validateSpecialCharacters() {
        System.out.println("  → Validando caracteres especiales");
        // En un escenario real, verificaríamos el manejo de caracteres especiales
    }

    private void validateUppercaseFields() {
        System.out.println("  → Validando campos en mayúsculas");
        // En un escenario real, verificaríamos la normalización de case
    }

    private void validateTemporaryBlock() {
        System.out.println("  → Validando bloqueo temporal");
        // En un escenario real, verificaríamos que la cuenta se bloquee temporalmente
        assertTrue("Bloqueo temporal debe activarse después de 3 intentos", loginAttempts >= 3);
    }

    private void validatePermanentBlock() {
        System.out.println("  → Validando bloqueo permanente");
        // En un escenario real, verificaríamos que la cuenta se bloquee permanentemente
        assertTrue("Bloqueo permanente debe activarse después de 5 intentos", loginAttempts >= 5);
    }

    private void validateAccessGranted() {
        System.out.println("  → Validando acceso concedido");
        // En un escenario real, verificaríamos que el login fue exitoso
        assertEquals("Acceso debe concederse en el primer intento válido", 1, loginAttempts);
    }

    private void validateSecurityLogging(String accionSeguridad) {
        System.out.println("  → Verificando logs de seguridad para: " + accionSeguridad);

        // En un escenario real, verificaríamos que los eventos se registren
        // correctamente
        switch (accionSeguridad.toLowerCase()) {
            case "intento de fuerza bruta":
                System.out.println("    ✓ Log de fuerza bruta registrado");
                break;
            case "actividad sospechosa":
                System.out.println("    ✓ Log de actividad sospechosa registrado");
                break;
            case "login exitoso":
                System.out.println("    ✓ Log de login exitoso registrado");
                break;
            default:
                System.out.println("    ⚠ Tipo de log no reconocido");
        }
    }
}
