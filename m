Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F511E7C18;
	Fri, 21 Aug 2026 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355214; cv=none; b=hwVpTHGpAucm7zjU/x5GU73DRkpIbJOnRI5BCWJXqzk9bFjH75vpjs3eBGrsO3lcv2BLf8w4+8AXFKELT2bd/NWT7XSz5nTp15+bUm+A8EW5D+f5Ips3wqUY1ECy9pqP4YZpyJPIM5tWDrg3qJCtT0k/HdbYsM74zi1xzH4Fv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355214; c=relaxed/simple;
	bh=yPVzlxBhZ0lL7gTCENbZi91sysSxRdJtOEmGyTtGrMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aao2H2ZVyuFSmBBIYkoB3G2tlSZae2mIkv85R9Gm72URmqwP18OQZMps6MJ0YcbgT/m/yCaz61fKAYq8JjKL8e1WFUtmf8NPek8sJOfOx2Cp0DvU5JbJb+7V2l74kelJHMkGhenVaCWnZXHFPVFTxD0jyy0hgWb24q69Zgb+B7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0GD0Z9f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0GD0Z9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787355211; x=1818891211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yPVzlxBhZ0lL7gTCENbZi91sysSxRdJtOEmGyTtGrMM=;
  b=L0GD0Z9fFDIqs+rl62BqnGlJ6J7uccCvTdld8v+AFbYp+m56IwWIurnK
   EHFGRrvDZSCFA3yfpcEFeXcRxSSA7SB+CVeM7kvMkzFizeEaFhgHIS/fg
   XIxXmpoBFAi2jJUR/g4M/qRyDet5TaeLZx6IKhhMaxbSE6pErmHOlP+7U
   gGSylfIUvomwqejmiWxj+yoREPNnkSg2YjGvNIKFZig5dQAybYETz9jpe
   K+bgX0xYXyR34RgA2k6iA/HWtysIgFXWivJKtLJtr4bZpDCrYlrt0KyWy
   0iBIy+eul/Ra6nv20eTfctNvtfAN4MdqT0k6OHHxbg5xGPe0KwCwyPOZy
   g==;
X-CSE-ConnectionGUID: 9O5OIikBQ+GevC/XhguJlw==
X-CSE-MsgGUID: f+MOWpglRJmY93jTUnsa4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91582833"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91582833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 16:33:31 -0700
X-CSE-ConnectionGUID: ejCM3dmSTwOkav4r0aDSMA==
X-CSE-MsgGUID: Iix9TPFhSMSJpeyTnytE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="267053248"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.117]) ([10.125.108.117])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 16:33:30 -0700
Message-ID: <1c648e0d-eb07-4006-91ec-9f092fd7c8ec@intel.com>
Date: Fri, 21 Aug 2026 16:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
> 
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning.
> 
> CXL core reuses and refreshes the same cache as decoders are committed or
> reset, and retries cache setup during CXL HDM enumeration if the PCI
> bus-add attempt did not publish a cache. Move the register helpers into
> the built-in CONFIG_CXL_HDM set so the early cache path is available
> without cxl_core, and keep the cxl-test mock core from building a
> duplicate regs.o.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   3 +-
>  drivers/cxl/core/hdm.c      |  13 +-
>  drivers/cxl/core/regs.c     |   4 +
>  drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/probe.c         |   2 +
>  include/cxl/cxl.h           |  26 +++
>  tools/testing/cxl/Kbuild    |   1 -
>  8 files changed, 360 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 0df4178bbbaa..e22f05d83c39 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += resource.o
> +obj-$(CONFIG_CXL_HDM) += regs.o resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ec988e7b7c0c..b47701fc5315 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -112,10 +112,17 @@ static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  	struct pci_dev *pdev __free(pci_dev_put) =
>  		cxl_port_get_uport_pci_dev(cxlhdm->port);
>  	bool present;
> +	int rc;
>  
>  	if (!pdev)
>  		return 0;
>  
> +	rc = cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
> +	if (rc || present)
> +		return rc;
> +
> +	pci_cxl_hdm_init(pdev);
> +
>  	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
>  }
>  
> @@ -180,6 +187,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
>  	else
> @@ -1002,11 +1013,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl, tl_low, tl_high;
> -	struct cxl_decoder_settings settings;

This adjustment should be moved to the patch where settings was initially introduced
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..040b0304f63c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 97cb136cb2ae..7f5946d3f2c4 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,16 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -170,3 +177,309 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  				  &settings->interleave_granularity);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> +
> +struct cxl_hdm_decoder_state {
> +	u32 ctrl;
> +	u32 base_low;
> +	u32 base_high;
> +	u32 size_low;
> +	u32 size_high;
> +	u32 target_low;
> +	u32 target_high;
> +};
> +
> +static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
> +{
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +
> +	cxl_pci_hdm_info_free(info);
> +}
> +
> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	if (!pci_resource_len(pdev, bar))
> +		return false;
> +	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +		return false;
> +	if (resource_type(res) != IORESOURCE_MEM)
> +		return false;
> +	if (!res->start || !res->end)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end;
> +
> +	if (!hdm_size)
> +		return -EINVAL;
> +
> +	hdm_end = hdm_start + hdm_size - 1;
> +	if (hdm_end < hdm_start)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!cxl_pci_bar_usable(pdev, i))
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		if (bar)
> +			*bar = i;
> +		if (offset)
> +			*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
> +				     struct cxl_register_map *map,
> +				     struct cxl_hdm_info *info)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm_start = map->resource + hdm_map->offset;
> +	info->hdm_size = hdm_map->size;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
> +				  &info->hdm_bar, &info->hdm_offset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	hdm = ioremap(hdm_start, info->hdm_size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
> +					   void __iomem *hdm, int id)
> +{
> +	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_hdm_decoder_state *state,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, NULL);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)

Function should return a bool.

cxl_pci_mem_capable() would be clearer on what this function is checking. Although do you want to check the hdm_count as well? That would make the original function name make sense.

Also a helper that returns the DVSEC offset and the cap word can be shared with cxl_dvsec_rr_decode() and cxl_reset_dvsec().


> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map,
> +				 struct cxl_hdm_info *info)
> +{
> +	struct cxl_decoder_settings *settings;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map->component_map.hdm_decoder.valid)
> +		return -ENODEV;
> +
> +	hdm = cxl_pci_hdm_map(pdev, map, info);

I think you can setup a custom __free() for the hdm so you don't need to have the gotos.

> +	if (IS_ERR(hdm))
> +		return PTR_ERR(hdm);
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {

There's no need to check this. The register cannot decoder larger than a value of 32. So this scenario would never happen. Maybe
	if (decoder_count > ARRAY_SIZE(info->settings))

DJ


> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);
> +	if (!info->decoder_state) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	rc = 0;
> +out_unmap:
> +	iounmap(hdm);
> +	return rc;
> +}
> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	bool restore_command;
> +	u16 command;
> +	int rc;
> +
> +	down_read(&cxl_rwsem.dpa);
> +	if (pdev->hdm) {
> +		up_read(&cxl_rwsem.dpa);
> +		return 0;
> +	}
> +	up_read(&cxl_rwsem.dpa);
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
> +	if (rc)
> +		return rc;
> +
> +	info = kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_free_info;
> +	}
> +
> +	restore_command = !(command & PCI_COMMAND_MEMORY);
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc) {
> +			rc = pcibios_err_to_errno(rc);
> +			goto out_free_info;
> +		}
> +	}
> +
> +	rc = cxl_pci_hdm_read_info(pdev, &map, info);
> +
> +	if (restore_command) {
> +		int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +
> +		if (rc2) {
> +			rc2 = pcibios_err_to_errno(rc2);
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				rc2);
> +			if (!rc)
> +				rc = rc2;
> +		}
> +	}
> +
> +	if (rc)
> +		goto out_free_info;
> +
> +	down_write(&cxl_rwsem.dpa);
> +	if (!pdev->hdm) {
> +		pdev->hdm = info;
> +		info = NULL;
> +	}
> +	up_write(&cxl_rwsem.dpa);
> +
> +	cxl_pci_hdm_info_free(info);
> +	return 0;
> +
> +out_free_info:
> +	cxl_pci_hdm_info_free(info);
> +	return rc;
> +}
> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..5fd7bae8e786 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
> +#include <cxl/cxl.h>
>  
>  #include "pci.h"
>  
> @@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..0bed5638d6da 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  static struct resource busn_resource = {
> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 703285966946..a1fe8949f3f7 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -135,16 +136,41 @@ struct cxl_regs {
>  
>  #define CXL_HDM_DECODER_MAX_COUNT 32
>  
> +struct cxl_hdm_decoder_state;
> +
>  /**
>   * struct cxl_hdm_info - PCI device HDM decoder programming cache
>   * @decoder_count: number of decoder settings entries
> + * @hdm_bar: BAR containing the HDM decoder registers
> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
> + * @hdm_size: HDM decoder register resource size
> + * @global_ctrl: cached HDM decoder global control register
> + * @decoder_state: cached raw per-decoder register state
>   * @settings: cached per-decoder programming state
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	struct cxl_hdm_decoder_state *decoder_state;
>  	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>  };
>  
> +#ifdef CONFIG_CXL_HDM
> +void pci_cxl_hdm_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6c09932587ce..2eb61812a8e7 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o

