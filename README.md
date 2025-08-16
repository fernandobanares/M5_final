# Proyecto Final BDD - Automatización con Cucumber

## 📋 Descripción del Proyecto

Este proyecto implementa un conjunto de pruebas automatizadas basadas en la metodología de Desarrollo Conducido por Comportamiento (BDD) utilizando Cucumber, Selenium WebDriver y Java. El objetivo es verificar la calidad y el comportamiento de una aplicación web, asegurando que cada flujo cumpla con los requerimientos definidos por el área de negocio.

## 🏗️ Estructura del Proyecto

```
Proyecto_final_m5/
├── src/
│   ├── main/
│   │   └── java/
│   │       └── utils/
│   │           └── DriverManager.java          # Gestión del WebDriver
│   └── test/
│       ├── java/
│       │   ├── hooks/
│       │   │   └── TestHooks.java              # Hooks para setup/teardown
│       │   ├── runners/
│       │   │   └── TestRunner.java             # Configuración de ejecución
│       │   └── steps/
│       │       └── LoginSteps.java             # Step Definitions
│       └── resources/
│           └── features/
│               └── login.feature               # Escenarios en Gherkin
├── reports/                                    # Reportes de ejecución
├── screenshots/                                # Screenshots de fallos
├── config/                                     # Archivos de configuración
├── pom.xml                                     # Configuración Maven
└── README.md                                   # Documentación del proyecto
```

## 🛠️ Tecnologías Utilizadas

- **Java 11**: Lenguaje de programación principal
- **Maven**: Gestión de dependencias y construcción del proyecto
- **Cucumber 7.14.0**: Framework BDD para escribir y ejecutar escenarios
- **Selenium WebDriver 4.15.0**: Automatización de navegadores web
- **JUnit 5**: Framework de testing
- **WebDriverManager**: Gestión automática de drivers de navegadores

## 📦 Dependencias Principales

```xml
<!-- Cucumber Core -->
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>7.14.0</version>
</dependency>

<!-- Selenium WebDriver -->
<dependency>
    <groupId>org.seleniumhq.selenium</groupId>
    <artifactId>selenium-java</artifactId>
    <version>4.15.0</version>
</dependency>

<!-- WebDriverManager -->
<dependency>
    <groupId>io.github.bonigarcia</groupId>
    <artifactId>webdrivermanager</artifactId>
    <version>5.5.3</version>
</dependency>
```

## 🚀 Configuración del Entorno

### Prerrequisitos

1. **Java 11 o superior** instalado
2. **Maven 3.6+** instalado
3. **Git** para control de versiones
4. **IDE** (IntelliJ IDEA, Eclipse, VS Code)

### Instalación

1. Clonar el repositorio:
```bash
git clone <url-del-repositorio>
cd Proyecto_final_m5
```

2. Instalar dependencias:
```bash
mvn clean install
```

3. Verificar la instalación:
```bash
mvn test -Dtest=TestRunner
```

## 🎯 Ejecución de Pruebas

### Ejecutar todas las pruebas
```bash
mvn test
```

### Ejecutar pruebas por tags
```bash
# Solo pruebas de Smoke
mvn test -Dcucumber.filter.tags="@SmokeTest"

# Solo pruebas de Login
mvn test -Dcucumber.filter.tags="@Login"

# Excluir pruebas en desarrollo
mvn test -Dcucumber.filter.tags="not @WIP"
```

### Ejecutar en diferentes navegadores
```bash
# Chrome (por defecto)
mvn test -Dbrowser=chrome

# Firefox
mvn test -Dbrowser=firefox

# Modo headless
mvn test -Dheadless=true
```

## 📊 Reportes

Los reportes se generan automáticamente en la carpeta `reports/cucumber-reports/`:

- **HTML Report**: `reports/cucumber-reports/index.html`
- **JSON Report**: `reports/cucumber-reports/Cucumber.json`
- **XML Report**: `reports/cucumber-reports/Cucumber.xml`

## 🏷️ Tags Utilizados

- `@SmokeTest`: Pruebas críticas que deben ejecutarse en cada build
- `@Login`: Pruebas relacionadas con funcionalidad de login
- `@CRUD`: Pruebas de operaciones Create, Read, Update, Delete
- `@Regression`: Pruebas de regresión completas
- `@WIP`: Pruebas en desarrollo (Work In Progress)

## 📝 Convenciones de Escritura

### Archivos .feature
- Usar sintaxis Gherkin en español
- Incluir narrativa clara (Como... Quiero... Para...)
- Usar tags apropiados para organización
- Incluir antecedentes cuando sea necesario

### Step Definitions
- Métodos descriptivos y claros
- Manejo de excepciones apropiado
- Logging para trazabilidad
- Assertions claras y específicas

## 🔧 Configuración Avanzada

### Personalizar el TestRunner

Modifica `src/test/java/runners/TestRunner.java` para cambiar:
- Tags de filtrado
- Plugins de reporte
- Ubicación de features
- Configuración de glue

### Hooks Personalizados

Los hooks en `src/test/java/hooks/TestHooks.java` permiten:
- Setup/teardown por escenario
- Captura automática de screenshots en fallos
- Configuraciones específicas por tag
- Limpieza de datos de prueba

## 📈 Métricas del Proyecto

### Lección 1 - Fundamentos de BDD
- ✅ 1 feature creado correctamente

### Lección 2 - Introducción a Cucumber
- ✅ 1 Runner configurado
- ✅ 3+ pasos funcionales implementados

### Lección 6 - Uso de Hooks
- ✅ 2 hooks funcionales (@Before, @After)
- ✅ 1 captura automática en fallos

## 🤝 Contribución

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crear un Pull Request

## 📞 Soporte

Para preguntas o problemas, crear un issue en el repositorio del proyecto.

---

**Desarrollado por**: Equipo de QA  
**Fecha**: 2025  
**Versión**: 1.0.0
