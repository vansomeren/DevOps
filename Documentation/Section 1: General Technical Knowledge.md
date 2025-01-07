
# Section 1: General Technical Knowledge
1. What are the key security concerns when it comes to DevOps?
- Developer having unchecked access to environments, especially production. This occurs when correct access is not set, push rules are not well defined and merge request rules are open to everyone, to mitigate this have clear IAM roles and RBAC policies.
- Poor code management, having hard coded credentials in the pipeline, using outdated libraries with known vulnerabilities, deploying unvalidated code into production. To solve this secure the cicd pipeline and perform regular security scan, this process can be automated.
- Poor API security, this is done through open endpoints, no rate limiting put in place and weak authentication and authorization. To secure API implement JWT as an extra layer of security and API gateway as well.
- Inadequate logging or monitoring of DevOps and infrastructure. This slows down incident response and more often can lead to missed errors. Implement centralized logging like ELK stack to monitor and alert on systems.
2. How do you design a self-healing distributed service?
- Avoid single point of failures, this is done by distributing microservices across multiple nodes, deploying services across multiple availability zones and regions as well as implementing graceful degradation.
- Continuously monitor system health to detect errors early, monitor CPU, memory, and request latency to detect failures. Implement logging and alerting as well as automated recovery incase of system failure  the system should automatically remediate itself.
- Implement production and disaster recovery sites, this will enable to setup failover mechanism and automatically route traffic to healthy regions or services.

``Self Healing Architecture Diagram``
  ![](/Users/eriksomeren/DevOps Assessment/images/Self-Healing.jpg "self-healing-architecture")
- Implement deployment strategies either ``blue-green`` or ``canary deployment`` this will help in reducing downtime.
- Implement proper documentation especially for `runbooks` and ``RCA`` for post-incident analysis.
3. Describe a centralized logging solution and you can implement logging for a
   microservice architecture.
- When implementing a centralized logging solution it must be ``scalable``, ``easy to use and understand``,
``cost efficient`` and ``offer clear visualization of all critical systems``.
through my professional and practical experience `elk stack` check all the boxes.
- Elasticsearch allows for fast querying of large log datasets.
- Logstash supports plugins for various data sources and transformations.
-  Kibana offers customizable dashboards and alerting.
4. What are some of the reasons for choosing Terraform for DevOps?
- It is very agnostic, can manage infrastructure across multiple cloud and orchestration tools
from a single configuration, no need to change syntax or approach for different cloud.
- It reduces errors on the infrastructure, through the configuration file
one can define the desired state of infrastructure and it will 
automatically determines the necessary steps to achieve that state,
also this ensures consistency across environments.
- Terraform integrates well with all CI/CD pipelines, hence automating infrastructure creation and deployments, 
and speed ups the DevOps Process.
5. How would you design and implement a secure CI/CD architecture for microservice
deployment using GitOps? Take a scenario of 20 microservices developed using
different languages and deploying to an orchestrated environment like Kubernetes.
(You can add a low-level architectural diagram)
![](/Users/eriksomeren/PycharmProjects/DevOps Assessment/images/Microservice-CICD.drawio.png)
6. You notice React Native builds are failing intermittently. What’s your debugging
process?
- I will review the full error stack trace in the build logs to identify at which point the  failure occurs.
- Run a dependency and environment check this is to ensure that from the local to production environment are running on
the same version.
- Review 3rd party environments used in the project and check for any deprecation or mismatch in the build step.
- Monitor build performance especially in the pipeline and check for any inconsistency in the stack trace log.