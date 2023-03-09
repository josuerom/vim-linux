# Configuración básica de VIM 9.0 para Linux

Antes de continuar usted deberá tener instalado obviamente: *vim, nodejs y git*.

Luego copie y pegue el siguiente comando en su terminal para que pueda más adelante instalarle complementos a vim

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Una vez finalice, ejecute el siguiente comando que, crea un enlace símbolico del archivo de configuración inicial
```bash
sudo ln -s ~/.vimrc ~/.config/vim/
```

Ahora abra el archivo y reemplace el contenido por este [.vimrc](https://github.com/josuerom/vim-linux/blob/main/vim/.vimrc) que es mi archivo
```bash
cd ~/.config/vim/ && git clone https://github.com/josuerom/vim-linux.git
```

Abra el archivo .vimrc que está en ~/.config/vim/
```bash
vim .vimrc
```

Instale los plugins, para ello presione la tecla : seguido escriba PlugInstall y presione enter. De la siguiente manera
> :PlugInstall

Por último, cierre e inicie vim.

#### Si realizó todos los pasos que índique correctamente, habrá terminado con la configuración.
