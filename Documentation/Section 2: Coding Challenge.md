7. How the prometheus exporter works 
- Connects to the RabbitMQ management API ```http://<host>:15672/api/queues```
- Periodically after ```every 30 seconds``` fetches queue information from all vhosts. 
- Updates Prometheus Gauges with queue data ```messages```, ```messages_ready```, and ```messages_unacknowledged```. 
- Finally Exposes metrics at ```port 9105``` on ```/metrics``` endpoint.

- Use the commands below to run the exporter.
```
export RABBITMQ_HOST=rabbitmq.local
export RABBITMQ_USER=adminuser
export RABBITMQ_PASSWORD=adminpass
python prometheus_exporter.py
```
8. How it laravel monitoring script works 
- Uses ```top``` to check the current CPU usage. 
- If CPU usage exceeds ```80%```, the script triggers a restart of the ```Laravel backend```. 
- Restarts the service using ```systemctl```.

- How to run the script.
`
chmod +x laravel-monitor.sh
`
9. A Postgres query is running slower than expected. Explain your approach to
troubleshooting it.
- First find out as much as possible about the query, by highlighting specific key areas such as
```query execution time```, ```indexes```, ```system performance```, ```query complexity.....```
- Run the command below on how PostgreSQL executes the query and highlights issues.
```
EXPLAIN ANALYZE <query>;
```
- Next is check if `index` have created and the queried columns are indexed, also aggregate queries and filter using `where` clause.
- use below command to list the indexes.
```
\d table_name
```
- See if the query uses indexes
```
EXPLAIN (ANALYZE) SELECT * FROM table WHERE indexed_column = 'value';
```
- Then check for locking or blocking queries
- use below command to identify locking queries
```
SELECT * FROM pg_stat_activity WHERE state = 'active';
SELECT * FROM pg_locks;
```
- Then check for active and slow queries
- See below commands to check for both
```
# Check active queries
SELECT * FROM pg_stat_activity;
#Check for slow queries
SELECT * FROM pg_stat_statements ORDER BY total_exec_time DESC;
```
10. Write a Dockerfile to containerize a Laravel application.
- Configure apache to learn laravel with clean url by create a configuration file in the `/etc/apache2/sites-available/`
- See example file below `001-laravel.conf`
```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/public

    <Directory /var/www/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
- Build the docker image
```
docker build -t laravel-app .
```
-Run the containers using Docker Compose:
```
docker-compose up -d
```
- Test application by running 
Open your browser and navigate to ``` http://localhost:8080.```


