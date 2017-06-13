Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v5 3/3] PCI: Add tango MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
Date: Tue, 13 Jun 2017 13:09:47 +0100
MIME-Version: 1.0
In-Reply-To: <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 31/05/17 14:35, Marc Gonzalez wrote:
> The MSI controller in Tango supports 256 message-signaled interrupts,
> and a single doorbell address.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/pci/host/pcie-tango.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> index 67aaadcc1c5e..7d99ef26173f 100644
> --- a/drivers/pci/host/pcie-tango.c
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -1,16 +1,225 @@
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/delay.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  
>  #define MSI_MAX 256
>  
>  #define SMP8759_MUX		0x48
>  #define SMP8759_TEST_OUT	0x74
> +#define SMP8759_STATUS		0x80
> +#define SMP8759_ENABLE		0xa0
> +#define SMP8759_DOORBELL	0xa002e07c
>  
>  struct tango_pcie {
> +	DECLARE_BITMAP(used, MSI_MAX);
> +	spinlock_t lock;

These two fields have pretty generic names. Consider naming them in a
way that indicates their purpose (used_msi? used_msi_lock?).

>  	void __iomem *mux;
> +	void __iomem *msi_status;
> +	void __iomem *msi_enable;
> +	phys_addr_t msi_doorbell;
> +	struct irq_domain *irq_dom;
> +	struct irq_domain *msi_dom;
> +	int irq;
>  };
>  
> +/*** MSI CONTROLLER SUPPORT ***/
> +
> +static void tango_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
> +	unsigned long status, base, virq, idx, pos = 0;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((pos = find_next_bit(pcie->used, MSI_MAX, pos)) < MSI_MAX) {

The pcie->used bitmap read can race against another CPU accessing this
bitmap in the alloc/free paths.

> +		base = round_down(pos, 32);
> +		status = readl_relaxed(pcie->msi_status + base / 8);
> +		for_each_set_bit(idx, &status, 32) {
> +			virq = irq_find_mapping(pcie->irq_dom, base + idx);
> +			generic_handle_irq(virq);
> +		}
> +		pos = base + 32;
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void tango_ack(struct irq_data *d)
> +{
> +	struct tango_pcie *pcie = d->chip_data;
> +	u32 offset = (d->hwirq / 32) * 4;
> +	u32 bit = BIT(d->hwirq % 32);
> +
> +	writel_relaxed(bit, pcie->msi_status + offset);
> +}
> +
> +static void update_msi_enable(struct irq_data *d, bool unmask)
> +{
> +	unsigned long flags;
> +	struct tango_pcie *pcie = d->chip_data;
> +	u32 offset = (d->hwirq / 32) * 4;
> +	u32 bit = BIT(d->hwirq % 32);
> +	u32 val;
> +
> +	spin_lock_irqsave(&pcie->lock, flags);
> +	val = readl_relaxed(pcie->msi_enable + offset);
> +	val = unmask ? val | bit : val & ~bit;
> +	writel_relaxed(val, pcie->msi_enable + offset);
> +	spin_unlock_irqrestore(&pcie->lock, flags);
> +}
> +
> +static void tango_mask(struct irq_data *d)
> +{
> +	update_msi_enable(d, false);
> +}
> +
> +static void tango_unmask(struct irq_data *d)
> +{
> +	update_msi_enable(d, true);
> +}
> +
> +static int tango_set_affinity(struct irq_data *d,
> +		const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static void tango_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct tango_pcie *pcie = d->chip_data;
> +	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
> +	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
> +	msg->data = d->hwirq;
> +}
> +
> +static struct irq_chip tango_chip = {
> +	.irq_ack		= tango_ack,
> +	.irq_mask		= tango_mask,
> +	.irq_unmask		= tango_unmask,
> +	.irq_set_affinity	= tango_set_affinity,
> +	.irq_compose_msi_msg	= tango_compose_msi_msg,
> +};
> +
> +static void msi_ack(struct irq_data *d)
> +{
> +	irq_chip_ack_parent(d);
> +}
> +
> +static void msi_mask(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void msi_unmask(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static struct irq_chip msi_chip = {
> +	.name = "MSI",
> +	.irq_ack = msi_ack,
> +	.irq_mask = msi_mask,
> +	.irq_unmask = msi_unmask,
> +};
> +
> +static struct msi_domain_info msi_dom_info = {
> +	.flags	= MSI_FLAG_PCI_MSIX
> +		| MSI_FLAG_USE_DEF_DOM_OPS
> +		| MSI_FLAG_USE_DEF_CHIP_OPS,
> +	.chip	= &msi_chip,
> +};
> +
> +static int tango_irq_domain_alloc(struct irq_domain *dom,
> +		unsigned int virq, unsigned int nr_irqs, void *args)
> +{
> +	unsigned long flags;
> +	int pos, err = -ENOSPC;
> +	struct tango_pcie *pcie = dom->host_data;
> +
> +	spin_lock_irqsave(&pcie->lock, flags);
> +	pos = find_first_zero_bit(pcie->used, MSI_MAX);
> +	if (pos < MSI_MAX) {
> +		err = 0;
> +		__set_bit(pos, pcie->used);
> +		irq_domain_set_info(dom, virq, pos,
> +				&tango_chip, pcie, handle_edge_irq, NULL, NULL);
> +	}
> +	spin_unlock_irqrestore(&pcie->lock, flags);
> +
> +	return err;
> +}
> +
> +static void tango_irq_domain_free(struct irq_domain *dom,
> +		unsigned int virq, unsigned int nr_irqs)
> +{
> +	unsigned long flags;
> +	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
> +	struct tango_pcie *pcie = d->chip_data;
> +
> +	spin_lock_irqsave(&pcie->lock, flags);
> +	__clear_bit(d->hwirq, pcie->used);
> +	spin_unlock_irqrestore(&pcie->lock, flags);
> +}
> +
> +static const struct irq_domain_ops irq_dom_ops = {
> +	.alloc	= tango_irq_domain_alloc,
> +	.free	= tango_irq_domain_free,
> +};
> +
> +static int tango_msi_remove(struct platform_device *pdev)
> +{
> +	struct tango_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> +	irq_domain_remove(pcie->msi_dom);
> +	irq_domain_remove(pcie->irq_dom);
> +
> +	return 0;
> +}
> +
> +static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie)
> +{
> +	int i, virq;
> +	struct irq_domain *msi_dom, *irq_dom;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
> +
> +	spin_lock_init(&pcie->lock);
> +	for (i = 0; i < MSI_MAX / 32; ++i)
> +		writel_relaxed(0, pcie->msi_enable + i * 4);
> +
> +	virq = platform_get_irq(pdev, 1);
> +	if (virq <= 0) {
> +		pr_err("Failed to map IRQ\n");
> +		return -ENXIO;
> +	}
> +
> +	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &irq_dom_ops, pcie);
> +	if (!irq_dom) {
> +		pr_err("Failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);
> +	if (!msi_dom) {
> +		pr_err("Failed to create MSI domain\n");
> +		return -ENOMEM;

You're now leaking irq_dom.

> +	}
> +
> +	pcie->irq_dom = irq_dom;
> +	pcie->msi_dom = msi_dom;
> +	pcie->irq = virq;
> +
> +	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
> +
> +	return 0;
> +}
> +
>  /*** HOST BRIDGE SUPPORT ***/
>  
>  static int smp8759_config_read(struct pci_bus *bus,
> @@ -88,6 +297,9 @@ static int tango_check_pcie_link(void __iomem *test_out)
>  static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
>  {
>  	pcie->mux		= base + SMP8759_MUX;
> +	pcie->msi_status	= base + SMP8759_STATUS;
> +	pcie->msi_enable	= base + SMP8759_ENABLE;
> +	pcie->msi_doorbell	= SMP8759_DOORBELL;
>  
>  	return tango_check_pcie_link(base + SMP8759_TEST_OUT);
>  }
> @@ -121,11 +333,21 @@ static int tango_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = tango_msi_probe(pdev, pcie);
> +	if (ret)
> +		return ret;
> +
>  	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
>  }
>  
> +static int tango_pcie_remove(struct platform_device *pdev)
> +{
> +	return tango_msi_remove(pdev);
> +}
> +
>  static struct platform_driver tango_pcie_driver = {
>  	.probe	= tango_pcie_probe,
> +	.remove	= tango_pcie_remove,
>  	.driver	= {
>  		.name = KBUILD_MODNAME,
>  		.of_match_table = tango_pcie_ids,
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
