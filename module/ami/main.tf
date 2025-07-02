resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    Name = "${var.component}-${var.env}-ami"
    }
}