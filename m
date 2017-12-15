Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932359AbdLOQNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 11:13:32 -0500
Subject: Re: [PATCH v5 3/3] PCI: mobiveil: Add MSI support for Mobiveil PCIe
 Host
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org
Cc: devicetree@vger.kernel.org, mingkai.hu@nxp.com,
        peter.newton@nxp.com, minghuan.lian@nxp.com, rajesh.raina@nxp.com,
        rajan.kapoor@nxp.com, prabhjot.singh@nxp.com
References: <1513181336-19955-1-git-send-email-l.subrahmanya@mobiveil.co.in>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <23b886bf-b21e-8e8c-460c-42316469f989@arm.com>
Date: Fri, 15 Dec 2017 16:13:28 +0000
MIME-Version: 1.0
In-Reply-To: <1513181336-19955-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/12/17 16:08, Subrahmanya Lingappa wrote:
> Adds MSI support for Mobiveil PCIe Host Bridge IP driver
> 
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/host/pcie-mobiveil.c | 222 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 220 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
> index 8611aaa..39818d5 100644
> --- a/drivers/pci/host/pcie-mobiveil.c
> +++ b/drivers/pci/host/pcie-mobiveil.c
> @@ -14,6 +14,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -55,6 +56,7 @@
>  #define PAB_INTP_AMBA_MISC_ENB	0x0b0c
>  #define PAB_INTP_AMBA_MISC_STAT	0x0b1c
>  #define  PAB_INTP_INTX_MASK	0x1e0
> +#define  PAB_INTP_MSI_MASK	0x8
>  
>  #define PAB_AXI_AMAP_CTRL(win)	PAB_REG_ADDR_16(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT	0
> @@ -85,8 +87,19 @@
>  
>  /* supported number of interrupts */
>  #define PCI_NUM_INTX		4
> +#define PCI_NUM_MSI		16
>  #define PAB_INTA_POS		5
>  
> +/* MSI registers */
> +#define MSI_BASE_LO_OFFSET	0x04
> +#define MSI_BASE_HI_OFFSET	0x08
> +#define MSI_SIZE_OFFSET		0x0c
> +#define MSI_ENABLE_OFFSET	0x14
> +#define MSI_STATUS_OFFSET	0x18
> +#define MSI_DATA_OFFSET		0x20
> +#define MSI_ADDR_L_OFFSET	0x24
> +#define MSI_ADDR_H_OFFSET	0x28
> +
>  /* outbound and inbound window definitions */
>  #define WIN_NUM_0		0
>  #define WIN_NUM_1		1
> @@ -105,11 +118,22 @@
>  #define UINT64_MAX		(u64)(~((u64)0))
>  #endif
>  
> +struct mobiveil_msi {			/* MSI information */
> +	struct mutex lock;		/* protect bitmap variable */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	phys_addr_t msi_pages_phys;
> +	int *msi_pages;
> +	int num_of_vectors;
> +	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> +};
> +
>  struct mobiveil_pcie {
>  	struct platform_device *pdev;
>  	struct list_head resources;
>  	void __iomem *config_axi_slave_base;	/* endpoint config base */
>  	void __iomem *csr_axi_slave_base;	/* root port config base */
> +	void __iomem *apb_csr_base;	/* MSI register base */
>  	struct irq_domain *intx_domain;
>  	int irq;
>  	int apio_wins;
> @@ -118,6 +142,7 @@ struct mobiveil_pcie {
>  	int ib_wins_configured;	/*  configured inbound windows */
>  	struct resource *ob_io_res;
>  	char root_bus_nr;
> +	struct mobiveil_msi msi;
>  };
>  
>  static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
> @@ -202,11 +227,18 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
>  	struct device *dev = &pcie->pdev->dev;
> -	u32 intr_status;
> +	struct mobiveil_msi *msi = &pcie->msi;
> +	u32 msi_data, msi_addr_lo, msi_addr_hi;
> +	u32 intr_status, msi_status;
>  	unsigned long shifted_status;
>  	u32 bit, virq;
>  	u32 val, mask;
>  
> +	/*
> +	 * The core provides a single interrupt for both INTx/MSI messages.
> +	 * So we'll read both INTx and MSI status
> +	 */
> +
>  	chained_irq_enter(chip, desc);
>  
>  	/* read INTx status */
> @@ -241,6 +273,41 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  		} while ((shifted_status >>  PAB_INTA_POS) != 0);
>  	}
>  
> +	/* read extra MSI status register */
> +	msi_status = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);

You are using the non-relaxed accessors here, while the rest of the
driver used the _relaxed version. Why is that so?

> +
> +	/* handle MSI interrupts */
> +	if ((intr_status & PAB_INTP_MSI_MASK) || (msi_status & 1)) {
> +		do {
> +			msi_data = readl(pcie->apb_csr_base + MSI_DATA_OFFSET);
> +
> +			/*
> +			 * MSI_STATUS_OFFSET gets updated to zero once we have
> +			 * popped not only the data but also address from MSI
> +			 * hardware FIFO.so keeping these following two dummy
> +			 * reads.
> +			 */
> +			msi_addr_lo = readl(pcie->apb_csr_base +
> +					MSI_ADDR_L_OFFSET);
> +			msi_addr_hi = readl(pcie->apb_csr_base +
> +					MSI_ADDR_H_OFFSET);

Is that really valid? Don't you have to issue a 64bit access?

> +			dev_dbg(dev,
> +				"MSI registers, data: %08x, addr: %08x:%08x\n",
> +				msi_data, msi_addr_hi, msi_addr_lo);
> +
> +			if (msi_data) {
> +				virq = irq_find_mapping(msi->dev_domain,
> +					msi_data);
> +				if (virq)
> +					generic_handle_irq(virq);
> +			} else
> +				dev_err_ratelimited(dev, "MSI data null\n");

Braces on both sides of the else statement.

Also, why is msi_data==0 not valid? You can definitely allocate it from
your bitmap, and I'm expecting that there is a strong correlation
between what you read from MSI_DATA_OFFSET and the payload that the
endpoint writes.

> +
> +			msi_status = readl(pcie->apb_csr_base +
> +					MSI_STATUS_OFFSET);
> +		} while (msi_status & 1);
> +	}
> +
>  	csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
>  	chained_irq_exit(chip, desc);
>  }
> @@ -274,6 +341,12 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	if (IS_ERR(pcie->csr_axi_slave_base))
>  		return PTR_ERR(pcie->csr_axi_slave_base);
>  
> +	/* map MSI config resource */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> +	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(pcie->apb_csr_base))
> +		return PTR_ERR(pcie->apb_csr_base);
> +
>  	/* read the number of windows requested */
>  	if (!pcie->apio_wins &&
>  		of_property_read_u32(node, "apio-wins", &pcie->apio_wins)) {
> @@ -430,6 +503,27 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
> +{
> +	phys_addr_t msg_addr;
> +	struct mobiveil_msi *msi = &pcie->msi;
> +
> +
> +	pcie->msi.num_of_vectors = PCI_NUM_MSI;
> +
> +	msi->msi_pages = (void *)__get_free_pages(GFP_DMA, 0);

That old trick again... Do you really need to carve out a RAM page for
this? Can't you use just some dummy physical address instead? The base
address of your PCIe RC, for example.

> +	msg_addr = virt_to_phys((void *)msi->msi_pages);
> +	msi->msi_pages_phys = (phys_addr_t)msg_addr;
> +
> +	writel_relaxed(lower_32_bits(msg_addr),
> +		pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
> +	writel_relaxed(upper_32_bits(msg_addr),
> +		pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
> +	writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
> +	writel_relaxed(1,
> +		pcie->apb_csr_base + MSI_ENABLE_OFFSET);

nit: No need to break all these writes, each of them can fit on a single
line.

> +}
> +
>  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>  	u32 value;
> @@ -465,7 +559,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  		(1 << PEX_PIO_ENABLE_SHIFT),
>  		PAB_CTRL);
>  
> -	csr_writel(pcie, PAB_INTP_INTX_MASK, PAB_INTP_AMBA_MISC_ENB);
> +	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> +		PAB_INTP_AMBA_MISC_ENB);
>  
>  	/* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
>  	 * PAB_AXI_PIO_CTRL Register
> @@ -503,6 +598,10 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  		}
>  	}
>  
> +	/* setup MSI hardware registers */
> +	if (IS_ENABLED(CONFIG_PCI_MSI))

Your driver already depends on PCI_MSI_IRQ_DOMAIN, which depends on
PCI_MSI. So this IS_ENABLED() is pointless.

> +		mobiveil_pcie_enable_msi(pcie);
> +
>  	return err;
>  }
>  
> @@ -520,6 +619,118 @@ static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  	.map = mobiveil_pcie_intx_map,
>  };
>  
> +static struct irq_chip mobiveil_msi_irq_chip = {
> +	.name = "Mobiveil PCIe MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info mobiveil_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		     MSI_FLAG_PCI_MSIX),
> +	.chip	= &mobiveil_msi_irq_chip,
> +};
> +
> +static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr = virt_to_phys((void *)pcie->msi.msi_pages +
> +				(data->hwirq * sizeof(int)));
> +
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->data = data->hwirq;
> +
> +	dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
> +		const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip mobiveil_msi_bottom_irq_chip = {
> +	.name			= "Mobiveil MSI",
> +	.irq_compose_msi_msg	= mobiveil_compose_msi_msg,
> +	.irq_set_affinity	= mobiveil_msi_set_affinity,
> +};
> +
> +static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
> +		unsigned int virq, unsigned int nr_irqs, void *args)
> +{
> +	struct mobiveil_pcie *pcie = domain->host_data;
> +	struct mobiveil_msi *msi = &pcie->msi;
> +	unsigned long bit;
> +
> +	WARN_ON(nr_irqs != 1);
> +	mutex_lock(&msi->lock);
> +
> +	bit = find_first_zero_bit(msi->msi_irq_in_use, msi->num_of_vectors);
> +	if (bit >= msi->num_of_vectors) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	set_bit(bit, msi->msi_irq_in_use);
> +
> +	mutex_unlock(&msi->lock);
> +
> +	irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
> +	return 0;
> +}
> +
> +static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
> +		unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct mobiveil_msi *msi = &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (!test_bit(d->hwirq, msi->msi_irq_in_use)) {
> +		dev_err(&pcie->pdev->dev, "trying to free unused MSI#%lu\n",
> +			d->hwirq);
> +	} else {
> +		__clear_bit(d->hwirq, msi->msi_irq_in_use);
> +	}
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= mobiveil_irq_msi_domain_alloc,
> +	.free	= mobiveil_irq_msi_domain_free,
> +};
> +
> +static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct mobiveil_msi *msi = &pcie->msi;
> +
> +	mutex_init(&pcie->msi.lock);
> +	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
> +					     &msi_domain_ops, pcie);
> +	if (!msi->dev_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> +				&mobiveil_msi_domain_info, msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
>  static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> @@ -535,6 +746,13 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  		return -ENODEV;
>  	}
>  
> +#ifdef CONFIG_PCI_MSI

Useless #ifdef

> +	/* setup MSI */
> +	ret = mobiveil_allocate_msi_domains(pcie);
> +	if (ret)
> +		return ret;
> +#endif
> +
>  	return 0;
>  }
>  
> 

Now, there is something that I find a bit annoying: This code looks very
similar to drivers/pci/host/pcie-altera-msi.c, to the extent that I
suspect this is the same IP.

I suggest you investigate whether you can reuse the existing code
instead of adding yet another MSI driver to the kernel.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
