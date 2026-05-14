Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932D3B6362;
	Thu, 14 May 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745820; cv=none; b=ngR2x1D5cDl8gxN6vtt6SQ5oY1EzOHN/HRkB5fbHJkt3KjgR4aDctyrsxpwb4Y6FQt2xiYvQJq4wcR6ItM9Q6SxinPoW1Xp702NIukL1cHhcf2nQhn80MS9nnrsLd5eTOlZM9CsavqLNx65Dk+b8oXJ8BCOHbtnTyPKZDZnnx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745820; c=relaxed/simple;
	bh=zAZWpgNRsJdzE1RvDZlwg0hx9NSChpObIVKEq5vkdAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/whFMf0GReovuQYha5Og24vVO+hm3mvDCB6Xqpf15XhyUei7q0AjZ83KgKz7CzZbaU5xnGVWPTMHT/rblizdEDKIIAJyR1N0FZr/S8r0CsgNVJOaGyaGopzxXlWZoefSgb4ENrI2Tn+JxkAHj8+7jWsw8aFQrfv34YbamAHzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1FWBCUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1FWBCUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B0C2BCB7;
	Thu, 14 May 2026 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778745820;
	bh=zAZWpgNRsJdzE1RvDZlwg0hx9NSChpObIVKEq5vkdAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1FWBCUyxxG/tBq/kLKVFJQwKoD+Wls8WV5aL8OHRVBG1mvFFEekHzip8ZSszujid
	 3bn1Xe/QWG2lUSs8zz8lS49skIFnzjSYFi0oCcjXoi5q0+2RvkAoxSijr1kEoywt/S
	 2AoNdGBy11Mm4HAHlf2zEzRX9YPB5lVI8lGVNyjDM+jakJ/yhz3f4YyQDbIlqebFOX
	 2PHHPbBCFKoX9ekCgK3AVbaQyx0VsO1MwMMgFukkb70EjYz9UffV4Ow6WN4wOSz5Co
	 JSxBN/YhT9bj/I/tSYowtSBp9N3Ox7LmU+9yIAFSg4A5Z4IxawXk+/+MkEXf+9UWvP
	 ZakKFfG1QkMww==
Date: Thu, 14 May 2026 13:33:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org, 
	skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, alistair@alistair23.me, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v3 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Message-ID: <hohf2lui4dyu6fzypl7kkwfvgf73ldmvinok7dfukhaornhkqp@n336bwjkvb6f>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-3-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427051725.223704-3-a-garg7@ti.com>

On Mon, Apr 27, 2026 at 10:47:23AM +0530, Aksh Garg wrote:
> DOE (Data Object Exchange) is a standard PCIe extended capability
> feature introduced in the Data Object Exchange (DOE) ECN for
> PCIe r5.0. It provides a communication mechanism primarily used for
> implementing PCIe security features such as device authentication, and
> secure link establishment. Think of DOE as a sophisticated mailbox
> system built into PCIe. The root complex can send structured requests
> to the endpoint device through DOE mailboxes, and the endpoint device
> responds with appropriate data.
> 
> Add the DOE support for PCIe endpoint devices, enabling endpoint
> functions to process the DOE requests from the host. The implementation
> provides framework APIs for EPC core driver and controller drivers to
> register mailboxes, and request processing with workqueues ensuring
> sequential handling per mailbox, and parallel handling across mailboxes.
> The Discovery protocol is handled internally by the DOE core.
> 
> This implementation complements the existing DOE implementation for
> root complex in drivers/pci/doe.c.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
> 
> Changes since v1:
> - Moved the DOE-EP core file to drivers/pci/endpoint/pci-ep-doe.c, and
>   corresponding Kconfig and Makefile to match the existing naming scheme,
>   as suggested by Niklas Cassel.
> - Renamed the config from PCI_DOE_EP to PCI_ENDPOINT_DOE
> - Moved the function declarations that need not be visible outside the
>   PCI core to drivers/pci/pci.h instead to include/linux/pci-doe.h as
>   suggested by Lukas Wunner
> - Converted from synchronous to asynchronous request processing:
>   * Removed wait_for_completion() from pci_ep_doe_process_request()
>   * Function returns immediately after queuing to workqueue, hence
>     removed private data for completion in the task structure
>   * Added completion callback as an additional argument to
>     pci_ep_doe_process_request(), which takes the response and status
>     parameters as arguments (along with other required arguments), hence
>     removed task_status in the task structure
>   * Created a typedef pci_ep_doe_complete_t for completion callback
>   * Removed the pci_ep_doe_task_complete() function, as it would not be
>     required anymore with these changes
>   * Moved from INIT_WORK_ONSTACK() to INIT_WORK(), to initialize the work
>     on heap instead of stack
>   * signal_task_complete() now invokes the completion callback, once the
>     protocol handler completes its task
> - Changed from dynamic xarray-based protocol registration to static array:
>   * Removed the register/unregister protocol APIs
>   * Replaced the dynamic xarray with static array of struct pci_doe_protocol
>   * Added discovery protocol to static array, instead of treating it specially,
>     hence removed the special handling for Discovery protocol in
>     doe_ep_task_work()
>   * Updated pci_ep_doe_handle_discovery() and pci_ep_doe_find_protocol()
>     accordingly.
> - Memory Management:
>   * DOE core frees request buffer in signal_task_complete()
>     or during error handling
>   * pci_ep_doe_process_request() defines response_pl and response_pl_sz
>     as NULL and 0 respectively, whose pointer is passed to the protocol
>     handler, hence removed the arguments void **response, size_t *response_sz
>     to this function.
> - Task structure refactoring:
>   * Response buffer: void **response_pl to void *response_pl
>   * Response size: size_t *response_pl_sz to size_t response_pl_sz
>   * Changed the completion callback to type pci_ep_doe_complete_t
>   * Removed void *private and int task_status
> - Updated documentation comments of the functions according to the changes 
> 
> v2: https://lore.kernel.org/all/20260401073022.215805-3-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260213123603.420941-4-a-garg7@ti.com/
> 
>  drivers/pci/endpoint/Kconfig      |  14 +
>  drivers/pci/endpoint/Makefile     |   1 +
>  drivers/pci/endpoint/pci-ep-doe.c | 552 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.h                 |  38 ++
>  include/linux/pci-doe.h           |   5 +
>  include/linux/pci-epc.h           |   3 +
>  6 files changed, 613 insertions(+)
>  create mode 100644 drivers/pci/endpoint/pci-ep-doe.c
> 
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index 8dad291be8b8..15ae16aaa58f 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -36,6 +36,20 @@ config PCI_ENDPOINT_MSI_DOORBELL
>  	  doorbell. The RC can trigger doorbell in EP by writing data to a
>  	  dedicated BAR, which the EP maps to the controller's message address.
>  
> +config PCI_ENDPOINT_DOE
> +	bool "PCI Endpoint Data Object Exchange (DOE) support"
> +	depends on PCI_ENDPOINT
> +	help
> +	  This enables support for Data Object Exchange (DOE) protocol
> +	  on PCI Endpoint controllers. It provides a communication
> +	  mechanism through mailboxes, primarily used for PCIe security
> +	  features.
> +
> +	  Say Y here if you want be able to communicate using PCIe DOE
> +	  mailboxes.
> +
> +	  If unsure, say N.
> +
>  source "drivers/pci/endpoint/functions/Kconfig"
>  
>  endmenu
> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> index b4869d52053a..1fa176b6792b 100644
> --- a/drivers/pci/endpoint/Makefile
> +++ b/drivers/pci/endpoint/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
>  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
>  					   pci-epc-mem.o functions/
>  obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
> +obj-$(CONFIG_PCI_ENDPOINT_DOE)		+= pci-ep-doe.o
> diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci-ep-doe.c
> new file mode 100644
> index 000000000000..ded0290b15ed
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-doe.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-only or MIT
> +/*
> + * Data Object Exchange for PCIe Endpoint
> + *	PCIe r7.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com
> + *	Aksh Garg <a-garg7@ti.com>
> + *	Siddharth Vadapalli <s-vadapalli@ti.com>
> + */
> +
> +#define dev_fmt(fmt) "DOE EP: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-doe.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <linux/xarray.h>
> +
> +#include "../pci.h"
> +
> +/* Forward declaration of discovery protocol handler */
> +static int pci_ep_doe_handle_discovery(const void *request, size_t request_sz,
> +				       void **response, size_t *response_sz);
> +
> +/**
> + * struct pci_doe_protocol - DOE protocol handler entry
> + * @vid: Vendor ID
> + * @type: Protocol type
> + * @handler: Handler function pointer
> + */
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +	pci_doe_protocol_handler_t handler;
> +};
> +
> +/**
> + * struct pci_ep_doe_mb - State for a single DOE mailbox on EP
> + *
> + * This state is used to manage a single DOE mailbox capability on the
> + * endpoint side.
> + *
> + * @epc: PCI endpoint controller this mailbox belongs to
> + * @func_no: Physical function number of the function this mailbox belongs to
> + * @cap_offset: Capability offset
> + * @work_queue: Queue of work items
> + * @flags: Bit array of PCI_DOE_FLAG_* flags
> + */
> +struct pci_ep_doe_mb {
> +	struct pci_epc *epc;
> +	u8 func_no;
> +	u16 cap_offset;
> +	struct workqueue_struct *work_queue;
> +	unsigned long flags;
> +};
> +
> +/**
> + * struct pci_ep_doe_task - Represents a single DOE request/response task
> + *
> + * @feat: DOE feature (vendor ID and type)
> + * @request_pl: Request payload
> + * @request_pl_sz: Size of request payload in bytes
> + * @response_pl: Response buffer
> + * @response_pl_sz: Size of response buffer in bytes
> + * @complete: Completion callback
> + * @work: Work structure for workqueue
> + * @doe_mb: DOE mailbox handling this task
> + */
> +struct pci_ep_doe_task {
> +	struct pci_doe_feature feat;
> +	const void *request_pl;
> +	size_t request_pl_sz;
> +	void *response_pl;
> +	size_t response_pl_sz;
> +	pci_ep_doe_complete_t complete;
> +
> +	/* Initialized by pci_ep_doe_submit_task() */
> +	struct work_struct work;
> +	struct pci_ep_doe_mb *doe_mb;
> +};
> +
> +/*
> + * Global registry of protocol handlers.
> + * When a new DOE protocol, library is added, add an entry to this array.
> + */
> +static const struct pci_doe_protocol pci_doe_protocols[] = {
> +	{
> +		.vid = PCI_VENDOR_ID_PCI_SIG,
> +		.type = PCI_DOE_FEATURE_DISCOVERY,
> +		.handler = pci_ep_doe_handle_discovery,
> +	},
> +};
> +
> +/*
> + * Combines function number and capability offset into a unique lookup key
> + * for storing/retrieving DOE mailboxes in an xarray.
> + */
> +#define PCI_DOE_MB_KEY(func, offset) \
> +	(((unsigned long)(func) << 16) | (offset))
> +#define PCI_DOE_PROTOCOL_COUNT        ARRAY_SIZE(pci_doe_protocols)
> +
> +/**
> + * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
> + * @epc: PCI endpoint controller
> + *
> + * Initialize the DOE framework data structures. This only initializes
> + * the xarray that will hold the mailboxes.
> + *
> + * RETURNS: 0 on success, -errno on failure

kernel-doc format to describe return value is 'Return:' or 'Returns:".

> + */
> +int pci_ep_doe_init(struct pci_epc *epc)
> +{
> +	if (!epc)
> +		return -EINVAL;
> +
> +	xa_init(&epc->doe_mbs);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_init);
> +
> +/**
> + * pci_ep_doe_add_mailbox() - Add a DOE mailbox for a physical function
> + * @epc: PCI endpoint controller
> + * @func_no: Physical function number
> + * @cap_offset: Offset of the DOE capability
> + *
> + * Create and register a DOE mailbox for the specified physical function
> + * and capability offset.
> + *
> + * EPC core driver calls this for each DOE capability discovered in the config
> + * space of each endpoint function through an API. The API is invoked by the
> + * controller driver during initialization if DOE support is available.
> + *
> + * RETURNS: 0 on success, -errno on failure
> + */
> +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long key;
> +	int ret;
> +
> +	if (!epc)
> +		return -EINVAL;
> +
> +	doe_mb = kzalloc_obj(*doe_mb, GFP_KERNEL);
> +	if (!doe_mb)
> +		return -ENOMEM;
> +
> +	doe_mb->epc = epc;
> +	doe_mb->func_no = func_no;
> +	doe_mb->cap_offset = cap_offset;
> +
> +	doe_mb->work_queue = alloc_ordered_workqueue("pci_ep_doe[%s:pf%d:offset%x]", 0,
> +						     dev_name(&epc->dev),
> +						     func_no, cap_offset);
> +	if (!doe_mb->work_queue) {
> +		dev_err(epc->dev.parent,
> +			"[pf%d:offset%x] failed to allocate work queue\n",
> +			func_no, cap_offset);
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	/* Add to xarray with composite key */
> +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
> +	ret = xa_insert(&epc->doe_mbs, key, doe_mb, GFP_KERNEL);
> +	if (ret) {
> +		dev_err(epc->dev.parent,
> +			"[pf%d:offset%x] failed to insert mailbox: %d\n",
> +			func_no, cap_offset, ret);
> +		goto err_destroy;
> +	}
> +
> +	dev_dbg(epc->dev.parent,
> +		"DOE mailbox added: pf%d offset 0x%x\n",
> +		func_no, cap_offset);
> +
> +	return 0;
> +
> +err_destroy:
> +	destroy_workqueue(doe_mb->work_queue);
> +err_free:
> +	kfree(doe_mb);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_add_mailbox);
> +
> +/**
> + * pci_ep_doe_cancel_tasks() - Cancel all pending tasks
> + * @doe_mb: DOE mailbox
> + *
> + * Cancel all pending tasks in the mailbox. Mark the mailbox as dead
> + * so no new tasks can be submitted.
> + */
> +static void pci_ep_doe_cancel_tasks(struct pci_ep_doe_mb *doe_mb)
> +{
> +	if (!doe_mb)
> +		return;
> +
> +	/* Mark the mailbox as dead */
> +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +
> +	/* Stop all pending work items from starting */
> +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> +}
> +
> +/**
> + * pci_ep_doe_get_mailbox() - Get DOE mailbox by function and offset
> + * @epc: PCI endpoint controller
> + * @func_no: Physical function number
> + * @cap_offset: Offset of the DOE capability
> + *
> + * Internal helper to look up a DOE mailbox by its function number and
> + * capability offset.
> + *
> + * RETURNS: Pointer to the mailbox or NULL if not found
> + */
> +static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
> +						    u8 func_no, u16 cap_offset)
> +{
> +	unsigned long key;
> +
> +	if (!epc)
> +		return NULL;
> +
> +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
> +	return xa_load(&epc->doe_mbs, key);
> +}
> +
> +/**
> + * pci_ep_doe_find_protocol() - Find protocol handler in static array
> + * @vendor: Vendor ID
> + * @type: Protocol type
> + *
> + * Look up a protocol handler in the static protocol array by matching vendor ID
> + * and protocol type.
> + *
> + * RETURNS: Handler function pointer or NULL if not found
> + */
> +static pci_doe_protocol_handler_t pci_ep_doe_find_protocol(u16 vendor, u8 type)
> +{
> +	int i;
> +
> +	/* Search static protocol array */
> +	for (i = 0; i < PCI_DOE_PROTOCOL_COUNT; i++) {
> +		if (pci_doe_protocols[i].vid == vendor &&
> +		    pci_doe_protocols[i].type == type)
> +			return pci_doe_protocols[i].handler;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * pci_ep_doe_handle_discovery() - Handle Discovery protocol request
> + * @request: Request payload
> + * @request_sz: Request size
> + * @response: Output pointer for response buffer
> + * @response_sz: Output pointer for response size
> + *
> + * Handle the DOE Discovery protocol. The request contains an index specifying
> + * which protocol to query. This function creates a response containing the
> + * vendor ID and protocol type for the requested index, along with the next
> + * index value for further discovery:
> + *
> + * - next_index = 0: Signals this is the last protocol supported
> + * - next_index = n (non-zero): Signals more protocols available,
> + *   query index n next
> + *
> + * RETURNS: 0 on success, -errno on failure
> + */
> +static int pci_ep_doe_handle_discovery(const void *request, size_t request_sz,
> +				       void **response, size_t *response_sz)
> +{
> +	struct pci_doe_protocol protocol;
> +	u8 requested_index, next_index;
> +	u32 *response_pl;
> +	u32 request_pl;
> +	u16 vendor;
> +	u8 type;
> +
> +	if (request_sz != sizeof(u32))
> +		return -EINVAL;
> +
> +	request_pl = *(u32 *)request;
> +	requested_index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, request_pl);
> +
> +	if (requested_index >= PCI_DOE_PROTOCOL_COUNT)
> +		return -EINVAL;
> +
> +	/* Get protocol from array at requested_index */
> +	protocol = pci_doe_protocols[requested_index];
> +	vendor = protocol.vid;
> +	type = protocol.type;
> +
> +	/* Calculate next index */
> +	next_index = (requested_index + 1 < PCI_DOE_PROTOCOL_COUNT) ? requested_index + 1 : 0;
> +
> +	response_pl = kzalloc_obj(*response_pl, GFP_KERNEL);
> +	if (!response_pl)
> +		return -ENOMEM;
> +
> +	/* Build response */
> +	*response_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, vendor) |
> +		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE, type) |
> +		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, next_index);
> +
> +	*response = response_pl;
> +	*response_sz = sizeof(*response_pl);
> +
> +	return 0;
> +}
> +
> +static void signal_task_complete(struct pci_ep_doe_task *task, int status)
> +{
> +	kfree(task->request_pl);
> +	task->complete(task->doe_mb->func_no, task->doe_mb->cap_offset, status,
> +		       task->feat.vid, task->feat.type,
> +		       task->response_pl, task->response_pl_sz);
> +	kfree(task);
> +}
> +
> +/**
> + * doe_ep_task_work() - Work function for processing DOE EP tasks
> + * @work: Work structure
> + *
> + * Process a DOE request by calling the appropriate protocol handler.
> + */
> +static void doe_ep_task_work(struct work_struct *work)
> +{
> +	struct pci_ep_doe_task *task = container_of(work, struct pci_ep_doe_task,
> +						    work);
> +	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
> +	pci_doe_protocol_handler_t handler;
> +	int rc;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		signal_task_complete(task, -EIO);
> +		return;
> +	}
> +
> +	/* Check if request was aborted */
> +	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
> +		signal_task_complete(task, -ECANCELED);
> +		return;
> +	}
> +
> +	/* Find protocol handler in the array */
> +	handler = pci_ep_doe_find_protocol(task->feat.vid, task->feat.type);
> +	if (!handler) {
> +		dev_warn(doe_mb->epc->dev.parent,
> +			 "[%d:%x] Unsupported protocol VID=%04x TYPE=%02x\n",
> +			 doe_mb->func_no, doe_mb->cap_offset,
> +			 task->feat.vid, task->feat.type);
> +		signal_task_complete(task, -EOPNOTSUPP);
> +		return;
> +	}
> +
> +	/* Call protocol handler */
> +	rc = handler(task->request_pl, task->request_pl_sz,
> +		     &task->response_pl, &task->response_pl_sz);
> +
> +	signal_task_complete(task, rc);
> +}
> +
> +/**
> + * pci_ep_doe_submit_task() - Submit a task to be processed
> + * @doe_mb: DOE mailbox
> + * @task: Task to submit
> + *
> + * Submit a DOE task to the workqueue for asynchronous processing.
> + *
> + * RETURNS: 0 on success, -errno on failure
> + */
> +static int pci_ep_doe_submit_task(struct pci_ep_doe_mb *doe_mb,
> +				  struct pci_ep_doe_task *task)
> +{
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	task->doe_mb = doe_mb;
> +	INIT_WORK(&task->work, doe_ep_task_work);
> +	queue_work(doe_mb->work_queue, &task->work);
> +	return 0;
> +}
> +
> +/**
> + * pci_ep_doe_process_request() - Process DOE request on endpoint
> + * @epc: PCI endpoint controller
> + * @func_no: Physical function number
> + * @cap_offset: DOE capability offset
> + * @vendor: Vendor ID from request header
> + * @type: Protocol type from request header
> + * @request: Request payload in CPU-native format
> + * @request_sz: Size of request payload (bytes)
> + * @complete: Callback to invoke upon completion
> + *
> + * Asynchronously process a DOE request received on the endpoint. The request
> + * payload should not include the DOE header (vendor/type/length). The protocol
> + * handler will allocate the response buffer, which the caller (controller driver)
> + * must free after use.
> + *
> + * This function returns immediately after queuing the request. The completion
> + * callback will be invoked asynchronously from workqueue context once the
> + * request is processed. The callback receives the function number and capability
> + * offset to identify the mailbox, along with a status code (0 on success, -errno
> + * on failure), and other required arguments.
> + *
> + * As per DOE specification, a mailbox processes one request at a time.
> + * Therefore, this function will never be called concurrently for the same
> + * mailbox by different callers.
> + *
> + * The caller is responsible for the conversion of the received DOE request
> + * with le32_to_cpu() before calling this function.
> + * Similarly, it is responsible for converting the response payload with
> + * cpu_to_le32() before sending it back over the DOE mailbox.
> + *
> + * The caller is also responsible for ensuring that the request size
> + * is within the limits defined by PCI_DOE_MAX_LENGTH.
> + *
> + * RETURNS: 0 if the request was successfully queued, -errno on failure
> + */
> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> +			       u16 vendor, u8 type, const void *request, size_t request_sz,
> +			       pci_ep_doe_complete_t complete)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	struct pci_ep_doe_task *task;
> +	int rc;
> +
> +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> +	if (!doe_mb) {
> +		kfree(request);
> +		return -ENODEV;
> +	}
> +
> +	task = kzalloc_obj(*task, GFP_KERNEL);
> +	if (!task) {
> +		kfree(request);
> +		return -ENOMEM;
> +	}
> +
> +	task->feat.vid = vendor;
> +	task->feat.type = type;
> +	task->request_pl = request;
> +	task->request_pl_sz = request_sz;
> +	task->response_pl = NULL;
> +	task->response_pl_sz = 0;
> +	task->complete = complete;
> +
> +	rc = pci_ep_doe_submit_task(doe_mb, task);
> +	if (rc) {
> +		kfree(request);
> +		kfree(task);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);

So who is supposed to call this API? EPC driver that receives the DOE interrupt?
But I don't see the any callers of this and below exported APIs in this series.
Either you should add the callers or limit this series just to adding the DOE
skeleton implementation with a clear follow-up.

But since you've limited the scope of this series to support only DOE Discovery
Data Object Protocol, it'd be good to add the EPC implementation to get the full
picture.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
