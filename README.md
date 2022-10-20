# Docker-Compose #

## Explicación del docker-compose ###

    * Comienzamos el fichero de configuración de docker-compose indicando la versión de motor a utilizar (version:3.3)// Si no se añade ninguna, utiliza por defecto la más reciente.
    * Procedemos a crear los servicios:        
         * Creamos el servicio a bind9
         * Le damos un nombre al contenedor
         * Para la imagen,que es un archivo  que se e utiliza con el objetivo de ejecutar un código dentro de un contenedor, podemos descargar una externa o utilizar una propia.
         * Creamos la red para los contendores, creamos la subred y le asignamos una IP a nuestro servicio asir_bind9, que es el que funciona como DNS. Añadimos esa misma subred para asir_cliente.
         *Para asir_bin9 creamos los volumenes, que es un espacio de memoria que reservamos a archivos que nos permiten conservan los datos del contendor, aunque este se elimine.
         * Para el cliente además le añadimos las instrucciones de stdin_open: true, para abrir la consola y tty: true para mantener el contenedor en ejecución.
    * Finalmente,  teniendo una red existente le diremos a  los containers se conecten a dicha red,para indicar que es una red externa de docker lo configuramos con el external: true.

## Procedimiento de creación de servicios ##

    * Para este procedimiento, creamos el archivo de named.conf que  contiene la configuración de funcionamiento del servicio. Aquí tenemos incluidos los archivos de conf. local y options.

## Modificación de la configuración, arranque y parada de servicio bind9 ##

    * Para el archivo de named.conf.local tenemos la zona: 
        * Una declaración zone define las características de una zona tal como la ubicación de su archivo de configuración y opciones específicas de la zona. Por tanto tenemos el nombre de la zona, el nombre del archivo en el directorio de trabajo named que contiene los datos de configuración de zona y por último el tipo de zona master, que designa el servidor de nombres actual como el que tiene la autoridad para esa zona.
    
    * Para el archivo de named.conf.options tenemos:
        * La declaración options define opciones de configuración de servidor globales y configura otras declaraciones por defecto. Puede ser usado para especificar la ubicación del directorio de trabajo named, los tipos de consulta permitidos y mucho más.
        * Tenemos el directory  que especifica el directorio de trabajo named si es diferente del valor predeterminado /var/named.
        * Tenemos forwarders que especifica una lista de direcciones IP válidas para los servidores de nombres donde las peticiones se pueden reenviar para ser resueltas.

    * Para el listen-on se especifica la interfaz de red en la cual named escucha por solicitudes (por defecto todas las interfaces son usadas).
    * El allow-query especifica cuáles hosts tienen permitido consultar este servidor de nombres.

    * Para arrancar el docker-compose utilizamos en la terminal el comando docker-compose run (de no estar levantado el servicio, esto se haría con docker-compose up).
    * Para parar exclusivamente el bind9, sin parar el servicio al cliente, yendo al contendor del bind9 y pulsando stop, paramos solo este contenedor dejando en funcionamiento alpine.

## Configuración zona y como comprobar que funciona  ##

    * En este archivo tenemos la configuración de la zona :
        * Para empezar tenemos el TTL, que especifica el tiempo máximo que otros servidores DNS y aplicaciones deben mantener en caché ese registro.
        * Tenemos que configurar el SOA, que permite la descripción del servidor de nombre de dominio con autoridad en la zona (ns.asircastelao1.com), así como la dirección de correo electrónico (importante saber que el  @ equivale a un punto).
        * El NS, que es el servidor de nombres de dominio con autoridad sobre el dominio.
        * El TXT es un registro de texto que permite que el administrador de un dominio pueda introducir texto en el DNS.
        * El CNAME sirve para definir un alias para el nombre canónico. Da nombres alternativos relacionados con diferentes servicios en el mismo equipo.
        * Por último está A sirve para hacer coincidir el nombre CNAME con la dirección IP. Además, pueden existir varios registros A relacionados con diferentes equipos de la red.

    * Para comprobar que funciona, ejecutamos docker-compose exec para poder usar el comando ping desde el cliente al servidor. Una vez comprobamos que hace ping ya estaría finalizado todo el proceso del docker-compose.
