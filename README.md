## Pre-Installation Tools
- Launch an EC2 Instance
- Create a empty Git repository
- Connect EC2 instance with VS Code Editor
  - Add extension : `Remote SSH`
  - Edit SSH Config File
    ```yaml
    # Open or create ~/.ssh/config
    Host my-ec2-server
          HostName <EC2_PUBLIC_IP_OR_DNS>
          User ec2-user (or) ubuntu
          IdentityFile ~/path/to/my-key.pem
    ```
  - Clone the empty repository into EC2 server
    - Add extension : `Git pull requests and issues`
    - clone the repository
