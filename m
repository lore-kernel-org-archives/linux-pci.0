Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33991 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbHDW6U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 18:58:20 -0400
Received: by igk11 with SMTP id 11so103271889igk.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 15:58:20 -0700 (PDT)
Date: Tue, 4 Aug 2015 17:58:12 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 7/9] PCI: xgene: Set msi_controller->dev to
 platform_device, not pci_bus
Message-ID: <20150804225812.GD17327@google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215442.9189.83038.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804215442.9189.83038.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 04, 2015 at 04:54:42PM -0500, Bjorn Helgaas wrote:
> Other users of struct msi_controller set msi->dev to the platform_device of
> the PCI host controller, not the device of the pci_bus for the root bus.
> 
> Set X-Gene's msi_controller->dev to the PCI host controller platform_device
> as other platforms do.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-xgene.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 4c2fb1f..5e0d6de 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -501,7 +501,8 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
>  	return 0;
>  }
>  
> -static int xgene_pcie_msi_enable(struct pci_bus *bus)
> +static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
> +				 struct pci_bus *bus)
>  {
>  	struct device_node *msi_node;
>  
> @@ -515,7 +516,7 @@ static int xgene_pcie_msi_enable(struct pci_bus *bus)
>  		return -ENODEV;
>  
>  	of_node_put(msi_node);
> -	bus->msi->dev = &bus->dev;
> +	bus->msi->dev = &port->dev;

Thomas, the surrounding code here and in mvebu_pcie_msi_enable() looks like
this:

  pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
  pcie->msi->dev = &pcie->pdev->dev;

It seems sort of strange to search for a struct msi_controller, then set
the "dev" field inside it.  This code isn't really the owner of the
msi_controller, and it seems like in principle at least, the
of_pci_find_msi_chip_by_node() interface could be used by several clients.
Then it's not clear which one of them should update msi->dev.

It would make more sense to me if the caller of of_pci_msi_chip_add() set
the msi->dev field.  But I don't know whether that's feasible.  I don't
even know what msi->dev is used for.

Bjorn
