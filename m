Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0783EA949;
	Mon, 20 Jul 2026 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587956; cv=none; b=DnUqnhUctdQbISLsowhgC/qILC4G0C98jS48HNdnZNYrw2eAC69fs2bQebMagGXhcjrwbuFRg0MG6/Nn/hyTvyz4BryE+rSY/1HV3OaDANiW4mPWYOXNNpHgtsSuKO8fvv8GDTVqvrMqbxFjGV9AnrGNWPeuxb9A4Ot2Rr6Oh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587956; c=relaxed/simple;
	bh=oW2gP6/TaWsZXZvlJtO1GQ1XZMokluipQNGn0iUsBiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuEl8GJ0ph3uo3pRy5wpJ7ikqVbi9DcxgvUb303EyUVwst/kmRHCK24jYMcSjaQ6YKj/5+oPLGCVug1lYqhLJ+NIgWkhUWZ3xZ1N4e5hsezRSt39GbKAphtvUuK6bJz8dfvpT8A8/ryqn9cRvql9iq50yg1r1vvNbonB3zlPjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xfe3Maxo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xfe3Maxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784587955; x=1816123955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oW2gP6/TaWsZXZvlJtO1GQ1XZMokluipQNGn0iUsBiA=;
  b=Xfe3MaxocYCqkL+HoIgadxauM9MhlkYLNHfh+5ZMeU1wKxu0OeZfnCRK
   Nep5vGClfmGlr4wV+2QAg5mWeao4VXYvPJ4k1nZPfqzvU4EMeFSs1b+Vv
   uc1NJgiiF/DevsA78UTtDGWp8pshF9BIUqYAez1kHm1jHWyubeOt8piM3
   XxgV7axvkafd+7p0uGSIMbXAdEAAw2rVKB5z8HvGaeu7GrnhcoMz/d3Dj
   q3G7anyha9GMsFCEoU0LiwI6HpXC4q7edyU1Xn269BMDi2bDP/ZulRP1E
   ruvP3SJZF7e9s2yRAIp2rfGZ2YPAPLK2b9bRvmUXWUWYVu+Gi1lzZ2E7t
   A==;
X-CSE-ConnectionGUID: pKHAkUMBRfmEK2qNQsQqzQ==
X-CSE-MsgGUID: LxPfCpHdSDa+nhqDpg+9rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87719780"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87719780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:52:33 -0700
X-CSE-ConnectionGUID: C8Xk+B+eSYGJ8tyXdgVJLw==
X-CSE-MsgGUID: 2uX0zFPKRBWHzOuxqdekgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254176453"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:52:30 -0700
Message-ID: <197ed6e0-be56-4fce-9fea-42e1d1eeb51e@intel.com>
Date: Mon, 20 Jul 2026 15:52:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/13] PCI/CXL: Mask/Unmask CXL protocol errors
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-13-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot.
> They must be enabled in order to process CXL protocol errors. Provide
> matching teardown helpers so the masks are restored when a CXL Port
> or dport goes away.
> 
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core
> module.
> 
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> or non-PCI @dev so callers do not have to special-case it.
> 
> Wire cxl_unmask_proto_interrupts() into the success path of
> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask
> only runs when the RAS register block was actually mapped. Pair each
> unmask with a devm_add_action_or_reset() registration of
> cxl_mask_proto_irqs() scoped to the host device so the mask is
> restored when devres is released. This applies to dports, Endpoints,
> Upstream Switch Ports, Downstream Switch Ports, and Root Ports.
> 
> Remove the dev_is_pci(dport->dport_dev) guard in
> devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev is the
> pci_host_bridge device, which is not on pci_bus_type, so this guard
> caused the function to return early on real hardware without mapping
> dport RAS or AER registers. The caller already gates on dport->rch,
> which is sufficient to exclude cxl_test mock devices.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17->v18:
> - Make cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts() static
> - Remove dev_is_pci() guard from devm_cxl_dport_rch_ras_setup(); the guard
>   blocked real RCH hardware because pci_host_bridge is not on pci_bus_type
> 
> Changes in v16->v17:
> - Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
>   and cxl_dport_remove(); the devres action registered alongside the unmask
>   is the sole mask path.
> - Update title
> - Remove unnecessary check for aer_capabilities
> - Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
> - Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
> - Only unmask on successful cxl_map_component_regs()
> - NULL-check @dev in cxl_{un,}mask_proto_interrupts()
> - Drop static and declare in core/core.h
> 
> Change in v15 -> v16:
> - None
> 
> Change in v14 -> v15:
> - None
> 
> Changes in v13->v14:
> - Update commit title's prefix (Bjorn)
> 
> Changes in v12->v13:
> - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
> - Add Dave Jiang's and Ben's review-by
> 
> Changes in v11->v12:
> - None
> ---
>  drivers/cxl/core/ras.c        | 73 +++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/aer.c        | 28 ++++++++++++--
>  include/linux/aer.h           |  2 +
>  tools/testing/cxl/Kbuild      |  1 +
>  tools/testing/cxl/test/mock.c | 12 ++++++
>  5 files changed, 105 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 69b320c74469c..d77208af41e03 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,16 +117,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +static void cxl_unmask_proto_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pcie_aer_is_native(pdev))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(pdev);
> +}
> +
> +static void cxl_mask_proto_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pcie_aer_is_native(pdev))
> +		return;
> +
> +	pci_aer_mask_internal_errors(pdev);
> +}
> +
> +static void cxl_mask_proto_irqs(void *dev)
> +{
> +	cxl_mask_proto_interrupts(dev);
> +}
> +
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
>  	struct device *dev = dport->dport_dev;
>  
> -	if (!map->component_map.ras.valid)
> +	if (!map->component_map.ras.valid) {
>  		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(dport_to_host(dport),
> +				     cxl_mask_proto_irqs, dev)) {
> +		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
> +		dport->regs.component.ras = NULL;
> +	}
>  }
>  
>  /**
> @@ -143,9 +191,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
>  {
>  	struct pci_host_bridge *host_bridge;
>  
> -	if (!dev_is_pci(dport->dport_dev))
> -		return;
> -
>  	devm_cxl_dport_ras_setup(dport);
>  
>  	host_bridge = to_pci_host_bridge(dport->dport_dev);
> @@ -160,6 +205,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
>  void devm_cxl_port_ras_setup(struct cxl_port *port)
>  {
>  	struct cxl_register_map *map = &port->reg_map;
> +	struct device *dev;
>  
>  	if (!map->component_map.ras.valid) {
>  		dev_dbg(&port->dev, "RAS registers not found\n");
> @@ -168,8 +214,21 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  
>  	map->host = &port->dev;
>  	if (cxl_map_component_regs(map, &port->regs,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +		return;
> +	}
> +
> +	dev = is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_dev;
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev)) {
> +		dev_warn(&port->dev,
> +			 "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
> +		port->regs.ras = NULL;
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0bd23a65e7ebc..be6dc2cbd4491 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1143,12 +1143,32 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -/*
> - * Internal errors are too device-specific to enable generally, however for CXL
> - * their behavior is standardized for conveying CXL protocol errors.
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pci_dev data structure
> + *
> + * Mask internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask |= PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask |= PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
>  
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 8eba3192e2d15..b3657b80564b9 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -58,6 +58,7 @@ struct aer_capability_regs {
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
> @@ -65,6 +66,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
>  #ifdef CONFIG_CXL_RAS
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc93..957945201f04d 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -6,6 +6,7 @@ ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
> +ldflags-y += --wrap=devm_cxl_dport_rch_ras_setup
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 6454b868b122c..5ad3243da8d29 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -220,6 +220,18 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> +void __wrap_devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
> +{
> +	int index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (!ops || !ops->is_mock_port(dport->dport_dev))
> +		devm_cxl_dport_rch_ras_setup(dport);
> +
> +	put_cxl_mock_ops(index);
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_rch_ras_setup, "CXL");
> +
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;

