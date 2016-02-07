# Objective
To install Jupyter Notebook Server on `losalamos` and make it run automatically on system startup.

# Steps
1. Switch to root such that you will have correct setting when running the server as a root
2. Install Jupyter via `pip` or `Anaconda`. Please find more detail in [here](http://jupyter.readthedocs.org/en/latest/install.html). If you use `pip`, you may need run `apt-get install build-essential python-dev` prior to installation
3. Generate a configuration file and make the server public (It is optional to add a password for security concern). Please find more detail in [here](http://jupyter-notebook.readthedocs.org/en/latest/public_server.html)
4. Configure the iptables to make the port publicly accessible.
5. Write a simple script and see [here](http://stackoverflow.com/questions/7221757/run-automatically-program-on-startup-under-linux-ubuntu) to learn how to make the system run Jupyter on startup. (Maybe you need configure correct $PATH)
6. There are some arguments you may want to use, e.g. `--no-browser` and -`-config`. Run `jupyter notebook --help` for more detail.
7. Reboot and see if everything goes well.
