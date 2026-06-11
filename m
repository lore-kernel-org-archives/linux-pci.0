Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349D346E56;
	Thu, 11 Jun 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205111; cv=none; b=kOUY2sB+vqX98/sDdRVkvoEU6yijGGWVGcqSE4qVHDVQTcsQ293Ecrw+XN9mn93cFuEHwragiVntWrxWdA8Y8L34dLSK4LJ6xvUx/R2A6P6b51K25Ed+3CQJXIUBClSAJZOevBCZ38CMQuqSrIWnBZe17yzyKbmZ0VlZ+V1m3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205111; c=relaxed/simple;
	bh=ujidx2LrQk7EyXMNuM2QalSHKMcbFATHjbi/K4s+4eo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ojolPiJOijipEvbFGLBDKX6Enen/PD5Q2jQci+qz4R/GlxUk0c98aNyHUiAYZ3Hp5dY+/I5nNXqjqsWoPZAeIo+2h4jXcw+Iv4f43/A4ZV+sAaGY3wOmvYY/Yaka8XqU+z2TBrWx8BJ3iPqaiFrl2cfEHsAUKlM2OxiMvQqb+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azXfUAai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azXfUAai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852301F000E9;
	Thu, 11 Jun 2026 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205108;
	bh=K4iMcSNYhlvvq1hyNXfaeDAtpnRPTxurBssRnVcitAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=azXfUAaiiovWSh1fHDT75Kdy0U7QAjNQ8go3aB6Q2MPtCvA3MZeW7YtSIFBRkPU6g
	 gA1/MFwJS7wQPLXxbSylvJDi035g2kRwq2TwAh0z1/GntWwxK0TBobhZQ3ytghylHt
	 6e2ZVPZCiGToxWOFgNKtOBJSoJDdHhGpXaa5gT/T+++CQZYfThDFyILHrg+PoT7wXQ
	 X00fRbYcL3GLRTeIao3/Fm9HNgjMatf+NhbfH4C8OH4SeDqUZdr0HxPNYQCHIt5DON
	 TXWZS3bs3e9eTCbduydPXwJFtru9NCThybMhJlMPt8TfA43NAmKjUQRWVlwQr+K4Ck
	 iEaN3CJEZV0ww==
Date: Thu, 11 Jun 2026 14:11:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de,
	cassel@kernel.org, alistair@alistair23.me,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Message-ID: <20260611191147.GA493632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610100256.1889111-3-a-garg7@ti.com>

On Wed, Jun 10, 2026 at 03:32:54PM +0530, Aksh Garg wrote:
> DOE (Data Object Exchange) is a standard PCIe extended capability
> feature introduced in the Data Object Exchange (DOE) ECN for
> PCIe r5.0. It provides a communication mechanism primarily used for
> implementing PCIe security features such as device authentication, and
> secure link establishment. Think of DOE as a sophisticated mailbox
> system built into PCIe. The root complex can send structured requests
> to the endpoint device through DOE mailboxes, and the endpoint device
> responds with appropriate data.

Please cite a spec revision and section instead of the ECN because
it's easier to find the spec than the ECN.  E.g., "PCIe r7.0, sec
6.30" or similar.

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
> Changes from v4 to v5:
> - Addressed the review comments by Sashiko
> - Added refcount per DOE Mailbox to fix Use-After-Free bug
> - Change in the Abort Sequence:
>   * Instead of waiting on flush_workqueue() to clear the CANCEL flag,
>     return immediately after setting the CANCEL flag. The CANCEL flag
>     gets cleared in signal_task_complete(), allowing the mailbox to
>     accept new requests
>   * Abort sequence handling in various scenarios is updated and explained
>     in the documentation at PATCH 4/4
> 
> Changes from v3 to v4:
> - Used 'Returns' instead of 'RETURNS' in the function docstrings to
>   comply with kernel-doc format, as suggested by Manivannan Sadhasivam.
> - In pci_ep_doe_process_request(), changed the type of request buffer
>   from "const void *" to "void *", as the ownership is transferred to
>   DOE-EP framework, which is responsible to free the buffer.
> - Added "struct pci_epc *epc" to typedef "pci_ep_doe_complete_t", to be
>   used by the EPC driver.
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
> v4: https://lore.kernel.org/all/20260522052434.802034-3-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-3-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-3-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260213123603.420941-4-a-garg7@ti.com/
> 
>  drivers/pci/endpoint/Kconfig      |  14 +
>  drivers/pci/endpoint/Makefile     |   1 +
>  drivers/pci/endpoint/pci-ep-doe.c | 594 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.h                 |  39 ++
>  include/linux/pci-doe.h           |   5 +
>  include/linux/pci-epc.h           |   3 +
>  6 files changed, 656 insertions(+)
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
> index 000000000000..ea6a152461bb
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-doe.c
> @@ -0,0 +1,594 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
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
> +#include <linux/refcount.h>
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
> + * @refs: Refcount to manage mailbox lifetime and ensure safe cleanup
> + */
> +struct pci_ep_doe_mb {
> +	struct pci_epc *epc;
> +	u8 func_no;
> +	u16 cap_offset;
> +	struct workqueue_struct *work_queue;
> +	unsigned long flags;
> +	refcount_t refs;
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

s/Combines/Combine/

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
> + * Returns: 0 on success, -errno on failure

s/Returns:/Return:/ (throughout)

Mani suggested "Returns" (from v3 to v4 above), so that's OK too.
https://origin.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
includes four "Return:" examples and one "Returns:" example, and
"Return" fits better in the preferred imperative mood, so I have a
slight preference for that.

> + */
> +int pci_ep_doe_init(struct pci_epc *epc)
> +{
> +	if (!epc)
> +		return -EINVAL;

I doubt this is useful.  Obviously a bug in the caller and I'd rather
take the NULL pointer dereference, which will definitely be noticed,
than assume the buggy caller checks for failure.  The function might
as well be void then, same as pci_doe_init().

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
> + * space of each endpoint function if DOE support is available for the EPC.
> + *
> + * Returns: 0 on success, -errno on failure
> + */
> +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long key;
> +	int ret;
> +
> +	if (!epc)
> +		return -EINVAL;

Also doubtful about this.

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
> +	refcount_set(&doe_mb->refs, 1);
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

Seems like this silently hides caller bugs without even the
possibility of checking for failure?

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
> + * Returns: Pointer to the mailbox or NULL if not found
> + */
> +static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
> +						    u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long key;
> +
> +	if (!epc)
> +		return NULL;

Same?

> +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
> +
> +	xa_lock(&epc->doe_mbs);
> +
> +	doe_mb = xa_load(&epc->doe_mbs, key);
> +	if (doe_mb && !refcount_inc_not_zero(&doe_mb->refs))
> +		doe_mb = NULL;
> +
> +	xa_unlock(&epc->doe_mbs);
> +
> +	return doe_mb;
> +}
> +
> +/**
> + * pci_ep_doe_put_mailbox() - Release a reference to a DOE mailbox
> + * @doe_mb: The mailbox structure to release
> + *
> + * Drops the reference count. If this was the last active reference,
> + * the memory allocated for the mailbox structure is freed.

s/Drops/Drop/
s/If ... is freed/Free the ... if this was last active .../

> + */
> +static void pci_ep_doe_put_mailbox(struct pci_ep_doe_mb *doe_mb)
> +{
> +	if (!doe_mb)
> +		return;

Omit unless there's a reason for this.

> +	if (refcount_dec_and_test(&doe_mb->refs))
> +		kfree(doe_mb);
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
> + * Returns: Handler function pointer or NULL if not found
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
> + * Returns: 0 on success, -errno on failure
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
> +	if (requested_index >= PCI_DOE_PROTOCOL_COUNT) {
> +		/* No more protocols to report */
> +		vendor = 0;
> +		type = 0;
> +	} else {
> +		/* Get protocol from array at requested_index */
> +		protocol = pci_doe_protocols[requested_index];
> +		vendor = protocol.vid;
> +		type = protocol.type;
> +	}
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
> +	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
> +
> +	task->complete(doe_mb->epc, doe_mb->func_no, doe_mb->cap_offset,
> +		       status, task->feat.vid, task->feat.type,
> +		       task->response_pl, task->response_pl_sz);
> +
> +	/* Clear the CANCEL flag for next DOE request */
> +	clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> +
> +	kfree(task->request_pl);
> +	kfree(task);
> +
> +	/* Release the mailbox reference acquired during process_request */
> +	pci_ep_doe_put_mailbox(doe_mb);
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

Comment seems superfluous, given the function name.

> +	handler = pci_ep_doe_find_protocol(task->feat.vid, task->feat.type);
> +	if (!handler) {
> +		dev_warn_ratelimited(doe_mb->epc->dev.parent,
> +				     "[%d:%x] Unsupported protocol VID=%04x TYPE=%02x\n",
> +				     doe_mb->func_no, doe_mb->cap_offset,
> +				     task->feat.vid, task->feat.type);
> +		signal_task_complete(task, -EOPNOTSUPP);
> +		return;
> +	}
> +
> +	/* Call protocol handler */

Ditto.

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
> + * Returns: 0 on success, -errno on failure
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
> + * payload should not include the DOE header (vendor/type/length). Ownership
> + * of the request buffer is transferred to DOE EP core, which frees the buffer
> + * either on error or after the completion callback fires. The protocol handler
> + * will allocate the response buffer, which the caller (controller driver) must
> + * free after use.

I guess signal_task_complete() is where the request buffer is freed
after completion?  Maybe mention the function name directly instead of
just "completion callback", e.g., "by signal_task_complete(), the
completion callback"?

> + * This function returns immediately after queuing the request. The completion
> + * callback will be invoked asynchronously from workqueue context once the
> + * request is processed. The callback receives the function number and capability
> + * offset to identify the mailbox, along with a status code (0 on success, -errno
> + * on failure), and other required arguments.

Wrap to fit in 80 columns.

> + * As per DOE specification, a mailbox processes one request at a time.
> + * Therefore, this function will never be called concurrently for the same
> + * mailbox by different callers.
> + *
> + * The caller is responsible for the conversion of the received DOE request
> + * with le32_to_cpu() before calling this function.
> + * Similarly, it is responsible for converting the response payload with
> + * cpu_to_le32() before sending it back over the DOE mailbox.

Wrap to fill 78-80 columns (or add blank line if you want a new
paragraph, but this looks like all one paragraph).

> + * The caller is also responsible for ensuring that the request size
> + * is within the limits defined by PCI_DOE_MAX_LENGTH.
> + *
> + * Returns: 0 if the request was successfully queued, -errno on failure
> + */
> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> +			       u16 vendor, u8 type, void *request, size_t request_sz,
> +			       pci_ep_doe_complete_t complete)

Wrap to fit in 80 columns.

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
> +	task = kzalloc_obj(*task, GFP_ATOMIC);
> +	if (!task) {
> +		kfree(request);
> +		pci_ep_doe_put_mailbox(doe_mb);
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
> +		pci_ep_doe_put_mailbox(doe_mb);
> +		return rc;

Good candidate for error path ladder, as you did in
pci_ep_doe_add_mailbox().

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
> +
> +/**
> + * pci_ep_doe_abort() - Abort DOE operations on a mailbox
> + * @epc: PCI endpoint controller
> + * @func_no: Physical function number
> + * @cap_offset: DOE capability offset
> + *
> + * Abort the queued or in-flight DOE operation for the specified mailbox.
> + * This function is called by the EP controller driver when the RC sets the
> + * ABORT bit in the DOE Control register, and the BUSY bit is set in the
> + * DOE Status Register.
> + *
> + * The function sets the CANCEL flag on the mailbox to prevent queued requests
> + * from starting, and returns immediately. The CANCEL flag gets cleared in
> + * signal_task_complete(), allowing the mailbox to accept new requests.

s/The function sets .../Set .../
s/and returns/and return/

> + *
> + * Returns: 0 on success, -errno on failure
> + */
> +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +
> +	if (!epc)
> +		return -EINVAL;

?

> +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> +	if (!doe_mb)
> +		return -ENODEV;
> +
> +	/* Set CANCEL flag - worker will abort queued requests */
> +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> +
> +	dev_dbg_ratelimited(epc->dev.parent,
> +			    "DOE mailbox abort initialized: PF%d offset 0x%x\n",
> +			    func_no, cap_offset);
> +
> +	pci_ep_doe_put_mailbox(doe_mb);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_abort);
> +
> +/**
> + * pci_ep_doe_destroy_mb() - Destroy a single DOE mailbox
> + * @doe_mb: DOE mailbox to destroy
> + *
> + * Internal function to destroy a mailbox and free its resources.
> + */
> +static void pci_ep_doe_destroy_mb(struct pci_ep_doe_mb *doe_mb)
> +{
> +	if (!doe_mb)
> +		return;

?

> +	pci_ep_doe_cancel_tasks(doe_mb);
> +
> +	if (doe_mb->work_queue)
> +		destroy_workqueue(doe_mb->work_queue);
> +
> +	pci_ep_doe_put_mailbox(doe_mb);
> +}
> +
> +/**
> + * pci_ep_doe_destroy() - Destroy all DOE mailboxes
> + * @epc: PCI endpoint controller
> + *
> + * Destroy all DOE mailboxes and free associated resources.
> + *
> + * The EPC core driver calls this to free all DOE resources,
> + * if DOE support is available for the EPC.
> + */
> +void pci_ep_doe_destroy(struct pci_epc *epc)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	if (!epc)
> +		return;

?

> +	xa_for_each(&epc->doe_mbs, index, doe_mb) {
> +		xa_erase(&epc->doe_mbs, index);
> +		pci_ep_doe_destroy_mb(doe_mb);
> +	}
> +
> +	xa_destroy(&epc->doe_mbs);
> +}
> +EXPORT_SYMBOL_GPL(pci_ep_doe_destroy);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5844deee2b5f..c4a0e25625e3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -692,6 +692,13 @@ struct pci_doe_feature {
>  	u8 type;
>  };
>  
> +struct pci_epc;
> +
> +typedef void (*pci_ep_doe_complete_t)(struct pci_epc *epc, u8 func_no,
> +				      u16 cap_offset, int status,
> +				      u16 vendor, u8 type,
> +				      void *response_pl, size_t response_pl_sz);
> +
>  #ifdef CONFIG_PCI_DOE
>  void pci_doe_init(struct pci_dev *pdev);
>  void pci_doe_destroy(struct pci_dev *pdev);
> @@ -702,6 +709,38 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +#ifdef CONFIG_PCI_ENDPOINT_DOE
> +int pci_ep_doe_init(struct pci_epc *epc);
> +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset);
> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> +			       u16 vendor, u8 type, void *request,
> +			       size_t request_sz, pci_ep_doe_complete_t complete);
> +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset);
> +void pci_ep_doe_destroy(struct pci_epc *epc);
> +#else
> +static inline int pci_ep_doe_init(struct pci_epc *epc) { return -EOPNOTSUPP; }
> +static inline int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no,
> +					 u16 cap_offset)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no,
> +					     u16 cap_offset, u16 vendor, u8 type,
> +					     void *request, size_t request_sz,
> +					     pci_ep_doe_complete_t complete)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)

Wrap to fit in 80 columns.

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void pci_ep_doe_destroy(struct pci_epc *epc) { }
> +#endif
> +
>  #ifdef CONFIG_PCI_NPEM
>  void pci_npem_create(struct pci_dev *dev);
>  void pci_npem_remove(struct pci_dev *dev);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index abb9b7ae8029..c46e42f3ce78 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -22,6 +22,11 @@ struct pci_doe_mb;
>  /* Max data object length is 2^18 dwords */
>  #define PCI_DOE_MAX_LENGTH		(1 << 18)
>  
> +typedef int (*pci_doe_protocol_handler_t)(const void *request,
> +					  size_t request_sz,
> +					  void **response,
> +					  size_t *response_sz);
> +
>  struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>  					u8 type);
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 1eca1264815b..dd26294c8175 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -182,6 +182,9 @@ struct pci_epc {
>  	unsigned long			function_num_map;
>  	int				domain_nr;
>  	bool				init_complete;
> +#ifdef CONFIG_PCI_ENDPOINT_DOE
> +	struct xarray			doe_mbs;
> +#endif
>  };
>  
>  /**
> -- 
> 2.34.1
> 
