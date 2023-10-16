resource "aws_elastic_beanstalk_environment" "terra-env" {
  name = "terra-bean-env"
  application = aws_elastic_beanstalk_application.terra-app
  solution_stack_name = "64bit Amazon Linux 2 v4.3.12 running Tomcat 8.5 Corretto 11"
}
