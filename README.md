"The Kafka Terraform file is designed to provision an Amazon Managed Streaming for Apache Kafka (MSK) cluster in AWS. This file defines the essential networking configurations required for setting up the cluster. It employs the aws_msk_cluster resource type to create an MSK cluster with the following key features:

Encryption at Rest: Utilizes a previously created AWS Key Management Service (KMS) key for securing data at rest within the MSK cluster.
Encryption in Transit: Configures transport layer security (TLS) to ensure encryption of data during transit.
The Terraform file allows for customization by specifying the cluster name, Kafka version, and the desired number of broker nodes."
