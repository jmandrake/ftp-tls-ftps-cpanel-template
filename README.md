[![CI/CD](https://github.com/jmandrake/ftp-tls-ftps-cpanel-template/actions/workflows/deploy.yml/badge.svg)](https://github.com/jmandrake/ftp-tls-ftps-cpanel-template/actions/workflows/deploy.yml)


# ftps-tls-cpanel-template
Deploy files to a cPanel FTP account using explicit FTP over TLS (FTPS)

## Quick start:

1) Clone this repo and add the Github Action secrets required in the workflow file: deploy.yml

        server: ${{ secrets.FTP_HOST }}
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
        
2) Set the local and remote paths in the deploy.yml file. 



## About the FTP settings:

This configuration file was tested successfully on a Cpanel shared hosting account from Namecheap.com.
It requires explicit FTP over TLS (FTPS) to connect to the cPanel FTP account.

I was getting an error message that said "Error: security: invalid parameter - you provided "explicit". Try "loose" or "strict" instead." when you try to run your GitHub Action.

If you want to use explicit FTP over TLS (FTPS), set the security parameter to strict as shown below. If you want to use implicit FTP over TLS (FTPS), you can try setting the security parameter to loose. This YAML file is set with the security parameter: strict.

The yaml file for the Github Actions Workflow looks like this:

```
# This is a basic workflow to help you get started with Github Actions

name: CI/CD

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Deploy to cPanel FTP
      uses: SamKirkland/FTP-Deploy-Action@4.0.0
      with:
        server: ${{ secrets.FTP_HOST }}
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
        # local-dir: <local github folder -- use ./ for repository root>
        local-dir: ./
        # server-dir: <remote_dir -- use / for root>
        server-dir: /
        protocol: ftps
        security: strict
        dry-run: false

```

## Note: 
- I used ./ for the local Github repo's directory, but you should be able to use $GITHUB_WORKSPACE/
- The server-dir should be whatever subfolder to upload the files to but it needs to end with a / or just use / if the ftp account's home is where you want to upload the files to.
- This template can be used for Python, PHP, Javascript, or anything you need that has to be uploaded via FTP/TLS. The Makefile is set up for Python in this example.
- on: workflow_dispatch: This option lets you re-run jobs by just clicking a button in the Github Actions section



