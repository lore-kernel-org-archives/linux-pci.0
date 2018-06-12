Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 12 Jun 2018 14:22:07 +0530
From: poza@codeaurora.org
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
In-Reply-To: <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <3ecc33ebe3db1f010f5c8938dfb87677@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-30 03:28, Ray Jui wrote:
> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
> INTD share the same interrupt line connected to the GIC in the system,
> while the status of each INTx can be obtained through the INTX CSR
> register
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc-platform.c |  2 +
>  drivers/pci/host/pcie-iproc.c          | 95 
> +++++++++++++++++++++++++++++++++-
>  drivers/pci/host/pcie-iproc.h          |  6 +++
>  3 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c
> b/drivers/pci/host/pcie-iproc-platform.c
> index e764a2a..7a51e6c 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -70,6 +70,8 @@ static int iproc_pcie_pltfm_probe(struct
> platform_device *pdev)
>  	}
>  	pcie->base_addr = reg.start;
> 
> +	pcie->irq = platform_get_irq(pdev, 0);
> +
>  	if (of_property_read_bool(np, "brcm,pcie-ob")) {
>  		u32 val;
> 
> diff --git a/drivers/pci/host/pcie-iproc.c 
> b/drivers/pci/host/pcie-iproc.c
> index 14f374d..0bd2c14 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -264,6 +265,7 @@ enum iproc_pcie_reg {
> 
>  	/* enable INTx */
>  	IPROC_PCIE_INTX_EN,
> +	IPROC_PCIE_INTX_CSR,
> 
>  	/* outbound address mapping */
>  	IPROC_PCIE_OARR0,
> @@ -305,6 +307,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
>  	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
>  	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
>  	[IPROC_PCIE_INTX_EN]		= 0x330,
> +	[IPROC_PCIE_INTX_CSR]		= 0x334,
>  	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
>  };
> 
> @@ -316,6 +319,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
>  	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
>  	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
>  	[IPROC_PCIE_INTX_EN]		= 0x330,
> +	[IPROC_PCIE_INTX_CSR]		= 0x334,
>  	[IPROC_PCIE_OARR0]		= 0xd20,
>  	[IPROC_PCIE_OMAP0]		= 0xd40,
>  	[IPROC_PCIE_OARR1]		= 0xd28,
> @@ -332,6 +336,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
>  	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
>  	[IPROC_PCIE_INTX_EN]		= 0x330,
> +	[IPROC_PCIE_INTX_CSR]		= 0x334,
>  	[IPROC_PCIE_OARR0]		= 0xd20,
>  	[IPROC_PCIE_OMAP0]		= 0xd40,
>  	[IPROC_PCIE_OARR1]		= 0xd28,
> @@ -782,9 +787,90 @@ static int iproc_pcie_check_link(struct iproc_pcie 
> *pcie)
>  	return link_is_active ? 0 : -ENODEV;
>  }
> 
> -static void iproc_pcie_enable(struct iproc_pcie *pcie)
> +static int iproc_pcie_intx_map(struct irq_domain *domain, unsigned int 
> irq,
> +			       irq_hw_number_t hwirq)
>  {
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = iproc_pcie_intx_map,
> +};
> +
> +static void iproc_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct iproc_pcie *pcie;
> +	struct device *dev;
> +	unsigned long status;
> +	u32 bit, virq;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +	dev = pcie->dev;
> +
> +	/* go through INTx A, B, C, D until all interrupts are handled */
> +	while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
> +		SYS_RC_INTX_MASK) != 0) {
> +		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(dev, "unexpected INTx%u\n", bit);
> +		}
> +	}
> +

Are these level or edge interrupts ? although I see DT says: 
IRQ_TYPE_NONE
do you not need to clear interrupt status bits in IPROC_PCIE_INTX_CSR ?

> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int iproc_pcie_intx_enable(struct iproc_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret;
> +
>  	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
> +
> +	/*
> +	 * BCMA devices do not map INTx the same way as platform devices. All
> +	 * BCMA needs is the above code to enable INTx
> +	 */
> +	if (pcie->irq <= 0)
> +		return 0;
> +
> +	/* set IRQ handler */
> +	irq_set_chained_handler_and_data(pcie->irq, iproc_pcie_isr, pcie);
> +
> +	/* add IRQ domain for INTx */
> +	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX + 1,
> +						 &intx_domain_ops, pcie);
> +	if (!pcie->irq_domain) {
> +		dev_err(dev, "failed to add INTx IRQ domain\n");
> +		ret = -ENOMEM;
> +		goto err_rm_handler_data;
> +	}
> +
> +	return 0;
> +
> +err_rm_handler_data:
> +	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> +
> +	return ret;
> +}
> +
> +static void iproc_pcie_intx_disable(struct iproc_pcie *pcie)
> +{
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, 0x0);
> +
> +	if (pcie->irq <= 0)
> +		return;
> +
> +	irq_domain_remove(pcie->irq_domain);
> +	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>  }
> 
>  static inline bool iproc_pcie_ob_is_valid(struct iproc_pcie *pcie,
> @@ -1410,7 +1496,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie,
> struct list_head *res)
>  		goto err_power_off_phy;
>  	}
> 
> -	iproc_pcie_enable(pcie);
> +	ret = iproc_pcie_intx_enable(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable INTx\n");
> +		goto err_power_off_phy;
> +	}
> 
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		if (iproc_pcie_msi_enable(pcie))
> @@ -1455,6 +1545,7 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
>  	pci_remove_root_bus(pcie->root_bus);
> 
>  	iproc_pcie_msi_disable(pcie);
> +	iproc_pcie_intx_disable(pcie);
> 
>  	phy_power_off(pcie->phy);
>  	phy_exit(pcie->phy);
> diff --git a/drivers/pci/host/pcie-iproc.h 
> b/drivers/pci/host/pcie-iproc.h
> index 67081cb..cbcaf9d 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -72,6 +72,9 @@ struct iproc_msi;
>   * @ib: inbound mapping related parameters
>   * @ib_map: outbound mapping region related parameters
>   *
> + * @irq: interrupt line wired to the generic GIC for INTx
> + * @irq_domain: IRQ domain for INTx
> + *
>   * @need_msi_steer: indicates additional configuration of the iProc 
> PCIe
>   * controller is required to steer MSI writes to external interrupt 
> controller
>   * @msi: MSI data
> @@ -99,6 +102,9 @@ struct iproc_pcie {
>  	struct iproc_pcie_ib ib;
>  	const struct iproc_pcie_ib_map *ib_map;
> 
> +	int irq;
> +	struct irq_domain *irq_domain;
> +
>  	bool need_msi_steer;
>  	struct iproc_msi *msi;
>  };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
