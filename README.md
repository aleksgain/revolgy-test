# Revolgy Work Application Test

# [Try here! (Revolgy email address required to login)](https://revolgy.alexkri.net)

![It's honest work](https://i.redd.it/jqpuqv2uzag21.png)

This is a very simple app that records a visitor's IP address and stores it in a database. The whole point of it's existence is to demonstrate an IaC solution: 

  - Repo hosted on [GitHub](https://github.com/aleksgain)
  - Automated container builds via [DockerHub](https://hub.docker.com/r/aleksgain/revolgy-test)
  - Automated rollout to AWS via [Terraform Cloud](https://app.terraform.ioapp)
  - CDN through [CloudFlare](https://www.cloudflare.com/learning/cdn/what-is-a-cdn)
  - Access control via [CloudFlare Access](https://www.cloudflare.com/teams/access) (revolgy emails only)
  - SSL termination via [Traefik](https://traefik.io) 
  - Monitoring via [CloudWatch](https://aws.amazon.com/cloudwatch) 

# AWS Infrastructure

  - [AWS Fargate](https://aws.amazon.com/fargate) for running serverless container workload
  - [RDS](https://aws.amazon.com/rds) MySQL database for app data storage
  - [S3](https://aws.amazon.com/s3) bucket for Terrafrom state storage
  - [Application Load balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
  - [CloudWatch](https://aws.amazon.com/cloudwatch) for monitoring dashboard and logs

# Original Task

1. Develop a simple custom service that will be run later (be creative, you can use any language) or if you dont want to develop anything take any public repo with hello world service of your choice
2. Create a container for your service
3. Set up build pipeline
4. Use these services - Follow Infrastructure as code best practices
    - Kubernetes(gcp), Fargate (aws) - Application serves, could be lamdas, Virtual machines or containers
    - Database
    - API Gateway
    - Identity management (Cognito, eg. using JWT, ...)
    - Monitoring
    - Logging (access logs, using cloud watch)
5. Set up infrastructure pipeline using Terraform
6. CICD

License
----

MIT
