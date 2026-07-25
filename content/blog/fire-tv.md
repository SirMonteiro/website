+++
title="Fire TV"
date="2026-07-24"
description="Setup do Fire TV stick, basicamente minha TV smart"
[taxonomies]
tags=["project"]
+++

# Fire TV

*tldr* - Se for comprar um Fire TV stick, dê preferencia a versão 4k e aos modelos que venham com FireOS (android) ao invés do novo sistema proprietário VEGA OS.

## Intenções
Quero descrever aqui o setup criado para assistir TV aberta, fechada, *streaming*s focando em qualidade máxima, velocidade e mais privacidade ao considerar outras soluções, ou ao Fire OS pela amazon.

### Dispositivos que testei

Testei esse método em dois dispositivos que podem ser expandidos a mais outros modelos com *Hardware* idênticos que a Amazon vendeu
- Fire TV Stick HD (3rd gen) - codinome sheldon - BR version
- Fire TV Stick 4k (2nd gen) - codinome karat - US version

A versão HD é um relançamento do Fire TV Stick Lite e recentemente a Amazon relançou a versão 4k em uma versão Fire TV Stick Plus.

Para ver as especificações e determinar os relançamentos é possível analisar o SoC pelo [site de comparação](https://developer.amazon.com/docs/device-specs/device-specifications-comparison-table.html)

Apesar de vários modelos os melhores vão ser os 4k com Android 9 ou 11, visto na tabela em "Android Version", essa conclusão é tirada do seguinte:

#### Suporte a mais codecs em resoluções maiores

Mesmo que seja instalado em alguma televisão inferior a 4k, sem HDR, ou em sistemas sem Surround, o suporte extra garante que arquivos somente 4k sejam tocados e dimensionados em 1080p como pós processamento por exemplo

Olhando na tabela comparando meus dois dispositivos dá para reparar a presença dos codecs extras de vídeo Dolby Vision e AV1 e como os outros codecs oferecem níveis de especificações mais avançados.

Se fosse para medir a importância de cada um, pode-se dizer o seguinte:

- **H.264 (ou AVC)**: é importante por ser o padrão do mercado, canais em IPTVs, e basicamente todos os streamings fornecem hoje um *fallback* nesse codec
- **H.265 (ou HEVC)**: Codec proprietário amplamente utilizado em streaming por fornecer melhor qualidade de vídeo para o mesmo bitrate, basicamente economiza banda nos servidores entregando a mesma qualidade. Como é utilizado em blu-rays, para assistir REMUX de filmes e séries novos é necessário tocar nele.
- **AV1**: Codec mais novo e de licença aberta, hoje o Youtube já amplamente utiliza ele, gasta ainda menos banda que o **HEVC** para a mesma qualidade e para mim tende a virar o próximo padrão de mercado por isso digo ser mais *future-proof* ter ele.
- **Dolby Vision**: Codec proprietário parecido com o **HEVC** com suporte diferente ao HDR, usado em filmes e séries masterizados focando nele, importante para assistir REMUX.

Importante mencionar que comprei o Fire TV Stick HD em 07/2025 e cadastrei ele em uma conta brasileira, mesmo com amplo estudo com ajuda do [Pro-me3us](https://xdaforums.com/m/pro-me3us.12131149/) não foi possível ligar o HEVC para todos os APPs, não tenho certeza, mas me parece que a [disputa judicial](https://www.tecmundo.com.br/minha-serie/600079-por-que-a-amazon-prime-video-parou-de-exibir-conteudo-em-4k-no-brasil-entenda.htm) que a Amazon se envolveu em 2024 afetou também o OS e acabei sendo afetado.

#### Hardware mais potente

Os modelos em 4k já possuem 2GB de RAM e um SoC com um CPU cortex mais forte. A questão da RAM se dá pela necessidade em geral do Android de bastante memória para multi tarefa, vai por mim, você vai querer alternar de APP de streaming mais rápido ou deixar alguma música tocando enquanto alterna entre launcher, e procura algo para assistir. A Amazon parece economizar no quesito RAM/armazenamento como pode-se ler nesse [artigo](https://www.androidauthority.com/android-tv-minimum-ram-3497217/).

Na minha experiência real, era impossível fazer *streaming* de torrent em tempo real com 1GB de RAM. No momento que alterna do APP que faria o seed do torrent para o reprodutor MPV o outro era forçado para background e era fechado pelo OOM (Out-of-Memory killer) tunado pela Amazon.

### Porque o Fire TV stick 4k?

Meu foco sempre foi deixar a sala o mais prático para assistir TV, na minha atual eu possuo uma televisão "Smart" FULLHD da Samsung de 2011, especificamente o modelo UN40D5500RG. É importante ressaltar o modelo porque descobri da pior forma o vício oculto deixado pela Samsung nesse em específico, dependendo como é manipulado o Smart dela ocorre uma corrupção na memória flash e então um *boot loop*, só consegui resolver mandando regravar a memória, nessa ocasião fui muito bem atendido na loja TV & Cia perto do Metrô Santa cecília.

Outro defeito que tinha é o som que acabou estourando as caixas, para resolver isso comprei um *Home Theater* que devo abordar as características em outro *post* descrevendo o setup completo.

Assim queria gastar o mínimo dinheiro possível com um bom dispositivo que tenha obrigatoriamente os seguintes requisitos:
- Certificação Widevine L1 com autorização do Prime video e Netflix;
- Suporte a H.265 (HEVC);
- Ser Android.
Com a experiência do Fire TV Stick HD adicionei outros:
 - Ter 2GB+ de RAM;
 - Possuir suporte dos Codecs em 4K.

O Fire TV stick 4k custando hoje em média R$250,00 com cupons no Mercado Livre não chega perto dos concorrentes. De extra ele vem com controle com IR semi programável, integrando a TV, o stick e o HT em um único controle. 

## Configuração

Modificar o dispositivo mantendo o status de original com o Widevine L1 restringe o que pode-se fazer, graças ao [Pro-me3us](https://xdaforums.com/m/pro-me3us.12131149/) em seu post [\[SYSTEM USER\] Fire Cube/Stick/TV/Tablet ≤ PS7704 \(FireOS7\) / RS8149 \(FireOS8\)](https://xdaforums.com/t/system-user-fire-cube-stick-tv-tablet-ps7704-fireos7-rs8149-fireos8.4759215/) é possível atingir um nível suficiente de modificações. O único requisito que ficou é ter a versão não superior ao título do post.

Objetivos com a modificação:
- **Remap dos botões do controle**: trocar os APPs não usados do controle por outros usados;
- **Desativar atualização**: Apesar de ser importante ter as atualizações de segurança, isso carrega junto decisões de mercado da Amazon que não agradam;
- **Desativar proteções Amazon**: A amazon adicionou com o tempo *Blacklist* de ID de APPs que podem ser colocados em *sideload* (fora da loja oficial);
- **Desativar telemetria**: Desligar o máximo de informações coletadas e enviadas por telemetria, incluindo o [ACR](https://en.wikipedia.org/wiki/Automatic_content_recognition) (Reconhecimento automático de conteúdo);
- **Desativar ADs**: Várias medidas para fugir do máximo de anúncios possíveis, incluindo *launcher*, Youtube, navegação WEB, etc;
- **Aceleração do sistema**: Deixar mais ciclos de CPU e mais RAM para ser utilizados pelos serviços em *Foreground*;
- **Remoção de Bloatware**: Desativar vários componentes adicionais de serviços não utilizados afim de atingir os outros objetivos.

### Configuração inicial

A Amazon obriga atrelar o Fire TV a uma conta, porém em *background* é executado as atualizações, como a gente não quer, temos que fazer um *setup* de rede temporário que seja suficiente para cadastrar e chegar a tela inicial, mas não seja suficiente para atualizar.

Para isso peguei meu notebook com Linux, pluguei ele no cabo de rede e usei a placa wi-fi para criar um *Hotspot* configurável, com os seguinte comandos:

```sh
sudo nmcli device wifi hotspot ifname wlan0 ssid "laptop" password "lapt1234" con-name "Hotspot"
sudo wondershaper -a wlan0 -d 1024 -u 1024
sudo iw reg set US
```

Para descobrir o nome da placa no sistema pode Executar o seguinte comando:

```sh
ip a | grep wl | head -n1 | cut -d: -f2
```


No meu caso queria cadastrar ele no US na tentativa de evitar qualquer possível restrição regional, por isso rodei o último comando para "setar" o wi-fi para o US, nesse caso estava usando uma VPN de Miami no momento. Adicionalmente, alterei a região nas [preferências](https://www.amazon.com.br/hz/mycd/preferences/myx#/home/settings/payment) e "Dispositivos e conteúdo" da conta para os Estados Unidos e adicionei o endereço principal como um de lá.

Outra forma é fazer o método pelo roteador como descrito pelo [comentário](https://xdaforums.com/t/system-user-fire-cube-stick-tv-tablet-ps7704-fireos7-rs8149-fireos8.4759215/page-28#post-90314443) feito pelo Pro-me3us.

Um detalhe importante é ter um *kill-switch* fácil desse Hotspot, para desconectar e conectar a internet. O método que irei seguir e traduzir aqui foi do [AFTVnews](https://www.aftvnews.com/how-to-skip-software-updates-during-initial-setup-or-factory-reset-on-a-fire-tv-firestick-or-fire-tv-cube/). Para chegar na tela inicial faça os seguintes passos:
- Configure idioma e conecte no *Hotspot*;
- Quando começar a procurar atualizações, desligue a internet;
- Quando der um erro de conexão de rede, segure os botões de voltar e menu do controle ao mesmo tempo até abrir o "VoiceView", depois clique no botão voltar, você deve estar na tela de login da Amazon.
- Conecte novamente a internet e coloque o login com o usuário e senha, após logar e ir para o próximo passo desligue a internet novamente.
- Termine de configurar pulando todas as próximas configurações possíveis, elas estão todas disponíveis nas configurações do sistema.

Agora você deve estar no menu inicial com a rede do Hotspot sem internet, isso é ótimo, podemos começar a executar comandos para desligar as atualizações e poder conectar na rede principal de casa.

Vá para as configurações, "My Fire TV->about" e clique 7 vezes em "Fire TV Stick..." até se tornar desenvolvedor, volte para "My Fire TV" e nas opções de desenvolvedor ligue o "ADB debugging".

Volte em configurações, "My Fire TV->about->Network" e anote o IP Address.

Agora no computador baixe o último [LM](https://xdaforums.com/attachments/lm_1-1-9-apk.6309327/) no post "SYSTEM USER" e execute os seguintes comandos:

```sh
adb connect <IP Address>
adb install <lm.apk>
adb shell pm grant com.wolf.tn android.permission.WRITE_SECURE_SETTINGS
```

Abra o APP instalado (launcher manager) e desligue as opções "OTA App", "ADEP App" e "ARCUS App", deixando-os com descrição verde. Quando esse APP é aberto a cada *reboot* é possível acessar o shell do stick como usuário system com o seguinte comando que devemos executar agora:

```sh
adb shell
toybox nc localhost 9060
```

e finalmente para desativar o último APP de atualização que hoje o launcher manager ainda não desabilita no Fire OS 8:

```sh
pm disable com.amazon.tv.forcedotaupdater.v2
```

A partir desse momento já é possível conectar ao wifi principal, mas recomendo executar os comandos da próxima seção.

### Configurações em shell

Nessa seção deixarei os comandos que executei no `adb shell` para fazer *debloat* (remover bloatware), acelerar animações, desativar telemetria, etc

Em nível de usuário shell, como pode ser visto executando o comando `whoami` executei o seguinte:

```sh
settings put global captive_portal_mode 0
settings put global captive_portal_fallback_url http://grapheneos.online/gen_204
settings put global captive_portal_http_url http://connectivitycheck.grapheneos.network/generate_204
settings put global captive_portal_https_url https://connectivitycheck.grapheneos.network/generate_204
settings put global captive_portal_other_fallback_urls http://grapheneos.online/generate_204
settings put global captive_portal_use_https 1
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
settings put global maxAppsOnNavBar 7
#settings put global private_dns_mode hostname
#settings put global private_dns_specifier FireTV-<ID>.dns.nextdns.io
settings put global cpuset.sched_boost 1
settings put global limit_ad_tracking 1 # Disable advertising tracking identifier
settings put global amazon:interest_based_ads 0 # Disable interest-based ad profiling
pm trim-caches 10G
```

O DNS privado é muito útil criando uma segunda camada de proteção para evitar as atualizações e telemetria, mas descobri empiricamente que no Fire OS 8 da edição 4K foi feito alguma implementação esquisita que não funciona, por isso comentei as duas linhas sobre "private_dns_", mas no Fire OS 7 é recomendável criar uma conta no [NextDNS](https://nextdns.io/) e adicionar os seguintes domínios na "Denylist":

```
paifas.amazon.com
dd6dycghj50pd.cloudfront.net
d2jmp5j6kma5v6.cloudfront.net
arcus-uswest.amazon.com
softwareupdates.amazon.com
dubri19p4y5b.cloudfront.net
amzdigitaldownloads.edgesuite.net
amzdigital-a.akamaihd.net
updates.amazon.com
d1s31zyz7dcc2d.cloudfront.net
prod.ota-cloudfront.net
```

O NextDNS cuida dos subdomínios com *wildcard* então não precisamos nos preocupar com isso.

Para *debloat* é necessário executar o próximo bloco em contexto do usuário system, então abra o launcher manager e no computador execute o `toybox nc localhost 9060` antes, verificando o usuário com o comando `whoami`:

```sh
pm disable com.amazon.device.software.ota
pm clear com.amazon.device.software.ota
pm disable com.amazon.device.software.ota.override
pm disable com.amazon.tv.forcedotaupdater.v2
pm disable-user com.amazon.sneakpeek
pm disable com.amazon.client.metrics
pm clear com.amazon.device.software.ota.override
pm clear com.amazon.tv.forcedotaupdater.v2
pm clear com.amazon.client.metrics
pm disable com.fireos.arcus.proxy
pm clear com.fireos.arcus.proxy
pm disable com.amazon.adep


# 1. Screensavers / Media Feeds / Visual Content
pm disable com.amazon.recess                   # Ambient screensaver / ads
pm disable com.amazon.bueller.photos           # Screensaver photo feed
pm disable com.amazon.bueller.music            # Music screensaver feed
pm disable com.amazon.tv.fss                   # Fire TV screensaver service
#pm disable com.amazon.ftv.xpicker              # App picker / tutorial overlay
#pm disable com.amazon.tv.ooberesource          # Out-of-box experience tutorial content
#pm disable com.amazon.ftv.profilepicker        # Profile chooser overlay

# 2. Tutorials / Onboarding / Help Overlays
pm disable com.amazon.tmm.tutorial             # Tutorial overlay / guide
pm disable com.amazon.storm.lightning.tutorial # Lightning tutorial content
pm disable com.amazon.tv.releasenotes          # Release notes viewer
pm disable com.amazon.tv.legal.notices         # Legal notices viewer
#pm disable com.amazon.sneakpeek                # Sneak peek/tutorial overlay

# 3. Optional Amazon Apps / Extras
pm disable com.amazon.hedwig                   # Fire TV News / miniTV
pm disable com.amazon.imdb.tv.android.app      # IMDb TV / Freevee
pm disable com.amazon.alexashopping            # Alexa shopping app
pm disable com.amazon.shoptv.client            # Shopping overlay app
#pm disable com.amazon.android.marketplace      # Legacy app store handler
pm disable com.amazon.minitv.android.app       # Amazon MiniTV app
pm disable amazon.jackson19                    # Deprecated internal Amazon JSON library

# 4. Non-Critical Background Services (Safe)
pm disable com.amazon.aca                      # Amazon Customer Analytics (ACA) — telemetry/usage metrics
pm disable com.amazon.ale                      # Alexa learning engine
pm disable com.amazon.dcp                      # Device Communication Platform (non-essential)
pm disable com.amazon.sync.service             # Sync service for app data (non-essential)
pm disable com.amazon.tifobserver              # TV Input Framework observer (non-critical)
pm disable com.amazon.naatyam                  # Music visualizations / promo service
pm disable com.amazon.tv.fw.metrics            # Framework metrics collector
pm disable com.amazon.securitysyncclient       # Security events sync (non-essential)
pm disable com.amazon.device.sale.service      # Retail / sales notifications
pm disable com.amazon.cardinal                 # Ads targeting engine
pm disable com.amazon.sharingservice.android.client.proxy # Share menu integration
pm disable com.amazon.kso.blackbird            # Kindle/store overlay
pm disable com.amazon.providers.contentsupport # Content provider support
pm disable com.amazon.avl.ftv                  # App verification layer (optional)
pm disable com.amazon.device.crashmanager      # Crash report uploader
pm disable com.amazon.application.compatibility.enforcer # App compatibility checker (safe)
pm disable com.ivona.tts.oem                   # Ivona TTS engine (optional)
pm disable com.android.nfc                     # NFC service (if no NFC hardware)
pm disable com.android.managedprovisioning     # Device enrollment (not used)
pm disable com.amazon.platform.fdrw            # FDRW background service
pm disable com.amazon.whisperplay.contracts    # WhisperPlay / media casting contracts
pm disable com.amazon.tv.csapp                 # TV CSApp background service
pm disable com.amazon.tahoe                    # Tahoe service
pm disable com.amazon.comms.starktachyon       # Internal comms / telemetry
pm disable com.amazon.dcp.contracts.framework.library # DCP framework lib
pm disable com.amazon.sync.provider.ipc        # Sync provider IPC

# 5. Telemetry-Heavy Packages (Amazon “Call Home” / Usage Stats)
# pm disable com.amazon.client.metrics.api       # Usage metrics / telemetry (KEEP for Equipment Control)
# pm disable com.amazon.device.metrics           # System telemetry (KEEP for Equipment Control)
# pm disable com.amazon.perfcollection           # Performance telemetry (KEEP for Equipment Control)
pm disable com.amazon.wirelessmetrics.service  # Wireless telemetry
# pm disable com.amazon.connectivitycontroller   # Network telemetry checks (KEEP for Equipment/Game Controllers)
pm disable com.amazon.net.smartconnect         # Network portal / telemetry
# pm disable com.amazon.uxcontrollerservice      # UX telemetry (KEEP for Equipment/Game Controllers)
pm disable com.amazon.uxnotification           # UX telemetry
pm disable com.amazon.fireos.usagestats.proxy  # Usage stats proxy
pm disable com.amazon.whasettings              # System metrics & analytics
pm disable com.amazon.aria                     # Analytics / diagnostics


# 6. Custom more packages
pm disable com.amazon.alta.h2clientservice     # Alta H2 client background service
pm disable com.amazon.prism.android.service    # Prism Android background service
pm disable com.amazon.whisperlink.core.android # WhisperLink core casting service
pm disable com.amazon.firebat                  # Firebat internal telemetry / diagnostics
pm disable com.amazon.whisperjoin.middleware.np # WhisperJoin networking / setup middleware
pm disable com.amazon.franktvinput             # Live TV Input framework integration
pm disable com.amazon.whad                     # Wireless Headset Audio Daemon / Bluetooth logs
pm disable com.fireos.sdk.ftve.addp            # FireOS SDK Add-on data provider
pm disable com.amazon.tv.livetv                # Live TV management service
pm disable com.amazon.shoptv.firetv.client     # Amazon live shopping app

# 7. Packages based on https://github.com/WB2024/firestrip
pm disable com.amazon.whisperplay.service.install  # WhisperPlay installer / remote app connection backend
pm disable com.amazon.tv.acr                       # Automatic Content Recognition (tracks viewing habits for ads)
pm disable com.amazon.ftvads.deeplinking           # Ads deep-linking helper (launches sponsored apps from ads)
pm disable com.amazon.hybridadidservice            # Hybrid Advertising ID service (cross-app user tracking)
pm disable com.amazon.tv.parentalcontrols          # Amazon TV parental controls
pm disable com.amznfuse.operatorredirection        # Amazon operator redirect shim

# 8. Custom
pm disable com.amazon.ods.kindleconnect
pm disable com.amazon.tv.developer.dataservice
pm disable com.amazon.audiohome
pm disable com.fireos.usagestats.proxy
pm disable com.amazon.aiondec
pm disable com.amazon.gamehub
pm disable com.amazon.device.lowstoragemanager
```

Essa lista foi feita a partir de um [tópico do XDA](https://xdaforums.com/t/debloat-list-for-os7-ps7704-5024n-fire-tv-4-series.4765581/) e recomendações de outros posts recomendações discutidas nesse outro [tópico do XDA](https://xdaforums.com/t/fire-os-8-stuck-on-black-firetv-logo.4634089/).

Caso queira habilitar algum app novamente é possível em contexto de system executar `pm enable <APP ID>`. 

### APPs de terceiros

Para aplicativos fora da loja da Amazon, estou usando a seguinte lista:

- **Launcher**: [Projectivy Launcher](https://forum.mobilism.org/viewtopic.php?f=439&t=6336684)
- **Player IPTV**: [TiviMate](https://github.com/skysolf/iptv/main/TiviMate%20%202.1.5%20-%20Premium%E4%BB%98%E8%B4%B9%E7%A0%B4%E8%A7%A3%E7%89%88.apk) com a logo disponível no [archive.org](https://ia600902.us.archive.org/27/items/tivimatebanner/TiviMate-banner.png) ou a [oficial](https://tivimate.com/logo.png)
- **Player externo**: [MPV Nova](https://github.com/Laskco/mpvNova/releases/latest/download/app-default-armeabi-v7a-release.apk)
- **Gerenciador de arquivos**: [Fluffy](https://github.com/mlm-games/Fluffy/releases/latest)
- **Organizador de media**: [Nuvio](https://github.com/NuvioMedia/NuvioTV/releases/latest/download/app-full-armeabi-v7a-release.apk)
- **Youtube**: [SmartTube](https://github.com/yuliskov/SmartTube/releases/latest)
- **Twitch**: [SmartTwitchTV](https://github.com/fgl27/SmartTwitchTV/releases/latest)
- **Anime**: (AnimeTV by Amarullz) - [old original version](https://animetv.amarullz.com/nightly) - [fork version](https://github.com/k-nacion/rc-store/releases/latest) - [fork version short link](https://tinyurl.com/AnimeTV-android)
- **VPN**: [Tailscale](https://github.com/tailscale/tailscale-android/releases/latest)

#### Uni-TV
Para assistir TV fechada, uma das formas mais conhecidas e viáveis é usando esse aplicativo. Originalmente você precisaria comprar uma TV Box com ele pré instalado, mas é possível "injetar" no armazenamento interno um dump de algum dele e fazer funcionar em qualquer Android TV, para isso é necessário um .APK dele antigo e uma .config clone de um funcional. Por motivos de segurança do processo não vou deixar disponível esses arquivos aqui, mas se me conhecer e eu tiver confiança possa ser que eu te passe no privado :)


```sh
adb shell pm uninstall com.integration.unitvsiptv
adb shell rm -f /sdcard/.config /sdcard/Android/.config /sdcard/Android/.properties
adb shell mkdir /sdcard/Alarms
adb push --sync .config /sdcard/.config
adb push --sync .config /sdcard/Android/.config
adb install UniTV_Free_5.1.0.apk
adb shell am start -n com.integration.unitvsiptv/com.interactive.brasiliptv.ui.activity.WelcomeActivity
```

#### Listas IPTV

Para assistir a vários canais brasileiros de TV aberta e canais do mundo inteiro de forma legalizada é possível achar os links das streams e compilar eles em listas. Várias comunidades fizeram scripts para ir atualizando essas listas dinamicamente, vou deixar a lista na ordem que aparece no meu player aqui:

```
https://live.hacks.tools/iptv/languages/por.m3u
https://raw.githubusercontent.com/BuddyChewChew/lg-playlist-generator/main/lg_channels_us.m3u
https://www.apsattv.com/moviearkbr.m3u
https://www.apsattv.com/olhosnatv.m3u
https://raw.githubusercontent.com/BuddyChewChew/app-m3u-generator/main/playlists/plex_us.m3u
https://raw.githubusercontent.com/BuddyChewChew/app-m3u-generator/main/playlists/plutotv_all.m3u
https://raw.githubusercontent.com/BuddyChewChew/app-m3u-generator/main/playlists/roku_all.m3u
https://raw.githubusercontent.com/BuddyChewChew/app-m3u-generator/main/playlists/samsungtvplus_all.m3u
https://raw.githubusercontent.com/BuddyChewChew/tcl-playlist-generator/main/tcl.m3u8
https://www.apsattv.com/whaletvplus_br.m3u
```

Como crédito deixo ao [BuddyChewChew](https://github.com/BuddyChewChew), e ao site [apsattv](https://www.apsattv.com/).
Em geral essas listas ou são compilados de fontes diversas ou são feitos *scraps* de serviços de TV gratuita como os canais das TVs Samsung, TCL, LG, Roku, Plex e WhaleTV. Se for para reparar todos os canais são idênticos ao encontrados nos canais com números altos integrados nessas TVs.
Para facilitar colar esses links no Fire TV é possível fazer no *shell* o seguinte comando:

```sh
adb shell input keyboard text "<URL>"
```

##### Configuração no Launcher
No Launcher que utilizo, o banner do TiviMate fica "bugado" e aparece um ícone genérico, para resolver coloco a imagem na pasta Pictures do armazenamento interno e troco manualmente, porém ele abre a interface padrão de arquivos do Android que no Fire OS não tem como interagir, então quando chego nessa tela preciso rodar os seguintes comandos na resolução Full-HD:

```sh
adb shell push TiviMate-banner.png /sdcard/Pictures
adb shell input touchscreen tap 50 25
adb shell input touchscreen tap 100 450
```

#### MPV
Para reproduzir as mídia com mais qualidade estou utilizando um fork do MPV que possibilita ter a flexibilidade dos algoritmos e configurações dele com uma interface muito boa para reproduzir. Especificamente no meu caso, estou utilizando um Home Theater da Philips antigo modelo HTS3365 que não possuí entrada óptica, assim estou entrando com a saída Line stereo direto da minha TV, porém ele possuí a tecnologia [Dolby pro Logic 2](https://en.wikipedia.org/wiki/Dolby_Pro_Logic), assim, junto com o MPV, é possível fazer *downmixing* em tempo real do que está sendo reproduzido de 5.1, 7.1 para dois canais com o cálculo necessário para tocar o *surround* no meu setup.
Por esses motivos minha configuração tem que ser feita através de um .conf e incluída na parte avançada MPV.conf do aplicativo, para isso, criei um mpv.conf com a configuração abaixo e apliquei com os seguintes comandos:

```conf
# ------------------------------------------------------------------------------
# Hardware Decoding & Video Output
# ------------------------------------------------------------------------------
vo=gpu
gpu-context=android
hwdec=mediacodec
hwdec-codecs=all
initial-audio-sync=no

# ------------------------------------------------------------------------------
# Performance / Quality Compromises
# ------------------------------------------------------------------------------
# Enables mpv's built-in fast profile to turn off heavy post-processing (like debanding)
profile=fast

# The cheapest scaling algorithms available. Firestick GPUs cannot handle heavy upscaling.
scale=bilinear
dscale=bilinear
cscale=bilinear

# Disable all heavy GPU computations
dither=no
correct-downscaling=no
linear-downscaling=no
sigmoid-upscaling=no
hdr-compute-peak=no
allow-delayed-peak-detect=yes
interpolation=no

video-sync=audio
framedrop=vo
osd-playing-msg = No profile loaded

# ------------------------------------------------------------------------------
# Network & RAM Cache Management
# ------------------------------------------------------------------------------
cache=yes
demuxer-max-bytes=100MiB
demuxer-max-back-bytes=20MiB
demuxer-readahead-secs=10

# ------------------------------------------------------------------------------
# Conditional High-Quality Upscaling
# ------------------------------------------------------------------------------
[hq-upscale]
profile-cond=width <= 1366 and height <= 768
# Reverts to the base bilinear settings if a new video exceeds the dimensions
profile-restore=copy-equal
profile-desc="High-quality upscaling for 768p or lower"

# Spline36 offers excellent upscaling quality without being as heavy as Lanczos
ascale=spline36
cscale=spline36

###### Antiring
scale-antiring=0.5
dscale-antiring=0.5
cscale-antiring=0.5

# ------------------------------------------------------------------------------
# Low-End Hardware HDR to SDR Tone-Mapping Fallback
# ------------------------------------------------------------------------------
[hdr-to-sdr]
profile-cond=video_params and (video_params["primaries"] == "bt.2020" or video_params["sig-peak"] > 1)
profile-restore=copy-equal
profile-desc="Efficient HDR to SDR Conversion for Low-End HW"

tone-mapping=clip
target-peak=203
hdr-compute-peak=no
osd-playing-msg=HDR->SDR

# ------------------------------------------------------------------------------
# Zero-RAM Caching for Local Torrent Streams
# ------------------------------------------------------------------------------
[torrent-stream]
profile-cond=path and (path:find("announce") ~= nil)
profile-restore=copy-equal
profile-desc="Disables player-side caching for torrent servers"

cache=no
demuxer-max-bytes=50MiB
demuxer-max-back-bytes=10MiB
demuxer-readahead-secs=3

# Instructs the system not to pre-fetch network blocks aggressively
cache-secs=0

# https://github.com/mpv-player/mpv/issues/2214
[dplii]
profile-cond=audio_params and audio_params["channel-count"] > 2
profile-restore = copy-equal
osd-playing-msg = ${osd-sym-cc} DolbyPLII: [${audio-params/channel-count}ch -> Downmix]
osd-duration = 3000
profile-desc="downmix surround to Dolby Pro Logic II compatible stereo"
audio-swresample-o=matrix_encoding=dplii,lfe_mix_level=1
audio-channels=stereo
```

```sh
adb shell mkdir -p /storage/emulated/0/Android/media/mpv
adb shell push mpv.conf /storage/emulated/0/Android/media/mpv
adb shell input keyboard text "include=/storage/emulated/0/Android/media/mpv/mpv.conf"
```

## Configurações e considerações finais

Após toda esse configuração acompanhado do PC volto a televisão e exploro as configurações padrões do Fire TV Stick, do Launcher manager e de todos os outros APPS logando nas contas e personalizando do jeito que prefiro deixar.
Bom, dessa forma concluo o projeto da minha TV smart na sala abordando todas as características que queria, uma forma mais barata possível de assistir e ouvir todos os tipos diferentes de mídia, envolvendo tanto *streaming*s até formas menos legais de se assistir conteúdos no Brasil, acredito que esse sistema configurado aqui supere 99% das TVs Smart vistas no mercado, possibilitando assistir praticamente todos os Filmes, séries, animes disponíveis além de praticamente todos os Canais de TV minimamente populares no Brasil e muitos abertos no mundo.