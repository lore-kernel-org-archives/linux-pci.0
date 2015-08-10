Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:32806 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbbHJVjE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 17:39:04 -0400
Received: by ioii16 with SMTP id i16so183405218ioi.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 14:39:04 -0700 (PDT)
Date: Mon, 10 Aug 2015 16:39:00 -0500
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
	Jason Cooper <jason@lakedaemon.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 6/9] PCI: Drop references acquired by
 of_parse_phandle()
Message-ID: <20150810213900.GA9805@google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215435.9189.94410.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804215435.9189.94410.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben, Rob]

On Tue, Aug 04, 2015 at 04:54:35PM -0500, Bjorn Helgaas wrote:
> of_parse_phandle() returns a device_node pointer with the refcount
> incremented.  We should dispose of this reference when we're finished.
> 
> Drop the reference acquired by of_parse_phandle().

I cc'd everybody who wrote or signed off on 0d5a6db3aa46 ("of: pci: add
registry of MSI chips"), which added of_pci_find_msi_chip_by_node().

The existing code (before this patch) looks wrong to me, but I'm not an OF
person.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    1 +
>  drivers/pci/host/pci-xgene.c |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 70aa095..67ec5e1 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -879,6 +879,7 @@ static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
>  		return;
>  
>  	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
> +	of_node_put(msi_node);
>  
>  	if (pcie->msi)
>  		pcie->msi->dev = &pcie->pdev->dev;
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index a9dfb70..4c2fb1f 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -514,6 +514,7 @@ static int xgene_pcie_msi_enable(struct pci_bus *bus)
>  	if (!bus->msi)
>  		return -ENODEV;
>  
> +	of_node_put(msi_node);
>  	bus->msi->dev = &bus->dev;
>  	return 0;
>  }
> 
