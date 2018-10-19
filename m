Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA34ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28CA20836
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rB7iFIH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28CA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJSU2f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:28:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50086 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeJSU2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 16:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wZnGYAHUHCz6kaAnXdMQCvmtvVeP4gOuTbxu+TI1GQI=; b=rB7iFIH36td2y3uhM6UFuGhB8
        kp3cm6xf5uxw+mO5OkqG4rSYmLjaARzIV22FH8lgilWGwoapVNYNSmDMqdE8PTfkyI/10QzcuQfI3
        O2vOwvipnA81ehpEJ1rycb5KQ269jWhkHpeskcmVuPoKw6FgcoH5GGllGdNQXVM7xeeUE=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:55887)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gDTnW-00079f-6G; Fri, 19 Oct 2018 13:22:34 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gDTnT-0000JK-A0; Fri, 19 Oct 2018 13:22:31 +0100
Date:   Fri, 19 Oct 2018 13:22:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181019122228.GJ30658@n2100.armlinux.org.uk>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019120952.32763-7-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 02:09:49PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e33735ce1c14..7495d0a0aa31 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -149,9 +149,6 @@ config ARM_DMA_IOMMU_ALIGNMENT
>  
>  endif
>  
> -config MIGHT_HAVE_PCI
> -	bool
> -
>  config SYS_SUPPORTS_APM_EMULATION
>  	bool
>  
> @@ -320,7 +317,7 @@ config ARCH_MULTIPLATFORM
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_MULTI_HANDLER
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	select PCI_DOMAINS if PCI
>  	select SPARSE_IRQ
>  	select USE_OF
> @@ -436,7 +433,7 @@ config ARCH_IXP4XX
>  	select DMABOUNCE if PCI
>  	select GENERIC_CLOCKEVENTS
>  	select GPIOLIB
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	select NEED_MACH_IO_H
>  	select USB_EHCI_BIG_ENDIAN_DESC
>  	select USB_EHCI_BIG_ENDIAN_MMIO
> @@ -449,7 +446,7 @@ config ARCH_DOVE
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select GPIOLIB
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	select MVEBU_MBUS
>  	select PINCTRL
>  	select PINCTRL_DOVE
> @@ -1216,14 +1213,6 @@ config ISA_DMA
>  config ISA_DMA_API
>  	bool
>  
> -config PCI
> -	bool "PCI support" if MIGHT_HAVE_PCI
> -	help
> -	  Find out whether you have a PCI motherboard. PCI is the name of a
> -	  bus system, i.e. the way the CPU talks to the other stuff inside
> -	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
> -	  VESA. If you have PCI, say Y, otherwise N.
> -
>  config PCI_DOMAINS
>  	bool "Support for multiple PCI domains"
>  	depends on PCI
> @@ -1252,8 +1241,6 @@ config PCI_HOST_ITE8152
>  	default y
>  	select DMABOUNCE
>  
> -source "drivers/pci/Kconfig"
> -
>  source "drivers/pcmcia/Kconfig"
>  
>  endmenu
> diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
> index a545976bdbd6..b3185c05fffa 100644
> --- a/arch/arm/mach-ks8695/Kconfig
> +++ b/arch/arm/mach-ks8695/Kconfig
> @@ -4,7 +4,7 @@ menu "Kendin/Micrel KS8695 Implementations"
>  
>  config MACH_KS8695
>  	bool "KS8695 development board"
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to run on the original
>  	  Kendin-Micrel KS8695 development board.
> @@ -52,7 +52,7 @@ config MACH_CM4002
>  
>  config MACH_CM4008
>  	bool "OpenGear CM4008"
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  CM4008 Console Server. See http://www.opengear.com for more
> @@ -60,7 +60,7 @@ config MACH_CM4008
>  
>  config MACH_CM41xx
>  	bool "OpenGear CM41xx"
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  CM4016 or CM4048 Console Servers. See http://www.opengear.com for
> @@ -68,7 +68,7 @@ config MACH_CM41xx
>  
>  config MACH_IM4004
>  	bool "OpenGear IM4004"
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  IM4004 Secure Access Server. See http://www.opengear.com for
> @@ -76,7 +76,7 @@ config MACH_IM4004
>  
>  config MACH_IM42xx
>  	bool "OpenGear IM42xx"
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  IM4216 or IM4248 Console Servers. See http://www.opengear.com for
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index a68b34183107..b185794549be 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -125,7 +125,7 @@ config MACH_ARMCORE
>  	bool "CompuLab CM-X255/CM-X270 modules"
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
>  	select IWMMXT
> -	select MIGHT_HAVE_PCI
> +	select HAVE_PCI
>  	select NEED_MACH_IO_H if PCI
>  	select PXA25x
>  	select PXA27x

This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
have a bunch of platforms that mandatorily have PCI and these select
PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
menu option, but does not prevent it being selected.  Your patch will
cause Kconfig to complain for those which mandatorily have PCI but
do not set HAVE_PCI.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
