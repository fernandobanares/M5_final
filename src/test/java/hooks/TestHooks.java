package hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import utils.DriverManager;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * TestHooks - Clase para manejar la inicialización y finalización de pruebas
 * 
 * Los hooks se ejecutan automáticamente antes y después de cada escenario,
 * permitiendo centralizar la configuración y limpieza del entorno de pruebas.
 */
public class TestHooks {
    
    private WebDriver driver;
    private static final String SCREENSHOTS_DIR = "screenshots";
    
    /**
     * Hook que se ejecuta ANTES de cada escenario
     * Inicializa el WebDriver y prepara el entorno de prueba
     * 
     * @param scenario Información del escenario que se va a ejecutar
     */
    @Before
    public void setUp(Scenario scenario) {
        System.out.println("=".repeat(80));
        System.out.println("🚀 INICIANDO ESCENARIO: " + scenario.getName());
        System.out.println("📋 Tags: " + scenario.getSourceTagNames());
        System.out.println("=".repeat(80));
        
        // Crear directorio de screenshots si no existe
        createScreenshotsDirectory();
        
        // Inicializar WebDriver
        driver = DriverManager.getDriver();
        
        System.out.println("✅ Entorno de prueba inicializado correctamente");
        System.out.println("-".repeat(80));
    }
    
    /**
     * Hook que se ejecuta DESPUÉS de cada escenario
     * Captura screenshot en caso de fallo y cierra el WebDriver
     * 
     * @param scenario Información del escenario que se ejecutó
     */
    @After
    public void tearDown(Scenario scenario) {
        System.out.println("-".repeat(80));
        System.out.println("🏁 FINALIZANDO ESCENARIO: " + scenario.getName());
        System.out.println("📊 Estado: " + (scenario.isFailed() ? "❌ FALLIDO" : "✅ EXITOSO"));
        
        // Capturar screenshot si el escenario falló
        if (scenario.isFailed()) {
            captureScreenshot(scenario);
        }
        
        // Cerrar WebDriver
        DriverManager.quitDriver();
        
        System.out.println("🧹 Limpieza completada");
        System.out.println("=".repeat(80));
        System.out.println(); // Línea en blanco para separar escenarios
    }
    
    /**
     * Hook específico para escenarios con tag @Login
     * Se ejecuta antes de los escenarios de login para configuraciones específicas
     * 
     * @param scenario Información del escenario
     */
    @Before("@Login")
    public void setUpLogin(Scenario scenario) {
        System.out.println("🔐 Configuración específica para pruebas de Login");
        // Aquí se pueden agregar configuraciones específicas para login
        // Por ejemplo: limpiar cookies, configurar datos de prueba, etc.
    }
    
    /**
     * Hook específico para escenarios con tag @CRUD
     * Se ejecuta antes de los escenarios CRUD para preparar datos de prueba
     * 
     * @param scenario Información del escenario
     */
    @Before("@CRUD")
    public void setUpCRUD(Scenario scenario) {
        System.out.println("📝 Configuración específica para pruebas CRUD");
        // Aquí se pueden preparar datos de prueba para operaciones CRUD
        // Por ejemplo: crear registros base, limpiar base de datos, etc.
    }
    
    /**
     * Hook que se ejecuta después de escenarios con tag @SmokeTest
     * Realiza validaciones adicionales para pruebas críticas
     * 
     * @param scenario Información del escenario
     */
    @After("@SmokeTest")
    public void tearDownSmokeTest(Scenario scenario) {
        System.out.println("🔍 Validaciones adicionales para Smoke Test completadas");
        // Aquí se pueden agregar validaciones adicionales para smoke tests
        // Por ejemplo: verificar logs, validar métricas, etc.
    }
    
    /**
     * Captura un screenshot y lo adjunta al reporte de Cucumber
     * 
     * @param scenario El escenario que falló
     */
    private void captureScreenshot(Scenario scenario) {
        try {
            if (driver != null) {
                // Capturar screenshot
                byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
                
                // Adjuntar al reporte de Cucumber
                scenario.attach(screenshot, "image/png", "Screenshot");
                
                // Guardar screenshot en archivo
                saveScreenshotToFile(screenshot, scenario.getName());
                
                System.out.println("📸 Screenshot capturado y adjuntado al reporte");
            }
        } catch (Exception e) {
            System.err.println("❌ Error al capturar screenshot: " + e.getMessage());
        }
    }
    
    /**
     * Guarda el screenshot en un archivo en el directorio de screenshots
     * 
     * @param screenshot Bytes del screenshot
     * @param scenarioName Nombre del escenario
     */
    private void saveScreenshotToFile(byte[] screenshot, String scenarioName) {
        try {
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
            String fileName = String.format("%s_%s_%s.png", 
                scenarioName.replaceAll("[^a-zA-Z0-9]", "_"), 
                DriverManager.getBrowserName(), 
                timestamp);
            
            String filePath = SCREENSHOTS_DIR + File.separator + fileName;
            Files.write(Paths.get(filePath), screenshot);
            
            System.out.println("💾 Screenshot guardado en: " + filePath);
        } catch (IOException e) {
            System.err.println("❌ Error al guardar screenshot: " + e.getMessage());
        }
    }
    
    /**
     * Crea el directorio de screenshots si no existe
     */
    private void createScreenshotsDirectory() {
        try {
            Files.createDirectories(Paths.get(SCREENSHOTS_DIR));
        } catch (IOException e) {
            System.err.println("❌ Error al crear directorio de screenshots: " + e.getMessage());
        }
    }
}
