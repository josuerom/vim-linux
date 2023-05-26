# Configuración básica de VIM 9.0 para Linux

Antes de continuar usted deberá tener instalado obviamente: **vim, nodejs, git y python3**.

Si es así, copie y pegue el siguiente comando en su terminal para que pueda más adelante instalarle complementos a vim

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Una vez finalice, ejecute el siguiente comando que, crea un enlace símbolico del archivo de configuración inicial
```bash
sudo ln -s ~/.vimrc ~/.config/vim/
```

Ahora abra el archivo y reemplace el contenido por este [.vimrc](https://github.com/josuerom/vim-linux/blob/main/.vimrc) que es mi archivo
```bash
git clone https://github.com/josuerom/vim-linux.git ~/.config/vim-config --depth 1 && cp  -r ~/.config/vim-config/.vimrc ~/.config/vim/
```

Abra el archivo .vimrc y edite lo que desee
```bash
vim ~/.config/vim/.vimrc
```

Instale los plugins, para ello presione la tecla : seguido escriba PlugInstall y presione enter. De la siguiente manera
> :PlugInstall

Por último, debe cerrar e iniciar vim para visualizar su nuevo aspecto.

#### Si realizó los pasos correctamente, habrá terminado con la configuración y personalización.
