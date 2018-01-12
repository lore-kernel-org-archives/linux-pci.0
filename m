Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 12 Jan 2018 18:07:41 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dra7xx: Iterate over INTx status bits
Message-ID: <20180112180741.GC26438@red-moon>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229114131.22296-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 05:11:31PM +0530, Vignesh R wrote:
> It is possible that more than one legacy IRQ may be set at the same
> time, therefore iterate and handle all the pending INTx interrupts
> before clearing the status and exiting the IRQ handler. Otherwise, some
> interrupts would be lost.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied to pci/dwc for v4.16, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 892f93910012..48c6ae535847 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -257,7 +257,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	struct dra7xx_pcie *dra7xx = arg;
>  	struct dw_pcie *pci = dra7xx->pci;
>  	struct pcie_port *pp = &pci->pp;
> -	u32 reg;
> +	unsigned long reg;
> +	u32 virq, bit;
>  
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>  
> @@ -269,8 +270,11 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	case INTB:
>  	case INTC:
>  	case INTD:
> -		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
> -						    ffs(reg) - 1));
> +		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(dra7xx->irq_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
>  		break;
>  	}
>  
> -- 
> 2.15.1
> 
