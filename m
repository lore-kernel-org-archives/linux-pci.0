Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53791 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbcGUMFO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2016 08:05:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
	mark.rutland@arm.com, linux@armlinux.org.uk,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
Date: Thu, 21 Jul 2016 14:04:33 +0200
Message-ID: <8047226.VhgpLo8JQu@wuerfel>
In-Reply-To: <1469102276-14777-3-git-send-email-kishon@ti.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com> <1469102276-14777-3-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 21, 2016 5:27:56 PM CEST Kishon Vijay Abraham I wrote:
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 1a648e9..8e6e2c0 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -86,6 +86,7 @@ config SOC_DRA7XX
>         select OMAP_INTERCONNECT_BARRIER
>         select PM_OPP if PM
>         select ZONE_DMA if ARM_LPAE
> +       select PCI_DOMAINS if PCI
>  
>  config ARCH_OMAP2PLUS
>         bool
> 

Should we just set this unconditionally for ARCH_MULTIPLATFORM maybe?

	Arnd

