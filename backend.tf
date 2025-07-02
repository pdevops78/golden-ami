terraform {
  backend "s3" {
    bucket = "bucketinfo23"
    key    = "test/ami/file"
    region = "us-east-1"
      }
 }