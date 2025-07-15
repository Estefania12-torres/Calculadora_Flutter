# Calculadora_Flutter
Una aplicación de calculadora multifuncional desarrollada con Flutter, que ofrece operaciones matemáticas básicas, conversión de unidades, cálculo de subredes IPv4 y conversión de divisas. Diseñada con una interfaz de usuario limpia y responsiva, esta aplicación es una herramienta versátil para diversas necesidades de cálculo.
<img width="417" height="553" alt="imagen" src="https://github.com/user-attachments/assets/0130c42a-baeb-4148-9260-c248142e641d" />

Barra Lateral

<img width="417" height="561" alt="imagen" src="https://github.com/user-attachments/assets/cb411120-efb8-4e25-833c-300739ad352d" />

Historial

<img width="420" height="549" alt="imagen" src="https://github.com/user-attachments/assets/bf41bfd9-e0d5-4841-83aa-e1142d309ee5" />

Conversor de Unidades de Medida

<img width="425" height="552" alt="imagen" src="https://github.com/user-attachments/assets/f4b23c7c-2d53-4bd1-ba96-44449ab66a96" />

Calculadora Basica de subredes IPv4

<img width="423" height="553" alt="imagen" src="https://github.com/user-attachments/assets/928af18c-8f73-4279-b52c-929a14ec30e5" />

Conversor de Monedas

<img width="420" height="556" alt="imagen" src="https://github.com/user-attachments/assets/28f0076b-147b-4d9d-9479-6c2e96048934" />


## Características

*   **Calculadora Básica:** Realiza operaciones aritméticas fundamentales (suma, resta, multiplicación, división).
*   **Funciones Avanzadas:** Incluye funciones como cuadrado (x²), cubo (x³) y raíz cuadrada (√).
*   **Historial de Operaciones:** Guarda y muestra un historial de los cálculos realizados.
*   **Conversor de Unidades:** Convierte entre diferentes unidades de longitud, área, volumen, tiempo, temperatura y peso.
*   **Calculadora de Subred IPv4:** Determina la dirección de red, dirección de broadcast, primera y última dirección utilizable, y el número total de hosts para una IP y máscara de subred dadas (soporta notación CIDR y máscara decimal).
*   **Conversor de Divisas:** Convierte entre una selección de monedas populares con tasas de cambio predefinidas.
*   **Diseño Intuitivo:** Interfaz de usuario limpia y fácil de usar con un tema de colores agradable.
*   **Soporte Multiplataforma:** Desarrollado con Flutter para funcionar en múltiples plataformas (aunque enfocado en web/móvil).

## Tecnologías Utilizadas

*   **Flutter:** Framework de UI de Google para construir aplicaciones compiladas de forma nativa para móvil, web y escritorio desde una única base de código.
*   **Dart:** Lenguaje de programación optimizado para UI.

## Instalación y Ejecución

Para ejecutar este proyecto localmente, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/tu-usuario/calculadora.git # Reemplaza con la URL de tu repositorio
    cd calculadora
    ```

2.  **Obtén las dependencias de Flutter:**
    ```bash
    flutter pub get
    ```

3.  **Ejecuta la aplicación:**

    *   **Para Web:**
        ```bash
        flutter run -d chrome # O tu navegador preferido
        ```
    *   **Para Android/iOS (asegúrate de tener un emulador o dispositivo conectado):**
        ```bash
        flutter run
        ```

## Uso

### Calculadora Principal

*   Ingresa números y realiza operaciones usando los botones.
*   Usa `-/+` para cambiar el signo del número.
*   Usa `.` para añadir decimales.
*   `C` limpia la pantalla y reinicia la calculadora.
*   `=` calcula el resultado final.
*   Las funciones `x²`, `x³` y `√` aplican la operación al número actual en pantalla.

### Historial

*   Accede al historial de operaciones desde el menú lateral (Drawer).

### Conversor de Unidades

*   Selecciona la categoría de unidad (Longitud, Área, Volumen, etc.).
*   Ingresa el valor a convertir.
*   Elige las unidades de origen y destino.
*   Presiona "Convertir" para ver el resultado.

### Calculadora de Subred IPv4

*   Ingresa una dirección IP (ej. `192.168.1.1`).
*   Ingresa la máscara de subred (ej. `24` para CIDR o `255.255.255.0` para máscara decimal).
*   Presiona "Calcular" para obtener los detalles de la subred.

### Conversor de Divisas

*   Ingresa la cantidad a convertir.
*   Selecciona la moneda de origen y la moneda de destino.
*   Presiona "Convertir" para ver el resultado y las tasas de cambio recíprocas.

## Estructura del Proyecto

*   `lib/main.dart`: Punto de entrada de la aplicación y configuración del tema.
*   `lib/calculator.dart`: Lógica principal y UI de la calculadora, incluyendo la navegación a otras herramientas.
*   `lib/unit_converter.dart`: Implementación del conversor de unidades.
*   `lib/ipv4_subnet_calculator.dart`: Implementación de la calculadora de subred IPv4.
*   `lib/currency_converter.dart`: Implementación del conversor de divisas.
*   `lib/colors.dart`: Definición de los colores personalizados utilizados en la aplicación.


