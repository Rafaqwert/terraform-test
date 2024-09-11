resource "aws_instance" "ec2-terraform1" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.small"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 40
    volume_type = "gp3"
  }
  tags = {
    Name = "ec2-terraform1-separado"
  }
}