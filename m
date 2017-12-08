Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 8 Dec 2017 18:35:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] PCI: dwc: pci-dra7xx: Fix legacy IRQ handling
Message-ID: <20171208183523.GB1885@e107981-ln.cambridge.arm.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-5-vigneshr@ti.com>
MIME-Version: 1.0
In-Reply-To: <20171201061311.16691-5-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Chris Welch <Chris.Welch@viavisolutions.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 01, 2017 at 11:43:11AM +0530, Vignesh R wrote:
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
> Also, iterate over all the INTx bits and call their respective IRQ
> handlers before clearing the status register.

It seems to me that you are fixing two bugs with one patch and therefore
I would ask you to split it in two or explain to me why we should
consider lumping them together.

Thanks,
Lorenzo

> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 53f721d1cc40..59e8de34cec6 100644
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
> @@ -256,7 +257,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	struct dra7xx_pcie *dra7xx = arg;
>  	struct dw_pcie *pci = dra7xx->pci;
>  	struct pcie_port *pp = &pci->pp;
> -	u32 reg;
> +	unsigned long reg;
> +	u32 virq, bit;
>  
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>  
> @@ -268,8 +270,11 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	case INTB:
>  	case INTC:
>  	case INTD:
> -		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
> -						    ffs(reg)));
> +		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(dra7xx->irq_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
>  		break;
>  	}
>  
> -- 
> 2.15.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
