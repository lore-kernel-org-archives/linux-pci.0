Return-Path: <SRS0=/A9m=4Z=oracle.com=dan.carpenter@kernel.org>
Return-Path: <SRS0=/A9m=4Z=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 19 May 2017 14:27:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jork Loeser <jloeser@microsoft.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, leann.ogasawara@canonical.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Message-ID: <20170519112701.adqxvpkorrthjf7i@mwanda>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
 <1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
List-ID: <linux-pci.vger.kernel.org>

Minor nits only.

On Thu, May 18, 2017 at 12:14:30PM -0700, Jork Loeser wrote:
> From: Jork Loeser <jloeser@microsoft.com>
> 
> Update the Hyper-V vPCI driver to use the Server-2016 version
> of the vPCI protocol, fixing MSI creation and retargeting issues.
> 
> Signed-off-by: Jork Loeser <jloeser@microsoft.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h |    6 +
>  drivers/pci/host/pci-hyperv.c      |  297 ++++++++++++++++++++++++++++++------
>  2 files changed, 255 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> index 432df4b..237ec6c 100644
> --- a/arch/x86/include/uapi/asm/hyperv.h
> +++ b/arch/x86/include/uapi/asm/hyperv.h
> @@ -153,6 +153,12 @@
>  #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
>  
>  /*
> + * HV_VP_SET available
> + */
> +#define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)

Use BIT(11).  I thought checkpatch.pl complains about this but I guess
that's only with the --strict option.

> +
> +
> +/*
>   * Crash notification flag.
>   */
>  #define HV_CRASH_CTL_CRASH_NOTIFY (1ULL << 63)
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 5f4e136..9780050 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -70,6 +70,7 @@
>  
>  enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),	/* Win10 */
> +	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
>  };
>  
>  #define CPU_AFFINITY_ALL	-1ULL
> @@ -79,6 +80,7 @@ enum pci_protocol_version_t {
>   * first.
>   */
>  static enum pci_protocol_version_t pci_protocol_versions[] = {
> +	PCI_PROTOCOL_VERSION_1_2,
>  	PCI_PROTOCOL_VERSION_1_1,
>  };
>  
> @@ -124,6 +126,9 @@ enum pci_message_type {
>  	PCI_QUERY_PROTOCOL_VERSION      = PCI_MESSAGE_BASE + 0x13,
>  	PCI_CREATE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x14,
>  	PCI_DELETE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x15,
> +	PCI_RESOURCES_ASSIGNED2		= PCI_MESSAGE_BASE + 0x16,
> +	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
> +	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
>  	PCI_MESSAGE_MAXIMUM
>  };
>  
> @@ -194,6 +199,30 @@ struct hv_msi_desc {
>  } __packed;
>  
>  /**
> + * struct hv_msi_desc2 - 1.2 version of hv_msi_desc
> + * @vector:		IDT entry
> + * @delivery_mode:	As defined in Intel's Programmer's
> + *			Reference Manual, Volume 3, Chapter 8.
> + * @vector_count:	Number of contiguous entries in the
> + *			Interrupt Descriptor Table that are
> + *			occupied by this Message-Signaled
> + *			Interrupt. For "MSI", as first defined
> + *			in PCI 2.2, this can be between 1 and
> + *			32. For "MSI-X," as first defined in PCI
> + *			3.0, this must be 1, as each MSI-X table
> + *			entry would have its own descriptor.
> + * @processor_count:	number of bits enabled in array.
> + * @processor_array:	All the target virtual processors.
> + */
> +struct hv_msi_desc2 {
> +	u8	vector;
> +	u8	delivery_mode;
> +	u16	vector_count;
> +	u16	processor_count;
> +	u16	processor_array[32];
> +} __packed;
> +
> +/**
>   * struct tran_int_desc
>   * @reserved:		unused, padding
>   * @vector_count:	same as in hv_msi_desc
> @@ -309,6 +338,14 @@ struct pci_resources_assigned {
>  	u32 reserved[4];
>  } __packed;
>  
> +struct pci_resources_assigned2 {
> +	struct pci_message message_type;
> +	union win_slot_encoding wslot;
> +	u8 memory_range[0x14][6];	/* not used here */
> +	u32 msi_descriptor_count;
> +	u8 reserved[70];
> +} __packed;
> +
>  struct pci_create_interrupt {
>  	struct pci_message message_type;
>  	union win_slot_encoding wslot;
> @@ -321,6 +358,12 @@ struct pci_create_int_response {
>  	struct tran_int_desc int_desc;
>  } __packed;
>  
> +struct pci_create_interrupt2 {
> +	struct pci_message message_type;
> +	union win_slot_encoding wslot;
> +	struct hv_msi_desc2 int_desc;
> +} __packed;
> +
>  struct pci_delete_interrupt {
>  	struct pci_message message_type;
>  	union win_slot_encoding wslot;
> @@ -346,17 +389,42 @@ struct pci_eject_response {
>  #define HV_PARTITION_ID_SELF		((u64)-1)
>  #define HVCALL_RETARGET_INTERRUPT	0x7e
>  
> -struct retarget_msi_interrupt {
> -	u64	partition_id;		/* use "self" */
> -	u64	device_id;
> +struct hv_interrupt_entry {
>  	u32	source;			/* 1 for MSI(-X) */
>  	u32	reserved1;
>  	u32	address;
>  	u32	data;
> -	u64	reserved2;
> +};
> +
> +#define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
> +
> +struct hv_vp_set {
> +	u64	format;			/* 0 (HvGenericSetSparse4k) */
> +	u64	valid_banks;
> +	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
> +};
> +
> +/*
> + * flags for hv_device_interrupt_target.flags
> + */
> +#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> +#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> +
> +struct hv_device_interrupt_target {
>  	u32	vector;
>  	u32	flags;
> -	u64	vp_mask;
> +	union {
> +		u64		 vp_mask;
> +		struct hv_vp_set vp_set;
> +	};
> +};
> +
> +struct retarget_msi_interrupt {
> +	u64	partition_id;		/* use "self" */
> +	u64	device_id;
> +	struct hv_interrupt_entry int_entry;
> +	u64	reserved2;
> +	struct hv_device_interrupt_target int_target;
>  } __packed;
>  
>  /*
> @@ -397,7 +465,10 @@ struct hv_pcibus_device {
>  	struct msi_domain_info msi_info;
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
> +
> +	/* hypercall arg, must not cross page boundary */
>  	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> +

This comment should have been merged with patch 2/4.

>  	spinlock_t retarget_msi_interrupt_lock;
>  };
>  
> @@ -802,7 +873,10 @@ static void hv_irq_unmask(struct irq_data *data)
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	int cpu;
> +	int cpu_vmbus;
>  	unsigned long flags;
> +	u64 res;
> +	u32 var_size = 0;
>  
>  	dest = irq_data_get_affinity_mask(data);
>  	pdev = msi_desc_to_pci_dev(msi_desc);
> @@ -814,23 +888,74 @@ static void hv_irq_unmask(struct irq_data *data)
>  	params = &hbus->retarget_msi_interrupt_params;
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id = HV_PARTITION_ID_SELF;
> -	params->source = 1; /* MSI(-X) */
> -	params->address = msi_desc->msg.address_lo;
> -	params->data = msi_desc->msg.data;
> +	params->int_entry.source = 1; /* MSI(-X) */
> +	params->int_entry.address = msi_desc->msg.address_lo;
> +	params->int_entry.data = msi_desc->msg.data;
>  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
>  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>  			   PCI_FUNC(pdev->devfn);
> -	params->vector = cfg->vector;
> +	params->int_target.vector = cfg->vector;
>  
> -	for_each_cpu_and(cpu, dest, cpu_online_mask)
> -		params->vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
> +	/*
> +	 * Honoring apic->irq_delivery_mode set to dest_Fixed by
> +	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
> +	 * spurious interrupt storm. Not doing so does not seem to have a
> +	 * negative effect (yet?).
> +	 */
>  
> -	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
> +	if (pci_protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
> +		/*
> +		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
> +		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
> +		 * with >64 VP support.
> +		 * ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED
> +		 * is not sufficient for this hypercall.
> +		 */
> +		params->int_target.flags |=
> +			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> +		params->int_target.vp_set.valid_banks =
> +			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
>  
> +		/*
> +		 * var-sized hypercall, var-size starts after vp_mask (thus
> +		 * vp_set.format does not count, but vp_set.valid_banks does).
> +		 */
> +		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
> +
> +		for_each_cpu_and(cpu, dest, cpu_online_mask) {
> +			cpu_vmbus = vmbus_cpu_number_to_vp_number(cpu);
> +
> +			if (cpu_vmbus >= HV_VP_SET_BANK_COUNT_MAX * 64) {
> +				dev_err(&hbus->hdev->device,
> +					"too high CPU %d", cpu_vmbus);
> +				res = 1;
> +				goto exit_unlock;
> +			}
> +
> +			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
> +				(1ULL << (cpu_vmbus & 63));
> +		}
> +	} else {
> +		for_each_cpu_and(cpu, dest, cpu_online_mask) {
> +			params->int_target.vp_mask |=
> +				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
> +		}
> +	}
> +
> +	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
> +			      params, NULL);

I don't understand what hv_do_hypercall() is supposed to return.  The
lower 16 bits are an error code but what about the other 48 bits?  There
are no comments on the function.

> +
> +exit_unlock:
>  	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
>  
> +	if (res) {
> +		dev_err(&hbus->hdev->device,
> +			"%s() failed: %#llx", __func__, res);
> +		return;
> +	}
> +
>  	pci_msi_unmask_irq(data);
>  }
>  
> @@ -851,6 +976,53 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
>  	complete(&comp_pkt->comp_pkt.host_event);
>  }
>  
> +static u32 hv_compose_msi_req_v1(
> +	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
> +	u32 slot, u8 vector)
> +{
> +	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
> +	int_pkt->wslot.slot = slot;
> +	int_pkt->int_desc.vector = vector;
> +	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.delivery_mode =
> +		(apic->irq_delivery_mode == dest_LowestPrio) ?
> +			dest_LowestPrio : dest_Fixed;
> +
> +	/*
> +	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
> +	 * hv_irq_unmask().
> +	 */
> +	int_pkt->int_desc.cpu_mask = CPU_AFFINITY_ALL;
> +
> +	return sizeof(*int_pkt);
> +}
> +
> +static u32 hv_compose_msi_req_v2(
> +	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> +	u32 slot, u8 vector)
> +{
> +	int cpu;
> +
> +	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE2;
> +	int_pkt->wslot.slot = slot;
> +	int_pkt->int_desc.vector = vector;
> +	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.delivery_mode =
> +		(apic->irq_delivery_mode == dest_LowestPrio) ?
> +			dest_LowestPrio : dest_Fixed;
> +
> +	/*
> +	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> +	 * by subsequent retarget in hv_irq_unmask().
> +	 */
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> +	int_pkt->int_desc.processor_array[0] =
> +		vmbus_cpu_number_to_vp_number(cpu);
> +	int_pkt->int_desc.processor_count = 1;
> +
> +	return sizeof(*int_pkt);
> +}
> +
>  /**
>   * hv_compose_msi_msg() - Supplies a valid MSI address/data
>   * @data:	Everything about this MSI
> @@ -869,15 +1041,17 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct hv_pci_dev *hpdev;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
> -	struct pci_create_interrupt *int_pkt;
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
> -	struct cpumask *affinity;
>  	struct {
> -		struct pci_packet pkt;
> -		u8 buffer[sizeof(struct pci_create_interrupt)];
> -	} ctxt;
> -	int cpu;
> +		struct pci_packet pci_pkt;
> +		union {
> +			struct pci_create_interrupt v1;
> +			struct pci_create_interrupt2 v2;
> +		} int_pkts;
> +	} __packed ctxt;
> +
> +	u32 size;
>  	int ret;
>  
>  	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
> @@ -900,36 +1074,42 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  	memset(&ctxt, 0, sizeof(ctxt));
>  	init_completion(&comp.comp_pkt.host_event);
> -	ctxt.pkt.completion_func = hv_pci_compose_compl;
> -	ctxt.pkt.compl_ctxt = &comp;
> -	int_pkt = (struct pci_create_interrupt *)&ctxt.pkt.message;
> -	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
> -	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
> -	int_pkt->int_desc.vector = cfg->vector;
> -	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode =
> -		(apic->irq_delivery_mode == dest_LowestPrio) ? 1 : 0;
> +	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
> +	ctxt.pci_pkt.compl_ctxt = &comp;
> +
> +	switch (pci_protocol_version) {
> +	case PCI_PROTOCOL_VERSION_1_1:
> +		size = hv_compose_msi_req_v1(
> +			&ctxt.int_pkts.v1, irq_data_get_affinity_mask(data),
> +			hpdev->desc.win_slot.slot, cfg->vector);


Align it like:

		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
					     irq_data_get_affinity_mask(data),
					     hpdev->desc.win_slot.slot,
					     cfg->vector);
> +		break;
>  
> -	/*
> -	 * This bit doesn't have to work on machines with more than 64
> -	 * processors because Hyper-V only supports 64 in a guest.
> -	 */
> -	affinity = irq_data_get_affinity_mask(data);
> -	if (cpumask_weight(affinity) >= 32) {
> -		int_pkt->int_desc.cpu_mask = CPU_AFFINITY_ALL;
> -	} else {
> -		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
> -			int_pkt->int_desc.cpu_mask |=
> -				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
> -		}
> +	case PCI_PROTOCOL_VERSION_1_2:
> +		size = hv_compose_msi_req_v2(
> +			&ctxt.int_pkts.v2, irq_data_get_affinity_mask(data),
> +			hpdev->desc.win_slot.slot, cfg->vector);
> +		break;
> +
> +	default:
> +		/* As we only negotiate protocol versions known to this driver,
> +		 * this path should never hit. However, this is it not a hot
> +		 * path so we print a message to aid future updates.
> +		 */
> +		dev_err(&hbus->hdev->device,
> +			"Unexpected vPCI protocol, update driver.");

We should check the protocol version in probe() instead of here.

> +		goto free_int_desc;
>  	}
>  
> -	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt,
> -			       sizeof(*int_pkt), (unsigned long)&ctxt.pkt,
> +	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> +			       size, (unsigned long)&ctxt.pci_pkt,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&hbus->hdev->device,
> +			"Sending request for interrupt failed: 0x%x",
> +			comp.comp_pkt.completion_status);
>  		goto free_int_desc;
> +	}
>  
>  	wait_for_completion(&comp.comp_pkt.host_event);
>  
> @@ -1834,7 +2014,12 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
>  
>  	for (i = 0; i < ARRAY_SIZE(pci_protocol_versions); i++) {
> +
> +		dev_info(&hdev->device, "PCI VMBus probing version %x\n",
> +			pci_protocol_versions[i]);

We already have too many debugging printks in this loop.  Just delete
it.

> +
>  		version_req->protocol_version = pci_protocol_versions[i];
> +
>  		ret = vmbus_sendpacket(
>  			hdev->channel, version_req,
>  			sizeof(struct pci_version_request),
> @@ -2126,13 +2311,18 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
>  	struct pci_resources_assigned *res_assigned;
> +	struct pci_resources_assigned2 *res_assigned2;
>  	struct hv_pci_compl comp_pkt;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_packet *pkt;
>  	u32 wslot;
>  	int ret;
> +	size_t sizeRes;



Use size_res instead of CamelCase.

>  
> -	pkt = kmalloc(sizeof(*pkt) + sizeof(*res_assigned), GFP_KERNEL);
> +	sizeRes = (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2)
> +			? sizeof(*res_assigned) : sizeof(*res_assigned2);
> +
> +	pkt = kmalloc(sizeof(*pkt) + sizeRes, GFP_KERNEL);
>  	if (!pkt)
>  		return -ENOMEM;
>  
> @@ -2143,19 +2333,29 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  		if (!hpdev)
>  			continue;
>  
> -		memset(pkt, 0, sizeof(*pkt) + sizeof(*res_assigned));
> +		memset(pkt, 0, sizeof(*pkt) + sizeRes);
>  		init_completion(&comp_pkt.host_event);
>  		pkt->completion_func = hv_pci_generic_compl;
>  		pkt->compl_ctxt = &comp_pkt;
> -		res_assigned = (struct pci_resources_assigned *)&pkt->message;
> -		res_assigned->message_type.type = PCI_RESOURCES_ASSIGNED;
> -		res_assigned->wslot.slot = hpdev->desc.win_slot.slot;
>  
> +		if (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2) {
> +			res_assigned =
> +				(struct pci_resources_assigned *)&pkt->message;
> +			res_assigned->message_type.type =
> +				PCI_RESOURCES_ASSIGNED;
> +			res_assigned->wslot.slot = hpdev->desc.win_slot.slot;
> +		} else {
> +			res_assigned2 =
> +				(struct pci_resources_assigned2 *)&pkt->message;
> +			res_assigned2->message_type.type =
> +				PCI_RESOURCES_ASSIGNED2;
> +			res_assigned2->wslot.slot = hpdev->desc.win_slot.slot;
> +		}
>  		put_pcichild(hpdev, hv_pcidev_ref_by_slot);
>  
>  		ret = vmbus_sendpacket(
>  			hdev->channel, &pkt->message,
> -			sizeof(*res_assigned),
> +			sizeRes,
>  			(unsigned long)pkt,
>  			VM_PKT_DATA_INBAND,
>  			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -2424,6 +2624,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> +
>  	free_page((unsigned long)hbus);

This white space change should be in patch 2/4.

>  	return 0;
>  }

regards,
dan carpenter
