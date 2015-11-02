Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40608 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbbKBSgE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 13:36:04 -0500
Date: Mon, 2 Nov 2015 19:35:15 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <1445967247-24310-4-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1511021426020.4032@nanos>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com> <1445967247-24310-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keith!

On Tue, 27 Oct 2015, Keith Busch wrote:

I'm just looking at the interrupt part of the patch and it's way
better than the first version I looked at.

>   4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table and
>   PBA. MSIs from VMD domain devices and ports are remapped to appear if
>   they were issued using one of VMD's MSI-X table entries. Each MSI and
>   MSI-X addresses of VMD-owned devices and ports have a special format
>   where the address refers specific entries in VMD's MSI-X table.  As with
>   DMA, the interrupt source id is translated to VMD's bus-device-function.
>
>   The driver provides its own MSI and MSI-X configuration functions
>   specific to how MSI messages are used within the VMD domain, and
>   it provides an irq_chip for independent IRQ allocation and to relay
>   interrupts from VMD's interrupt handler to the appropriate device
>   driver's handler.

Is there any documentation on this available for mere mortals?

I have a faint idea how this is supposed to work, but some more
detailed information about this technology would be appreciated.
  
> +config HAVE_VMDDEV
> +	bool

Why do you need a seperate config symbol here?

We usually use HAVE_xxx to signal the availability of functionality
which is then used by some other Kconfig entry as a dependency.

> +config VMDDEV
> +	depends on PCI && PCI_DOMAINS && PCI_MSI && GENERIC_MSI_IRQ_DOMAIN && IRQ_DOMAIN_HIERARCHY

On x86 this dependency chain is not required. x86/Kconfig does:

   config PCI_DOMAINS
     def_bool y
     depends on PCI

and

    select PCI_MSI_IRQ_DOMAIN if PCI_MSI

and pci/Kconfig does:

  config PCI_MSI_IRQ_DOMAIN
    bool
    depends on PCI_MSI
    select GENERIC_MSI_IRQ_DOMAIN

kernel/irq/Kconfig has:

  config GENERIC_MSI_IRQ_DOMAIN
    bool
    select IRQ_DOMAIN_HIERARCHY

So all you really need is:

   depends on PCI_MSI

> +	tristate "Volume Management Device Driver"
> +	default N
> +	select HAVE_VMDDEV
> +	---help---
> +	Adds support for the Intel Volume Manage Device (VMD). VMD is

The help text should be indented with 2 extra spaces.

> +	a secondary PCI host bridge that allows PCI Express root ports,
> +	and devices attached to them, to be removed from the default PCI
> +	domain and placed within the VMD domain This provides additional

Missing period after domain.

> +	bus resources to allow more devices than are otherwise possible
> +	with a single domain. If your system provides one of these and
> +	has devices attached to it, say "Y".

How is one supposed to figure out that the system supports this?

> +#ifndef _ASM_X86_VMD_H
> +#define _ASM_X86_VMD_H
> +
> +#ifdef CONFIG_HAVE_VMDDEV

No need for that #ifdef

> +struct irq_domain_ops;
> +struct irq_domain *vmd_create_irq_domain(struct pci_dev *dev,
> +				const struct irq_domain_ops *domain_ops);
> +#endif

  
> +#ifdef CONFIG_HAVE_VMDDEV
> +static struct irq_chip pci_chained_msi_controller = {
> +	.name			= "PCI-MSI-chained",
> +};
> +
> +static struct msi_domain_info pci_chained_msi_domain_info = {
> +	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +			  MSI_FLAG_PCI_MSIX,
> +	.ops		= &pci_msi_domain_ops,
> +	.chip		= &pci_chained_msi_controller,
> +};
> +
> +struct irq_domain *vmd_create_irq_domain(struct pci_dev *dev,
> +				const struct irq_domain_ops *domain_ops)

This function really wants a comment what it is doing. AFAICT it
creates a disconnected vmd_irqdomain and a pci_msi irq domain as a
child domain of that. I'm missing the overall picture ...

> +{
> +	int count = 0;
> +	struct msi_desc *msi_desc;
> +	struct irq_domain *vmd_irqdomain, *msi_irqdomain;
> +
> +	if (!dev->msix_enabled)
> +		return NULL;
> +
> +	for_each_pci_msi_entry(msi_desc, dev)
> +		count += msi_desc->nvec_used;

Is this the number of vectors which are available for the VMD device
itself?

> +	vmd_irqdomain = irq_domain_add_linear(NULL, count,
> +						  domain_ops, dev);
> +	if (!vmd_irqdomain)
> +		return NULL;
> +	msi_irqdomain = pci_msi_create_irq_domain(NULL, &pci_chained_msi_domain_info,
> +						  vmd_irqdomain);
> +	if (!msi_irqdomain)
> +		irq_domain_remove(vmd_irqdomain);
> +	return msi_irqdomain;
> +}
> +EXPORT_SYMBOL_GPL(vmd_create_irq_domain);
> +#endif

> +++ b/arch/x86/pci/vmd.c

> +struct vmd_dev {
> +	struct pci_dev *dev;
> +
> +	spinlock_t cfg_lock;
> +	char __iomem *cfgbar;

It'd be nice if you could write those structs like a table

+	struct pci_dev		*dev;
+
+	spinlock_t		cfg_lock;
+	char __iomem		*cfgbar;

That makes it way simpler to parse.

> +struct vmd_irq {
> +	struct list_head node;
> +	struct vmd_irq_list *irq;
> +	unsigned int virq;
> +};
> +
> +static DEFINE_SPINLOCK(list_lock);

Please do not put a variable declaration in the middle of struct
definitions.

> +struct vmd_irq_list {
> +	struct list_head irq_list;
> +	unsigned int vmd_vector;
> +	unsigned int index;
> +};

These structs want an explanation for the struct members. Especially
the "*irq" one in vmd_irq is irritating.

> +static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> +{
> +	return container_of(bus->sysdata, struct vmd_dev, sysdata);
> +}
> +
> +static void vmd_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct vmd_irq *vmdirq = data->chip_data;
> +
> +	msg->address_hi = MSI_ADDR_BASE_HI;
> +	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(vmdirq->irq->index);
> +	msg->data = MSI_DATA_VECTOR(vmdirq->irq->vmd_vector);

Is this the MSI msg which gets written into the VMD device or into the
device which hangs off the VMD device bus?

> +}
> +
> +static void vmd_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	pci_write_msi_msg(data->irq, msg);

Why would you go through another lookup for the msi descriptor? What's
wrong with pci_msi_domain_write_msg() ?

> +}
> +
> +/*
> + * Function is required when using irq hierarchy domains, but we don't have a
> + * good way to not create conflicts with other devices sharing the same vector.

This is just a lame work around and suggests the user that he can set
the affinity.

You can prevent affinity setting by other means. 

Aside of that the question is whether you really want to prevent
affinity setting of all involved interrupts - the demultiplexers and
the device interrupts. Though I don't have any clue how this is going
to be used.

> + */
> +int vmd_irq_set_affinity(struct irq_data *data, const struct cpumask *dest,
> +								bool force)

Is there a reason why this function would be global?

> +{
> +	return 0;
> +}
> +
> +static struct irq_chip vmd_chip = {
> +	.name 			= "VMD-MSI",
> +	.irq_compose_msi_msg	= vmd_msi_compose_msg,
> +	.irq_write_msi_msg	= vmd_msi_write_msg,
> +	.irq_set_affinity	= vmd_irq_set_affinity,
> +};
> +
> +static void vmd_msi_free_irqs(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct vmd_irq *vmdirq;
> +	struct irq_data *irq_data;
> +
> +	irq_data = irq_domain_get_irq_data(domain, virq);
> +	if (!irq_data)
> +		return;
> +	vmdirq = irq_data->chip_data;
> +	kfree(vmdirq);

Shouldn't that be kfree_rcu()?

> +}
> +
> +static int vmd_msi_alloc_irqs(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *arg)
> +{
> +	struct vmd_dev *vmd;
> +	struct vmd_irq *vmdirq;
> +	struct irq_data *irq_data;
> +	struct pci_dev *dev = domain->host_data;
> +
> +	irq_data = irq_domain_get_irq_data(domain, virq);
> +	if (!irq_data)
> +		return -EINVAL;
> +
> +	vmd = pci_get_drvdata(dev);
> +	vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> +	if (!vmdirq)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&vmdirq->node);
> +	vmdirq->irq = &vmd->irqs[virq % vmd->msix_count];

So that points to the underlying VMD device irq, right? And you spread
the device interrupts across the available VMD irqs. So in the worst
case you might end up with empty and crowded VMD irqs, right?
Shouldn't you try to fill that space in a more intelligent way?

> +	vmdirq->virq = virq;
> +
> +	irq_domain_set_hwirq_and_chip(domain, virq, vmdirq->irq->vmd_vector,
> +							&vmd_chip, vmdirq);
> +	irq_set_chip(virq, &vmd_chip);
> +	irq_set_handler_data(virq, vmdirq);
> +	__irq_set_handler(virq, handle_simple_irq, 0, NULL);

What's wrong with irq_set_handler() ?

> +
> +	return 0;
> +}
> +
> +static void vmd_msi_activate(struct irq_domain *domain,
> +					struct irq_data *data)
> +{
> +	struct msi_msg msg;
> +	struct vmd_irq *vmdirq = data->chip_data;
> +	struct vmd_irq_list *irq = vmdirq->irq;
> +
> +	BUG_ON(irq_chip_compose_msi_msg(data, &msg));
> +	data->chip->irq_write_msi_msg(data, &msg);
> +
> +	spin_lock(&list_lock);
> +	list_add_tail_rcu(&vmdirq->node, &irq->irq_list);
> +	spin_unlock(&list_lock);
> +}
> +
> +static void vmd_msi_deactivate(struct irq_domain *domain,
> +				   struct irq_data *data)
> +{
> +	struct msi_msg msg;
> +	struct vmd_irq *vmdirq = data->chip_data;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	data->chip->irq_write_msi_msg(data, &msg);
> +
> +	spin_lock(&list_lock);
> +	list_del_rcu(&vmdirq->node);
> +	spin_unlock(&list_lock);
> +}
> +
> +static const struct irq_domain_ops vmd_domain_ops = {
> +	.alloc = vmd_msi_alloc_irqs,
> +	.free = vmd_msi_free_irqs,
> +	.activate = vmd_msi_activate,
> +	.deactivate = vmd_msi_deactivate,

You nicely aligned the irq_chip above. Can you please use the same
scheme here?

> +static int vmd_enable_domain(struct vmd_dev *vmd)
> +{
> +	struct pci_sysdata *sd = &vmd->sysdata;

<SNIP>

> +	vmd->irq_domain = vmd_create_irq_domain(vmd->dev, &vmd_domain_ops);

This is the irq domain which the devices on that VMD bus are seeing, right?

> +	if (!vmd->irq_domain)
> +		return -ENODEV;

> +static void vmd_flow_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct vmd_irq_list *irqs = irq_desc_get_handler_data(desc);
> +	struct vmd_irq *vmdirq;
> +
> +	chained_irq_enter(chip, desc);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> +		generic_handle_irq(vmdirq->virq);
> +	rcu_read_unlock();

I'm not entirely sure that the rcu protection here covers the whole
virq thing when an interrupt is torn down. Can you please explain the
whole protection scheme in detail?

> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	struct vmd_dev *vmd;
> +	int i, err;
> +
> +	if (resource_size(&dev->resource[0]) < (1 << 20))
> +		return -ENOMEM;
> +
> +	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
> +	if (!vmd)
> +		return -ENOMEM;
> +
> +	vmd->dev = dev;
> +	err = pcim_enable_device(dev);
> +	if (err < 0)
> +		return err;
> +
> +	vmd->cfgbar = pcim_iomap(dev, 0, 0);
> +	if (!vmd->cfgbar)
> +		return -ENOMEM;
> +
> +	pci_set_master(dev);
> +	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
> +	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
> +		return -ENODEV;
> +
> +	vmd->msix_count = pci_msix_vec_count(dev);
> +	if (!vmd->msix_count)
> +		return -ENODEV;
> +
> +	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
> +							GFP_KERNEL);
> +	if (!vmd->irqs)
> +		return -ENOMEM;
> +
> +	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
> +					sizeof(*vmd->msix_entries), GFP_KERNEL);
> +	if(!vmd->msix_entries)
> +		return -ENOMEM;
> +	for (i = 0; i < vmd->msix_count; i++)
> +		vmd->msix_entries[i].entry = i;
> +
> +	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
> +							vmd->msix_count);

So this allocates the CPU facing MSI vectors, which are used to run
the demultiplex handler, right?

A few comments explaining the whole thing would be really
appropriate. I'm sure you'll appreciate them when you look at it
yourself a year from now.

> +	if (vmd->msix_count < 0)
> +		return vmd->msix_count;
> +
> +	for (i = 0; i < vmd->msix_count; i++) {
> +		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> +		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
> +		vmd->irqs[i].index = i;
> +
> +		irq_set_chained_handler_and_data(vmd->msix_entries[i].vector,
> +					vmd_flow_handler, &vmd->irqs[i]);
> +	}
> +	spin_lock_init(&vmd->cfg_lock);
> +	err = vmd_enable_domain(vmd);
> +	if (err)
> +		return err;

What undoes the above in case that vmd_enable_domain() fails? Same
question for all other error returns ...

> +static void vmd_remove(struct pci_dev *dev)
> +{
> +	struct vmd_dev *vmd = pci_get_drvdata(dev);
> +
> +	pci_set_drvdata(dev, NULL);
> +	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> +	pci_stop_root_bus(vmd->bus);
> +	pci_remove_root_bus(vmd->bus);
> +	vmd_teardown_dma_ops(vmd);
> +	irq_domain_remove(vmd->irq_domain);

What tears down the chained handlers and the MSIx entries?

> +EXPORT_SYMBOL_GPL(irq_chip_compose_msi_msg);
> +EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
> +EXPORT_SYMBOL_GPL(irq_domain_set_hwirq_and_chip);
> +EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);

This wants to be a seperate patch please.

Thanks,

	tglx
