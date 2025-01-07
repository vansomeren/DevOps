13. Describe a time you improved the performance of an infrastructure system. What
challenges did you face?
# Optimizing an ecommerce platform for high traffic
## Backstory
- I was managing an ecommerce platform that offered regular flash sales on items and it was being marketed across
all social media platforms. I noticed during peak hours traffic slowed down and experienced occasional timeouts during
checkout for payments.
## Challenges faced.
1. Caching issues, we exceeded our memory limits leading to resource starvation causing loss of cache entries.
2. Workers crashing due to high traffic load and some having long queues and not releasing in time.
3. Database connectivity problems, queries running slow and and experiencing transactional rollbacks.

- After a rigorous triage and point of failure analysis, I came up with the major culprits causing the issues.
1. Flask workers were just queuing the requests and not processing, this was majorly caused by high cpu usage.
2. The database design was not meant to handle such high traffic, leading to slow queries.

## Short term solution
1. Created a script which had to be run manually so as to run stalled queues and workers.
2. Increased workers from 2 to 6 to handle more concurrent requests.

# Long term solution
1. Implemented Kubernetes on the flask app and implemented HPA for the flask pods, scaling based of CPU usage.
2. Redesigned the whole database, introduced replication for write and read queries, implemented indexing, and 
implemented PgBouncer for connection pooling to prevent the Flask app from exhausting database connections during
traffic surges.
3. Introduced caching to handle frequently accessed data and set the TTL to 1 week.
4. Used celery task queue to manager long running tasks from redis, to free up the cache to run time sensitive process.

14. How do you prioritize tasks when multiple urgent issues arise?
- My approach is usually to assess the impact and severity the issues has on the business across all domains.
- Issues that cause high impact and are urgent this come first, these are tasks that directly affect mission critical system
like downtime, security, revenue, business processes e.t.c
- First step is to analyze and categories which tasks can be handled quickly the easiest to fix and release. 
- Delegate where necessary to share workload and task distribution based on strength of team members.

