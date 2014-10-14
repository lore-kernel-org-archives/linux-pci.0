Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:60191 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbaJNSZt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:25:49 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so15757142igq.10
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:25:48 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:25:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 05/18] Delayed sh setup of PCI IRQs to bus scan time
Message-ID: <20141014182545.GE10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-6-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-6-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:33AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> Currently platform specific PCI device IRQ assignment is run during
> the boot code, this results in a wide array of differing code paths
> and causes hot-plugged PCI devices to not be assigned IRQs, this
> patch removes the boot time initialisation of such IRQs and instead
> registers assignment functions to be run during the PCI device enable
> plase.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/sh/drivers/pci/fixups-cayman.c     |  2 +-
>  arch/sh/drivers/pci/fixups-dreamcast.c  |  2 +-
>  arch/sh/drivers/pci/fixups-r7780rp.c    |  2 +-
>  arch/sh/drivers/pci/fixups-rts7751r2d.c |  6 +++---
>  arch/sh/drivers/pci/fixups-sdk7780.c    |  4 ++--
>  arch/sh/drivers/pci/fixups-se7751.c     |  2 +-
>  arch/sh/drivers/pci/fixups-sh03.c       |  2 +-
>  arch/sh/drivers/pci/fixups-snapgear.c   |  2 +-
>  arch/sh/drivers/pci/fixups-titan.c      |  4 ++--
>  arch/sh/drivers/pci/pci.c               | 10 +++++++---
>  arch/sh/drivers/pci/pcie-sh7786.c       |  2 +-
>  11 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/sh/drivers/pci/fixups-cayman.c b/arch/sh/drivers/pci/fixups-cayman.c
> index edc2fb7..3246788 100644
> --- a/arch/sh/drivers/pci/fixups-cayman.c
> +++ b/arch/sh/drivers/pci/fixups-cayman.c
> @@ -5,7 +5,7 @@
>  #include <cpu/irq.h>
>  #include "pci-sh5.h"
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)

Most of this patch is just removing "__init".  Can you split it into two:
one that removes the __init annotations, and another that adds the
pcibios_root_bridge_prepare() definition?  Then the first will be obviously
correct (it should always be safe to remove the __init optimization), and
the second will be smaller and contain only the interesting part.

>  {
>  	int result = -1;
>  
> diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
> index 1d1c5a2..9d597f7 100644
> --- a/arch/sh/drivers/pci/fixups-dreamcast.c
> +++ b/arch/sh/drivers/pci/fixups-dreamcast.c
> @@ -76,7 +76,7 @@ static void gapspci_fixup_resources(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, gapspci_fixup_resources);
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	/*
>  	 * The interrupt routing semantics here are quite trivial.
> diff --git a/arch/sh/drivers/pci/fixups-r7780rp.c b/arch/sh/drivers/pci/fixups-r7780rp.c
> index 57ed3f0..2c9b58f 100644
> --- a/arch/sh/drivers/pci/fixups-r7780rp.c
> +++ b/arch/sh/drivers/pci/fixups-r7780rp.c
> @@ -15,7 +15,7 @@
>  #include <linux/sh_intc.h>
>  #include "pci-sh4.h"
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	return evt2irq(0xa20) + slot;
>  }
> diff --git a/arch/sh/drivers/pci/fixups-rts7751r2d.c b/arch/sh/drivers/pci/fixups-rts7751r2d.c
> index eaddb56..358ac10 100644
> --- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
> +++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
> @@ -20,18 +20,18 @@
>  #define PCIMCR_MRSET_OFF	0xBFFFFFFF
>  #define PCIMCR_RFSH_OFF		0xFFFFFFFB
>  
> -static u8 rts7751r2d_irq_tab[] __initdata = {
> +static u8 rts7751r2d_irq_tab[] = {
>  	IRQ_PCI_INTA,
>  	IRQ_PCI_INTB,
>  	IRQ_PCI_INTC,
>  	IRQ_PCI_INTD,
>  };
>  
> -static char lboxre2_irq_tab[] __initdata = {
> +static char lboxre2_irq_tab[] = {
>  	IRQ_ETH0, IRQ_ETH1, IRQ_INTA, IRQ_INTD,
>  };
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	if (mach_is_lboxre2())
>  		return lboxre2_irq_tab[slot];
> diff --git a/arch/sh/drivers/pci/fixups-sdk7780.c b/arch/sh/drivers/pci/fixups-sdk7780.c
> index c0a015a..24e96df 100644
> --- a/arch/sh/drivers/pci/fixups-sdk7780.c
> +++ b/arch/sh/drivers/pci/fixups-sdk7780.c
> @@ -22,7 +22,7 @@
>  #define IRQ_INTD	evt2irq(0xa80)
>  
>  /* IDSEL [16][17][18][19][20][21][22][23][24][25][26][27][28][29][30][31] */
> -static char sdk7780_irq_tab[4][16] __initdata = {
> +static char sdk7780_irq_tab[4][16] = {
>  	/* INTA */
>  	{ IRQ_INTA, IRQ_INTD, IRQ_INTC, IRQ_INTD, -1, -1, -1, -1, -1, -1,
>  	  -1, -1, -1, -1, -1, -1 },
> @@ -37,7 +37,7 @@ static char sdk7780_irq_tab[4][16] __initdata = {
>  	  -1, -1, -1 },
>  };
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>         return sdk7780_irq_tab[pin-1][slot];
>  }
> diff --git a/arch/sh/drivers/pci/fixups-se7751.c b/arch/sh/drivers/pci/fixups-se7751.c
> index 84a88ca..1cb8d0a 100644
> --- a/arch/sh/drivers/pci/fixups-se7751.c
> +++ b/arch/sh/drivers/pci/fixups-se7751.c
> @@ -7,7 +7,7 @@
>  #include <linux/sh_intc.h>
>  #include "pci-sh4.h"
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *, u8 slot, u8 pin)
>  {
>          switch (slot) {
>          case 0: return evt2irq(0x3a0);
> diff --git a/arch/sh/drivers/pci/fixups-sh03.c b/arch/sh/drivers/pci/fixups-sh03.c
> index 16207be..55ac1ba 100644
> --- a/arch/sh/drivers/pci/fixups-sh03.c
> +++ b/arch/sh/drivers/pci/fixups-sh03.c
> @@ -4,7 +4,7 @@
>  #include <linux/pci.h>
>  #include <linux/sh_intc.h>
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	int irq;
>  
> diff --git a/arch/sh/drivers/pci/fixups-snapgear.c b/arch/sh/drivers/pci/fixups-snapgear.c
> index 6e33ba4..a931e59 100644
> --- a/arch/sh/drivers/pci/fixups-snapgear.c
> +++ b/arch/sh/drivers/pci/fixups-snapgear.c
> @@ -19,7 +19,7 @@
>  #include <linux/sh_intc.h>
>  #include "pci-sh4.h"
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	int irq = -1;
>  
> diff --git a/arch/sh/drivers/pci/fixups-titan.c b/arch/sh/drivers/pci/fixups-titan.c
> index bd1addb..a9d563e 100644
> --- a/arch/sh/drivers/pci/fixups-titan.c
> +++ b/arch/sh/drivers/pci/fixups-titan.c
> @@ -19,7 +19,7 @@
>  #include <mach/titan.h>
>  #include "pci-sh4.h"
>  
> -static char titan_irq_tab[] __initdata = {
> +static char titan_irq_tab[] = {
>  	TITAN_IRQ_WAN,
>  	TITAN_IRQ_LAN,
>  	TITAN_IRQ_MPCIA,
> @@ -27,7 +27,7 @@ static char titan_irq_tab[] __initdata = {
>  	TITAN_IRQ_USB,
>  };
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	int irq = titan_irq_tab[slot];
>  
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 1bc09ee..718fae3 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -141,16 +141,20 @@ static int __init pcibios_init(void)
>  	for (hose = hose_head; hose; hose = hose->next)
>  		pcibios_scanbus(hose);
>  
> -	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
> -
>  	dma_debug_add_bus(&pci_bus_type);
> -
>  	pci_initialized = 1;
>  
>  	return 0;
>  }
>  subsys_initcall(pcibios_init);
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->map_irq = pcibios_map_platform_irq;
> +	return 0;
> +}
> +
>  /*
>   *  Called after each bus is probed, but before its children
>   *  are examined.
> diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
> index a162a7f..0167a73 100644
> --- a/arch/sh/drivers/pci/pcie-sh7786.c
> +++ b/arch/sh/drivers/pci/pcie-sh7786.c
> @@ -467,7 +467,7 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
>  	return 0;
>  }
>  
> -int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> +int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>          return evt2irq(0xae0);
>  }
> -- 
> 2.1.0
> 
