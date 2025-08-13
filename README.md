## Project Installation Setup

- Launch an EC2 Instance
- Create a empty Git repository
- Connect EC2 instance with the VS Code Editor
  - Add VS code extension : `Remote SSH`
  - Edit SSH Config File
    ```yaml
    # Open or create ~/.ssh/config
    Host my-ec2-server
          HostName <EC2_PUBLIC_IP_OR_DNS>
          User ec2-user (or) ubuntu
          IdentityFile ~/path/to/my-key.pem
    ```
- Clone the empty project repository to the EC2 server
   - Add VS code extension : `Git pull requests`
   - clone the repository into EC2.

## Project Prerequisites

- Create a project folder and a .venv folder within:
  ```bash
  $ mkdir myproject
  $ cd myproject
  $ python3 -m venv .venv
  ```
- Activate the environment :
  ```bash
  . .venv/bin/activate
  ```
  
- Within the activated environment, use the following command to install Flask:
  ```bash
  pip install Flask
  ```
  
- To verify and list the installations :
  ```bash
  python3 --version && pip list
  ```
    
- copy the dependencies to requirements.txt :
  ```bash
  pip freeze > requirements.txt
  ```
  
