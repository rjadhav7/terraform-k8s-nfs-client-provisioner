resource "helm_release" "nfs_client_provisioner" {
  name       = var.helm_release_name
  repository = var.helm_repository_url
  chart      = var.helm_chart_name
  version    = var.helm_chart_version

  namespace  = var.namespace
  create_namespace = var.create_namespace

  values = [
    templatefile("${path.module}/templates/helm/values.yaml.tpl", {
      replica_count    = var.replica_count
      nfs_server       = var.nfs_server
      nfs_server_path  = var.nfs_server_path
      nfs_mount_options = var.nfs_mount_options
    }),
    var.values
  ]
}
/*:resource "helm_release" "nfs_client_provisioner" {
  name       = "nfs-client-provisioner"
  #repository = data.helm_repository.nfs.metadata[0].name
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner"
  chart      = "nfs-subdir-external-provisioner"
  set {
    name  = "10.0.101.183"
    value = "/nfsshare/data"
  }
  set {
    name  = "10.0.101.183"
    value = "/nfsshare/data"
  }
}
*/

