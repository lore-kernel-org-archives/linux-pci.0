Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH pci/host-iproc] pci-iproc: skip check for legacy IRQ on
 PAXC buses
To: Andy Gospodarek <gospo@broadcom.com>, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1480624492-32420-1-git-send-email-gospo@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <b8af3274-e2c5-68f8-02bd-664749d1e904@broadcom.com>
Date: Thu, 1 Dec 2016 12:37:32 -0800
MIME-Version: 1.0
In-Reply-To: <1480624492-32420-1-git-send-email-gospo@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ray Jui <rjui@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On 12/1/2016 12:34 PM, Andy Gospodarek wrote:
> PAXC and PAXCv2 buses do not support legacy IRQs so there is no reason
> to even try and map them.  Without a change like this, one cannot create
> VFs on Nitro ports since legacy interrupts are checked as part of the
> PCI device creation process.  Testing on PAXC hardware showed that VFs
> are properly created with only the change to not set pcie->map_irq, but
> just to be safe the change in iproc_pcie_setup will ensure that
> pdev_fixup_irq will not panic.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

This should be replaced Acked-by: Ray Jui <ray.jui@broadcom.com>

And this patch looks good to me. Thanks!

Ray

> ---
>  drivers/pci/host/pcie-iproc-platform.c | 9 ++++++++-
>  drivers/pci/host/pcie-iproc.c          | 5 ++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index fd3ed9b..22d814a 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -108,7 +108,14 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->map_irq = of_irq_parse_and_map_pci;
> +	/* PAXC doesn't support legacy IRQs, skip mapping */
> +	switch (pcie->type) {
> +	case IPROC_PCIE_PAXC:
> +	case IPROC_PCIE_PAXC_V2:
> +		break;
> +	default:
> +		pcie->map_irq = of_irq_parse_and_map_pci;
> +	}
>  
>  	ret = iproc_pcie_setup(pcie, &res);
>  	if (ret)
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index cd51334..3ebc025 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -1274,7 +1274,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> -	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +
> +	if (pcie->map_irq)
> +		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +
>  	pci_bus_add_devices(bus);
>  
>  	return 0;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
