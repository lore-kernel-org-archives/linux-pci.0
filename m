Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8498 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757999AbbLCDLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Dec 2015 22:11:55 -0500
Subject: Re: [PATCH v6 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@redhat.com, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
References: <1446499996-1350-1-git-send-email-jakeo@microsoft.com>
 <1446499996-1350-8-git-send-email-jakeo@microsoft.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <565FB2F5.6050504@linux.intel.com>
Date: Thu, 3 Dec 2015 11:11:49 +0800
MIME-Version: 1.0
In-Reply-To: <1446499996-1350-8-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/11/3 5:33, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch introduces a new driver which exposes a root PCI bus whenever a PCI
> Express device is passed through to a guest VM under Hyper-V. The device can
> be single- or multi-function. The interrupts for the devices are managed by an
> IRQ domain, implemented within the driver.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  MAINTAINERS                    |    1 +
>  drivers/pci/Kconfig            |    7 +
>  drivers/pci/host/Makefile      |    1 +
>  drivers/pci/host/hv_pcifront.c | 2267 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2276 insertions(+)
>  create mode 100644 drivers/pci/host/hv_pcifront.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a2d50fe..a1205b4 100644
[...]
> +/* Interrupt management hooks */
> +
> +/**
> + * hv_msi_free() - Free the MSI.
> + * @domain:	The interrupt domain pointer
> + * @info:	Extra MSI-related context
> + * @irq:	Identifies the IRQ.
> + *
> + * The Hyper-V parent partition and hypervisor are tracking the
> + * messages that are in use, keeping the interrupt redirection
> + * table up to date.  This callback sends a message that frees
> + * the the IRT entry and related tracking nonsense.
> + */
> +static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
> +			unsigned int irq)
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
> +	struct pci_dev *pdev;
> +
> +	desc = irq_to_desc(irq);
> +	msi = irq_desc_get_msi_desc(desc);
> +	pdev = msi_desc_to_pci_dev(msi);
For safety, don't assume this HV MSI irqdomain is the top domain.
So please use:
struct irq_data *irq_data = irq_domain_get_irq_data(domain, irq);
struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
struct tran_int_desc *int_desc = irq_data_get_chip_data(irq_data);

> +	hbus = info->data;
> +	hpdev = lookup_hv_dev(hbus, devfn_to_wslot(pdev->devfn));
> +	if (!hpdev)
> +		return;
> +
> +	int_desc = irq_get_chip_data(irq);
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
> +		desc->irq_data.chip_data = NULL;
> +		kfree(int_desc);
> +	}
> +
> +	hv_pcichild_dec(hpdev, hv_pcidev_ref_by_slot);
> +}
> +
> +static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
> +			   bool force)
> +{
> +	struct irq_data *parent = data->parent_data;
> +
> +	return parent->chip->irq_set_affinity(parent, dest, force);
> +}
> +
> +void hv_irq_mask(struct irq_data *data)
> +{
> +	pci_msi_mask_irq(data);
> +}
> +
> +/**
> + * hv_irq_unmask() - "Unmask" the IRQ by setting its current
> + * affinity.
> + * @data:	Describes the IRQ
> + *
> + * Build new a destination for the MSI and make a hypercall to
> + * update the Interrupt Redirection Table. "Device Logical ID"
> + * is built out of this PCI bus's instance GUID and the function
> + * number of the device.
> + */
> +void hv_irq_unmask(struct irq_data *data)
> +{
> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct retarget_msi_interrupt params;
> +	struct hv_pcibus_device *hbus;
> +	struct cpumask *dest;
> +	struct pci_bus *pbus;
> +	struct pci_dev *pdev;
> +	int cpu;
> +
> +	dest = irq_data_get_affinity_mask(data);
> +	pdev = msi_desc_to_pci_dev(msi_desc);
> +	pbus = pdev->bus;
> +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +
> +	memset(&params, 0, sizeof(params));
> +	params.partition_id = HV_PARTITION_ID_SELF;
> +	params.source = 1; /* MSI(-X) */
> +	params.address = msi_desc->msg.address_lo;
> +	params.data = msi_desc->msg.data;
> +	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> +			   (hbus->hdev->dev_instance.b[4] << 16) |
> +			   (hbus->hdev->dev_instance.b[7] << 8) |
> +			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +			   PCI_FUNC(pdev->devfn);
> +	params.vector = cfg->vector;
> +
> +	for_each_cpu_and(cpu, dest, cpu_online_mask)
> +		params.vp_mask |= (1 << vmbus_cpu_number_to_vp_number(cpu));
No knowledge about the HV implementation details, but feel some chances
of race here between hv_irq_unmask(), hv_set_affinity() and
cpu_up()/cpu_down() when accessing 'dest' and cpu_online_mask.

> +
> +	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> +
> +	pci_msi_unmask_irq(data);
> +}
> +
> +struct compose_comp_ctxt {
> +	struct hv_pci_compl comp_pkt;
> +	struct tran_int_desc int_desc;
> +};
> +
> +static void hv_pci_compose_compl(void *context, struct pci_response *resp,
> +				 int resp_packet_size)
> +{
> +	struct compose_comp_ctxt *comp_pkt = context;
> +	struct pci_create_int_response *int_resp =
> +		(struct pci_create_int_response *)resp;
> +
> +	comp_pkt->comp_pkt.completion_status = resp->status;
> +	comp_pkt->int_desc = int_resp->int_desc;
> +	complete(&comp_pkt->comp_pkt.host_event);
> +}
> +
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
> +static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct hv_pcibus_device *hbus;
> +	struct hv_pci_dev *hpdev;
> +	struct pci_bus *pbus;
> +	struct pci_dev *pdev;
> +	struct pci_create_interrupt *int_pkt;
> +	struct compose_comp_ctxt comp;
> +	struct tran_int_desc *int_desc;
> +	struct cpumask *affinity;
> +	struct {
> +		struct pci_packet pkt;
> +		u8 buffer[sizeof(struct pci_create_interrupt) -
> +			  sizeof(struct pci_message)];
> +	} ctxt;
> +	int cpu;
> +	int ret;
> +
> +	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
> +	pbus = pdev->bus;
> +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +	hpdev = lookup_hv_dev(hbus, devfn_to_wslot(pdev->devfn));
> +
> +	if (!hpdev)
> +		goto return_null_message;
> +
> +	int_desc = kzalloc(sizeof(*int_desc), GFP_KERNEL);
> +	if (!int_desc)
> +		goto drop_reference;
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
> +	 * This bit doesn't have to work on machines with more than 64
> +	 * processors because Hyper-V only supports 64 in a guest.
> +	 */
> +	affinity = irq_data_get_affinity_mask(data);
> +	for_each_cpu(cpu, affinity) {
> +		if (cpu_is_offline(cpu))
> +			continue;
> +		int_pkt->int_desc.cpu_mask |=
> +			(1 << vmbus_cpu_number_to_vp_number(cpu));
> +	}
> +
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
> +		goto free_int_desc;
> +	}
> +
> +	/*
> +	 * Record the assignment so that this can be unwound later. Using
> +	 * irq_set_chip_data() here would be appropriate, but the lock it takes
> +	 * is already held.
> +	 */
> +	*int_desc = comp.int_desc;
> +	data->chip_data = int_desc;
hv_compose_msi_msg() may be called multiple times, so seems int_desc
may get leaked.

> +
> +	/* Pass up the result. */
> +	msg->address_hi = comp.int_desc.address >> 32;
> +	msg->address_lo = comp.int_desc.address & 0xffffffff;
> +	msg->data = comp.int_desc.data;
> +
> +	hv_pcichild_dec(hpdev, hv_pcidev_ref_by_slot);
> +	return;
> +
> +free_int_desc:
> +	kfree(int_desc);
> +drop_reference:
> +	hv_pcichild_dec(hpdev, hv_pcidev_ref_by_slot);
> +return_null_message:
> +	msg->address_hi = 0;
> +	msg->address_lo = 0;
> +	msg->data = 0;
> +}
> +
> +/* HW Interrupt Chip Descriptor */
> +static struct irq_chip hv_msi_irq_chip = {
> +	.name			= "Hyper-V PCIe MSI",
> +	.irq_compose_msi_msg	= hv_compose_msi_msg,
> +	.irq_set_affinity	= hv_set_affinity,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_mask		= hv_irq_mask,
> +	.irq_unmask		= hv_irq_unmask,
> +};
> +
> +static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
> +						   msi_alloc_info_t *arg)
> +{
> +	return arg->msi_hwirq;
> +}
> +
> +/**
> + * hv_msi_set_desc() - Create a "hardware IRQ" for a message.
> + * @arg:	Describes the device
> + * @desc:	Describes the interrupt
> + *
> + * This function is derived from pci_msi_set_desc(), which
> + * creates a "hardware IRQ" based on the segment, bus, device,
> + * function and message numbers.  Here, the bus and device
> + * numbers will always be zero.  So, in the interest of more
> + * entropy, more of the bits in msi_hwirq are derived from
> + * things which will be non-zero.
> + */
It's not for entropy, but for unique. We need to uniquely identify
each MSI source because we need to look up irq number by MSI source
id. Actually we prefer to compatch the hwirq address space as small
as possible because irqdomain use a radix tree to lookup irq by hwirq.
So if bus and device number is alwasy zero, just ignore them and
compact the hwirq address space:)

> +static void hv_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +{
> +	arg->msi_hwirq = (irq_hw_number_t)desc->msi_attrib.entry_nr |
> +		(arg->msi_dev->devfn << 11) |
> +		(pci_domain_nr(arg->msi_dev->bus) & 0xFFFFFFFF) << 19;
> +}
> +
> +static struct msi_domain_ops hv_msi_ops = {
> +	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
> +	.msi_prepare	= pci_msi_prepare,
> +	.set_desc	= hv_msi_set_desc,
> +	.msi_free	= hv_msi_free,
> +};
> +
> +/**
> + * hv_pcie_free_irq_domain - Free IRQ domain
> + * @hbus:	The root PCI bus
> + */
> +static void hv_pcie_free_irq_domain(struct hv_pcibus_device *hbus)
> +{
> +	u32 irq;
> +	int i;
> +
> +	for (i = 0; i < MAX_SUPPORTED_MSI_MESSAGES; i++) {
> +		irq = irq_find_mapping(hbus->irq_domain, i);
> +		if (irq > 0)
> +			irq_dispose_mapping(irq);
> +	}
When int_desc() get called, all PCI devices, thus all PCI MSI
IRQs, should have been destroy, so seems about code is redundant.
Thanks,
Gerry
> +
> +	irq_domain_remove(hbus->irq_domain);
> +}
> +
> +/**
> + * hv_pcie_init_irq_domain() - Initialize IRQ domain
> + * @hbus:	The root PCI bus
> + *
> + * This function creates an IRQ domain which will be used for
> + * interrupts from devices that have been passed through.  These
> + * devices only support MSI and MSI-X, not line-based interrupts
> + * or simulations of line-based interrupts through PCIe's
> + * fabric-layer messages.  Because interrupts are remapped, we
> + * can support multi-message MSI here.
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
> +{
> +	hbus->msi_info.chip = &hv_msi_irq_chip;
> +	hbus->msi_info.chip_data = hbus;
> +	hbus->msi_info.ops = &hv_msi_ops;
> +	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> +		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> +		MSI_FLAG_PCI_MSIX);
> +	hbus->msi_info.handler = handle_edge_irq;
> +	hbus->msi_info.handler_name = "edge";
> +	hbus->msi_info.data = hbus;
> +	hbus->irq_domain = pci_msi_create_irq_domain(hbus->sysdata.fwnode,
> +						     &hbus->msi_info,
> +						     x86_vector_domain);
> +	if (!hbus->irq_domain) {
> +		pr_err("Failed to build an MSI IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
[...]
