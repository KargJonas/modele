# modele
A simple project template generator script.

### Usage
Modele consists of only one very simple `.sh` file, which copies the contents of a template folder to your current location.

The folder `templates/` contains all your templates in individual folders. You can customize the location of your templates folder by changing the `TEMPLATES_DIR` variable in the script.

By passing the name as a parameter, you can specify which template you want to generate:
```bash
$ modele your-template
```

### Installation
There's a couple ways to "install" the script but the easiest way is probably to create an alias by adding this line to your `.bashrc`:
```bash
alias modele="~/path/to/modele/modele.sh"
```

You might also need to make the script executable:
```bash
$ sudo chmod +x modele.sh
```