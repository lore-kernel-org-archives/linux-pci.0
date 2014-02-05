Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45652 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753588AbaBESml (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 13:42:41 -0500
Date: Wed, 5 Feb 2014 13:42:29 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: MVEBU: Use Device ID and revision from underlying
 endpoint
Message-ID: <20140205184229.GX8533@titan.lakedaemon.net>
References: <1391597749-29807-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391597749-29807-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 05, 2014 at 11:55:49AM +0100, Andrew Lunn wrote:
> Marvell SoCs place the SoC number into the PCIe endpoint device ID.
> The SoC stepping is placed into the PCIe revision. The old plat-orion
> PCIe driver allowed this information to be seen in user space with a
> simple lspci command.
> 
> The new driver places a virtual PCI-PCI bridge on top of these
> endpoints. It has its own hard coded PCI device ID. Thus it is no
> longer possible to see what the SoC is using lspci.
> 
> When initializing the PCI-PCI bridge, set its device ID and revision
> from the underlying endpoint, thus restoring this functionality.
> Debian would like to use this in order to aid installing the correct
> DTB file.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/pci/host/pci-mvebu.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Also, since this fixes a userspace regression:

Fixes: 45361a4fe4464 ("pci: PCIe driver for Marvell Armada 370/XP systems")
Cc: <stable@vger.kernel.org> # v3.11+

thx,

Jason.

> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13478ecd4113..0e79665afd44 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -60,14 +60,6 @@
>  #define PCIE_DEBUG_CTRL         0x1a60
>  #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
>  
> -/*
> - * This product ID is registered by Marvell, and used when the Marvell
> - * SoC is not the root complex, but an endpoint on the PCIe bus. It is
> - * therefore safe to re-use this PCI ID for our emulated PCI-to-PCI
> - * bridge.
> - */
> -#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 0x7846
> -
>  /* PCI configuration space of a PCI-to-PCI bridge */
>  struct mvebu_sw_pci_bridge {
>  	u16 vendor;
> @@ -388,7 +380,8 @@ static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
>  
>  	bridge->class = PCI_CLASS_BRIDGE_PCI;
>  	bridge->vendor = PCI_VENDOR_ID_MARVELL;
> -	bridge->device = MARVELL_EMULATED_PCI_PCI_BRIDGE_ID;
> +	bridge->device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
> +	bridge->revision = mvebu_readl(port, PCIE_DEV_REV_OFF) & 0xff;
>  	bridge->header_type = PCI_HEADER_TYPE_BRIDGE;
>  	bridge->cache_line_size = 0x10;
>  
> -- 
> 1.8.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
