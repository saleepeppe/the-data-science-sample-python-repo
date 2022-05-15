# the-data-science-sample-python-repo

Guido Van Beethoven:

> There is only one way to structure your shitty python code, and this is the way!

Mark Zackemberg:

> We built meth-a in this way!

Elong Mask:

> Edison invented it!

Billy Gatish

> Microsoft was written in basic only because we did not know about python!

## why?

Why not?

## ideas

The main ideas behind this template are:

- does not matter which skills you have, the scaffolding is there to help you find a way
- a repl environment for prototyping is fun and useful (if you know how to employ it)
- pip sucks, we <3 miniconda, poetry is not ready but we do not care and use it anyway
- modularity is the way, if you do not get it, it is your fault
- if you know better, we do look for pull requests :)

In short, just grab it and you are good to:

1. Prototype
2. Dev
3. Debug
4. Test
5. Deploy
6. Go back to point 1 :)

## tooling

Regarding the tooling, this is the way you go:

- **vscode** is your IDE
- **bash** can help you from time to time
- **poetry** is your package manager
- **docker**, you need it
- **docker-compose**, if you wish
- **terraform** as iac tool, if you need it
- **jupyter notebook** for prototyping, if you like it

## init

**The following command must be executed only once!**

```bash
./scripts/init.sh
```

## test template

To verify the template is working properly:

```bash
./scripts/test.sh
```

## prototype

The following command will create a docker container with a jupyter notebook exposed over the port `8890`.

```bash
docker-compose --log-level CRITICAL -f docker-compose.prototype.yml up --detach --quiet
```

## default dependecies

The source code comes with few dependencies, which believe could be useful for data science project.

[Check the pyproject file for the list.](./src/pyproject.toml)
