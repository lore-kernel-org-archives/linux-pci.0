Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFB4B8DFE;
	Wed,  6 May 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090479; cv=none; b=RJIzXkBBCpcOC1qPspmjNrx1FyMTonDie3IPp9m+faMr4Jci/fQHCNVQoB5ekzSpS8yw+3VM/mPQv/2V3DU5NKq2qLxCeXMU2jjd1aD2wpCj65gEe+W2TCpug3Pk1iglh6J2zKlZnEQXc7lLCLi7u2EX7pHY7b5ZXZgd5DvMoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090479; c=relaxed/simple;
	bh=ZKbdGx5mNDwFl13GeUM4CbCOmMNrBQIHPIWXJRT2/GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9OG3t986hVHFq29VTkxOF0lPai4Awk/zEZB8helrNhNRFdb2YyWoqGcCU65SajFWNZuMIGm1Y4nkL69nK1xM5WpBfChmP0trCMstTHQLobXa4kye1XQNaf4RS82oz5zfl+CZ2lYCfxbnFgrDJAF7o4gOQyxGh2WuXNcXzinaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlvY0Vio; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlvY0Vio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778090467; x=1809626467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZKbdGx5mNDwFl13GeUM4CbCOmMNrBQIHPIWXJRT2/GI=;
  b=IlvY0VioYn0mQebfasZtYwnAkeqyHFkbJ1joWn0xZVUJDShSchAfSLUp
   5VL0ykLwM6IAOjjwH5I9prD/K2hO1DIPHa5OTqSHotx/uPLpjGm+wYjXV
   brJqAVki2mUfR7Gb7+VzHpDyL9vfONLccXs2zXj/vMYTsagpHCH8lhNBu
   EJrpUmtsVYErt+JOp9gtz+W7dHybPy0YCLCTpR53bE33ChrI+Pdskj+iM
   R/E7PjA7Hq0eZ4jpyrwy59TX67kvzkOlJ+uPCl/84QqQv4QVTJylxCk+U
   QQsDHbVR1j7XKh0B/dfPfYg6O8KWCZ0IZdjfPnBuK6qGp6p1E9AWofw5t
   A==;
X-CSE-ConnectionGUID: 9hTEYNIYTDSx62o8KuvnUg==
X-CSE-MsgGUID: s7zuWRlTSKOsTQGrFJSI5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89618709"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89618709"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:01:00 -0700
X-CSE-ConnectionGUID: bGrIqHRdQquMsmEaN+iSrQ==
X-CSE-MsgGUID: BErO3eFYT/GtilNigiRfUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233110143"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.169]) ([10.125.110.169])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:00:58 -0700
Message-ID: <38155e50-c0c0-4f51-9777-243f0dd049ca@intel.com>
Date: Wed, 6 May 2026 11:00:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-11-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot. They
> must be enabled in order to process CXL protocol errors. Provide matching
> teardown helpers so the masks are restored when a CXL Port or Downstream
> Port goes away.
> 
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core module.
> 
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> @dev so teardown callers do not have to special-case it.
> 
> Wire cxl_unmask_proto_interrupts() into the success path of
> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask only
> runs when the RAS register block was actually mapped. Pair each unmask
> with a devm_add_action_or_reset() registration of
> cxl_mask_proto_interrupts() scoped to the cxl_port device. The mask is
> then restored when the cxl_port device releases its devres. This
> applies to Endpoints, Upstream Switch Ports, Downstream Switch Ports,
> and Root Ports.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I do wonder if we should save the original mask values and write those back rather than blindly remask everything when we are done.


> 
> ---
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
>  drivers/cxl/core/core.h |  4 +++
>  drivers/cxl/core/ras.c  | 63 ++++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pcie/aer.c  | 25 ++++++++++++++++
>  include/linux/aer.h     |  2 ++
>  4 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 2c7387506dfb..ff39985d363f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -190,6 +190,8 @@ void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
> +void cxl_unmask_proto_interrupts(struct device *dev);
> +void cxl_mask_proto_interrupts(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -207,6 +209,8 @@ static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
> +static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
> +static inline void cxl_mask_proto_interrupts(struct device *dev) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index a98ce0f412ad..b45e2b539b5f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -66,16 +66,59 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +void cxl_unmask_proto_interrupts(struct device *dev)
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
> +void cxl_mask_proto_interrupts(struct device *dev)
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
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(dport_to_host(dport),
> +				     cxl_mask_proto_irqs, dev))
> +		dev_warn(dev, "failed to register CXL proto-irq mask cleanup\n");
>  }
>  
>  /**
> @@ -109,6 +152,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
>  void devm_cxl_port_ras_setup(struct cxl_port *port)
>  {
>  	struct cxl_register_map *map = &port->reg_map;
> +	struct device *dev;
>  
>  	if (!map->component_map.ras.valid) {
>  		dev_dbg(&port->dev, "RAS registers not found\n");
> @@ -117,8 +161,19 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
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
> +	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev))
> +		dev_warn(&port->dev,
> +			 "Failed to register CXL proto-irq mask cleanup\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b9c6c7b97217..eaa36fe0eb31 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1151,6 +1151,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   */
>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pci_dev data structure
> + *
> + * Mask internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
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
> +
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 979ed2f9fd38..c52db62d4c7e 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -71,6 +71,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
> @@ -79,6 +80,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
>  #ifdef CONFIG_CXL_RAS

