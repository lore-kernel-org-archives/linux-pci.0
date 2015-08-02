Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57526 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbbHBIrv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2015 04:47:51 -0400
Date: Sun, 2 Aug 2015 10:47:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jake Oshins <jakeo@microsoft.com>
cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	LKML <linux-kernel@vger.kernel.org>,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
In-Reply-To: <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
Message-ID: <alpine.DEB.2.11.1508020948470.3825@nanos>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com> <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2 Aug 2015, jakeo@microsoft.com wrote:
> +#include <linux/kernel.h>
> +#include <linux/jiffies.h>
> +#include <linux/mman.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/kthread.h>
> +#include <linux/completion.h>
> +#include <linux/notifier.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/semaphore.h>
> +#include <linux/irqdomain.h>
> +#include <asm/irqdomain.h>
> +#include <linux/msi.h>

I seriously doubt, that you need all of these includes.

> +/* Interrupt management hooks */
> +
> +/**
> + * hv_msi_free() - Free the MSI.
> + * @domain:	The interrupt domain pointer
> + * @info:	Extra MSI-related context
> + * @virq:	Identifies the IRQ.
> + *
> + * The Hyper-V parent partition and hypervisor are tracking the
> + * messages that are in use, keeping the interrupt redirection
> + * table up to date.  This callback sends a message that frees
> + * the the IRT entry and related tracking nonsense.
> + */
> +void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
> +		 unsigned int virq)

static?

> +{
> +	struct pci_delete_interrupt *int_pkt;
> +	struct {
> +		struct pci_packet pkt;
> +		u8 buffer[sizeof(struct pci_delete_interrupt) -
> +			  sizeof(struct pci_message)];
> +	} ctxt;
> +	struct hv_pcibus_device *hbus;
> +	struct hv_pci_dev *hpdev;
> +	struct irq_desc *desc;
> +	struct msi_desc *msi;
> +	struct tran_int_desc *int_desc;
> +	struct irq_desc *irq_desc;
> +
> +	desc = irq_to_desc(virq);
> +	msi = irq_desc_get_msi_desc(desc);

Why do you need to lookup the irq descriptor if you want the msi descriptor?

> +	hbus = info->data;
> +	hpdev = lookup_hv_dev(hbus, devfn_to_wslot(msi->dev->devfn));
> +	if (!hpdev)
> +		return;
> +
> +	int_desc = irq_get_handler_data(virq);

I don't think this is a proper storage point. The data is domain/chip
specific, right? So, what's wrong with storing it in irq_data::chip_data?

> +	if (int_desc) {
> +		memset(&ctxt, 0, sizeof(ctxt));
> +		int_pkt = (struct pci_delete_interrupt *)&ctxt.pkt.message;
> +		int_pkt->message_type.message_type =
> +			PCI_DELETE_INTERRUPT_MESSAGE;
> +		int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
> +		int_pkt->int_desc = *int_desc;
> +		vmbus_sendpacket(hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
> +				 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND,
> +				 0);
> +		kfree(int_desc);

Free before clearing the reference?

> +		irq_desc = irq_to_desc(virq);

Do you expect the descriptor to change between the lookup above and
this one?

> +		irq_desc->irq_data.handler_data = NULL;

You are not supposed to fiddle in irq_desc or irq_data internals. We
have helper functions for that.

> +	}
> +
> +	hv_pcichild_dec(hpdev, hv_pcidev_ref_by_slot);
> +}
> +
> +int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
> +		    bool force)

static, if at all.

> +{
> +	struct irq_data *parent = data->parent_data;
> +
> +	return parent->chip->irq_set_affinity(parent, dest, force);
> +}

irq_chip_set_affinity_parent ???

> +/**
> + * hv_compose_msi_msg() - Supplies a valid MSI address/data
> + * @data:	Everything about this MSI
> + * @msg:	Buffer that is filled in by this function
> + *
> + * This function unpacks the IRQ looking for target CPU set, IDT
> + * vector and mode and sends a message to the parent partition
> + * asking for a mapping for that tuple in this partition.  The
> + * response supplies a data value and address to which that data
> + * should be written to trigger that interrupt.
> + */
> +void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)

static ?

> +{
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct hv_pcibus_device *hbus;
> +	struct hv_pci_dev *hpdev;
> +	struct pci_bus *pbus;
> +	struct pci_create_interrupt *int_pkt;
> +	struct compose_comp_ctxt comp;
> +	struct tran_int_desc *int_desc;
> +	struct irq_desc *irq_desc;
> +	struct {
> +		struct pci_packet pkt;
> +		u8 buffer[sizeof(struct pci_create_interrupt) -
> +			  sizeof(struct pci_message)];
> +	} ctxt;
> +	int cpu;
> +	int ret;
> +
> +	pbus = data->msi_desc->dev->bus;
> +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +	hpdev = lookup_hv_dev(hbus, devfn_to_wslot(data->msi_desc->dev->devfn));
> +
> +	if (!hpdev)
> +		goto return_null_message;
> +
> +	int_desc = kzalloc(sizeof(*int_desc), GFP_KERNEL);
> +	if (!int_desc)
> +		goto return_null_message;
> +
> +	memset(&ctxt, 0, sizeof(ctxt));
> +	init_completion(&comp.comp_pkt.host_event);
> +	ctxt.pkt.completion_func = hv_pci_compose_compl;
> +	ctxt.pkt.compl_ctxt = &comp;
> +	int_pkt = (struct pci_create_interrupt *)&ctxt.pkt.message;
> +	int_pkt->message_type.message_type = PCI_CREATE_INTERRUPT_MESSAGE;
> +	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
> +	int_pkt->int_desc.vector = cfg->vector;
> +	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.delivery_mode =
> +		(apic->irq_delivery_mode == dest_LowestPrio) ? 1 : 0;
> +
> +	/*
> +	 * Cut down interrupt targets to a single processor. Hyper-V
> +	 * currently only supports picking the target of an MSI by
> +	 * sending a message to the parent partition and receiving a
> +	 * response. This can't really work in the context of
> +	 * irq_set_affinity, which sometimes needs to run in an environment
> +	 * that can't wait for a completion.  Until a future version of
> +	 * Hyper-V exists that can retarget an interrupt without waiting,
> +	 * this code picks a single virtual processor as the target.  This
> +	 * comment and the following lines should be deleted when that
> +	 * happens.
> +	 */
> +	cpu = cpumask_any_and(data->affinity, cpu_online_mask);

We have accessors for this for a reason. data->affinity will be gone
after 4.3-rc1.

> +	cpumask_clear(data->affinity);
> +	cpumask_set_cpu(cpu, data->affinity);

> +	/*
> +	 * This bit doesn't have to work on machines with more than 64
> +	 * processors because Hyper-V only supports 64 in a guest.
> +	 */
> +	for_each_cpu(cpu, data->affinity) {
> +		if (cpu_is_offline(cpu))
> +			continue;
> +		int_pkt->int_desc.cpu_mask |=
> +			(1 << vmbus_cpu_number_to_vp_number(cpu));
> +	}

ROTFL. What's the point of this loop? To find the single already known
cpu which is in the mask?

> +	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt,
> +			       sizeof(*int_pkt), (unsigned long)&ctxt.pkt,
> +			       VM_PKT_DATA_INBAND,
> +			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (!ret)
> +		wait_for_completion(&comp.comp_pkt.host_event);
> +
> +	if (comp.comp_pkt.completion_status < 0) {
> +		pr_err("Request for interrupt failed: 0x%x",
> +		       comp.comp_pkt.completion_status);
> +		goto return_null_message;
> +	}
> +
> +	/*
> +	 * Record the assignment so that this can be unwound later. Using
> +	 * irq_set_handler_data() here would be appropriate, but the lock
> +	 * it takes is already held.
> +	 */
> +	*int_desc = comp.int_desc;
> +	irq_desc = irq_to_desc(data->irq);
> +	irq_desc->irq_data.handler_data = int_desc;

You're really a fan of redundant lookups. How is irq_desc->irq_data
going to be different from data?

> +	/* Pass up the result. */
> +	msg->address_hi = comp.int_desc.address >> 32;
> +	msg->address_lo = comp.int_desc.address & 0xffffffff;
> +	msg->data = comp.int_desc.data;
> +
> +	hv_pcichild_dec(hpdev, hv_pcidev_ref_by_slot);
> +	return;
> +
> +return_null_message:

Leaks int_desc and a refcount on hpdev.

> +	msg->address_hi = 0;
> +	msg->address_lo = 0;
> +	msg->data = 0;
> +}
> +
> +/* HW Interrupt Chip Descriptor */
> +static struct irq_chip hv_msi_irq_chip = {
> +	.name = "Hyper-V PCIe MSI",
> +	.irq_compose_msi_msg = hv_compose_msi_msg,
> +	.irq_set_affinity = hv_set_affinity,
> +	.irq_ack = irq_chip_ack_parent,

Please format this readable:

	.name			= "Hyper-V PCIe MSI",
	.irq_compose_msi_msg	= hv_compose_msi_msg,
	.irq_set_affinity	= hv_set_affinity,
	.irq_ack		= irq_chip_ack_parent,

Hmm?       

> +};
> +
> +static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
> +						   msi_alloc_info_t *arg)
> +{
> +	return arg->msi_hwirq;
> +}
> +
> +static int hv_msi_domain_ops_prepare(struct irq_domain *domain,
> +				     struct device *dev, int nvec,
> +				     msi_alloc_info_t *arg)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct msi_desc *desc = first_pci_msi_entry(pdev);
> +
> +	memset(arg, 0, sizeof(*arg));
> +	arg->msi_dev = pdev;
> +	if (desc->msi_attrib.is_msix) {
> +		arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
> +	} else {
> +		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
> +		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
> +	}
> +
> +	return 0;
> +}

Pretty much a copy of the x86 code, right?

I wonder whether this MSI infrastructure code would be better
seperated out and moved to arch/x86/hyperv/msi.c or
arch/x86/kernel/apic/hvmsi.c. It's small enough to be built in. So all
you'd need to export is hv_pcie_init_irq_domain and
hv_pcie_free_irq_domain.

Thanks,

	tglx
