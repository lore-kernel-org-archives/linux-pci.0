Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47018436BF6;
	Tue,  7 Jul 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446466; cv=none; b=MVapU/LxgiOzJ9mtGJFnYGiLqw6YHO/TmM1MQRGL1dn8byGzFO8Rl/CZj5WjN/P4zAG2b0pUnAFOH8JRBFvxm/ULbIZODd2hBAfNt1PnZQLZ6DS1hYZe1tE29A5ybH45TrwQJ/H4T2k+DqucrkZROsDy1HmBB1nNgynTvHiVVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446466; c=relaxed/simple;
	bh=ht+JkdwrUeSgS/QADvPB1ABNdqYIc3aIJ3sEPoNZzbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEq5JKS20ItIEa/Tn4pNLoURtlBaVILpVaXeRA0kmt13beqeV4C5+0UkZlrZxLLvifOI6GrHDWrF4Dh+XqA4t2DErGVxxuT+W3tfeHhDwI+CvI0q5Vl+hk+tVi2daIXsCAxEUu2XiHZYnZZ6fCq3ChAHay4dsaXKYLvGpyKpsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfkPsQGb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfkPsQGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783446462; x=1814982462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ht+JkdwrUeSgS/QADvPB1ABNdqYIc3aIJ3sEPoNZzbI=;
  b=AfkPsQGbhsknrDuisJLZjO2pOlMExr0N/MBnn1v+3qcy+tXnhwc8RKxj
   hg+/a6ds1a3hvOpSbQuj4HwwyNxHKZfTbClGLcgq7z/0vyYEn3BAIWk9y
   G75miqmRJ2y1jmAVRQ3ZQW7b7sqi5jZX/Iz8VvBH9GItTIy8kNMMQ2fDB
   kkrz6h+u4zONt+SrO6+nB2OxFy8l3uEhvGFHJWXZ0MkuriQoM5nasrERG
   LnqUTtSnz01dxZMhAulUrGE4uBR5fvJ4xexGxC0FRhiLwtoWRW4CXMhVH
   OpdSI9NCy0jOfvHLKaiB8xnYDoO5pQxoyRYCJvTkhdIPyUvLMxB8hE640
   Q==;
X-CSE-ConnectionGUID: 9MeGA0mORam/SSlnTGA7ow==
X-CSE-MsgGUID: k0qJcAuFTzGyIxF+Vr9+YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95481415"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95481415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:47:41 -0700
X-CSE-ConnectionGUID: gEpEuhB3SU6rZmvnk85ViQ==
X-CSE-MsgGUID: M6uY9pfFTxGVkRwXl1ISrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254706710"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:47:39 -0700
Message-ID: <2452a9ef-4986-48fd-9be2-03a9069bf216@intel.com>
Date: Tue, 7 Jul 2026 10:47:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-5-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:05 PM, Srirangan Madhavan wrote:
> Populate pci_dev->hdm from PCI capability initialization for CXL.mem
> functions. If Memory Space Enable is clear, temporarily set it while
> reading HDM MMIO and restore the original PCI_COMMAND value before
> returning. This gives driver-free reset paths an early HDM snapshot.
> 
> CXL core later reuses and refreshes the same cache. Move the register
> helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
> available without cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile |   3 +-
>  drivers/cxl/core/hdm.c    |  58 ++++----
>  drivers/cxl/core/regs.c   |   4 +
>  drivers/cxl/core/reset.c  | 288 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |   3 +
>  include/cxl/cxl.h         |  31 +++-
>  6 files changed, 349 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index dc075cee0450..69cf2ea7ee74 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += reset.o
> +obj-$(CONFIG_CXL_HDM) += regs.o reset.o
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
> index bd1d92e5add2..7a1ade846c9c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,18 +84,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> -static void clear_hdm_info(void *data)
> -{
> -	struct pci_dev *pdev = data;
> -
> -	WRITE_ONCE(pdev->hdm, NULL);
> -}
> -
> -static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +static struct pci_dev *cxl_hdm_to_pci_dev(struct cxl_hdm *cxlhdm)
>  {
>  	struct cxl_port *port = cxlhdm->port;
> -	struct cxl_hdm_info *info;
> -	struct pci_dev *pdev;
>  	struct device *uport;
>  
>  	if (is_cxl_endpoint(port)) {
> @@ -107,42 +98,42 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  	}
>  
>  	if (!dev_is_pci(uport))
> -		return 0;
> +		return NULL;
>  
> -	pdev = to_pci_dev(uport);
> -	info = devm_kzalloc(&pdev->dev,
> -			    struct_size(info, settings, cxlhdm->decoder_count),
> -			    GFP_KERNEL);
> -	if (!info)
> -		return -ENOMEM;
> +	return to_pci_dev(uport);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
>  
> -	info->decoder_count = cxlhdm->decoder_count;
> -	WRITE_ONCE(pdev->hdm, info);
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
> +		return 0;
>  
> -	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (info) {
> +		if (info->decoder_count != cxlhdm->decoder_count)
> +			return -ENXIO;
> +	}
> +
> +	return 0;
>  }
>  
>  static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  				     struct cxl_decoder *cxld)
>  {
> -	struct cxl_port *port = cxlhdm->port;
>  	struct cxl_hdm_info *info;
>  	struct pci_dev *pdev;
> -	struct device *uport;
> -
> -	if (is_cxl_endpoint(port)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> -
> -		uport = cxlmd->dev.parent;
> -	} else {
> -		uport = port->uport_dev;
> -	}
>  
> -	if (!dev_is_pci(uport))
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
>  		return;
>  
> -	pdev = to_pci_dev(uport);
> -	info = READ_ONCE(pdev->hdm);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> @@ -948,6 +939,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
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
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 4c977fc47f8d..97b72cc67b6b 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -2,9 +2,16 @@
>  /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
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
> @@ -161,3 +168,284 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
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
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end = hdm_start + hdm_size - 1;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		*bar = i;
> +		*offset = hdm_start - res->start;
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
> +	bool committed;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, &committed);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	if (!committed)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
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
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_decoder_settings *settings;
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	void __iomem *hdm = NULL;
> +	bool restore_command = false;
> +	bool allocated_info = false;
> +	int decoder_count;
> +	u16 command;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		if (info)
> +			return 0;
> +	}
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		restore_command = true;
> +
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +	}
> +
> +	if (!info) {
> +		info = kzalloc_obj(*info, GFP_KERNEL);
> +		if (!info)
> +			goto err_nomem;
> +		allocated_info = true;
> +	}
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	if (!map.component_map.hdm_decoder.valid) {
> +		rc = -ENODEV;
> +		goto out_restore_command;
> +	}
> +
> +	hdm = cxl_pci_hdm_map(pdev, &map, info);
> +	if (IS_ERR(hdm)) {
> +		rc = PTR_ERR(hdm);
> +		hdm = NULL;
> +		goto out_restore_command;
> +	}
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	if (info->decoder_count && info->decoder_count != decoder_count) {
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
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			goto out_restore_failed;
> +	}
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		if (pdev->hdm)
> +			goto out_unmap;
> +		pdev->hdm = info;
> +	}
> +	iounmap(hdm);
> +	return 0;
> +
> +out_restore_failed:
> +	rc = pcibios_err_to_errno(rc);
> +	goto out_unmap;
> +err_nomem:
> +	rc = -ENOMEM;
> +	goto out_restore_command;
> +out_unmap:
> +	if (hdm)
> +		iounmap(hdm);
> +out_restore_command:
> +	if (allocated_info) {
> +		kfree(info->decoder_state);
> +		kfree(info);
> +	}
> +	if (restore_command) {
> +		int rc2;
> +
> +		rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc2 && !rc)
> +			rc = pcibios_err_to_errno(rc2);
> +	}
> +	return rc;
> +}

This function is awfully long plus with the nested gotos is rather ugly. Maybe something like this? Claude generated refactoring with adjusments.

static void cxl_hdm_info_free(struct cxl_hdm_info *info)
{
	kfree(info->decoder_state);
	kfree(info);
}
DEFINE_FREE(cxl_hdm_info, struct cxl_hdm_info *, if (_T) cxl_hdm_info_free(_T))
DEFINE_FREE(cxl_iounmap, void __iomem *, if (!IS_ERR_OR_NULL(_T)) iounmap(_T))

/* Runs with PCI_COMMAND_MEMORY guaranteed enabled by the caller. */
static int __pci_cxl_hdm_probe(struct pci_dev *pdev, struct cxl_hdm_info *info)
{
	struct cxl_register_map map = { 0 };
	int decoder_count;
	int rc;

	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
	if (rc)
		return rc;

	rc = cxl_setup_regs(&map);
	if (rc)
		return rc;

	if (!map.component_map.hdm_decoder.valid)
		return -ENODEV;

	void __iomem *hdm __free(cxl_iounmap) = cxl_pci_hdm_map(pdev, &map, info);
	if (IS_ERR(hdm))
		return PTR_ERR(hdm);

	decoder_count = cxl_hdm_decoder_count(readl(hdm +
						    CXL_HDM_DECODER_CAP_OFFSET));
	if (decoder_count < 0)
		return decoder_count;
	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT)
		return -ENXIO;
	if (info->decoder_count && info->decoder_count != decoder_count)
		return -ENXIO;

	info->decoder_count = decoder_count;
	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
	info->decoder_state = kcalloc(decoder_count,
				      sizeof(*info->decoder_state),
				      GFP_KERNEL);
	if (!info->decoder_state)
		return -ENOMEM;

	for (int i = 0; i < info->decoder_count; i++) {
		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
					      &info->settings[i], hdm, i);
		if (rc)
			return rc;
	}

	return 0;
}

static int __pci_cxl_hdm_init(struct pci_dev *pdev)
{
	bool enabled_memory = false;
	u16 command;
	int rc;

	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
		if (pdev->hdm)
			return 0;

	rc = cxl_pci_hdm_capable(pdev);
	if (rc)
		return rc;

	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
	if (rc)
		return pcibios_err_to_errno(rc);

	if (!(command & PCI_COMMAND_MEMORY)) {
		rc = pci_write_config_word(pdev, PCI_COMMAND,
					   command | PCI_COMMAND_MEMORY);
		if (rc)
			return pcibios_err_to_errno(rc);
		enabled_memory = true;
	}

	struct cxl_hdm_info *info __free(cxl_hdm_info) =
		kzalloc_obj(*info, GFP_KERNEL);
	if (!info)
		rc = -ENOMEM;
	else
		rc = __pci_cxl_hdm_probe(pdev, info);

	if (enabled_memory) {
		int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);

		if (rc2 && !rc)
			rc = pcibios_err_to_errno(rc2);
	}
	if (rc)
		return rc;

	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
		if (!pdev->hdm)
			pdev->hdm = no_free_ptr(info);

	return 0;
}

DJ

> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc..2fd186468498 100644
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
> @@ -2489,6 +2490,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> @@ -2679,6 +2681,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rebar_init(dev);		/* Resizable BAR */
>  	pci_dev3_init(dev);		/* Device 3 capabilities */
>  	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 80839517eabf..2215fe1c3f78 100644
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
> @@ -121,22 +122,46 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +struct cxl_hdm_decoder_state;
> +
>  /**
>   * struct cxl_hdm_info - PCI device HDM decoder programming cache
>   * @decoder_count: number of decoder settings entries
> - * @regs: mapped CXL component registers for this HDM decoder block
> + * @hdm_bar: BAR containing the HDM decoder registers
> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
> + * @hdm_size: HDM decoder register resource size
> + * @global_ctrl: cached HDM decoder global control register
> + * @decoder_state: cached raw per-decoder register state
>   * @settings: cached per-decoder programming state
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> -	struct cxl_component_regs regs;
> -	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	struct cxl_hdm_decoder_state *decoder_state;
> +	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>  };
>  
>  int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
>  			   bool *committed);
>  int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
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
>  
>  struct cxl_reg_map {
>  	bool valid;

