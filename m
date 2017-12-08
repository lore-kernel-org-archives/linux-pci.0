Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Dec 2017 10:24:46 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: rcar: Fix use-after-free in probe error path
Message-ID: <20171208102446.GA26816@red-moon>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
 <1512641720-4715-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512641720-4715-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 07, 2017 at 11:15:19AM +0100, Geert Uytterhoeven wrote:
> If CONFIG_DEBUG_SLAB=y, and no PCIe card is inserted, the kernel crashes
> during probe on r8a7791/koelsch:
> 
>     rcar-pcie fe000000.pcie: PCIe link down
>     Unable to handle kernel paging request at virtual address 6b6b6b6b
> 
> (seeing this message requires earlycon and keep_bootcon).
> 
> Indeed, pci_free_host_bridge() frees the PCI host bridge, including the
> embedded rcar_pcie object, so pci_free_resource_list() must not be
> called afterwards.
> 
> To fix this, move the call to pci_free_resource_list() up, and update the
> label name accordingly.
> 
> Fixes: ddd535f1ea3eb27e ("PCI: rcar: Fix memory leak when no PCIe card is inserted")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/host/pcie-rcar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 12796eccb2befd91..52ab3cb0a0bfe065 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1128,12 +1128,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	err = rcar_pcie_get_resources(pcie);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request resources: %d\n", err);
> -		goto err_free_bridge;
> +		goto err_free_resource_list;
>  	}
>  
>  	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>  	if (err)
> -		goto err_free_bridge;
> +		goto err_free_resource_list;
>  
>  	pm_runtime_enable(dev);
>  	err = pm_runtime_get_sync(dev);
> @@ -1176,9 +1176,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  err_pm_disable:
>  	pm_runtime_disable(dev);
>  
> -err_free_bridge:
> -	pci_free_host_bridge(bridge);
> +err_free_resource_list:
>  	pci_free_resource_list(&pcie->resources);
> +	pci_free_host_bridge(bridge);
>  
>  	return err;
>  }
> -- 
> 2.7.4
> 
