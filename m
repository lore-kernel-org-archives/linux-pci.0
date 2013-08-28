Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42210 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753130Ab3H1MOU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 08:14:20 -0400
Date: Wed, 28 Aug 2013 14:14:17 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Jason Cooper' <jason@lakedaemon.net>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Subject: Re: [PATCH 3/3] PCI: mvebu: add wrapped I/O access functions
Message-ID: <20130828141417.139ad2b0@skate>
In-Reply-To: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
References: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Seungwon Jeon,

On Wed, 28 Aug 2013 20:53:47 +0900, Seungwon Jeon wrote:
> read/write operation for I/O mem is wrapped with hiding
> base address inside in order to simplify the usage.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

I'm fine with the principle, but I have a few comments below.

> ---
>  drivers/pci/host/pci-mvebu.c |  105 +++++++++++++++++++++++++++---------------
>  1 files changed, 68 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index d66530e..db8b00b 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -141,29 +141,59 @@ struct mvebu_pcie_port {
>  	size_t iowin_size;
>  };
>  
> +static inline void mvebu_writeb(struct mvebu_pcie_port *port, u8 val, u32 reg)
> +{
> +	writeb(val, port->base + reg);
> +}
> +
> +static inline u8 mvebu_readb(struct mvebu_pcie_port *port, u32 reg)
> +{
> +	return readb(port->base + reg);
> +}

Those ones are not needed, all registers of this IP block are 32 bits
registers.

> +
> +static inline void mvebu_writew(struct mvebu_pcie_port *port, u16 val, u32 reg)
> +{
> +	writew(val, port->base + reg);
> +}
> +
> +static inline u16 mvebu_readw(struct mvebu_pcie_port *port, u32 reg)
> +{
> +	return readw(port->base + reg);
> +}

Provided a small change is done below, those will also not be needed.

> +static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> +{
> +	writel(val, port->base + reg);
> +}
> +
> +static inline u32 mvebu_readl(struct mvebu_pcie_port *port, u32 reg)
> +{
> +	return readl(port->base + reg);
> +}

Ok, but they should be called mvebu_pcie_readl() and
mvebu_pcie_writel(), because they are specific to the PCIe IP block.
Once you've done that, you'll realize that it's in fact longer to write:

	mvebu_pcie_readl(port, PCIE_FOO);

than

	readl(port->base + PCIE_FOO);

but ok, I do not oppose to the change.

>  	/* Master + slave enable. */
> -	cmd = readw(port->base + PCIE_CMD_OFF);
> +	cmd = mvebu_readw(port, PCIE_CMD_OFF);
>  	cmd |= PCI_COMMAND_IO;
>  	cmd |= PCI_COMMAND_MEMORY;
>  	cmd |= PCI_COMMAND_MASTER;
> -	writew(cmd, port->base + PCIE_CMD_OFF);
> +	mvebu_writew(port, cmd, PCIE_CMD_OFF);

I believe this can be turned into a 32 bits read/modify/write, because
the register is really a 32 bits registers, on both Armada 370/XP and
Kirkwood (I guess Dove is the same).

With this change, you can keep only the 32 bits variants of the
accessors functions at the top of the file.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
