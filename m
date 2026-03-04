Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD841A682D;
	Wed,  4 Mar 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633941; cv=none; b=XtJvIPbQBDucR+soZzO6jcEf/JfNkc/bPbQn0mrXQhSD4MM9wVF3EvTSmFiO2GLlJmJF39vWuqLnYoxkOekpR8GklC8fgU1D2RgOsBvmMeMhU3fvVq6EaFkOE2K6+g1XV3LPKFIzQ7HdYNO0EJ+Xu0ACq/fD7hjome8E617YTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633941; c=relaxed/simple;
	bh=r+Jj++BxtL2q6btD+3HmGeqTaPfodzuDIhIecCJ5zjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIGhEG4V/cvetq1nJ25YuLk0roaYcYSHvcPSj61X5x9+H0PAtvHjdxqRt85ZnTVQ9xFsUrTwaHR8XkpwugCK6HapG8ZvefF2W9rc92+gu17rcnbqE/BTxHM5X2Lii1sE7DkJaXp/PT4GMZIvNZ2ODvj472eU88ebt1JpcqKiqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C83yQcKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C83yQcKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A1C2BCB6;
	Wed,  4 Mar 2026 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772633940;
	bh=r+Jj++BxtL2q6btD+3HmGeqTaPfodzuDIhIecCJ5zjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C83yQcKOBcAmQlGeWbMm853nLAzKY8hscAlerR9g5iy1Hb/wfzX8gCASyAG6+aUmZ
	 UTb8FGywqeb7o42fnHa/WyeYWAmTuKgPULdvDKLoCjXttsU8lOBMhJC538HzMyoZTN
	 aIDyTmW1HMdi4uBaOGkl4IdegAtfVbNIaXLC4/PbebWnwN2bxfuG+rXlZnyRqUh8+J
	 namDV2SJKAlZspoX+vmRBYzsvkacfP8RGCEJh9/2E9jMV0a2iNq3b9yThjpSJEvHol
	 NmE5mAMU07fUghwRwYbHZ+Uh/IOCBy2VbT+ujW12hU/DPdDW8r+N2cAKq3DQ5UjSPI
	 gDSO45tl2beIg==
Date: Wed, 4 Mar 2026 19:48:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net, cassel@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 3/4] PCI/DOE: Add DOE mailbox support for endpoint
 functions
Message-ID: <m7zyatomfy37j3dmvefkxr2waokhgj3qjl65fsnn7tsug3bti4@q77qhwwmauwo>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-4-a-garg7@ti.com>
 <1907366a-e6d6-41ac-b61d-6e65e9dafe9a@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1907366a-e6d6-41ac-b61d-6e65e9dafe9a@alistair23.me>

On Wed, Feb 18, 2026 at 02:28:23PM +1000, Alistair Francis wrote:
> On 13/2/26 22:36, Aksh Garg wrote:
> > From: Aksh Garg <a-garg7@ti.com>
> > 
> > DOE (Data Object Exchange) is a standard PCIe extended capability
> > feature introduced in the Data Object Exchange (DOE) ECN for
> > PCIe r5.0. It provides a communication mechanism primarily used for
> > implementing PCIe security features such as device authentication, and
> > secure link establishment. Think of DOE as a sophisticated mailbox
> > system built into PCIe. The root complex can send structured requests
> > to the endpoint device through DOE mailboxes, and the endpoint device
> > responds with appropriate data.
> > 
> > Add the DOE support for PCIe endpoint devices, enabling endpoint
> > functions to process the DOE requests from the host. The implementation
> > provides framework APIs for controller drivers to register mailboxes,
> > protocol handler registration for different DOE data object types, and
> > request processing with workqueues ensuring sequential handling per
> > mailbox. The Discovery protocol is handled internally by the DOE core.
> > 
> > This implementation complements the existing DOE implementation for
> > root complex in drivers/pci/doe.c.
> 
> This looks good to me!
> 
> I would love to see a handler implementation and integration with a driver
> as well.
> 
> For SPDM the handler could even be in userspace
> 

+1. We should not be introducing dead APIs.

- Mani

> Alistair
> 
> > 
> > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Aksh Garg <a-garg7@ti.com>
> > ---
> >   drivers/pci/Kconfig     |  14 +
> >   drivers/pci/Makefile    |   1 +
> >   drivers/pci/doe-ep.c    | 671 ++++++++++++++++++++++++++++++++++++++++
> >   include/linux/pci-doe.h |  69 +++++
> >   include/linux/pci-epc.h |   4 +
> >   5 files changed, 759 insertions(+)
> >   create mode 100644 drivers/pci/doe-ep.c
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index e3f848ffb52a..2a57a314054c 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -146,6 +146,20 @@ config PCI_DOE
> >   	  Say Y here if you want be able to communicate with PCIe DOE
> >   	  mailboxes.
> > +config PCI_DOE_EP
> > +	bool "PCI Endpoint Data Object Exchange (DOE) support"
> > +	depends on PCI_ENDPOINT
> > +	help
> > +	  This enables support for Data Object Exchange (DOE) protocol
> > +	  on PCI Endpoint controllers. It provides a communication
> > +	  mechanism through mailboxes, primarily used for PCIe security
> > +	  features.
> > +
> > +	  Say Y here if you want be able to communicate using PCIe DOE
> > +	  mailboxes.
> > +
> > +	  If unsure, say N.
> > +
> >   config PCI_ECAM
> >   	bool
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index e10cfe5a280b..66084e2ef9b2 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
> >   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> >   obj-$(CONFIG_PCI_DOE)		+= doe.o
> > +obj-$(CONFIG_PCI_DOE_EP)	+= doe-ep.o
> >   obj-$(CONFIG_PCI_IDE)		+= ide.o
> >   obj-$(CONFIG_PCI_TSM)		+= tsm.o
> >   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> > diff --git a/drivers/pci/doe-ep.c b/drivers/pci/doe-ep.c
> > new file mode 100644
> > index 000000000000..ff0551644f54
> > --- /dev/null
> > +++ b/drivers/pci/doe-ep.c
> > @@ -0,0 +1,671 @@
> > +// SPDX-License-Identifier: GPL-2.0-only or MIT
> > +/*
> > + * Data Object Exchange for PCIe Endpoint
> > + *	PCIe r7.0, sec 6.30 DOE
> > + *
> > + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com
> > + *	Aksh Garg <a-garg7@ti.com>
> > + *	Siddharth Vadapalli <s-vadapalli@ti.com>
> > + */
> > +
> > +#define dev_fmt(fmt) "DOE EP: " fmt
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/slab.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/xarray.h>
> > +
> > +/*
> > + * Combines function number and capability offset into a unique lookup key
> > + * for storing/retrieving DOE mailboxes in an xarray.
> > + */
> > +#define PCI_DOE_MB_KEY(func, offset) \
> > +	(((unsigned long)(func) << 16) | (offset))
> > +
> > +/**
> > + * struct pci_doe_protocol - DOE protocol handler entry
> > + * @vid: Vendor ID
> > + * @type: Protocol type
> > + * @handler: Handler function pointer
> > + */
> > +struct pci_doe_protocol {
> > +	u16 vid;
> > +	u8 type;
> > +	pci_doe_protocol_handler_t handler;
> > +};
> > +
> > +/*
> > + * Global registry of protocol handlers,
> > + * holding struct pci_doe_protocol
> > + */
> > +static DEFINE_XARRAY_ALLOC(pci_doe_protocols);
> > +
> > +/* Serializes concurrent accesses to pci_doe_protocols xarray */
> > +static DEFINE_MUTEX(protocols_mutex);
> > +
> > +/**
> > + * struct pci_ep_doe_mb - State for a single DOE mailbox on EP
> > + *
> > + * This state is used to manage a single DOE mailbox capability on the
> > + * endpoint side.
> > + *
> > + * @epc: PCI endpoint controller this mailbox belongs to
> > + * @func_no: Physical function number of the function this mailbox belongs to
> > + * @cap_offset: Capability offset
> > + * @work_queue: Queue of work items
> > + * @flags: Bit array of PCI_DOE_FLAG_* flags
> > + */
> > +struct pci_ep_doe_mb {
> > +	struct pci_epc *epc;
> > +	u8 func_no;
> > +	u16 cap_offset;
> > +	struct workqueue_struct *work_queue;
> > +	unsigned long flags;
> > +};
> > +
> > +/**
> > + * struct pci_ep_doe_task - Represents a single DOE request/response task
> > + *
> > + * @feat: DOE feature (vendor ID and type)
> > + * @request_pl: Request payload
> > + * @request_pl_sz: Size of request payload in bytes
> > + * @response_pl: Output pointer for response buffer
> > + * @response_pl_sz: Output pointer for response size
> > + * @task_status: Task completion status (0 on success, -errno on failure)
> > + * @complete: Completion callback
> > + * @private: Private data for completion
> > + * @work: Work structure for workqueue
> > + * @doe_mb: DOE mailbox handling this task
> > + */
> > +struct pci_ep_doe_task {
> > +	struct pci_doe_feature feat;
> > +	const void *request_pl;
> > +	size_t request_pl_sz;
> > +	void **response_pl;
> > +	size_t *response_pl_sz;
> > +	int task_status;
> > +	void (*complete)(struct pci_ep_doe_task *task);
> > +	void *private;
> > +
> > +	/* Initialized by pci_ep_doe_submit_task() */
> > +	struct work_struct work;
> > +	struct pci_ep_doe_mb *doe_mb;
> > +};
> > +
> > +/**
> > + * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
> > + * @epc: PCI endpoint controller
> > + *
> > + * Initialize the DOE framework data structures. This only initializes
> > + * the xarray that will hold the mailboxes.
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +int pci_ep_doe_init(struct pci_epc *epc)
> > +{
> > +	if (!epc)
> > +		return -EINVAL;
> > +
> > +	xa_init(&epc->doe_mbs);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_init);
> > +
> > +/**
> > + * pci_ep_doe_add_mailbox() - Add a DOE mailbox for a physical function
> > + * @epc: PCI endpoint controller
> > + * @func_no: Physical function number
> > + * @cap_offset: Offset of the DOE capability
> > + *
> > + * Create and register a DOE mailbox for the specified physical function
> > + * and capability offset. The controller driver should call this for each
> > + * DOE capability it finds in its config space.
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> > +{
> > +	struct pci_ep_doe_mb *doe_mb;
> > +	unsigned long key;
> > +	int ret;
> > +
> > +	if (!epc)
> > +		return -EINVAL;
> > +
> > +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
> > +	if (!doe_mb)
> > +		return -ENOMEM;
> > +
> > +	doe_mb->epc = epc;
> > +	doe_mb->func_no = func_no;
> > +	doe_mb->cap_offset = cap_offset;
> > +
> > +	doe_mb->work_queue = alloc_ordered_workqueue("pci_ep_doe[%s:pf%d:offset%x]", 0,
> > +						     dev_name(&epc->dev),
> > +						     func_no, cap_offset);
> > +	if (!doe_mb->work_queue) {
> > +		dev_err(epc->dev.parent,
> > +			"[pf%d:offset%x] failed to allocate work queue\n",
> > +			func_no, cap_offset);
> > +		ret = -ENOMEM;
> > +		goto err_free;
> > +	}
> > +
> > +	/* Add to xarray with composite key */
> > +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
> > +	ret = xa_insert(&epc->doe_mbs, key, doe_mb, GFP_KERNEL);
> > +	if (ret) {
> > +		dev_err(epc->dev.parent,
> > +			"[pf%d:offset%x] failed to insert mailbox: %d\n",
> > +			func_no, cap_offset, ret);
> > +		goto err_destroy;
> > +	}
> > +
> > +	dev_dbg(epc->dev.parent,
> > +		"DOE mailbox added: pf%d offset 0x%x\n",
> > +		func_no, cap_offset);
> > +
> > +	return 0;
> > +
> > +err_destroy:
> > +	destroy_workqueue(doe_mb->work_queue);
> > +err_free:
> > +	kfree(doe_mb);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_add_mailbox);
> > +
> > +/**
> > + * pci_ep_doe_register_protocol() - Register a protocol handler
> > + * @vendor: Vendor ID
> > + * @type: Protocol type
> > + * @handler: Handler function pointer
> > + *
> > + * Register a protocol handler that will be called when DOE requests
> > + * with the specified vendor ID and type are received. Protocol libraries
> > + * should call this during module initialization.
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +int pci_ep_doe_register_protocol(u16 vendor, u8 type,
> > +				 pci_doe_protocol_handler_t handler)
> > +{
> > +	struct pci_doe_protocol *protocol;
> > +	unsigned long index;
> > +	int ret;
> > +	u32 id;
> > +
> > +	if (!handler)
> > +		return -EINVAL;
> > +
> > +	/* Don't allow registering discovery protocol */
> > +	if (vendor == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_FEATURE_DISCOVERY)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&protocols_mutex);
> > +
> > +	/* Check if already registered */
> > +	xa_for_each(&pci_doe_protocols, index, protocol) {
> > +		if (protocol->vid == vendor && protocol->type == type) {
> > +			ret = -EEXIST;
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	protocol = kzalloc(sizeof(*protocol), GFP_KERNEL);
> > +	if (!protocol) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	protocol->vid = vendor;
> > +	protocol->type = type;
> > +	protocol->handler = handler;
> > +
> > +	ret = xa_alloc(&pci_doe_protocols, &id, protocol,
> > +		       xa_limit_32b, GFP_KERNEL);
> > +	if (ret) {
> > +		kfree(protocol);
> > +		goto err;
> > +	}
> > +
> > +	mutex_unlock(&protocols_mutex);
> > +
> > +	pr_debug("DOE EP: Registered protocol %04x:%02x at index %u\n",
> > +		 vendor, type, id);
> > +
> > +	return 0;
> > +
> > +err:
> > +	mutex_unlock(&protocols_mutex);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_register_protocol);
> > +
> > +/**
> > + * pci_ep_doe_unregister_protocol() - Unregister a protocol handler
> > + * @vendor: Vendor ID
> > + * @type: Protocol type
> > + *
> > + * Unregister a previously registered protocol handler. Protocol libraries
> > + * should call this during module cleanup.
> > + */
> > +void pci_ep_doe_unregister_protocol(u16 vendor, u8 type)
> > +{
> > +	struct pci_doe_protocol *protocol;
> > +	unsigned long index;
> > +
> > +	mutex_lock(&protocols_mutex);
> > +
> > +	/* Find and remove the protocol entry */
> > +	xa_for_each(&pci_doe_protocols, index, protocol) {
> > +		if (protocol->vid == vendor && protocol->type == type) {
> > +			xa_erase(&pci_doe_protocols, index);
> > +			kfree(protocol);
> > +			mutex_unlock(&protocols_mutex);
> > +			pr_debug("DOE EP: Unregistered protocol %04x:%02x\n",
> > +				 vendor, type);
> > +			return;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&protocols_mutex);
> > +	pr_warn("DOE EP: Attempted to unregister non-existent protocol %04x:%02x\n",
> > +		vendor, type);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_unregister_protocol);
> > +
> > +/**
> > + * pci_ep_doe_cancel_tasks() - Cancel all pending tasks
> > + * @doe_mb: DOE mailbox
> > + *
> > + * Cancel all pending tasks in the mailbox. Mark the mailbox as dead
> > + * so no new tasks can be submitted.
> > + */
> > +static void pci_ep_doe_cancel_tasks(struct pci_ep_doe_mb *doe_mb)
> > +{
> > +	if (!doe_mb)
> > +		return;
> > +
> > +	/* Mark the mailbox as dead */
> > +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > +
> > +	/* Stop all pending work items from starting */
> > +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > +}
> > +
> > +/**
> > + * pci_ep_doe_get_mailbox() - Get DOE mailbox by function and offset
> > + * @epc: PCI endpoint controller
> > + * @func_no: Physical function number
> > + * @cap_offset: Offset of the DOE capability
> > + *
> > + * Internal helper to look up a DOE mailbox by its function number and
> > + * capability offset.
> > + *
> > + * RETURNS: Pointer to the mailbox or NULL if not found
> > + */
> > +static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
> > +						    u8 func_no, u16 cap_offset)
> > +{
> > +	unsigned long key;
> > +
> > +	if (!epc)
> > +		return NULL;
> > +
> > +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
> > +	return xa_load(&epc->doe_mbs, key);
> > +}
> > +
> > +/**
> > + * pci_ep_doe_find_protocol() - Find protocol handler
> > + * @vendor: Vendor ID
> > + * @type: Protocol type
> > + *
> > + * Look up a protocol handler in the registered protocols.
> > + *
> > + * RETURNS: Handler function pointer or NULL if not found
> > + */
> > +static pci_doe_protocol_handler_t pci_ep_doe_find_protocol(u16 vendor, u8 type)
> > +{
> > +	pci_doe_protocol_handler_t handler = NULL;
> > +	struct pci_doe_protocol *protocol;
> > +	unsigned long index;
> > +
> > +	mutex_lock(&protocols_mutex);
> > +
> > +	xa_for_each(&pci_doe_protocols, index, protocol) {
> > +		if (protocol->vid == vendor && protocol->type == type) {
> > +			handler = protocol->handler;
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&protocols_mutex);
> > +	return handler;
> > +}
> > +
> > +/**
> > + * pci_ep_doe_handle_discovery() - Handle Discovery protocol request
> > + * @request: Request payload
> > + * @request_sz: Request size
> > + * @response: Output pointer for response buffer
> > + * @response_sz: Output pointer for response size
> > + *
> > + * Handle the DOE Discovery protocol. The request contains an index specifying
> > + * which protocol to query. This function creates a response containing the
> > + * vendor ID and protocol type for the requested index, along with the next
> > + * index value for further discovery:
> > + *
> > + * - next_index = 0: Signals this is the last protocol supported
> > + * - next_index = n (non-zero): Signals more protocols available,
> > + *   query index n next
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +static int pci_ep_doe_handle_discovery(const void *request, size_t request_sz,
> > +				       void **response, size_t *response_sz)
> > +{
> > +	struct pci_doe_protocol *protocol;
> > +	u8 requested_index, next_index;
> > +	unsigned long index;
> > +	u8 xarray_count = 0;
> > +	u32 *response_pl;
> > +	u32 request_pl;
> > +	u16 vendor;
> > +	u8 type;
> > +
> > +	if (request_sz != sizeof(u32))
> > +		return -EINVAL;
> > +
> > +	request_pl = *(u32 *)request;
> > +	requested_index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, request_pl);
> > +
> > +	mutex_lock(&protocols_mutex);
> > +
> > +	/* Count protocols in xarray */
> > +	xa_for_each(&pci_doe_protocols, index, protocol)
> > +		xarray_count++;
> > +
> > +	if (requested_index > xarray_count) {
> > +		mutex_unlock(&protocols_mutex);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Index 0 is always Discovery protocol */
> > +	if (requested_index == 0) {
> > +		vendor = PCI_VENDOR_ID_PCI_SIG;
> > +		type = PCI_DOE_FEATURE_DISCOVERY;
> > +	} else {
> > +		protocol = xa_load(&pci_doe_protocols, (unsigned long)(requested_index - 1));
> > +		if (!protocol) {
> > +			mutex_unlock(&protocols_mutex);
> > +			return -EINVAL;
> > +		}
> > +		vendor = protocol->vid;
> > +		type = protocol->type;
> > +	}
> > +	mutex_unlock(&protocols_mutex);
> > +
> > +	/* Calculate next index */
> > +	next_index = (requested_index < xarray_count) ? requested_index + 1 : 0;
> > +
> > +	response_pl = kzalloc(sizeof(*response_pl), GFP_KERNEL);
> > +	if (!response_pl)
> > +		return -ENOMEM;
> > +
> > +	/* Build response */
> > +	*response_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, vendor) |
> > +		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE, type) |
> > +		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, next_index);
> > +
> > +	*response = response_pl;
> > +	*response_sz = sizeof(*response_pl);
> > +
> > +	return 0;
> > +}
> > +
> > +static void signal_task_complete(struct pci_ep_doe_task *task, int status)
> > +{
> > +	task->task_status = status;
> > +	destroy_work_on_stack(&task->work);
> > +	task->complete(task);
> > +}
> > +
> > +/**
> > + * doe_ep_task_work() - Work function for processing DOE EP tasks
> > + * @work: Work structure
> > + *
> > + * Process a DOE request by calling the appropriate protocol handler.
> > + */
> > +static void doe_ep_task_work(struct work_struct *work)
> > +{
> > +	struct pci_ep_doe_task *task = container_of(work, struct pci_ep_doe_task,
> > +						    work);
> > +	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
> > +	pci_doe_protocol_handler_t handler;
> > +	int rc;
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > +		signal_task_complete(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	/* Check if request was aborted */
> > +	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
> > +		signal_task_complete(task, -ECANCELED);
> > +		return;
> > +	}
> > +
> > +	/* Handle Discovery protocol directly */
> > +	if (task->feat.vid == PCI_VENDOR_ID_PCI_SIG &&
> > +	    task->feat.type == PCI_DOE_FEATURE_DISCOVERY) {
> > +		rc = pci_ep_doe_handle_discovery(task->request_pl,
> > +						 task->request_pl_sz,
> > +						 task->response_pl,
> > +						 task->response_pl_sz);
> > +		signal_task_complete(task, rc);
> > +		return;
> > +	}
> > +
> > +	/* Find protocol handler in xarray */
> > +	handler = pci_ep_doe_find_protocol(task->feat.vid, task->feat.type);
> > +	if (!handler) {
> > +		dev_warn(doe_mb->epc->dev.parent,
> > +			 "[%d:%x] Unsupported protocol VID=%04x TYPE=%02x\n",
> > +			 doe_mb->func_no, doe_mb->cap_offset,
> > +			 task->feat.vid, task->feat.type);
> > +		signal_task_complete(task, -EOPNOTSUPP);
> > +		return;
> > +	}
> > +
> > +	/* Call protocol handler */
> > +	rc = handler(task->request_pl, task->request_pl_sz,
> > +		     task->response_pl, task->response_pl_sz);
> > +
> > +	signal_task_complete(task, rc);
> > +}
> > +
> > +/**
> > + * pci_ep_doe_submit_task() - Submit a task to be processed
> > + * @doe_mb: DOE mailbox
> > + * @task: Task to submit
> > + *
> > + * Submit a DOE task to the workqueue for processing.
> > + * Task must be allocated on the stack.
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +static int pci_ep_doe_submit_task(struct pci_ep_doe_mb *doe_mb,
> > +				  struct pci_ep_doe_task *task)
> > +{
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > +		return -EIO;
> > +
> > +	task->doe_mb = doe_mb;
> > +	INIT_WORK_ONSTACK(&task->work, doe_ep_task_work);
> > +	queue_work(doe_mb->work_queue, &task->work);
> > +	return 0;
> > +}
> > +
> > +static void pci_ep_doe_task_complete(struct pci_ep_doe_task *task)
> > +{
> > +	complete(task->private);
> > +}
> > +
> > +/**
> > + * pci_ep_doe_process_request() - Process DOE request on endpoint
> > + * @epc: PCI endpoint controller
> > + * @func_no: Physical function number
> > + * @cap_offset: DOE capability offset
> > + * @vendor: Vendor ID from request header
> > + * @type: Protocol type from request header
> > + * @request: Request payload in CPU-native format
> > + * @request_sz: Size of request payload (bytes)
> > + * @response: Output pointer for response buffer in CPU-native format
> > + * @response_sz: Output pointer for response size (bytes)
> > + *
> > + * Process a DOE request received on the endpoint. The request payload should
> > + * not include the DOE header (vendor/type/length). The protocol handler will
> > + * allocate the response buffer, which the caller (controller driver) must
> > + * free after use.
> > + *
> > + * As per DOE specification, a mailbox processes one request at a time.
> > + * Therefore, this function will never be called concurrently for the same
> > + * mailbox by different callers.
> > + *
> > + * The caller is responsible for the conversion of the received DOE request
> > + * with le32_to_cpu() before calling this function.
> > + * Similarly, it is responsible for converting the response payload with
> > + * cpu_to_le32() before sending it back over the DOE mailbox.
> > + *
> > + * The caller is also responsible for ensuring that the request size
> > + * is within the limits defined by PCI_DOE_MAX_LENGTH.
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> > +			       u16 vendor, u8 type, const void *request,
> > +			       size_t request_sz, void **response, size_t *response_sz)
> > +{
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_ep_doe_mb *doe_mb;
> > +	struct pci_ep_doe_task task = {
> > +		.feat.vid = vendor,
> > +		.feat.type = type,
> > +		.request_pl = request,
> > +		.request_pl_sz = request_sz,
> > +		.response_pl = response,
> > +		.response_pl_sz = response_sz,
> > +		.complete = pci_ep_doe_task_complete,
> > +		.private = &c,
> > +	};
> > +	int rc;
> > +
> > +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> > +	if (!doe_mb)
> > +		return -ENODEV;
> > +
> > +	rc = pci_ep_doe_submit_task(doe_mb, &task);
> > +	if (rc)
> > +		return rc;
> > +
> > +	wait_for_completion(&c);
> > +
> > +	return task.task_status;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
> > +
> > +/**
> > + * pci_ep_doe_abort() - Abort DOE operations on a mailbox
> > + * @epc: PCI endpoint controller
> > + * @func_no: Physical function number
> > + * @cap_offset: DOE capability offset
> > + *
> > + * Abort all queued and wait for in-flight DOE operations to complete for the
> > + * specified mailbox. This function is called by the EP controller driver
> > + * when the RC sets the ABORT bit in the DOE Control register.
> > + *
> > + * The function will:
> > + *
> > + * - Set CANCEL flag to prevent new requests in the queue from starting
> > + * - Wait for the currently executing handler to complete (cannot interrupt)
> > + * - Flush the workqueue to wait for all requests to be handled appropriately
> > + * - Clear CANCEL flag to prepare for new requests
> > + *
> > + * RETURNS: 0 on success, -errno on failure
> > + */
> > +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> > +{
> > +	struct pci_ep_doe_mb *doe_mb;
> > +
> > +	if (!epc)
> > +		return -EINVAL;
> > +
> > +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> > +	if (!doe_mb)
> > +		return -ENODEV;
> > +
> > +	/* Set CANCEL flag - worker will abort queued requests */
> > +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > +	flush_workqueue(doe_mb->work_queue);
> > +
> > +	/* Clear CANCEL flag - mailbox ready for new requests */
> > +	clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > +
> > +	dev_dbg(epc->dev.parent,
> > +		"DOE mailbox aborted: PF%d offset 0x%x\n",
> > +		func_no, cap_offset);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_abort);
> > +
> > +/**
> > + * pci_ep_doe_destroy_mb() - Destroy a single DOE mailbox
> > + * @doe_mb: DOE mailbox to destroy
> > + *
> > + * Internal function to destroy a mailbox and free its resources.
> > + */
> > +static void pci_ep_doe_destroy_mb(struct pci_ep_doe_mb *doe_mb)
> > +{
> > +	if (!doe_mb)
> > +		return;
> > +
> > +	pci_ep_doe_cancel_tasks(doe_mb);
> > +
> > +	if (doe_mb->work_queue)
> > +		destroy_workqueue(doe_mb->work_queue);
> > +
> > +	kfree(doe_mb);
> > +}
> > +
> > +/**
> > + * pci_ep_doe_destroy() - Destroy all DOE mailboxes
> > + * @epc: PCI endpoint controller
> > + *
> > + * Destroy all DOE mailboxes and free associated resources.
> > + *
> > + * This function should be called during controller cleanup to free all
> > + * DOE resources.
> > + */
> > +void pci_ep_doe_destroy(struct pci_epc *epc)
> > +{
> > +	struct pci_ep_doe_mb *doe_mb;
> > +	unsigned long index;
> > +
> > +	if (!epc)
> > +		return;
> > +
> > +	xa_for_each(&epc->doe_mbs, index, doe_mb)
> > +		pci_ep_doe_destroy_mb(doe_mb);
> > +
> > +	xa_destroy(&epc->doe_mbs);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ep_doe_destroy);
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index a966626c47f9..b353c3a1aa82 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -13,6 +13,8 @@
> >   #ifndef LINUX_PCI_DOE_H
> >   #define LINUX_PCI_DOE_H
> > +#include <linux/types.h>
> > +
> >   /* Mailbox state flags */
> >   #define PCI_DOE_FLAG_CANCEL		0
> >   #define PCI_DOE_FLAG_DEAD		1
> > @@ -24,12 +26,19 @@
> >   #define PCI_DOE_FEATURE_CMA		1
> >   #define PCI_DOE_FEATURE_SSESSION	2
> > +typedef int (*pci_doe_protocol_handler_t)(const void *request,
> > +					  size_t request_sz,
> > +					  void **response,
> > +					  size_t *response_sz);
> > +
> >   struct pci_doe_feature {
> >   	u16 vid;
> >   	u8 type;
> >   };
> >   struct pci_doe_mb;
> > +struct pci_dev;
> > +struct pci_epc;
> >   #ifdef CONFIG_PCI_DOE
> >   struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> > @@ -54,4 +63,64 @@ static inline int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> >   }
> >   #endif /* CONFIG_PCI_DOE */
> > +#ifdef CONFIG_PCI_DOE_EP
> > +int pci_ep_doe_init(struct pci_epc *epc);
> > +
> > +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset);
> > +
> > +int pci_ep_doe_register_protocol(u16 vendor, u8 type,
> > +				 pci_doe_protocol_handler_t handler);
> > +
> > +void pci_ep_doe_unregister_protocol(u16 vendor, u8 type);
> > +
> > +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> > +			       u16 vendor, u8 type, const void *request,
> > +			       size_t request_sz, void **response, size_t *response_sz);
> > +
> > +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset);
> > +
> > +void pci_ep_doe_destroy(struct pci_epc *epc);
> > +
> > +#else
> > +static inline int pci_ep_doe_init(struct pci_epc *epc)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no,
> > +					 u16 cap_offset)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int pci_ep_doe_register_protocol(u16 vendor, u8 type,
> > +					       pci_doe_protocol_handler_t handler)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void pci_ep_doe_unregister_protocol(u16 vendor, u8 type)
> > +{
> > +}
> > +
> > +static inline int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> > +					     u16 vendor, u8 type,
> > +					     const void *request, size_t request_sz,
> > +					     void **response, size_t *response_sz)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no,
> > +				   u16 cap_offset)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void pci_ep_doe_destroy(struct pci_epc *epc)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_PCI_DOE_EP */
> > +
> >   #endif /* LINUX_PCI_DOE_H */
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 4286bfdbfdfa..ad4de4d33da3 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -165,6 +165,7 @@ struct pci_epc_mem {
> >    * @domain_nr: PCI domain number of the endpoint controller
> >    * @init_complete: flag to indicate whether the EPC initialization is complete
> >    *                 or not
> > + * @doe_mbs: array of DOE mailboxes (CONFIG_PCI_DOE_EP)
> >    */
> >   struct pci_epc {
> >   	struct device			dev;
> > @@ -182,6 +183,9 @@ struct pci_epc {
> >   	unsigned long			function_num_map;
> >   	int				domain_nr;
> >   	bool				init_complete;
> > +#ifdef CONFIG_PCI_DOE_EP
> > +	struct xarray			doe_mbs;
> > +#endif
> >   };
> >   /**
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
