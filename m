Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59925 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933566Ab3BLSbF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 13:31:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Tue, 12 Feb 2013 18:30:11 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201302121830.11375.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> new file mode 100644
> index 0000000..3ad563f
> --- /dev/null
> +++ b/drivers/pci/host/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> +CFLAGS_pci-mvebu.o += \
> +	-I$(srctree)/arch/arm/plat-orion/include \
> +	-I$(srctree)/arch/arm/mach-mvebu/include

This does not seem like a good idea to me. We should not include
architecture specific directories from a driver directory.

What are the header files you need here? 

> +/*
> + * This product ID is registered by Marvell, and used when the Marvell
> + * SoC is not the root complex, but an endpoint on the PCIe bus. It is
> + * therefore safe to re-use this PCI ID for our emulated PCI-to-PCI
> + * bridge.
> + */
> +#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 0x7846

Just a side note: What happens if you have two of these systems and connect
them over PCIe, putting one of them into host mode and the other into
endpoint mode?

> +static void mvebu_pcie_setup_io_window(struct mvebu_pcie_port *port,
> +				       int enable)
> +{
> +	unsigned long iobase, iolimit;
> +
> +	if (port->bridge.iolimit < port->bridge.iobase)
> +		return;
> +
> +	iolimit = 0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> +		(port->bridge.iolimitupper << 16);
> +	iobase = ((port->bridge.iobase & 0xF0) << 8) |
> +		(port->bridge.iobaseupper << 16);

I don't understand this code with the masks and shifts. Could you
add a comment here for readers like me?

> +
> +/*
> + * Initialize the configuration space of the PCI-to-PCI bridge
> + * associated with the given PCIe interface.
> + */
> +static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
> +{

As mentioned, I'm still skeptical of the sw_pci_bridge approach,
so I'm not commenting on the details of your implementations
(they seem fine on a first look though)

> +	/* Get the I/O and memory ranges from DT */
> +	while ((range = of_pci_process_ranges(np, &res, range)) != NULL) {
> +		if (resource_type(&res) == IORESOURCE_IO) {
> +			memcpy(&pcie->io, &res, sizeof(res));
> +			memcpy(&pcie->realio, &res, sizeof(res));
> +			pcie->io.name = "I/O";
> +			pcie->realio.start &= 0xFFFFF;
> +			pcie->realio.end   &= 0xFFFFF;
> +		}

The bit masking seems fishy here. What exactly are you doing,
does this just assume you have a 1MB window at most?

Maybe something like

	pcie->realio.start = 0;
	pcie->realio.end = pcie->io.end - pcie->io.start;

I suppose you also need to fix up pcie->io to be in IORESOURCE_MEM
space instead of IORESOURCE_IO, or fix the of_pci_process_ranges
function to return it in a different way.

> +static int mvebu_pcie_init(void)
> +{
> +	return platform_driver_probe(&mvebu_pcie_driver,
> +				     mvebu_pcie_probe);
> +}
> +
> +subsys_initcall(mvebu_pcie_init);

You don't have to do it, but I wonder if this could be a module
with unload support instead.

	Arnd
