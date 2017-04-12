Return-Path: <SRS0=d/kp=3U=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=d/kp=3U=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
 <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
 <30f662a6-5dab-515b-e35a-a312f3c7b509@free.fr>
 <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
 <2b5eef4c-32f2-54f1-ca2f-f9426e68fb2c@free.fr>
 <67014006-a380-9e3b-c9af-a421052cb8e0@arm.com>
 <b59b81ea-bc1b-bff5-4a78-8a69538b0de3@free.fr>
 <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <241b130e-1fb7-ecd4-034e-eb02065ada66@free.fr>
Date: Wed, 12 Apr 2017 11:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 12/04/2017 10:08, Marc Zyngier wrote:

> On 11/04/17 18:52, Mason wrote:
> 
>> so data->irq is the virq (30, 34, 35, 36)
>> and data->hwirq is the domain hwirq (0, 524288, 524289, 524290)
>>
>> Is there a way to map hwirq 524288 to MSI 0, hwirq 524289 to MSI 1, etc?
> 
> Why would you need to do such a thing?
> - In MSI domain: IRQ34 -> hwirq 524288
> - In foo domain: IRQ34 -> hwirq [whatever your driver has allocated]
> 
> The data is already there, at your fingertips. Just deal with with your
> "foo" irqchip.

OK, let me take a step back, I may have missed the forest for
the trees.

In my original code (copied from the Altera driver) I unmasked
a given MSI in the tango_irq_domain_alloc() function. You said
this was the wrong place, as it should be done in the irqchip
unmask callback. Did I understand correctly, so far?

I have registered custom mask/unmask callbacks for both irq_chips.

The unmask callback that gets called is the one where hwirqs are
524288 and up. But what I need at that point is the "real" MSI
number, because I need to set bit i in some HW register.

Did I somehow mix up domains in one of the init functions?

Regards.



Current debug code posted below, because natural language is often
too ambiguous.

#define MSI_COUNT 32

struct tango_pcie {
	void __iomem *mux;
	void __iomem *msi_status;
	void __iomem *msi_mask;
	phys_addr_t msi_doorbell;
	struct mutex lock; /* lock for updating msi_mask */
	struct irq_domain *irq_domain;
	struct irq_domain *msi_domain;
	int irq;
};

static void tango_msi_isr(struct irq_desc *desc)
{
	unsigned long status;
	unsigned int pos, virq;
	struct irq_chip *chip = irq_desc_get_chip(desc);
	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);

	chained_irq_enter(chip, desc);

	status = readl_relaxed(pcie->msi_status);
	writel_relaxed(status, pcie->msi_status); /* clear IRQs */

	for_each_set_bit(pos, &status, MSI_COUNT) {
		virq = irq_find_mapping(pcie->irq_domain, pos);
		generic_handle_irq(virq);
	}

	chained_irq_exit(chip, desc);
}

#define HOP printk("\nENTER %s\n", __func__); dump_stack()

void foo_ack(struct irq_data *data)	{ HOP; }
void foo_mask(struct irq_data *data)	{ HOP; pci_msi_mask_irq(data); }
void foo_unmask(struct irq_data *data)	{ HOP; pci_msi_unmask_irq(data); }

static struct irq_chip tango_msi_irq_chip = {
	.name = "MSI_foo",
	.irq_ack = foo_ack,
	.irq_mask = foo_mask,
	.irq_unmask = foo_unmask,
};

static struct msi_domain_info msi_domain_info = {
	.flags	= MSI_FLAG_PCI_MSIX | MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
	.chip	= &tango_msi_irq_chip,
};

static void tango_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
{
	struct tango_pcie *pcie = irq_data_get_irq_chip_data(data);

	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
	msg->data = data->hwirq;
}

static int tango_set_affinity(struct irq_data *irq_data,
		const struct cpumask *mask, bool force)
{
	 return -EINVAL;
}

void bar_ack(struct irq_data *data)	{ HOP; }
void bar_mask(struct irq_data *data)	{ HOP; }
void bar_unmask(struct irq_data *data)	{ HOP; }

static struct irq_chip tango_msi_chip = {
	.name			= "MSI_bar",
	.irq_compose_msi_msg	= tango_compose_msi_msg,
	.irq_set_affinity	= tango_set_affinity,
	.irq_ack = bar_ack,
	.irq_mask = bar_mask,
	.irq_unmask = bar_unmask,
};

static int find_free_msi(struct irq_domain *dom, unsigned int virq)
{
	unsigned int pos;
	unsigned long mask;
	struct tango_pcie *pcie = dom->host_data;

	mask = readl_relaxed(pcie->msi_mask);
	pos = find_first_zero_bit(&mask, MSI_COUNT);
	if (pos >= MSI_COUNT)
		return -ENOSPC;
	writel_relaxed(mask | BIT(pos), pcie->msi_mask);

	irq_domain_set_info(dom, virq, pos, &tango_msi_chip,
			dom->host_data, handle_edge_irq, NULL, NULL);

	return 0;
}

static int tango_irq_domain_alloc(struct irq_domain *dom,
		unsigned int virq, unsigned int nr_irqs, void *args)
{
	int err;
	struct tango_pcie *pcie = dom->host_data;

	mutex_lock(&pcie->lock);
	err = find_free_msi(dom, virq);
	mutex_unlock(&pcie->lock);

	return err;
}

static void tango_irq_domain_free(struct irq_domain *dom,
		unsigned int virq, unsigned int nr_irqs)
{
	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
	struct tango_pcie *pcie = irq_data_get_irq_chip_data(d);
	unsigned int mask, pos = d->hwirq;

	mutex_lock(&pcie->lock);
	mask = readl_relaxed(pcie->msi_mask);
	writel_relaxed(mask & ~BIT(pos), pcie->msi_mask);
	mutex_unlock(&pcie->lock);
}

static const struct irq_domain_ops msi_dom_ops = {
	.alloc	= tango_irq_domain_alloc,
	.free	= tango_irq_domain_free,
};

static int tango_msi_remove(struct platform_device *pdev)
{
	struct tango_pcie *pcie = platform_get_drvdata(pdev);

	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
	irq_domain_remove(pcie->msi_domain);
	irq_domain_remove(pcie->irq_domain);

	return 0;
}

static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie)
{
	int virq;
	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
	struct irq_domain *msi_dom, *irq_dom;

	mutex_init(&pcie->lock);
	writel_relaxed(0, pcie->msi_mask);

	irq_dom = irq_domain_create_linear(fwnode, MSI_COUNT, &msi_dom_ops, pcie);
	if (!irq_dom) {
		pr_err("Failed to create IRQ domain\n");
		return -ENOMEM;
	}

	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_domain_info, irq_dom);
	if (!msi_dom) {
		pr_err("Failed to create MSI domain\n");
		irq_domain_remove(irq_dom);
		return -ENOMEM;
	}

	virq = platform_get_irq(pdev, 1);
	if (virq <= 0) {
		pr_err("Failed to map IRQ\n");
		irq_domain_remove(msi_dom);
		irq_domain_remove(irq_dom);
		return -ENXIO;
	}

	pcie->irq_domain = irq_dom;
	pcie->msi_domain = msi_dom;
	pcie->irq = virq;
	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);

	return 0;
}
