Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55394 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab3A1WVv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:21:51 -0500
Message-ID: <5106F9F9.3010905@wwwdotorg.org>
Date: Mon, 28 Jan 2013 15:21:45 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> This driver implements the support for the PCIe interfaces on the
> Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
> cover earlier families of Marvell SoCs, such as Dove, Orion and
> Kirkwood.
> 
> The driver implements the hw_pci operations needed by the core ARM PCI
> code to setup PCI devices and get their corresponding IRQs, and the
> pci_ops operations that are used by the PCI core to read/write the
> configuration space of PCI devices.
> 
> Since the PCIe interfaces of Marvell SoCs are completely separate and
> not linked together in a bus, this driver sets up an emulated PCI host
> bridge, with one PCI-to-PCI bridge as child for each hardware PCIe
> interface.
> 
> In addition, this driver enumerates the different PCIe slots, and for
> those having a device plugged in, it sets up the necessary address
> decoding windows, using the new armada_370_xp_alloc_pcie_window()
> function from mach-mvebu/addr-map.c.

> diff --git a/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt b/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt

> +Mandatory properties:
> +- compatible: must be "marvell,armada-370-xp-pcie"
> +- status: either "disabled" or "okay"

status is a standard DT property; I certainly wouldn't expect its
presence to be mandatory (there's a defined default), nor would I expect
each device's binding to redefine this property.

> +In addition, the Device Tree node must have sub-nodes describing each
> +PCIe interface, having the following mandatory properties:

> +- marvell,pcie-port: the physical PCIe port number

Should the standardized cell-index property be used here instead? Or,
perhaps that property is deprecated/discouraged...

> +- status: either "disabled" or "okay"

Similar comment as above.

> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> +ccflags-$(CONFIG_PCI_MVEBU) += \
> +	-I$(srctree)/arch/arm/plat-orion/include \
> +	-I$(srctree)/arch/arm/mach-mvebu/include

That seems a little dangerous w.r.t. multi-platform zImage. Can the
required headers be moved out to somewhere more public to avoid this?

> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c

> +/*
> + * Those are the product IDs used for the emulated PCI Host bridge and
> + * emulated PCI-to-PCI bridges. They are temporary until we get
> + * official IDs assigned.
> + */
> +#define MARVELL_EMULATED_HOST_BRIDGE_ID    4141
> +#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 4242

I assume that means we can't merge this driver yet. The cover letter
mentioned a desire to merge this for 3.9; there's not much time to get
official IDs assigned, then.

> +static int mvebu_pcie_init(void)
> +{
> +	return platform_driver_probe(&mvebu_pcie_driver,
> +				     mvebu_pcie_probe);
> +}
> +
> +subsys_initcall(mvebu_pcie_init);

Why isn't that just platform_driver_register()?

> +MODULE_LICENSE("GPL");

"GPL v2".
