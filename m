Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 12 Jan 2018 18:07:09 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dra7xx: Fix legacy INTD IRQ handling
Message-ID: <20180112180708.GB26438@red-moon>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229114131.22296-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 05:11:30PM +0530, Vignesh R wrote:
> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
> pci-dra7xx driver following warning is seen:
> 
>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
>        error: hwirq 0x4 is too large for dummy
> 
> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
> range into the 0-3 as done in other PCIe drivers.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to pci/dwc for v4.16, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 58aed0896468..892f93910012 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -226,6 +226,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  
>  static const struct irq_domain_ops intx_domain_ops = {
>  	.map = dra7xx_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,
>  };
>  
>  static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> @@ -269,7 +270,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	case INTC:
>  	case INTD:
>  		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
> -						    ffs(reg)));
> +						    ffs(reg) - 1));
>  		break;
>  	}
>  
> -- 
> 2.15.1
> 
