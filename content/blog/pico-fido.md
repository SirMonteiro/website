+++
title="HW security key with Rasp pico"
date="2026-05-13"
description="Detalhes sobre a criação de uma chave FIDO a partir de um RP2350"
[taxonomies]
tags=["hardware","project"]
+++

# HW security key with Rasp pico

Nesse post quero deixar registrado todas as descobertas e passos para a criação de uma chave de 2fa em Hardware construída a partir de um Raspberry Pi pico 2 e um firmware FOSS, implementando smart card OpenPGP, U2F e FIDO.

## Pré requisitos
- [Tenstar RP2350 USB](https://aliexpress.com/item/1005008624373149.html)
- [3D printed cover](https://www.thingiverse.com/thing:7311965) (opcional)
- Acesso a algum Linux bare metal (preferencial)

## Cover
Para a impressão do Cover, o link anexado leva a um post cujo autor fez as medições com um paquímetro do RP2040, me foi dito que o RP2350 é 0,6 mm maior, o que leva a ser necessário mudar a escala do 3D para 1.02x no fatiador
Em outro post esse autor disponibiliza um *scan* do RP2040

## Hardware

Apesar do Firmware suportar vários modelos de Hardware como Raspberry pi 1 (RP2040), ESP32 e derivados, foi escolhido o RP2350 pela presença do Secure boot e da memória One-Time programmable (OTP), possibilitando uma segurança maior a *dumps* e uso de Firmwares maliciosos.

## História
Estava a procura de um Hardware key pelo interesse no funcionamento e segurança que esse tipo de Gadget provê, pesquisando descobri o Firmware [pico-fido](https://github.com/polhenarejos/pico-fido/)o que me instigou a criar uma estrutura de segurança para minhas contas.

Assim comprei o Rasp e nesse meio tempo (meio de 2025), achei outro repo do mesmo autor que juntava as funcionalidades do FIDO + U2F com o OpenPGP, disponível em [pico-fido2](https://github.com/polhenarejos/pico-fido2/).

Porém, esse autor no final de 2025 mudou um pouco sua filosofia e decidiu dividir o Firmware em uma parte sem muito suporte FOSS e um modelo de cobrança para o commissioner de configurações que antes era disponibilizado gratuitamente no [website do projeto](https://www.picokeys.com/), inclusive pediu a remoção manual dessa página no Internet Archive. Junto com o configurador ele removeu todo o histórico da árvore de commits do repositório da junção dos projetos o que me levou a tomar algumas iniciativas.
- Não confiar na chave de assinatura do Firmware e consequentemente nas possíveis ações futuras do autor original em relação às filosofias;
- Achar um Fork antes da remoção e dar continuidade com as atualizações;
- Criar um modo fácil de compilar com minha chave privada para manter as chaves.

## Software

Foi feito o *fork* a partir do [commit do repositório](https://github.com/IsayIsee/pico-fido2/commit/d70c20c63aeaf8321575747a63d08418ff348ef6) logo antes da árvore ser reescrita, a partir disso foi atualizado os submódulos para os seus respectivos *main*s e então modificado os arquivos para passar a compilar para a última versão *nightly* que na data de hoje 2026-05-13 estão nas versões pico-fido v7.6-4, pico-keys-sdk v3.2-623 e pico-openpgp v4.6-4.

Parti da premissa que quero ter um repositório para gerenciar o Firmware com a minha compilação enquanto utilizo os repositórios originais para os últimos patches das implementações individuais, assim há os submódulos pelo git importados ao mesmo tempo que há algumas modificações minhas em forma de *patches*.

Os Patches incluem o seguinte:
- Aumentado o padrão mínimo de PIN de 4 para 8 caracteres
- Trocado o AAGUID para ser reconhecido como YubiKey 5 (USB-A, No NFC), que parece fazer mais sentido com o Hardware do Raspberry Pi. [tabela dos AAGUIDs da Yubico](https://support.yubico.com/s/article/YubiKey-hardware-FIDO2-AAGUIDs)
- Trocado o AID do OpenPGP para ser reconhecido como YubiKey, como encontrado em um [commit de um fork](https://github.com/polhenarejos/pico-openpgp/commit/90dfb75cc5990a624a7fb7550bc24d4332771b77)
- Descriptor USB para ser reconhecido como YubiKey 5 e caso habilitado redirecionar WebUSB para https://pico.gabrielsouza.top (não possui nada, mas decidi mudar para caso tenha alguma funcionalidade no futuro)
- Regras mais rígidas para criação de PIN, discutido em uma [issue](https://github.com/polhenarejos/pico-fido/issues/187) e listado como um dos diferenciais do [Token2](https://www.token2.com/pico), as regras estão listadas na página [PIN complexity in action](https://www.token2.com/site/page/token2-fido2-pin-see-the-pin-complexity-in-action), porém deixei o mínimo de caracteres alfanuméricos em 8 ao invés de 10

Para facilitar a compilação foi feito um script run_all.sh para a criação das chaves de assinatura do boot a partir do script keygen.sh, depois da criação ele não sobrescreve outras chaves! e rodar os patches.

A compilação pelo Arch Linux funciona dessa maneira:

```sh
sudo pacman -Sy --needed base-devel openssl git cmake arm-none-eabi-gcc arm-none-eabi-newlib

git clone --depth 1 https://github.com/raspberrypi/pico-sdk
cd pico-sdk
git submodule update --init --recursive
cd ..
git clone --depth 1 https://github.com/sirmonteiro/pico-fido2
cd pico-fido2
./run_all.sh
./build_pico_fido2.sarchh
```

Os arquivos .uf2 estarão disponíveis em "release/". Importante salvar o par de chaves ec_public_key.pem e ec_private_key.pem pois após ativar o secure boot apenas Firmwares compilados com eles vão dar boot.

## Gerenciar o RP2350 (picotool)

Para gerenciar o Raspberry Pi Pico no modo de BOOTSEL, instale o picotool.

No Arch Linux rode:
```sh
paru -S picotool
```

em outras distribuições:

```sh
curl -qL https://github.com/raspberrypi/pico-sdk-tools/releases/download/v2.2.0-3/picotool-2.2.0-a4-x86_64-lin.tar.gz | tar --strip-components=1 -xvzf - picotool/picotool
chmod +x picotool
mkdir -p ~/.local/bin
mv picotool ~/.local/bin
export PATH=~/.local/bin:$PATH
```

## Programas

Após instalação é possível configurar a luminosidade do LED, timeout na espera do click, etc. Para isso instale o [picoforge](https://github.com/librekeys/picoforge).

No Arch linux com o seguinte comando:

```sh
paru -S picoforge-git
```

Em outras distribuições instale com Flatpak:

```sh
flatpak install flathub in.suyogtandel.picoforge
```

É possível fazer o gerenciamento da chave com o [fido2-manage](https://github.com/token2/fido2-manage) to token2 ou com os patches da Yubico com o [yubico-authenticator](https://www.yubico.com/products/yubico-authenticator/)

## Configurar Yubico OTP

Pelo Yubico authentication vá em Slots e seleciona um desejado, no canto direito selecione Yubico OTP, clique em cada um dos botões na direita dos campos e anote os valores gerados e salva.
Anote também o S/N disponível no canto esquerdo superior.

vá para [Yubico upload](https://upload.yubico.com/), preencha com o anotado e no último campo "OTP from YubiKey" clica ou segure no botão de ação (boot) e *submita* o formulário.

Teste em [demo Yubico verify](https://demo.yubico.com/otp/verify).

## Segurança

Do que conversei com o João durante a Cryptorave 2026, ele participou da DEF CON 2024 que a Raspberry Foundation propôs o [desafio de quebrar a segurança do RP2350](https://www.raspberrypi.com/def-con-2024-challenge/) me disse que apesar de existir meios de burlar totalmente o Hardware, é exigido um nível de especialidade e equipamento que poucos conseguem chegar, chegando assim num nível que considero totalmente plausível a utilização!

Para ativar a segurança total, é necessário habilitar o secure boot e desabilitar todas as portas DEBUG do chip. Como referência, os comandos a seguir foram tirados do repositório:
https://github.com/raspberrypi/rp2350_hacking_challenge
### Secure boot

Dentro da pasta do pico-fido2, depois de já ter feito o backup corretamente do par de chaves, rode

```sh
picotool otp load build_release/pico_fido2.otp.json
```

Esse comando irá ativar o Secure boot permanentemente no Rasp, a partir desse momento o núcleo RISC-V estará permanentemente desativado e apenas irá iniciar com Firmwares assinados com as chaves anotadas.

### Desabilitar Debug e habilitar proteções anti fault injection

Lembrando que esses comandos são permanentes e devem ser rodados após habilitar o secure boot como instruídos no repositório.

```sh
# Disable debugging features
picotool otp set OTP_DATA_CRIT1.DEBUG_DISABLE 1
# Disable other boot keys
picotool otp set OTP_DATA_BOOT_FLAGS1.KEY_INVALID 0xe
# Enable glitch detector
picotool otp set OTP_DATA_CRIT1.GLITCH_DETECTOR_ENABLE 1
# Highest sensitivity
picotool otp set OTP_DATA_CRIT1.GLITCH_DETECTOR_SENS 3
```

## Problemas com o Raspberry Pi pico

Caso aconteça algum tipo de problema, ou deseje limpar totalmente a memória excluindo todo o programa e todas as chaves, entre no modo BOOTSEL segurando o botão boot ao inserir e coloque o .uf2 [nuke](https://pip.raspberrypi.com/documents/RP-008273-DS-flash_nuke.zip) da própria [Raspberry Foundation](https://www.raspberrypi.org/)

## Testes
Para testar os protocolos U2F e FIDO é possível usar demos de registros e logins disponíveis no [awesome-webauthn](https://github.com/yackermann/awesome-webauthn)
