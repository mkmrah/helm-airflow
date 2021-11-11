provider "ibm" {
}

data "ibm_container_cluster_config" "clusterConfig" {
  cluster_name_id   = var.cluster_id
  resource_group_id = var.resource_group_id
  config_dir        = "."
}

provider "helm" {
version = "1.1.1"
  kubernetes {
    config_path = data.ibm_container_cluster_config.clusterConfig.config_file_path
  }
}

output "cluster_config_path" {
  value = data.ibm_container_cluster_config.clusterConfig.config_file_path
}


resource "random_id" "name" {
  byte_length = 4
}

resource "helm_release" "test" {
  name      = "helm-airflow-${random_id.name.hex}"
  #repository = "https://charts.bitnami.com/bitnami"
  chart      = "https://charts.bitnami.com/bitnami/airflow-11.1.7.tgz"
  #version    = "11.1.7"
  #chart      = "airflow"
  wait       = "false"
}
