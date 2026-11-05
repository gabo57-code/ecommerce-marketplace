#  Plataforma E-Commerce (Estilo MercadoLibre)

Este es un proyecto de una plataforma de comercio electrónico desarrollada desde cero utilizando Java, Spring Boot y MySQL.

## Tecnologías y Requisitos Previos

* **Lenguaje:** Java 21
* **Framework:** Spring Boot (Spring Data JPA, Hibernate)
* **Base de Datos:** MySQL Server & MySQL Workbench
* **IDE Recomendado:** IntelliJ IDEA

##  Instrucciones de Instalación y Ejecución

Sigue estos pasos para configurar el entorno y ejecutar el proyecto en tu computadora:

### 1. Clonar el Repositorio

Descarga el proyecto en tu entorno local copiando la URL del repositorio y ejecutando:

```bash
git clone URL_DE_TU_REPOSITORIO_AQUI
```
## 2. Configurar e Importar la Base de Datos
   Para que la aplicación funcione y muestre la información correcta, debes cargar el script SQL incluido:

#### A) Abre MySQL Workbench.

#### B) Crea una base de datos vacía ejecutando la siguiente consulta:

```sql 
CREATE DATABASE marketplace_db;
```

#### C) En el menú superior de Workbench, ve a Server > Data Import.

#### D) Selecciona la opción Import from Self-Contained File.

#### E) Haz clic en el botón de los tres puntos (...) y busca el archivo Scrip_bd_Proyecto_Poo.sql que se encuentra en la carpeta principal de este proyecto que acabas de descargar.

#### F) En el menú desplegable Default Target Schema, selecciona marketplace_db.

#### G) Haz clic en el botón Start Import (esquina inferior derecha) y espera a que termine de cargar las tablas y los datos.

## 3. Configurar Credenciales en Spring Boot

#### A) Abre la carpeta del proyecto en IntelliJ IDEA.

#### B) En el panel izquierdo, navega hasta el archivo de propiedades: src/main/resources/application.properties.

#### C) Edita las líneas de usuario y contraseña colocando las credenciales con las que entras a tu propio MySQL local:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/marketplace_db
spring.datasource.username=COLOCA_TU_USUARIO_AQUI
spring.datasource.password=COLOCA_TU_CONTRASEÑA_AQUI
```
## 4. Ejecutar la Aplicación

#### A)  En IntelliJ IDEA, despliega la carpeta src/main/java hasta encontrar la clase principal (normalmente llamada MarketplaceApplication.java).

#### B) Haz clic derecho sobre el archivo y selecciona Run 'MarketplaceApplication'.

#### C) Espera a que la consola termine de cargar. Cuando veas un mensaje indicando que Tomcat inició en el puerto 8080, abre tu navegador web y visita: http://localhost:8080

# Autores del Proyecto:

### - Juan Gabriel Díaz Hernández

### - Gabriel Kenyiro Hernández

### - Mauricio Laguna

## Universidad del Tolima - Profundización de la Programación Orientada a Objetos 1