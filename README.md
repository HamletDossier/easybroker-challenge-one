# Instrucciones para ejecutar el proyecto

1. Crea un archivo llamado .env y coloca la siguiente variable de entorno:
    ```env
    API_KEY=YOUR_API_KEY
    ```
    
2. Ejecuta el siguiente comando:
    ```sh
    bundle install
    ```
    
3. Ejecuta la siguiente instrucción para ejecutar el programa:
    ```sh
    ruby main.rb
    ```
    

## Ejecutar pruebas

Para ejecutar las pruebas, ejecuta el siguiente comando:
```sh
ruby test/services/easybroker_service_test.rb
```