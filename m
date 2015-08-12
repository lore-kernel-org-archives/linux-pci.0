Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57659 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbbHLLYf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Aug 2015 07:24:35 -0400
Date: Wed, 12 Aug 2015 12:24:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <James.Morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 6/9] PCI: Drop references acquired by
 of_parse_phandle()
Message-ID: <20150812112428.GC5674@e107981-lin.cambridge.arm.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215435.9189.94410.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804215435.9189.94410.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 04, 2015 at 10:54:35PM +0100, Bjorn Helgaas wrote:
> of_parse_phandle() returns a device_node pointer with the refcount
> incremented.  We should dispose of this reference when we're finished.
> 
> Drop the reference acquired by of_parse_phandle().
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    1 +
>  drivers/pci/host/pci-xgene.c |    1 +
>  2 files changed, 2 insertions(+)

It looks fine to me:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
