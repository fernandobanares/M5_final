package runners;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

/**
 * MainTestRunner - Clase principal para ejecutar las pruebas BDD con Cucumber
 * 
 * Esta clase configura la ejecución de los archivos .feature y define:
 * - La ubicación de los archivos feature
 * - El paquete donde están los step definitions
 * - Los plugins para generar reportes
 * - Los tags para filtrar escenarios
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "src/test/resources/features", glue = { "steps", "hooks" }, plugin = {
        "pretty",
        "html:target/cucumber-html-reports",
        "json:target/cucumber-json-reports/cucumber.json",
        "junit:target/cucumber-xml-reports/cucumber.xml"
}, tags = "@SmokeTest or @Login")
public class MainTestRunner {

    /**
     * Esta clase no necesita métodos ya que utiliza las anotaciones de JUnit 4
     * para configurar la ejecución de Cucumber.
     * 
     * CONFIGURACIONES DE TAGS DISPONIBLES:
     * 
     * Para ejecutar diferentes conjuntos de pruebas, modifica el valor de tags:
     * 
     * TAGS INDIVIDUALES:
     * - "@SmokeTest" - Solo pruebas críticas de smoke
     * - "@Login" - Solo pruebas de funcionalidad de login
     * - "@CRUD" - Solo pruebas de operaciones Create, Read, Update, Delete
     * - "@Regression" - Pruebas completas de regresión
     * - "@Security" - Pruebas de seguridad
     * - "@DataDriven" - Pruebas con múltiples datos (Scenario Outline)
     * 
     * COMBINACIONES DE TAGS:
     * - "@SmokeTest or @Login" - Smoke tests O pruebas de login
     * - "@Login and @Security" - Pruebas que son de login Y de seguridad
     * - "@Regression and not @WIP" - Regresión excluyendo trabajo en progreso
     * 
     * CONFIGURACIÓN ACTUAL: Ejecuta SmokeTest y Login
     */
}
