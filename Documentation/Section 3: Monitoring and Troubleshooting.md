11. How would you set up monitoring for the React Native mobile app’s API endpoints?
- When monitoring react native mobile app one should be on ensure to have visibility into performance, availability, and errors.
- Use prometheus and grafana for server-side monitoring.
`Prometheus` will scrape API metrics and push to `grafana` for visualization and setting of alerts.
- Some the key metrics I will monitor will be `API response time`, `Error log`,`requests per second` and `success/failure rates`.
- Integrate `sentry` for front end monitoring, this will enable to get Tracks API call errors, crashes, and slow response times directly from the app
as well  as performance monitoring.
- Use firebase to Monitors latency, throughput, and network errors from the mobile app as well as identify slow endpoints affecting user experience.
- See diagram below for high level architecture
![](/Users/eriksomeren/PycharmProjects/DevOps Assessment/images/react-native-mobile-app.drawio.png)
12. Explain how you would debug high latency in the Node.js microservices.
- I would use `Prometheus` and `Grafana` to get metrics on request and response time, throughput, and service response latency.
- Check for any network issue causing latency it can be as simple as misconfigured DNS causing issue with service discovery.
- Next do a thorough code review of the application and 3rd party integration of dependencies to analyze any inefficient code running in production.
