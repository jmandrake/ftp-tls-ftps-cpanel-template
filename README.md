# ftps-tls-cpanel-template
Deploy to a cPanel FTP account using explicit FTP over TLS (FTPS)

## Quick start:

1) Clone this repo and add the Github Action secrets required in the workflow yml file:

        server: ${{ secrets.FTP_HOST }}
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
        
2) Set the local and remote paths in the yaml file. 

## About the FTP settings:

This configuration file was tested successfully on a Cpanel shared hosting account from Namecheap.com.
It requires explicit FTP over TLS (FTPS) to connect to the cPanel FTP account.

I was getting an error message that said "Error: security: invalid parameter - you provided "explicit". Try "loose" or "strict" instead." when you try to run your GitHub Action.

If you want to use explicit FTP over TLS (FTPS), you can set the security parameter to strict. If you want to use implicit FTP over TLS (FTPS), you can set the security parameter to loose. So the YAML file was set with the security parameter: strict.

The yaml file looks like this:
```
name: CI/CD

on: [push]

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
        local-dir: ./
        server-dir: /
        protocol: ftps
        security: strict
        dry-run: false
```

Note: 
- I tried using $GITHUB_WORKSPACE/ for the local-dir but it didn't work. So I just used ./
- The server-dir should be whatever subfolder to upload the files to but it needs to end with a / or just use / it the ftp account's home is where you want to upload the files to.





