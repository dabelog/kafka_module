resource "aws_kms_key" "kms" {
  description = "kafka_kms_key"
}

resource "aws_msk_cluster" "kafka-cluster" {
  cluster_name = var.cluster_name
  kafka_version =  var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type = var.environment == "prod" ? "kafka.m5.large" :  "kafka.t3.small"
    ebs_volume_size = 100
    client_subnets = [
      "${aws_subnet.subnet_1.id}",
      "${aws_subnet.subnet_2.id}",
      "${aws_subnet.subnet_3.id}"
    ]
    security_groups = [
      aws_security_group.kafka-cluster-sg.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
    encryption_in_transit {
       client_broker = "TLS"
       in_cluster = true
  }
}

  tags = {
    foo = "kafka-${var.environment}"
  }
}


