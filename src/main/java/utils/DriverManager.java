package utils;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;

import java.time.Duration;

/**
 * DriverManager - Clase utilitaria para gestionar el WebDriver
 * 
 * Esta clase implementa el patrón Singleton para asegurar que solo
 * exista una instancia del WebDriver durante la ejecución de las pruebas.
 */
public class DriverManager {
    
    private static WebDriver driver;
    private static final String BROWSER = System.getProperty("browser", "chrome");
    private static final boolean HEADLESS = Boolean.parseBoolean(System.getProperty("headless", "false"));
    
    /**
     * Obtiene la instancia del WebDriver
     * Si no existe, la crea con la configuración especificada
     * 
     * @return WebDriver instance
     */
    public static WebDriver getDriver() {
        if (driver == null) {
            createDriver();
        }
        return driver;
    }
    
    /**
     * Crea una nueva instancia del WebDriver según el navegador especificado
     */
    private static void createDriver() {
        switch (BROWSER.toLowerCase()) {
            case "chrome":
                createChromeDriver();
                break;
            case "firefox":
                createFirefoxDriver();
                break;
            default:
                throw new IllegalArgumentException("Navegador no soportado: " + BROWSER);
        }
        
        // Configuración común para todos los navegadores
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30));
        
        System.out.println("✓ WebDriver inicializado: " + BROWSER + 
                          (HEADLESS ? " (modo headless)" : ""));
    }
    
    /**
     * Crea una instancia de ChromeDriver con las opciones configuradas
     */
    private static void createChromeDriver() {
        WebDriverManager.chromedriver().setup();
        
        ChromeOptions options = new ChromeOptions();
        
        if (HEADLESS) {
            options.addArguments("--headless");
        }
        
        // Opciones adicionales para mejorar la estabilidad
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--disable-gpu");
        options.addArguments("--window-size=1920,1080");
        options.addArguments("--disable-extensions");
        options.addArguments("--disable-web-security");
        options.addArguments("--allow-running-insecure-content");
        
        driver = new ChromeDriver(options);
    }
    
    /**
     * Crea una instancia de FirefoxDriver con las opciones configuradas
     */
    private static void createFirefoxDriver() {
        WebDriverManager.firefoxdriver().setup();
        
        FirefoxOptions options = new FirefoxOptions();
        
        if (HEADLESS) {
            options.addArguments("--headless");
        }
        
        driver = new FirefoxDriver(options);
    }
    
    /**
     * Cierra el WebDriver y libera los recursos
     */
    public static void quitDriver() {
        if (driver != null) {
            try {
                driver.quit();
                System.out.println("✓ WebDriver cerrado correctamente");
            } catch (Exception e) {
                System.err.println("Error al cerrar WebDriver: " + e.getMessage());
            } finally {
                driver = null;
            }
        }
    }
    
    /**
     * Obtiene el nombre del navegador configurado
     * 
     * @return String con el nombre del navegador
     */
    public static String getBrowserName() {
        return BROWSER;
    }
    
    /**
     * Verifica si el modo headless está activado
     * 
     * @return true si está en modo headless, false en caso contrario
     */
    public static boolean isHeadless() {
        return HEADLESS;
    }
}
