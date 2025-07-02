resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    Name = "golden-ami"
    }
}

# create a provisioner to run ansible commands

resource "null_resource" "provisioner" {
    connection {
        type         =  "ssh"
        user         =  "ec2-user"
        password     =  "DevOps321"
        host         =  aws_instance.component.public_ip
        port         =  22
      }
   provisioner "remote-exec" {
    inline = [
      "sudo pip3.11 install ansible hvac"
      ]
  }
}

# # create an image from running instances
# resource "aws_ami_from_instance" "ami-instance-image" {
#   name               = "golden-ami"
#   source_instance_id = aws_instance.instance.id
# }