Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46944 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754200AbaBLVP3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 16:15:29 -0500
Date: Wed, 12 Feb 2014 22:15:26 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host
 controller
Message-ID: <20140212221526.60fd7f8b@skate>
In-Reply-To: <20140212194313.GA17248@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
	<201402092130.25615.arnd@arndb.de>
	<20140210173450.GA5554@obsidianresearch.com>
	<2006726.HhIT01YuXY@wuerfel>
	<20140212194313.GA17248@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Wed, 12 Feb 2014 12:43:13 -0700, Jason Gunthorpe wrote:

> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 2394e97..7fd54e9 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -876,14 +876,14 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
>         ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
>         if (!ret) {
>                 mem->start = reg[0];
> -               mem->end = mem->start + reg[1];
> +               mem->end = mem->start + reg[1] - 1;
>                 mem->flags = IORESOURCE_MEM;
>         }
>  
>         ret = of_property_read_u32_array(np, "pcie-io-aperture", reg, ARRAY_SIZE(reg));
>         if (!ret) {
>                 io->start = reg[0];
> -               io->end = io->start + reg[1];
> +               io->end = io->start + reg[1] - 1;
>                 io->flags = IORESOURCE_IO;
>         }
>  }

This certainly looks good.

> Fixes the wrong length (e0000000-f0000000 should be e0000000-efffffff)
> 
> And this fixes the <BAD>:
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index ef8691a..fbb89cb 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -109,7 +109,9 @@ struct mvebu_pcie {
>         struct mvebu_pcie_port *ports;
>         struct msi_chip *msi;
>         struct resource io;
> +       char io_name[30];
>         struct resource realio;
> +       char mem_name[30];
>         struct resource mem;
>         struct resource busn;
>         int nports;
> @@ -681,10 +683,29 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>         struct mvebu_pcie *pcie = sys_to_pcie(sys);
>         int i;
> +       int domain = 0;
>  
> +#ifdef CONFIG_PCI_DOMAINS
> +       domain = sys->domain;
> +#endif
> +
> +       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", domain);
> +       pcie->mem.name = pcie->mem_name;
> +
> +       snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
> +       pcie->realio.name = pcie->io_name;

I honestly don't know what PCI domains are, but this change looks
fairly harmless to me. I would however use kasprintf() instead maybe. I
can submit patches for those two changes if you want.

> Still missing release_region..

To match which request_region?

> > Since the mvebu_pcie_setup() function seems very generic at this,
> > we should probably try to factor out that code into a common
> > helper, at least for arm64, but ideally shared with arm32
> > as well.
> 
> Yah, especially since people are not getting it completely right..
> 
> But some of the trouble here is a lack of a generic pci host driver
> structure, eg I have to pull the domain number out of the ARM32
> specific structure ..

There is indeed a good deal of duplication of PCI related code in the
different architectures. The PCI_DOMAINS Kconfig option is for example
replicated in multiple architectures.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
