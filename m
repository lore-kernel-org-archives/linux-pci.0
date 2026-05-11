Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5402EDD69;
	Mon, 11 May 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539022; cv=none; b=RlruMFW+c/974x0JVDYDTk2Gh+k99Z8YoYNV54zgwpjLcmLk17015skub7C1y+trShrDNJNe2CasnKJJcx5xq9LJhf4aTlwBykfHjdzY/HUx6syygaoGTVu+3M/nb3hItEIvlI4VgKnTFh3yE9QCqK7vV7TnQWXRa4AZc1RQVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539022; c=relaxed/simple;
	bh=3R+hgMBF67mYP0ugC40K6hy8hGcBSeyRPXKwDKSy77c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzSuUJHHjOqI3FKHc4sn3QibN8sChf8/5TYfqoV1OXTiwpE+KWZycUYTNm9Fwu1e+EpHlyGCy5el5jzuWO4pqecNwlRIaFAxmcvl6wTvb75rBIgxxCpf//Qlvcyiyv4j8oiHFTaqABeqG4TzZTAZRiYMFCI3MONQnzSe5Q3OfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCa4H4DO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCa4H4DO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778539021; x=1810075021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3R+hgMBF67mYP0ugC40K6hy8hGcBSeyRPXKwDKSy77c=;
  b=DCa4H4DO+Tlu800o7JnF0FYYQmUwN/sRK/eB9lzXMg4cJcFFHH96KfQS
   c/WsAIbklyUxCDGouHMvuBiZJBX4Bgh3T+3o/yRsLhTaZVsiQDfF7HGHO
   ZFXhPevdQrtJnJ3Fj6VndpK5d7/fRlrjWEq3jvHlC16PvcCK6ZW3zBj7J
   bmBZLe7al7tMCBskQ+iweJLoneHwfBLE8apoHF5mUTE+u6A8HuZnt0ma+
   QiZ+4rOLMginU6o+dEvi0jbR7enJMIOy5CPfC1/xoLcHAFkNdw3gfXwgo
   /Vt9aLJcJhz4C58FqAn39my2zTM6yzO9UfPepT3wYlLHchb0tN31hKTe0
   w==;
X-CSE-ConnectionGUID: 3CG59hdHRXe+P1+Z0COrbw==
X-CSE-MsgGUID: bJU0R3jyQhiHiRJi/gdVCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102103390"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="102103390"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 15:37:01 -0700
X-CSE-ConnectionGUID: GnGZz2FXQsmxX3vcuzdT0Q==
X-CSE-MsgGUID: OMiw94sCRiW6AdoHvBpbfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237678564"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.111.187]) ([10.125.111.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 15:36:58 -0700
Message-ID: <ce03e27a-f82f-40f8-b185-d80c74ce15ed@intel.com>
Date: Mon, 11 May 2026 15:36:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
To: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, djbw@kernel.org,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
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
 <38155e50-c0c0-4f51-9777-243f0dd049ca@intel.com>
 <8ab3325b-175f-4664-a046-6f4b1d472816@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <8ab3325b-175f-4664-a046-6f4b1d472816@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/26 2:04 PM, Bowman, Terry wrote:
> On 5/6/2026 1:00 PM, Dave Jiang wrote:
>>
>>
>> On 5/5/26 10:30 AM, Terry Bowman wrote:
>>> CXL protocol errors are not enabled for all CXL devices after boot. They
>>> must be enabled in order to process CXL protocol errors. Provide matching
>>> teardown helpers so the masks are restored when a CXL Port or Downstream
>>> Port goes away.
>>>
>>> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
>>> pci_aer_unmask_internal_errors() and export both for the cxl_core module.
>>>
>>> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
>>> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
>>> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
>>> @dev so teardown callers do not have to special-case it.
>>>
>>> Wire cxl_unmask_proto_interrupts() into the success path of
>>> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask only
>>> runs when the RAS register block was actually mapped. Pair each unmask
>>> with a devm_add_action_or_reset() registration of
>>> cxl_mask_proto_interrupts() scoped to the cxl_port device. The mask is
>>> then restored when the cxl_port device releases its devres. This
>>> applies to Endpoints, Upstream Switch Ports, Downstream Switch Ports,
>>> and Root Ports.
>>>
>>> Co-developed-by: Dan Williams <djbw@kernel.org>
>>> Signed-off-by: Dan Williams <djbw@kernel.org>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> I do wonder if we should save the original mask values and write those back rather than blindly remask everything when we are done.
>>
>>
> 
> Hi Dave,
> 
> This is only masking/unmasking the internal error bit. The other mask bits are not 
> modified.

Hi Terry,
My point is we lost the original register values for internal error on exit. We probably should restore whatever was in the register before we unmasked. Currently it comes to us with everything masked. But maybe in the future in may not be and we don't want to go chasing that side effect. 

DJ

> 
> - Terry
> 
> 
>>>
>>> ---
>>>
>>> Changes in v16->v17:
>>> - Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
>>>   and cxl_dport_remove(); the devres action registered alongside the unmask
>>>   is the sole mask path.
>>> - Update title
>>> - Remove unnecessary check for aer_capabilities
>>> - Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
>>> - Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
>>> - Only unmask on successful cxl_map_component_regs()
>>> - NULL-check @dev in cxl_{un,}mask_proto_interrupts()
>>> - Drop static and declare in core/core.h
>>>
>>> Change in v15 -> v16:
>>> - None
>>>
>>> Change in v14 -> v15:
>>> - None
>>>
>>> Changes in v13->v14:
>>> - Update commit title's prefix (Bjorn)
>>>
>>> Changes in v12->v13:
>>> - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
>>> - Add Dave Jiang's and Ben's review-by
>>>
>>> Changes in v11->v12:
>>> - None
>>> ---
>>>  drivers/cxl/core/core.h |  4 +++
>>>  drivers/cxl/core/ras.c  | 63 ++++++++++++++++++++++++++++++++++++++---
>>>  drivers/pci/pcie/aer.c  | 25 ++++++++++++++++
>>>  include/linux/aer.h     |  2 ++
>>>  4 files changed, 90 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index 2c7387506dfb..ff39985d363f 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -190,6 +190,8 @@ void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>>>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>>> +void cxl_unmask_proto_interrupts(struct device *dev);
>>> +void cxl_mask_proto_interrupts(struct device *dev);
>>>  #else
>>>  static inline int cxl_ras_init(void)
>>>  {
>>> @@ -207,6 +209,8 @@ static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>>>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>>> +static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
>>> +static inline void cxl_mask_proto_interrupts(struct device *dev) { }
>>>  #endif /* CONFIG_CXL_RAS */
>>>  
>>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index a98ce0f412ad..b45e2b539b5f 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -66,16 +66,59 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>>  }
>>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>>  
>>> +void cxl_unmask_proto_interrupts(struct device *dev)
>>> +{
>>> +	struct pci_dev *pdev;
>>> +
>>> +	if (!dev || !dev_is_pci(dev))
>>> +		return;
>>> +
>>> +	pdev = to_pci_dev(dev);
>>> +	if (!pcie_aer_is_native(pdev))
>>> +		return;
>>> +
>>> +	pci_aer_unmask_internal_errors(pdev);
>>> +}
>>> +
>>> +void cxl_mask_proto_interrupts(struct device *dev)
>>> +{
>>> +	struct pci_dev *pdev;
>>> +
>>> +	if (!dev || !dev_is_pci(dev))
>>> +		return;
>>> +
>>> +	pdev = to_pci_dev(dev);
>>> +	if (!pcie_aer_is_native(pdev))
>>> +		return;
>>> +
>>> +	pci_aer_mask_internal_errors(pdev);
>>> +}
>>> +
>>> +static void cxl_mask_proto_irqs(void *dev)
>>> +{
>>> +	cxl_mask_proto_interrupts(dev);
>>> +}
>>> +
>>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>>  {
>>>  	struct cxl_register_map *map = &dport->reg_map;
>>>  	struct device *dev = dport->dport_dev;
>>>  
>>> -	if (!map->component_map.ras.valid)
>>> +	if (!map->component_map.ras.valid) {
>>>  		dev_dbg(dev, "RAS registers not found\n");
>>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +		return;
>>> +	}
>>> +
>>> +	if (cxl_map_component_regs(map, &dport->regs.component,
>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> +		return;
>>> +	}
>>> +
>>> +	cxl_unmask_proto_interrupts(dev);
>>> +	if (devm_add_action_or_reset(dport_to_host(dport),
>>> +				     cxl_mask_proto_irqs, dev))
>>> +		dev_warn(dev, "failed to register CXL proto-irq mask cleanup\n");
>>>  }
>>>  
>>>  /**
>>> @@ -109,6 +152,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
>>>  void devm_cxl_port_ras_setup(struct cxl_port *port)
>>>  {
>>>  	struct cxl_register_map *map = &port->reg_map;
>>> +	struct device *dev;
>>>  
>>>  	if (!map->component_map.ras.valid) {
>>>  		dev_dbg(&port->dev, "RAS registers not found\n");
>>> @@ -117,8 +161,19 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>>  
>>>  	map->host = &port->dev;
>>>  	if (cxl_map_component_regs(map, &port->regs,
>>> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>> +		return;
>>> +	}
>>> +
>>> +	dev = is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_dev;
>>> +	if (!dev_is_pci(dev))
>>> +		return;
>>> +
>>> +	cxl_unmask_proto_interrupts(dev);
>>> +	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev))
>>> +		dev_warn(&port->dev,
>>> +			 "Failed to register CXL proto-irq mask cleanup\n");
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>>  
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index b9c6c7b97217..eaa36fe0eb31 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1151,6 +1151,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>   */
>>>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>>>  
>>> +/**
>>> + * pci_aer_mask_internal_errors - mask internal errors
>>> + * @dev: pointer to the pci_dev data structure
>>> + *
>>> + * Mask internal errors in the Uncorrectable and Correctable Error
>>> + * Mask registers.
>>> + *
>>> + * Note: AER must be enabled and supported by the device which must be
>>> + * checked in advance, e.g. with pcie_aer_is_native().
>>> + */
>>> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
>>> +{
>>> +	int aer = dev->aer_cap;
>>> +	u32 mask;
>>> +
>>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>>> +	mask |= PCI_ERR_UNC_INTN;
>>> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>>> +
>>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>>> +	mask |= PCI_ERR_COR_INTERNAL;
>>> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>> +}
>>> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
>>> +
>>>  /**
>>>   * pci_aer_handle_error - handle logging error into an event log
>>>   * @dev: pointer to pci_dev data structure of error source device
>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>> index 979ed2f9fd38..c52db62d4c7e 100644
>>> --- a/include/linux/aer.h
>>> +++ b/include/linux/aer.h
>>> @@ -71,6 +71,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>  int pcie_aer_is_native(struct pci_dev *dev);
>>>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>>>  #else
>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>  {
>>> @@ -79,6 +80,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>>> +static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
>>>  #endif
>>>  
>>>  #ifdef CONFIG_CXL_RAS
>>
> 

