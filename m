Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbdF0Wan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 18:30:43 -0400
Date: Tue, 27 Jun 2017 17:30:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek: change to use the new host bridge
 interface
Message-ID: <20170627223039.GE17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
 <1498555451-55073-2-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498555451-55073-2-git-send-email-ryder.lee@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 27, 2017 at 05:24:11PM +0800, Ryder Lee wrote:
> With the introduction of pci_scan_root_bus_bridge() there is no need to
> export pci_register_host_bridge() to other kernel subsystems other than the
> PCI compilation unit that needs it.
> 
> Make pci_register_host_bridge() static to its compilation unit and convert
> the existing drivers usage over to pci_scan_root_bus_bridge().
> 
> Also, when probing the PCI host controller driver, if an error occurs, the probe
> function code does not free memory allocated for the struct pci_host_bridge
> resulting in memory leakage.
> 
> This patch fixes them by using the methods that introduces by Lorenzo.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

I rebased my pci/host-mediatek branch on top of pci/enumeration (which
contains the series from Lorenzo), and folded this into the initial
MediaTek driver commit.

This branch:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-mediatek&id=b6ca15d18881b784dc9efc5d81989be26ecd9fc8

should have all the MediaTek bits I know about.  Can you double-check
it, please?

If all goes well, I'll incorporate this into -next tomorrow.

> ---
>  drivers/pci/host/pcie-mediatek.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index 3baafa8..514ef34 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -482,12 +482,10 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
>  	host->dev.parent = pcie->dev;
>  	host->ops = &mtk_pcie_ops;
>  
> -	err = pci_register_host_bridge(host);
> +	err = pci_scan_root_bus_bridge(host);
>  	if (err < 0)
>  		return err;
>  
> -	pci_scan_child_bus(host->bus);
> -
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  	pci_bus_size_bridges(host->bus);
>  	pci_bus_assign_resources(host->bus);
> @@ -506,7 +504,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *host;
>  	int err;
>  
> -	host = pci_alloc_host_bridge(sizeof(*pcie));
> +	host = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
>  	if (!host)
>  		return -ENOMEM;
>  
> -- 
> 1.9.1
> 
