Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F53F4129;
	Fri, 15 May 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848842; cv=none; b=HzB4UsNpfYCRyhIHz7tXgLQqjzjkYS547W1WoSu/xNRuTdf3I8dzQ2/sG6mZN5qV/ocAtQNjAIBc8Q9JEUAlsOWwhLTKEAbTA6LFj24/a5vruvlNFE0LJJe4bSFe+zNdzDRjSC8j1yMimJWyIE9nYsqy78XqM+BrYSUJFttQBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848842; c=relaxed/simple;
	bh=dVZYaIysbGLyFj2Zvvl2YCrzogkMN54SkDpeWn/FwkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLCVPjeZGnwp3rRQQBm5/f9AFtxEs03bdlKG+bfIpqCrz34hGow+q46bjbw0/Lu30JAcz6WjaW7sXnkj+WIYdecpbwacJnJTObGbOLHQIScmK9pDyZek2EDfBPQWHJSPCFv5PJtjKTWJ7m3l26NKwNAKBhSQ2rsjaHEN9VrRu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBSZXlcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBSZXlcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A611C2BCB0;
	Fri, 15 May 2026 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778848841;
	bh=dVZYaIysbGLyFj2Zvvl2YCrzogkMN54SkDpeWn/FwkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBSZXlcpwGysw7G+cWTm3ogsmRwJzjrvvxTIo2uzKf9y/enpMbzvM7148F0FM9L9B
	 Fa91anpoRqoT/qeIBOboxrqKSVEVrb3Gj2GU5MKryjOZT/Y/WLHcCRhFoIauKUxFEp
	 Ierb1mh1RvCxY/hRXsca3CuNIftsM+2xy5d/MDW+fi0j9ghBVi0+6D/GZfWxtZjhYz
	 I99Ics1dZy1SDelBhpBx4+3Sly2X4NMIw+I4pGIT2tRC8C85Q84pN4J3C8SM3V3HIm
	 ecO83IPp78ydjaPRcaRdNjn5hel1lAQ3x3CR6itRjIV7G2foaB76p9xuyC4f3KQIS2
	 77Qseut/UpUaQ==
Date: Fri, 15 May 2026 18:10:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org, 
	skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, alistair@alistair23.me, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v3 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Message-ID: <ies3cbldthjv4vgraibgo642pfuvcr3lsixgxeisqa34ygkpbf@dd2qstv5fiig>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-3-a-garg7@ti.com>
 <hohf2lui4dyu6fzypl7kkwfvgf73ldmvinok7dfukhaornhkqp@n336bwjkvb6f>
 <20dce1c6-d24d-4344-86a9-f434fe52038b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20dce1c6-d24d-4344-86a9-f434fe52038b@ti.com>

On Fri, May 15, 2026 at 11:05:29AM +0530, Aksh Garg wrote:
> 
> 
> On 14/05/26 13:33, Manivannan Sadhasivam wrote:
> > On Mon, Apr 27, 2026 at 10:47:23AM +0530, Aksh Garg wrote:
> > > DOE (Data Object Exchange) is a standard PCIe extended capability
> > > feature introduced in the Data Object Exchange (DOE) ECN for
> > > PCIe r5.0. It provides a communication mechanism primarily used for
> > > implementing PCIe security features such as device authentication, and
> > > secure link establishment. Think of DOE as a sophisticated mailbox
> > > system built into PCIe. The root complex can send structured requests
> > > to the endpoint device through DOE mailboxes, and the endpoint device
> > > responds with appropriate data.
> > > 
> > > Add the DOE support for PCIe endpoint devices, enabling endpoint
> > > functions to process the DOE requests from the host. The implementation
> > > provides framework APIs for EPC core driver and controller drivers to
> > > register mailboxes, and request processing with workqueues ensuring
> > > sequential handling per mailbox, and parallel handling across mailboxes.
> > > The Discovery protocol is handled internally by the DOE core.
> > > 
> > > This implementation complements the existing DOE implementation for
> > > root complex in drivers/pci/doe.c.
> > > 
> > > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Aksh Garg <a-garg7@ti.com>
> > > ---
> > > +
> > > +/*
> > > + * Global registry of protocol handlers.
> > > + * When a new DOE protocol, library is added, add an entry to this array.
> > > + */
> > > +static const struct pci_doe_protocol pci_doe_protocols[] = {
> > > +	{
> > > +		.vid = PCI_VENDOR_ID_PCI_SIG,
> > > +		.type = PCI_DOE_FEATURE_DISCOVERY,
> > > +		.handler = pci_ep_doe_handle_discovery,
> > > +	},
> > > +};
> > > +
> > > +/*
> > > + * Combines function number and capability offset into a unique lookup key
> > > + * for storing/retrieving DOE mailboxes in an xarray.
> > > + */
> > > +#define PCI_DOE_MB_KEY(func, offset) \
> > > +	(((unsigned long)(func) << 16) | (offset))
> > > +#define PCI_DOE_PROTOCOL_COUNT        ARRAY_SIZE(pci_doe_protocols)
> > > +
> > > +/**
> > > + * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
> > > + * @epc: PCI endpoint controller
> > > + *
> > > + * Initialize the DOE framework data structures. This only initializes
> > > + * the xarray that will hold the mailboxes.
> > > + *
> > > + * RETURNS: 0 on success, -errno on failure
> > 
> > kernel-doc format to describe return value is 'Return:' or 'Returns:".
> 
> Thanks for pointing this out. I will update this.
> 
> > 
> > > + */
> > > +int pci_ep_doe_init(struct pci_epc *epc)
> > > +{
> > > +	if (!epc)
> > > +		return -EINVAL;
> > > +
> > > +	xa_init(&epc->doe_mbs);
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_ep_doe_init);
> > > +
> 
> [...]
> 
> > > +
> > > +/**
> > > + * pci_ep_doe_process_request() - Process DOE request on endpoint
> > > + * @epc: PCI endpoint controller
> > > + * @func_no: Physical function number
> > > + * @cap_offset: DOE capability offset
> > > + * @vendor: Vendor ID from request header
> > > + * @type: Protocol type from request header
> > > + * @request: Request payload in CPU-native format
> > > + * @request_sz: Size of request payload (bytes)
> > > + * @complete: Callback to invoke upon completion
> > > + *
> > > + * Asynchronously process a DOE request received on the endpoint. The request
> > > + * payload should not include the DOE header (vendor/type/length). The protocol
> > > + * handler will allocate the response buffer, which the caller (controller driver)
> > > + * must free after use.
> > > + *
> > > + * This function returns immediately after queuing the request. The completion
> > > + * callback will be invoked asynchronously from workqueue context once the
> > > + * request is processed. The callback receives the function number and capability
> > > + * offset to identify the mailbox, along with a status code (0 on success, -errno
> > > + * on failure), and other required arguments.
> > > + *
> > > + * As per DOE specification, a mailbox processes one request at a time.
> > > + * Therefore, this function will never be called concurrently for the same
> > > + * mailbox by different callers.
> > > + *
> > > + * The caller is responsible for the conversion of the received DOE request
> > > + * with le32_to_cpu() before calling this function.
> > > + * Similarly, it is responsible for converting the response payload with
> > > + * cpu_to_le32() before sending it back over the DOE mailbox.
> > > + *
> > > + * The caller is also responsible for ensuring that the request size
> > > + * is within the limits defined by PCI_DOE_MAX_LENGTH.
> > > + *
> > > + * RETURNS: 0 if the request was successfully queued, -errno on failure
> > > + */
> > > +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> > > +			       u16 vendor, u8 type, const void *request, size_t request_sz,
> > > +			       pci_ep_doe_complete_t complete)
> > > +{
> > > +	struct pci_ep_doe_mb *doe_mb;
> > > +	struct pci_ep_doe_task *task;
> > > +	int rc;
> > > +
> > > +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> > > +	if (!doe_mb) {
> > > +		kfree(request);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	task = kzalloc_obj(*task, GFP_KERNEL);
> > > +	if (!task) {
> > > +		kfree(request);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	task->feat.vid = vendor;
> > > +	task->feat.type = type;
> > > +	task->request_pl = request;
> > > +	task->request_pl_sz = request_sz;
> > > +	task->response_pl = NULL;
> > > +	task->response_pl_sz = 0;
> > > +	task->complete = complete;
> > > +
> > > +	rc = pci_ep_doe_submit_task(doe_mb, task);
> > > +	if (rc) {
> > > +		kfree(request);
> > > +		kfree(task);
> > > +		return rc;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
> > 
> > So who is supposed to call this API? EPC driver that receives the DOE interrupt?
> 
> Yes, the EPC drivers that receive the DOE interrupts are expected to
> call this API.
> 
> > But I don't see the any callers of this and below exported APIs in this series.
> > Either you should add the callers or limit this series just to adding the DOE
> > skeleton implementation with a clear follow-up.
> 
> I currently am working on the EPC driver implementation for a platform
> which has not been up-streamed yet. I plan to use these APIs to support
> the DOE feature for that driver. Currently, I am not aware of any
> platform whose EPC driver supports DOE feature and its interrupts, hence
> I see no real callers of these APIs to include in this patch series.
> 
> Would it be appropriate to add a dummy [NOT-FOR-MERGING] demonstration
> patch over an existing EPC driver, showing how these DOE APIs would be
> integrated into an EPC driver?
> 

Usually we don't add APIs without any callers. But if you have a realistic time
frame and guarantee that you are going to add EPC driver support soon, then we
can have these APIs merged first.

For demonstration purpose, you can just show the EPC integration as a snippet in
cover letter or point to the downstream driver for reference (if it is not a
secret sauce).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
