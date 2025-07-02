# create an instance with default ami
resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    Name = "golden-ami"
    }
}

# create a provisioner to run ansible commands
resource "null_resource" "ansible" {
    connection {
        type         =  "ssh"
        user         =  "ec2-user"
        password     =  "DevOps321"
        host         =  aws_instance.instance.public_ip
        port         =  22
      }
   provisioner "remote-exec" {
    inline = [
      "sudo pip3.11 install ansible hvac"
      ]
  }
}

# create an image from running instances
resource "aws_ami_from_instance" "ami-instance-image" {
  depends_on         = [null_resource.ansible]
  name               = "golden-ami${formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())}"
  source_instance_id = aws_instance.instance.id
  lifecycle{
      ignore_changes = {
          name
          }
#       lifecycle: to stop everytime creating name based on timestamp
  }
}