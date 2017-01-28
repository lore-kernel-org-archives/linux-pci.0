Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 28 Jan 2017 14:44:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
Message-ID: <20170128204407.GA20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru>
MIME-Version: 1.0
In-Reply-To: <1484265521-13497-1-git-send-email-aospan@netup.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 13, 2017 at 02:58:41AM +0300, Abylay Ospan wrote:
> Resource allocated on stack was saved by 'devm_request_resource' to
> global 'iomem_resource' but become invalid after 'iproc_pcie_bcma_probe' exit.
> So the global 'iomem_resource' was poisoned. This may cause kernel crash
> or second PCIe bridge registration failure.
> 
> Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two PCIe wifi
> adapters (b43 BCM4331 and ath10k QCA988X).
> 
> Signed-off-by: Abylay Ospan <aospan@netup.ru>

Hi Abylay, there was some follow-up discussion and I couldn't tell
what the ultimate resolution was.  Please repost this with any acks
you have if this is still necessary.

> ---
>  drivers/pci/host/pcie-iproc-bcma.c | 18 ++++++++----------
>  drivers/pci/host/pcie-iproc.h      |  2 ++
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> index bd4c9ec..28f9b89 100644
> --- a/drivers/pci/host/pcie-iproc-bcma.c
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  {
>  	struct device *dev = &bdev->dev;
>  	struct iproc_pcie *pcie;
> -	LIST_HEAD(res);
> -	struct resource res_mem;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  	}
>  
>  	pcie->base_addr = bdev->addr;
> +	INIT_LIST_HEAD(&pcie->resources);
>  
> -	res_mem.start = bdev->addr_s[0];
> -	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> -	res_mem.name = "PCIe MEM space";
> -	res_mem.flags = IORESOURCE_MEM;
> -	pci_add_resource(&res, &res_mem);
> +	pcie->res_mem.start = bdev->addr_s[0];
> +	pcie->res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> +	pcie->res_mem.name = "PCIe MEM space";
> +	pcie->res_mem.flags = IORESOURCE_MEM;
> +	pcie->res_mem.child = NULL;
> +	pci_add_resource(&pcie->resources, &pcie->res_mem);
>  
>  	pcie->map_irq = iproc_pcie_bcma_map_irq;
>  
> -	ret = iproc_pcie_setup(pcie, &res);
> +	ret = iproc_pcie_setup(pcie, &pcie->resources);
>  	if (ret)
>  		dev_err(dev, "PCIe controller setup failed\n");
>  
> -	pci_free_resource_list(&res);
> -
>  	bcma_set_drvdata(bdev, pcie);
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index 04fed8e..866d649 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -105,6 +105,8 @@ struct iproc_pcie {
>  
>  	bool need_msi_steer;
>  	struct iproc_msi *msi;
> +	struct resource res_mem;
> +	struct list_head resources;
>  };
>  
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
