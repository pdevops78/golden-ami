resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    Name = "golden-ami"
    }
}

# create an image from running instances
resource "aws_ami_from_instance" "ami-instance-image" {
  name               = "golden-ami"
  source_instance_id = aws_instance.instance.id
}