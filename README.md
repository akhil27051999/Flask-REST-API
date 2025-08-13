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
    - Add VS code extension : `Git pull requests and issues`
    - clone the repository into EC2.

## Project Prerequisites

- Create a project folder and a .venv folder within:
  ```bash
  $ mkdir myproject
  $ cd myproject
  $ python3 -m venv .venv
  ```
- Activate the environment : `$ . .venv/bin/activate`
- Install Flask:
  - Within the activated environment, use the following command to install Flask: `$ pip install Flask`
- Verify the installations : `$ python3 --version`
- copy the dependencies to requirements.txt : `pip freeze > requirements.txt`
  
