Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194C411695;
	Thu, 11 Jun 2026 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205175; cv=none; b=k12MfbHB0NCK8cuCcoEtfvD3N3lsHipLP4qTaQyLniDvh0hhGGzjfNykx4cCp/44Tdy5qYe3x6tReNaofHEL7BPHv7Y0YYP4v66M7sd4oW2EqqJQx8EAwO/VKVCovBHbZHa28PYmRFqswTg2U3ZL500HWtnifJxEfeSSu1cpzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205175; c=relaxed/simple;
	bh=oKroMKixH2xwI4aoT04N7fNdecAgwfN0yzRK9ZB1tIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FiDaDwoZ5adNuDl+2W+1mKju2zUY6sT0Rq+obhUhIoPRX7yOOuxCEgykxtjennGggAxkP6hK5FMCubPMOfsAb5A3PH1sSN7wKrctv6x3n3RUmkXoLbH6of9Q+uJY3XxrGFOHC5w+QfP0oSQ8D55luBv9fXkwvCRkomNG7wYn2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEhgpmeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEhgpmeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C405C1F000E9;
	Thu, 11 Jun 2026 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205174;
	bh=S/7DdcSz4YPEQG8E8fG13H/pav8xrhgQ+JpNMYjMmWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QEhgpmeHZA635hfGO3rONfxHPdtsjbP3UasKqbReIU1K9uIRhGAGIhaVg4U7Dgw/x
	 R2sN8QTP/5SKGONk5LpT0hLvClF9UzyA31tncaKzC2zFBWIOi0S6HNOMkhyVqUaxcT
	 dwiWsx+sfJGV7rODDe/bVnxLtQh2uEhfjom7JyuLaYBBziHkkN+PvOj69WadewOxVj
	 ULOHtDDdH3XDLIAzo/RAKYtrhNYXQD4RY0Sq2bAAha/dzXM41Mqd4AXMDtrcioC5ed
	 +7u7A5k8Ad47dQ+zzqJ+qAnOUoQwU2PkA0Izcy2zlA269u2+6AyCiMB9REmRMBw9FW
	 3S6swdupBKRHQ==
Date: Thu, 11 Jun 2026 14:12:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de,
	cassel@kernel.org, alistair@alistair23.me,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 3/4] PCI: endpoint: Add support for DOE initialization
 and setup in EPC core
Message-ID: <20260611191252.GA499821@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610100256.1889111-4-a-garg7@ti.com>

On Wed, Jun 10, 2026 at 03:32:55PM +0530, Aksh Garg wrote:
> Add pci_epc_init_capabilities() in EPC core driver to initialize and
> setup the capabilities supported by the EPC driver. This calls
> pci_epc_doe_setup() to setup the DOE framework for an endpoint controller,
> which discovers the DOE capabilities (extended capability ID 0x2E), and
> registers each discovered DOE mailbox for all the functions in the
> endpoint controller.
> 
> Add pci_epc_deinit_capabilities() in EPC core driver for cleanup of the
> resources used by the capabilities of the EPC driver. This calls
> pci_ep_doe_destroy() to destroy all DOE mailboxes and free associated
> resources.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes from v4 to v5:
> - Addressed the review comments by Sashiko
> 
> Changes from v3 to v4:
> - Call DOE setup and destroy APIs directly within the EPC core, instead of
>   relying on the EPC drivers to call them individually. EPC drivers do not
>   need to explicitly handle DOE setup, rather the EPC core manages this
>   transparently. (Suggested by Manivannan Sadhasivam).
> - Removed pci_epc_doe_destroy() API, which was just calling pci_ep_doe_destroy().
>   Instead, called pci_ep_doe_destroy() directly during cleanup.
> - Called pci_ep_doe_init() before the "!epc->ops->find_ext_capability" check,
>   because if doe-capable=1 and find_ext_capability() op is undefined, this
>   would not initialize the epc->doe_mbs xarray. However during cleanup, the
>   check "!epc->ops->find_ext_capability" would be unnecessary, and it will
>   try to destroy the epc->doe_mbs xarray even when it was not initialized.
> 
> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
> 
> Changes since v1:
> - New patch added to v2 (not present in v1)
> 
> v4: https://lore.kernel.org/all/20260522052434.802034-4-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-4-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/
> 
> This patch is introduced based on the feedback provided by Manivannan
> Sadhasivam at [1].
> 
> [1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/
> 
> 
>  drivers/pci/endpoint/pci-epc-core.c | 104 ++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |   6 ++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c3c58185fc5..e48f40eeed29 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -14,6 +14,8 @@
>  #include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
>  
> +#include "../pci.h"
> +
>  static const struct class pci_epc_class = {
>  	.name = "pci_epc",
>  };
> @@ -842,6 +844,81 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkdown);
>  
> +/**
> + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functions
> + * @epc: the EPC device on which DOE mailboxes has to be setup
> + *
> + * Discover DOE (Data Object Exchange) capabilities for all physical functions
> + * in the endpoint controller and register DOE mailboxes.
> + *
> + * Returns: 0 on success, -errno on failure
> + */
> +static int pci_epc_doe_setup(struct pci_epc *epc)
> +{
> +	u8 func_no, vfunc_no = 0;
> +	u16 cap_offset;
> +	int ret;
> +
> +	if (!epc->ops || !epc->ops->find_ext_capability)
> +		return -EINVAL;

I don't see anything that sets pci_epc_ops.find_ext_capability in this
series, so this looks currently unused and untestable, so likely not
mergeable as-is.  What's the plan for users of this?

> +	/* Discover DOE capabilities for all functions */
> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +		mutex_lock(&epc->lock);
> +		cap_offset = epc->ops->find_ext_capability(epc, func_no,
> +							   vfunc_no, 0,
> +							   PCI_EXT_CAP_ID_DOE);
> +		mutex_unlock(&epc->lock);
> +
> +		while (cap_offset) {
> +			/* Register this DOE mailbox */
> +			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
> +			if (ret) {
> +				dev_warn(&epc->dev,
> +					 "[pf%d:offset %x] failed to add DOE mailbox\n",
> +					 func_no, cap_offset);
> +			}
> +
> +			mutex_lock(&epc->lock);
> +			cap_offset = epc->ops->find_ext_capability(epc, func_no,
> +								   vfunc_no, cap_offset,
> +								   PCI_EXT_CAP_ID_DOE);
> +			mutex_unlock(&epc->lock);
> +		}
> +	}
> +
> +	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
> +	return 0;
> +}
> +
> +/**
> + * pci_epc_init_capabilities() - Initialize EPC capabilities
> + * @epc: the EPC device whose capabilities need to be initialized
> + *
> + * Invoke to initialize capabilities supported by the EPC device.

s/Invoke to initialize/Initialize/

> + */
> +static void pci_epc_init_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +	int ret;
> +
> +	epc_features = pci_epc_get_features(epc, 0, 0);
> +	if (!epc_features)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
> +		ret = pci_ep_doe_init(epc);
> +		if (ret) {
> +			dev_warn(&epc->dev, "DOE initialization failed: %d\n", ret);
> +			return;
> +		}
> +
> +		ret = pci_epc_doe_setup(epc);
> +		if (ret)
> +			dev_warn(&epc->dev, "DOE setup failed: %d\n", ret);
> +	}
> +}
> +
>  /**
>   * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
>   *                         is completed.
> @@ -857,6 +934,9 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
> +	if (!epc->init_complete)
> +		pci_epc_init_capabilities(epc);
> +
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> @@ -890,6 +970,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
>  
> +/**
> + * pci_epc_deinit_capabilities() - Cleanup EPC capabilities
> + * @epc: the EPC device whose capabilities need to be cleaned up
> + *
> + * Invoke to cleanup capabilities supported by the EPC device,
> + * and free the associated resources.

s/Invoke to cleanup/Clean up/

> + */
> +static void pci_epc_deinit_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +
> +	epc_features = pci_epc_get_features(epc, 0, 0);
> +	if (!epc_features)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
> +		pci_ep_doe_destroy(epc);
> +		dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
> +	}
> +}
> +
>  /**
>   * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
>   * @epc: the EPC device whose deinitialization is completed
> @@ -903,6 +1004,9 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
> +	if (epc->init_complete)
> +		pci_epc_deinit_capabilities(epc);
> +
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index dd26294c8175..11474e337db3 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -84,6 +84,8 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @find_ext_capability: ops to find extended capability offset for a function
> + *			 in endpoint controller
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +117,8 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	u16	(*find_ext_capability)(struct pci_epc *epc, u8 func_no,
> +				       u8 vfunc_no, u16 start, u8 cap);
>  	struct module *owner;
>  };
>  
> @@ -270,6 +274,7 @@ struct pci_epc_bar_desc {
>   * @msi_capable: indicate if the endpoint function has MSI capability
>   * @msix_capable: indicate if the endpoint function has MSI-X capability
>   * @intx_capable: indicate if the endpoint can raise INTx interrupts
> + * @doe_capable: indicate if the endpoint function has DOE capability
>   * @bar: array specifying the hardware description for each BAR
>   * @align: alignment size required for BAR buffer allocation
>   */
> @@ -280,6 +285,7 @@ struct pci_epc_features {
>  	unsigned int	msi_capable : 1;
>  	unsigned int	msix_capable : 1;
>  	unsigned int	intx_capable : 1;
> +	unsigned int	doe_capable : 1;
>  	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
>  	size_t	align;
>  };
> -- 
> 2.34.1
> 
