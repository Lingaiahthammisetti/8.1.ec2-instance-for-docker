resource "aws_instance" "ec2_instance" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.ec2_instance.instance_type
    vpc_security_group_ids = [var.allow_everything]
    user_data = file("${path.module}/install_docker_server.sh")

    root_block_device {
    volume_size = 100  # Size of the root volume in GB
    volume_type = "gp2"  # General Purpose SSD (you can change the volume type if needed)
    delete_on_termination = true  # Automatically delete the volume when the instance is terminated
    }

    tags = {
        Name = "docker-server"
    }
}
resource "aws_route53_record" "ec2_instance_r53" {
    zone_id = var.zone_id
    name    = "docker.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.ec2_instance.public_ip]
    allow_overwrite = true
}


