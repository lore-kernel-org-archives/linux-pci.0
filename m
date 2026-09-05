Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16331F9A7;
	Sat,  5 Sep 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601658; cv=none; b=Uu8nFqZm+VHtzRSVAheHo3TPMYfN/mfJCLHZ9RMlQRlLCtIrDtNwtFBwlq/pfJfVwoIG+yHi2nz72YJeVe5l9eZMMuqtpMr+gCjAgpvBuyvek90ZDHo6Q50szpWUgJ9TWZvN7QFWypqmoygF1+ixPAr603Nr8DA2q00JIc1eZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601658; c=relaxed/simple;
	bh=DMmTUl4gZ/uo7DvUsJvpo3hiGP4KQsZvrn8UedE56Eo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TqHPIEv9iFAUV82XoMhO2Mfq7XBrykk7sXOu6WcMI/xjx2uIibqYl5qiEg+qg2NMrFk9m48gPdBts7LPRAykrUGrLkiB1R/bgyB8JNY9wTr6JqOLeuGufdC7e8hfJruOx+77xQDZ9R0hLJj+HDwvx3a6Y17I9YxX491H4gMquGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dTAqXKkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWHJ1BCX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dTAqXKkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWHJ1BCX"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 66E521D00095;
	Sat,  5 Sep 2026 05:47:33 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sat, 05 Sep 2026 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788601652;
	 x=1788688052; bh=dpIbpuQe3XyPN3n+tJb53g4BmX7xhEeASMSDssg2FAY=; b=
	dTAqXKkqNbsMLz5Eb1taMnWSkTOpzgxeXVhldlPzVcZ0WLWHEtzMPNB1PdeKUFGJ
	MHchhWXztj6eGCeLsbDR0cYavvD2ZFagYLRAcW0QlNSlf3Gup51nA+lciys1+Ov6
	vqQxRi5QDrHyNFss8k54r1iAqkv09HS5wbF9oygHn7w/2WNrzhfgntdFGhCjj0i6
	gShRmyUWmjPfLkrTdRjmQH5BS9ARYz1NkLOPcVCkOBhUWT02XE/BE9eAmtbzijrw
	m6NO851hAyCk9i3MvlRi6L1erPKqQbupzJkm+DkMcxafrzhDK/RO372lzebSB1iU
	I6JS9HCIZbV9cynsmkHDtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788601652; x=
	1788688052; bh=dpIbpuQe3XyPN3n+tJb53g4BmX7xhEeASMSDssg2FAY=; b=M
	WHJ1BCXIPKZoQSwVCSnD8C7sqXX7eM2O1dQ6FfJan/RwEdQTc+WkS49v6RPmi8S/
	xLwjZ27DhFO/M3D/btKxhgUCeEMXsgk1rKjj40kVIoRXX1yBMtIpUanqzN3cHSZh
	l/OlxTBdH0coBGM5jd7kRNzyDRHFztm8dTWBMWOJZJ08F09vtqZ5jioQCBbowMFq
	89A26cgl0Mo/VZfuAI7cccm6+Ws/iKISP63oxxqF91ogi9Uk3BxtiwFhz5lGeiss
	qw/rpE4KAKsviAhtgftKS+KEzMBfk+N+7gg+qsccCEv77vlsI+v0Kd17Ou7ZV6DY
	fLzcatpuY7vjQCXflX5Hw==
X-ME-Sender: <xms:MeWbarsUWoQ2GSCeWhBsGh06zd1YI9Sn2S4vt0CGkvBscBDIjKXSVg>
    <xme:MeWbanSp7WrjpgJoLuF4D_fUO1fOX26Qb98o0R86CK4Ye3UHbAf_LmV-WRQSyfW6l
    Hk-GSBsvQoFkgtpUHZk7d8qHpyJOMO0fttNXIfv-MUamI2SYzfVArhu>
X-ME-Proxy-Cause: dmFkZTF90JHOteLx0W4V9S2K/5fYfrTbpzrSMTBXXX2h1FHHmjqULcyNksOR8GB915SPlw
    WpoBNVJhoggW9SN8VWmCpEbGAkzooTpCYAEz5TFjApVd8+duIOGp95ns7QKsxvlbbqmrLI
    yOT4y9RWtyxZPQoQ+/xn+hYy0n/fmfv+OJ8vHp/rjTJKvsR6qsqrkPcNuB6lsItU3ZyoCV
    NXCRok1Ma/s2Z+BI/wU5ejuB/TcRqJaDr0MfvNxkq85mZracrYk//r6Q6ZGYG2m9s0BWII
    /8S1Yn1r7xqv4wMCciG9zsK9fzXYz+i4Z27q/DxL8p8KNHgM4lqCBgcYCLBJSfRvJ4n5mY
    goAMI9JTeTYMxMwaKtXIBKinyuBCwSz7ig9xjLVW+Mb6BGafDhLmoCr3HxfTdLmHNACUnI
    ayV4LFuirTkUz8YXiSuEONn+K7AygSmyrDwhOMMjK+02A9loEfaEFpRhneXkOPmwyf0+ef
    gjBvs2hrutSg906CLMwR+BGFhs4Lz6ao9ztVlcSZjpO9bheT8QohHMnU6y/LjT1BAz4YA+
    Y3C2yG+Gc/ldMc4FM8zGDseDd55jfRAtNANJHobbqIXWr5EvEB4PHDl3ZsANM5egwf6tXN
    pawECE2CLbZqLYl6uqvccfLC9POXbbj939AT+8cKzwViswDqY8sm+GcQC49A
X-ME-Proxy: <xmx:M-WbahackKEHB2UJo2suXna5S70UAmM2P97QBSdjXB124ztI75YK3A>
    <xmx:M-WbagREwckkwlNo80YpTTawsazQPWy2huNvJ7MLEwG2Q9RDrmnFpA>
    <xmx:M-WbajXtyGk15JRIBMxixUDzN_oukLjOt0MTFGVvuPfmRVW8UQ7fqA>
    <xmx:M-WbanYl2EZudRJEd2t17M-2UW2YXHlJFtEqioZM72JTmrFYXfUAkQ>
    <xmx:NOWbaqIqGhWIxj3ltFlVf7lk5HOHkNkZOBTF5BqzppQV9hDLuuy39LkO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4F63432A0078; Sat,  5 Sep 2026 05:47:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbEPZWvNmxeF
Date: Sat, 05 Sep 2026 11:46:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Message-Id: <09c4c6c8-1431-41ff-95c5-c70baa1b2214@app.fastmail.com>
In-Reply-To: <20260904231240.87106-1-breno3011alves@gmail.com>
References: <20260904231240.87106-1-breno3011alves@gmail.com>
Subject: Re: [PATCH] Kconfig: purge twenty-nine legacy ghost options
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 5, 2026, at 01:12, Breno Rodrigues Alves wrote:
> You can keep a dead config option around for a while out of sympathy.
> After a couple of releases it stops being "transitional" and starts
> being "you are confusing every user who greps for it". These options
> select nothing, gate nothing, and -- I checked by hand, this is not a
> regex accident -- are referenced by exactly nobody in the tree.

Cleaning this up seems useful, but it's not nearly as trivial
as you describe it.

Some of them do 'select' other options, either for backwards
compatibility or as the intended use. I would suggest splitting
these out into separate patches and only having a combined
cleanup patch for changes that are free of side-effects.

> -config PANEL
> -	tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"
> -	depends on PARPORT
> -	select AUXDISPLAY
> -	select PARPORT_PANEL

This change may break old defconfigs, but is probably a good idea

> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index b059d4457..94a8a0a6f 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -181,12 +181,6 @@ config COMMON_CLK_MT6765_CAMSYS
>         help
>           This driver supports MediaTek MT6765 camsys clocks.
> 
> -config COMMON_CLK_MT6765_GCESYS
> -       tristate "Clock driver for MediaTek MT6765 gcesys"
> -       depends on COMMON_CLK_MT6765
> -       help
> -         This driver supports MediaTek MT6765 gcesys clocks.
> -
...
> -config COMMON_CLK_MT6765_MIPI2BSYS
> -       tristate "Clock driver for MediaTek MT6765 mipi2bsys"
> -       depends on COMMON_CLK_MT6765
> -       help
> -         This driver supports MediaTek MT6765 mipi2bsys clocks.

I think these have come up before, the change looks correct to
me, but I'd split that up for the mediatek clk maintainers
to decide.
   Topre REALFORCE R3S 87 key keyboards.
> 
> -config HID_THINGM
> -	tristate "ThingM blink(1) USB RGB LED"
> -	depends on LEDS_CLASS
> -	select HID_LED
> -	help
> -	Support for the ThingM blink(1) USB RGB LED. This driver has been
> -	merged into the generic hid led driver. Config symbol HID_THINGM
> -	just selects HID_LED and will be removed soon.
> -
>  config HID_THRUSTMASTER
>  	tristate "ThrustMaster devices support"
>  	depends on USB_HID

There is still a comment referring to the old option, which you
should modify at the same time.

> diff --git a/drivers/interconnect/mediatek/Kconfig 
> b/drivers/interconnect/mediatek/Kconfig
> index 9fd3f2170..a7aebfa1a 100644
> --- a/drivers/interconnect/mediatek/Kconfig
> +++ b/drivers/interconnect/mediatek/Kconfig
> @@ -28,9 +28,3 @@ config INTERCONNECT_MTK_MT8195
>  	  This is a driver for the MediaTek bus interconnect on MT8195-based
>  	  platforms.
> 
> -config INTERCONNECT_MTK_MT8196
> -	tristate "MediaTek MT8196 interconnect driver"
> -	depends on INTERCONNECT_MTK_DVFSRC_EMI
> -	help
> -	  This is a driver for the MediaTek bus interconnect on MT8196-based
> -	  platforms.

Here you should look at the patch that introduced it, it
appears that there is a typo in the Makefile that you
should fix instead.

> diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
> index 8b3f2d53c..c6a97add8 100644
> --- a/drivers/media/dvb-core/Kconfig
> +++ b/drivers/media/dvb-core/Kconfig
> @@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
> 
>  	  If you are unsure about this, say N here.
> 
> -config DVB_ULE_DEBUG
> -	bool "Enable DVB net ULE packet debug messages"
> -	depends on DVB_CORE
> -	help
> -	  Enable extra log messages meant to detect problems while
> -	  handling DVB network ULE packet loss inside the Kernel.
> -
> -	  Should not be enabled on normal cases, as logs can
> -	  be very verbose.
> -
> -	  If you are unsure about this, say N here.

Same here, commit ba711e1cee75 ("media: dvb-core: allow users
to enable DVB net ULE debug") introduced a typo. Please either
fix that typo or revert the whole thing.

> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 2c7699b66..dbef2275f 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -22,12 +22,6 @@ config SDR_PLATFORM_DRIVERS
>  	help
>  	  Say Y here to enable support for platform-specific SDR Drivers.
> 
> -config DVB_PLATFORM_DRIVERS
> -	bool "DVB platform devices"
> -	depends on MEDIA_DIGITAL_TV_SUPPORT
> -	help
> -	  Say Y here to enable support for platform-specific Digital TV drivers.
> -
>  config V4L_MEM2MEM_DRIVERS
>  	bool "Memory-to-memory multimedia devices"
>  	depends on VIDEO_DEV

This was apparently used until 2282f7610736 ("media: c8sectpfe:
remove support of STi c8sectpfe driver").

> b/drivers/pci/controller/dwc/Kconfig
> index dcfbe7e22..c43b3bde5 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -121,20 +121,6 @@ config PCI_IMX6_HOST
>  	  on DesignWare hardware and therefore the driver re-uses the
>  	  DesignWare core functions to implement the driver.
> 
> -config PCI_IMX6_EP
> -	bool "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
> -	depends on ARCH_MXC || COMPILE_TEST
> -	depends on PCI_ENDPOINT
> -	select PCIE_DW_EP
> -	select PCI_HOST_COMMON
> -	select PCI_IMX6
> -	select PCI_PWRCTRL_GENERIC
> -	help
> -	  Enables support for the PCIe controller in the i.MX SoCs to
> -	  work in endpoint mode. The PCI controller on i.MX is based
> -	  on DesignWare hardware and therefore the driver re-uses the
> -	  DesignWare core functions to implement the driver.

This looks intentional and useful, something went wrong with your
validation.
> 
> @@ -900,16 +899,6 @@ config REGULATOR_MT6315
>  	  This driver supports the control of different power rails of device
>  	  through regulator interface.
> 
> -config REGULATOR_MT6316
> -	tristate "MT6316 SPMI PMIC regulator driver"
> -	depends on SPMI
> -	select REGMAP_SPMI
> -	help
> -	  Say Y here to enable support for 2+2, 3+1 and 4 phase regulators
> -	  found in the MediaTek MT6316 BP, CP, DP, HP, VP and TP SPMI PMICs.
> -	  This driver supports the control of different power rails of device
> -	  through regulator interface.
> -

Another typo, this one from a87a7b353072 ("regulator: Add
support for MediaTek MT6316 SPMI PMIC Regulators")

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 76521555e..f05eb1bb7 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -492,20 +492,6 @@ config USB_CONFIGFS_F_PRINTER
>  	  For more information, see Documentation/usb/gadget_printer.rst
>  	  which includes sample code for accessing the device file.
> 
> -config USB_CONFIGFS_F_TCM
> -	bool "USB Gadget Target Fabric"
> -	depends on TARGET_CORE
> -	depends on USB_CONFIGFS
> -	select USB_LIBCOMPOSITE
> -	select USB_F_TCM
> -	help
> -	  This fabric is a USB gadget component. Two USB protocols are
> -	  supported that is BBB or BOT (Bulk Only Transport) and UAS
> -	  (USB Attached SCSI). BOT is advertised on alternative
> -	  interface 0 (primary) and UAS is on alternative interface 1.
> -	  Both protocols can work on USB2.0 and USB3.0.
> -	  UAS utilizes the USB 3.0 feature called streams support.
> -

How is this one different from the other USB_CONFIGFS_F_* ones?

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 10cff12a3..06999ba3d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -281,20 +281,6 @@ config USB_EHCI_HCD_AT91
>  	  Enables support for the on-chip EHCI controller on
>  	  Atmel chips.
> 
> -config USB_EHCI_TEGRA
> -	tristate "NVIDIA Tegra HCD support"
> -	depends on ARCH_TEGRA
> -	select USB_CHIPIDEA
> -	select USB_CHIPIDEA_HOST
> -	select USB_CHIPIDEA_TEGRA
> -	select USB_GADGET
> -	help
> -	  This option is deprecated now and the driver was removed, use
> -	  USB_CHIPIDEA_TEGRA instead.
> -

There is a recommentation to use USB_CHIPIDEA_TEGRA, but that
one depends on CONFIG_EXPERT. Changing this needs to be
done more carefully.

> index fdc954028..e52f7cb9e 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -192,15 +192,6 @@ config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
>  config SND_SOC_TEGRA_MACHINE_DRV
>  	tristate
> 
> -config SND_SOC_TEGRA_RT5631
> -	tristate "SoC Audio support for Tegra boards using an RT5631 codec"
> -	depends on SND_SOC_TEGRA && I2C && GPIOLIB
> -	select SND_SOC_TEGRA_MACHINE_DRV
> -	select SND_SOC_RT5631
> -	help
> -	  Say Y or M here if you want to add support for SoC audio on Tegra
> -	  boards using the RT5631 codec, such as Transformer.
... 
> -config SND_SOC_TEGRA_CPCAP
> -	tristate "SoC Audio support for Tegra boards using a CPCAP codec"
> -	depends on I2C && GPIOLIB && MFD_CPCAP
> -	select SND_SOC_TEGRA_MACHINE_DRV
> -	select SND_SOC_CPCAP
> -	help
> -	  Say Y or M here if you want to add support for SoC audio on Tegra
> -	  boards using the CPCAP codec, such as Motorola Atrix 4G or Droid X2.
> -

These all look like intentional shorthand options for selecting
the correct set of drivers.

     Arnd
