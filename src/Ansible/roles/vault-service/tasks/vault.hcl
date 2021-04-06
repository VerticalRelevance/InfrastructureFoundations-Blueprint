storage "s3" {
  bucket     = "hashicorptestingbucket"
  region         = "us-east-1"
}

listener "tcp" {
        address     = "0.0.0.0:8200"
        tls_disable = 1
}
