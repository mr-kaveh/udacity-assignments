# Set AWS as the cloud provider
provider "aws" {
  access_key = "ASIAVAR2LBDWED6BRTZW"
  secret_key = "j56eMczme25M0JfBWpu5Ayohlq4Ae59oB+YtGwhI"
  token = "FwoGZXIvYXdzEGkaDD0w585G4zMArESUUyLVAXfbzfodKoFqFlyN/IAF+qtmdBIy3MTHSCMAFFqkIWOSsassxJT23C7GEQw4Fiahn3Irvs+OMusHHPTDJMp8zsZW9XVl2V5kRhDQ9mqx5prEi7f0RVV7vVSNJYko6szMc0H9umU54cYDERGjnE1uFllR7VC/y5kwNqZjylyJFVkR/hbI6tlLVO1JBkXIUwg0kqLpkuwUW5Iyf4tSgHdtMu0OH93Ay9icbmVKvIkE0InNBiI+vPV+zp+iKaE17u09o6R/IbRkB7sdxEw7+9KQQQo6hdO60CiMht6fBjItWEvQ355D4MAZJ3ELEKfJ2Vu/xJzIkcGDKUz5fLRHGJhoZygPJq8xKgbdlQo/"
  region = "us-east-1"
}

# Use an existing VPC ID
resource "aws_instance" "udacity_t2" {
  count = 4
  ami = "ami-0dfcb1ef8550277af" # replace with your desired AMI ID
  instance_type = "t2.micro"
  #vpc_id = "vpc-0c150df0d663f565c"
  subnet_id = "subnet-06bf4642d428a9cc0" # replace with your existing public subnet ID
  tags = {
    Name = "Udacity T2"
  }
}

resource "aws_instance" "udacity_m4" {
  count = 2
  ami = "ami-0dfcb1ef8550277af" # replace with your desired AMI ID
  instance_type = "m4.large"
  #vpc_id = "vpc-0c150df0d663f565c"
  subnet_id = "subnet-06bf4642d428a9cc0" # replace with your existing public subnet ID
  tags = {
    Name = "Udacity M4"
  }
}
