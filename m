Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:43604 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab3C0BxL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 21:53:11 -0400
Received: by mail-ve0-f179.google.com with SMTP id cz11so348060veb.10
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2013 18:53:10 -0700 (PDT)
Message-ID: <51525104.4010304@gmail.com>
Date: Tue, 26 Mar 2013 20:53:08 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFCv1 01/11] arm: mvebu: move L2 cache initialization in init_early()
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com> <1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/26/2013 11:52 AM, Thomas Petazzoni wrote:
> In preparation for moving the IRQ controller driver to
> drivers/irqchip/, we don't want the IRQ controller driver to be
> responsible for initializing the L2 cache. Instead, let's initialize
> the L2 cache at the init_early() level, like mach-exynos/common.c is
> doing.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c     |    5 +++++
>  arch/arm/mach-mvebu/irq-armada-370-xp.c |    4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 12d3655..d98a0ca 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -20,6 +20,7 @@
>  #include <linux/clk/mvebu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mbus.h>
> +#include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> @@ -72,6 +73,10 @@ void __init armada_370_xp_init_early(void)
>  			ARMADA_370_XP_MBUS_WINS_SIZE,
>  			ARMADA_370_XP_SDRAM_WINS_BASE,
>  			ARMADA_370_XP_SDRAM_WINS_SIZE);
> +
> +#ifdef CONFIG_CACHE_L2X0
> +	l2x0_of_init(0, ~0UL);
> +#endif

Have you actually tested this? I don't think the ioremap in here will
work during init_early.

Rob

>  }
>  
>  static void __init armada_370_xp_dt_init(void)
> diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
> index 6a9195e..f6699f3 100644
> --- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
> @@ -25,7 +25,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/exception.h>
>  #include <asm/smp_plat.h>
> -#include <asm/hardware/cache-l2x0.h>
>  
>  /* Interrupt Controller Registers Map */
>  #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
> @@ -292,7 +291,4 @@ static const struct of_device_id mpic_of_match[] __initconst = {
>  void __init armada_370_xp_init_irq(void)
>  {
>  	of_irq_init(mpic_of_match);
> -#ifdef CONFIG_CACHE_L2X0
> -	l2x0_of_init(0, ~0UL);
> -#endif
>  }
> 

