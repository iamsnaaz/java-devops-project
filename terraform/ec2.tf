resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2023 for ap-south-1
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.devops_key.key_name
  subnet_id              = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-SonarQube"
  }
}

output "public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}
