Return-Path: <SRS0=CTSG=3A=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=CTSG=3A=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
Date: Thu, 23 Mar 2017 14:22:30 +0000
MIME-Version: 1.0
In-Reply-To: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/03/17 13:05, Mason wrote:
> I think this version is ready for review.
> It has all the required bits and pieces.
> I still have a few questions, embedded as comments in the code.
> (Missing are ancillary changes to Kconfig, Makefile)

May I suggest that if you think that a patch is ready for review, it
should really contain all the bits that make it an actual patch? That
would include an actual commit log and all what is required to actually
compile it. Not to mention a SoB.

We rely (at least I certainly do) on things like the kbuild robot
picking up stuff from the list and giving it a go. Also, it makes it a
much more efficient use of the reviewer time not to review the same
thing twice...

That being said:

> ---
>  drivers/pci/host/pcie-tango.c | 350 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 350 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-tango.c
> 
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> new file mode 100644
> index 000000000000..b2e6448aed2d
> --- /dev/null
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -0,0 +1,350 @@
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/msi.h>
> +
> +#define MSI_COUNT 32

Is this something that is hardcoded? Unlikely to ever change?

> +
> +struct tango_pcie {
> +	void __iomem *mux;
> +	void __iomem *msi_status;
> +	void __iomem *msi_mask;
> +	phys_addr_t msi_doorbell;
> +	struct mutex lock; /* lock for updating msi_mask */
> +	struct irq_domain *irq_domain;
> +	struct irq_domain *msi_domain;
> +	int irq;
> +};
> +
> +/*** MSI CONTROLLER SUPPORT ***/
> +
> +static void tango_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct tango_pcie *pcie;
> +	unsigned long status, virq;
> +	int pos;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +
> +	status = readl_relaxed(pcie->msi_status);

Please use types that unambiguously match that of the MMIO accessor (u32
in this case). On a 64bit system, unsigned long is likely to be 64bit.
You can assign it to an unsigned long before calling the
for_each_set_bit operator.

> +	writel_relaxed(status, pcie->msi_status); /* clear IRQs */

Why isn't this your irq_ack method instead of open-coding it?

> +
> +	for_each_set_bit(pos, &status, MSI_COUNT) {
> +		virq = irq_find_mapping(pcie->irq_domain, pos);
> +		if (virq)
> +			generic_handle_irq(virq);
> +		else
> +			pr_err("Unhandled MSI: %d\n", pos);

Please rate-limit this.

> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static struct irq_chip tango_msi_irq_chip = {
> +	.name = "MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info msi_domain_info = {
> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,

No support for MSI-X? Why?

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
> +static int tango_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +		unsigned int nr_irqs, void *args)
> +{
> +	struct tango_pcie *pcie = domain->host_data;
> +	int pos, err = 0;
> +	u32 mask;
> +
> +	if (nr_irqs != 1) /* When does that happen? */
> +		return -EINVAL;

Only if the end-point wants to use Multi-MSI. You don't advertise
support for it, so it should never happen.

> +
> +	mutex_lock(&pcie->lock);
> +
> +	mask = readl_relaxed(pcie->msi_mask);

Do you really need to read this from the HW each time you allocate an
interrupt? That feels pretty crazy. You're much better off having an
in-memory bitmap that will make things more efficient, and avoid the
following bug...

> +	pos = find_first_zero_bit(&mask, MSI_COUNT);

... where using a u32 as a bitmap is a very bad idea (because not the
whole world is a 32bit, little endian platform).

> +	if (pos < MSI_COUNT)
> +		writel(mask | BIT(pos), pcie->msi_mask);

And it would make a lot more sense to move this write (which should be
relaxed) to irq_unmask. Also, calling msi_mask for something that is an
enable register is a bit counter intuitive.

> +	else
> +		err = -ENOSPC;
> +
> +	mutex_unlock(&pcie->lock);
> +
> +	irq_domain_set_info(domain, virq, pos, &tango_msi_chip,
> +			domain->host_data, handle_simple_irq, NULL, NULL);

And here, you're polluting the domain even if you failed to allocate the
interrupt.

> +
> +	return err;
> +}
> +
> +static void tango_irq_domain_free(struct irq_domain *domain,
> +				   unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct tango_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	int pos = d->hwirq;
> +	u32 mask;
> +
> +	mutex_lock(&pcie->lock);
> +
> +	mask = readl(pcie->msi_mask);
> +	writel(mask & ~BIT(pos), pcie->msi_mask);

Same as above, please move this to the irq_unmask method.

> +
> +	mutex_unlock(&pcie->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= tango_irq_domain_alloc,
> +	.free	= tango_irq_domain_free,
> +};
> +
> +static int tango_msi_remove(struct platform_device *pdev)
> +{
> +	struct tango_pcie *msi = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler(msi->irq, NULL);
> +	irq_set_handler_data(msi->irq, NULL);
> +	/* irq_set_chained_handler_and_data(msi->irq, NULL, NULL); instead? */
> +
> +	irq_domain_remove(msi->msi_domain);
> +	irq_domain_remove(msi->irq_domain);
> +
> +	return 0;
> +}
> +
> +static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie)
> +{
> +	int virq;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
> +	struct irq_domain *msi_dom, *irq_dom;
> +
> +	mutex_init(&pcie->lock);
> +	writel(0, pcie->msi_mask);
> +
> +	/* Why is fwnode for this call? */
> +	irq_dom = irq_domain_add_linear(NULL, MSI_COUNT, &msi_domain_ops, pcie);

Use irq_domain_create_linear, pass the same fwnode.

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

In the absence of a documented binding, it is hard to know if you're
doing the right thing.

> +	if (virq <= 0) {
> +		irq_domain_remove(msi_dom);
> +		irq_domain_remove(irq_dom);
> +		return -ENXIO;

Maybe add a message indicating what failed?

> +	}
> +
> +	pcie->irq_domain = irq_dom;
> +	pcie->msi_domain = msi_dom;
> +	pcie->irq = virq;
> +	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
> +
> +	return 0;
> +}
> +
> +/*** HOST BRIDGE SUPPORT ***/

[...]

I don't know much about PCIe itself, hence stopping here.

I'd like to see the MSI code as a separate patch, because it is pretty
much standalone. And please write a DT binding document for the whole
thing, because I end-up second guessing what you're trying to do...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
