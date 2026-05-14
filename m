Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22E3D7D8B;
	Thu, 14 May 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746120; cv=none; b=EEowz31FkRTJ0YtJpb7TeVn5IvGu8ElfuOuFSdH0tb116E0YJKmTbGwWNlWAFZVEeA9my9o9apnu66yiH7HSZeb2rbN0jW5pTX9ox0BurcCgH7mhDoAoq0bCiINCaBHIRbBORPOEir/dLaKNFYz7nE1IfgmDoWakBCeK5c4AqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746120; c=relaxed/simple;
	bh=neubxVpu/X2LCngSEN7uVvoKch8IAHKiJULMvXS3QwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Y/HrnWNfljWcoOFiLu+FhmlVa3+EFL3C7vuAe5Fq3PsjrzbWCA4yEX6YcYgOZ7cTzOIe6HgstLJApZgGXshf6NuV0b3K2FkpMYdqKQIGHtvmlG1EU+HTJCWO7S8Gg7b8wwAEmEA/5+R/qBWiJoqncMrm10BToXLZ2dOUmmrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR2mw9nC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR2mw9nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C718EC2BCB7;
	Thu, 14 May 2026 08:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778746119;
	bh=neubxVpu/X2LCngSEN7uVvoKch8IAHKiJULMvXS3QwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kR2mw9nCQ+x/HROxAAb4Xw+lwdnW4iU1LT/ogmwMhUpnWBvqCQeZ5NCc88V8+nV7r
	 kRtSu8NjAg/8m8+uHSRew6zMbOV2crcVKubScsyfqa4UlCgmySOdlwewrOmcnhvV4y
	 +T2KnYR94wQFg4i/YHlP7iHJnSkecOLIiCSLo5bpCOBz/4RrE1W0t8jOGH34ZhOm8h
	 UVeWr9kg4J2h+4pARe39VGJG7Dq4Ii5vdDQhbETKCukOP8ggDkEGezDPwYr8xOwocA
	 njsLvab7HraddN7W4Q2nSDp2rc6t/tAi+qq9mPhwz0aUimrr6wy1Zguvx8ba239/HG
	 NCEOaNOv1MJYA==
Date: Thu, 14 May 2026 13:38:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org, 
	skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, alistair@alistair23.me, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v3 3/4] PCI: endpoint: Add API for DOE initialization and
 setup in EPC core
Message-ID: <m4z3q3pe3ro5vkl4uq4zkewpjdqccgeact2hj4tjnkonttx4vr@ndan37zzwgxc>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-4-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427051725.223704-4-a-garg7@ti.com>

On Mon, Apr 27, 2026 at 10:47:24AM +0530, Aksh Garg wrote:
> Add pci_epc_setup_doe() API in EPC core driver to initialize and setup
> the DOE framework for an endpoint controller. The API discovers the DOE
> capabilities (extended capability ID 0x2E), and registers each discovered
> DOE mailbox for all the functions in the endpoint controller. This API
> should be invoked by the controller driver during probe based on the
> doe_capable feature.
> 
> Add pci_epc_destroy_doe() API in EPC core driver for cleanup of DOE
> resources, which should be invoked by the controller driver during
> controller cleanup based on the doe_capable feature.
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
> - New patch added to v2 (not present in v1)
> 
> v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/
> 
> This patch is introduced based on the feedback provided by Manivannan
> Sadhasivam at [1].
> 

Sweet! But I was expecting you to add atleast one EPC driver implementation to
make use of these APIs.

Also, why can't you call these APIs from the EPC core directly? Maybe during
pci_epc_init_notify() once the register accesses become valid.

- Mani

> [1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/
> 
>  drivers/pci/endpoint/pci-epc-core.c | 71 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 21 +++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c3c58185fc5..5a95a07b7d3a 100644
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
> @@ -548,6 +550,75 @@ void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
>  
> +/**
> + * pci_epc_doe_setup() - Setup and discover DOE mailboxes for all functions
> + * @epc: the EPC device on which DOE mailboxes has to be setup
> + *
> + * Discover DOE (Data Object Exchange) capabilities for all physical functions
> + * in the endpoint controller and register DOE mailboxes.
> + *
> + * This API should be called by the controller driver during initialization
> + * if DOE support is available (indicated by doe_capable in pci_epc_features).
> + *
> + * RETURNS: 0 on success, -errno on failure
> + */
> +int pci_epc_doe_setup(struct pci_epc *epc)
> +{
> +	u16 cap_offset = 0;
> +	u8 func_no;
> +	int ret;
> +
> +	if (!epc || !epc->ops || !epc->ops->find_ext_capability)
> +		return -EINVAL;
> +
> +	/* Initialize DOE framework for this controller */
> +	ret = pci_ep_doe_init(epc);
> +	if (ret)
> +		return ret;
> +
> +	/* Discover DOE capabilities for all functions */
> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +		while ((cap_offset = epc->ops->find_ext_capability(epc, func_no, 0,
> +								   cap_offset,
> +								   PCI_EXT_CAP_ID_DOE))) {
> +			/* Register this DOE mailbox */
> +			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
> +			if (ret) {
> +				dev_err(&epc->dev,
> +					"[pf%d:offset %x] failed to add DOE mailbox\n",
> +					func_no, cap_offset);
> +			}
> +		}
> +	}
> +
> +	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_doe_setup);
> +
> +/**
> + * pci_epc_doe_destroy() - Destroy and cleanup DOE mailboxes
> + * @epc: the EPC device on which DOE mailboxes has to be destroyed
> + *
> + * Destroy all DOE mailboxes registered on this endpoint controller and
> + * free associated resources.
> + *
> + * This API should be called by the controller driver during controller cleanup
> + * if DOE support is available (indicated by doe_capable in pci_epc_features).
> + *
> + * RETURNS: 0 on success, -errno on failure
> + */
> +int pci_epc_doe_destroy(struct pci_epc *epc)
> +{
> +	if (!epc)
> +		return -EINVAL;
> +
> +	pci_ep_doe_destroy(epc);
> +	dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_doe_destroy);
> +
>  /**
>   * pci_epc_clear_bar() - reset the BAR
>   * @epc: the EPC device for which the BAR has to be cleared
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index dd26294c8175..7b0f258ef330 100644
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
> @@ -368,6 +374,21 @@ int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		       struct pci_epc_map *map);
>  
> +#ifdef CONFIG_PCI_ENDPOINT_DOE
> +int pci_epc_doe_setup(struct pci_epc *epc);
> +int pci_epc_doe_destroy(struct pci_epc *epc);
> +#else
> +static inline int pci_epc_doe_setup(struct pci_epc *epc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pci_epc_doe_destroy(struct pci_epc *epc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #else
>  static inline void pci_epc_init_notify(struct pci_epc *epc)
>  {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
