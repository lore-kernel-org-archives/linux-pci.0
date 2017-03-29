Return-Path: <SRS0=WlYQ=3G=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=WlYQ=3G=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add tango MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <f37d7b55-e065-72aa-e690-13dd4718a9ce@sigmadesigns.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a12a79fd-94f9-5aa4-5aa0-5dccb6c5d615@arm.com>
Date: Wed, 29 Mar 2017 13:29:04 +0100
MIME-Version: 1.0
In-Reply-To: <f37d7b55-e065-72aa-e690-13dd4718a9ce@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/17 12:29, Marc Gonzalez wrote:
> The MSI controller in Tango supports 256 message-signaled interrupts,
> and a single doorbell address.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes since v0.2
> - Support 256 MSIs instead of only 32
> - Use spinlock_t instead of struct mutex
> - Add MSI_FLAG_PCI_MSIX flag
> 
> IRQs are acked in tango_msi_isr because handle_simple_irq leaves
> ack, clear, mask and unmask up to the driver. For the same reason,
> interrupt enable mask is updated from tango_irq_domain_alloc/free.

I've asked you to move this to individual methods. You've decided not
to, and that's your call. But I now wonder why I'm even bothering to
review this, as you've so far just wasted my time.

Anyway...

> ---
>  drivers/pci/host/pcie-tango.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> new file mode 100644
> index 000000000000..e88850983a1d
> --- /dev/null
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -0,0 +1,194 @@
> +#include <linux/module.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/pci-ecam.h>

How is that include relevant to this patch?

> +#include <linux/msi.h>
> +
> +#define MSI_MAX 256
> +
> +struct tango_pcie {
> +	DECLARE_BITMAP(bitmap, MSI_MAX);
> +	spinlock_t lock;
> +	void __iomem *mux;
> +	void __iomem *msi_status;
> +	void __iomem *msi_mask;
> +	phys_addr_t msi_doorbell;
> +	struct irq_domain *irq_domain;
> +	struct irq_domain *msi_domain;
> +	int irq;
> +};
> +
> +/*** MSI CONTROLLER SUPPORT ***/
> +
> +static void dispatch(struct tango_pcie *pcie, unsigned long status, int base)
> +{
> +	unsigned int pos, virq;
> +
> +	for_each_set_bit(pos, &status, 32) {
> +		virq = irq_find_mapping(pcie->irq_domain, base + pos);
> +		generic_handle_irq(virq);
> +	}
> +}
> +
> +static void tango_msi_isr(struct irq_desc *desc)
> +{
> +	u32 status;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
> +	unsigned int base, offset, pos = 0;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((pos = find_next_bit(pcie->bitmap, MSI_MAX, pos)) < MSI_MAX) {
> +		base = round_down(pos, 32);
> +		offset = (pos / 32) * 4;
> +		status = readl_relaxed(pcie->msi_status + offset);
> +		writel_relaxed(status, pcie->msi_status + offset);
> +		dispatch(pcie, status, base);
> +		pos = base + 32;
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static struct irq_chip tango_msi_irq_chip = {
> +	.name = "MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,

How do you make that work if the PCI device doesn't support per-MSI masking?

> +};
> +
> +#define USE_DEF_OPS (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)

How is that useful?

> +
> +static struct msi_domain_info msi_domain_info = {
> +	.flags	= USE_DEF_OPS | MSI_FLAG_PCI_MSIX,
> +	.chip	= &tango_msi_irq_chip,
> +};
> +
> +static void tango_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct tango_pcie *pcie = irq_data_get_irq_chip_data(data);
> +
> +	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
> +	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
> +	msg->data = data->hwirq;
> +}
> +
> +static int tango_set_affinity(struct irq_data *irq_data,
> +		const struct cpumask *mask, bool force)
> +{
> +	 return -EINVAL;
> +}
> +
> +static struct irq_chip tango_msi_chip = {
> +	.name			= "MSI",
> +	.irq_compose_msi_msg	= tango_compose_msi_msg,
> +	.irq_set_affinity	= tango_set_affinity,
> +};
> +
> +static int find_free_msi(struct irq_domain *dom, unsigned int virq)
> +{
> +	u32 val;
> +	struct tango_pcie *pcie = dom->host_data;
> +	unsigned int offset, pos;
> +
> +	pos = find_first_zero_bit(pcie->bitmap, MSI_MAX);
> +	if (pos >= MSI_MAX)
> +		return -ENOSPC;
> +
> +	offset = (pos / 32) * 4;
> +	val = readl_relaxed(pcie->msi_mask + offset);
> +	writel_relaxed(val | BIT(pos % 32), pcie->msi_mask + offset);

Great. I'm now in a position where I can take an interrupt (because of
the broken locking that doesn't disable interrupts), but the bitmap
doesn't indicate it yet. With a bit of luck, I'll never make any forward
progress.

> +	__set_bit(pos, pcie->bitmap);
> +
> +	irq_domain_set_info(dom, virq, pos, &tango_msi_chip,
> +			dom->host_data, handle_simple_irq, NULL, NULL);

I've told you a number of times that PCI MSIs are edge triggered...

> +
> +	return 0;
> +}
> +
> +static int tango_irq_domain_alloc(struct irq_domain *dom,
> +		unsigned int virq, unsigned int nr_irqs, void *args)
> +{
> +	int err;
> +	struct tango_pcie *pcie = dom->host_data;
> +
> +	spin_lock(&pcie->lock);
> +	err = find_free_msi(dom, virq);
> +	spin_unlock(&pcie->lock);
> +
> +	return err;
> +}
> +
> +static void tango_irq_domain_free(struct irq_domain *dom,
> +		unsigned int virq, unsigned int nr_irqs)
> +{
> +	u32 val;
> +	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
> +	struct tango_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	unsigned int offset, pos = d->hwirq;
> +
> +	spin_lock(&pcie->lock);
> +
> +	offset = (pos / 32) * 4;
> +	val = readl_relaxed(pcie->msi_mask + offset);
> +	writel_relaxed(val & ~BIT(pos % 32), pcie->msi_mask + offset);
> +	__clear_bit(pos, pcie->bitmap);
> +
> +	spin_unlock(&pcie->lock);
> +}
> +
> +static const struct irq_domain_ops msi_dom_ops = {
> +	.alloc	= tango_irq_domain_alloc,
> +	.free	= tango_irq_domain_free,
> +};
> +
> +static int tango_msi_remove(struct platform_device *pdev)
> +{
> +	struct tango_pcie *msi = platform_get_drvdata(pdev);

Be consistent in your naming. It's called pcie everywhere else.

> +
> +	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
> +	irq_domain_remove(msi->msi_domain);
> +	irq_domain_remove(msi->irq_domain);
> +
> +	return 0;
> +}
> +
> +static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie)
> +{
> +	int i, virq;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
> +	struct irq_domain *msi_dom, *irq_dom;
> +
> +	spin_lock_init(&pcie->lock);
> +
> +	for (i = 0; i < MSI_MAX / 32; ++i)
> +		writel_relaxed(0, pcie->msi_mask + i * 4);
> +
> +	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &msi_dom_ops, pcie);
> +	if (!irq_dom) {
> +		pr_err("Failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_domain_info, irq_dom);
> +	if (!msi_dom) {
> +		pr_err("Failed to create MSI domain\n");
> +		irq_domain_remove(irq_dom);
> +		return -ENOMEM;
> +	}
> +
> +	virq = platform_get_irq(pdev, 1);
> +	if (virq <= 0) {
> +		pr_err("Failed to map IRQ\n");
> +		irq_domain_remove(msi_dom);
> +		irq_domain_remove(irq_dom);
> +		return -ENXIO;
> +	}
> +
> +	pcie->irq_domain = irq_dom;
> +	pcie->msi_domain = msi_dom;
> +	pcie->irq = virq;
> +	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
> +
> +	return 0;
> +}
> 

So there is not much progress from the previous version. It is just
broken in a different ways, and ignores most of the work that is already
done in the irqchip core. I can only repeat what I've said in my
previous review.

	M.
-- 
Jazz is not dead. It just smells funny...
