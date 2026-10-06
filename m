Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB53BB695;
	Tue,  6 Oct 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301184; cv=none; b=oxAtkT/VOyjWghnbJ1jxG4TGKxcRqbp3fH3GwCKNzQJ5o2Xf4Vyu8gYJhUjg9T4DvYCR+V6zhilJGCq4iPYTE5vmpg4EiCfD+F84Cg31mjPfTPfW2rPshOydM//aaAB6AFgSfo3avudHHpuqob51agCjx8V6o1F87iW+nZLwS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301184; c=relaxed/simple;
	bh=EPhs60JXBsZuFBZMagzNxSsOs5aqTpvFF0PPtw4pjI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=optLaqjdCsgdrl7uPgwQW4GvvQPwT7qHtXZqEWVqspkp3jyqZSlg97qgUiBRfTk73WRhW2eVzLCt6EAdbER8UE09UcC/rMK3CAxMJNYig6ui8hqgH1rhMa+lHNZbUg8fPK0VW6SmYxyMP84TEN5MWtTJsemUUswZT5eCIYs9KXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4JmHGys; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4JmHGys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791301182; x=1822837182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EPhs60JXBsZuFBZMagzNxSsOs5aqTpvFF0PPtw4pjI0=;
  b=c4JmHGysnoM9Lotg5busQrc12lvPqdBaKwmIerrmxf1ozvgbxZvqxOdu
   0iOZ8CNtSZ/g9MoMv19K2wLz0qlYt01dN8Sg68bearcCmXTkB6wI6A0VH
   nPoYqN46zMymAG5fZktyDgTJjoz69EhR85+yUNg1uI/hyH92OOfc5oREW
   RNDh40OPccW/QnWoYOn1ctu8P7o0ZuYeyCJrVzBpAZNSo0qQC1Uhxghkk
   aRhZ/Bv2ZnRhS2pVFJPULI6vIGtZjXuA7FqLOEhpBHFPGo63iVpySoMso
   mR/ziSzyy8/jKM2oTfXV1/knEy/D8BbbWrKm9jA6iBVZNniZxq80x6Go6
   w==;
X-CSE-ConnectionGUID: bnhD8dnfRXiijzBoOmMGgw==
X-CSE-MsgGUID: vdHf15FBQNWMqcD5rfji0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102666415"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102666415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 08:39:41 -0700
X-CSE-ConnectionGUID: efyy49/oTQavWPFk5mMQlg==
X-CSE-MsgGUID: c3S+P4jCQuGKnrNzpRIuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="285278945"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 08:39:39 -0700
Message-ID: <bcc1d04c-fd5f-4c65-bafd-c17b8bfe5011@intel.com>
Date: Tue, 6 Oct 2026 08:39:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/16] cxl: Cache endpoint HDM state during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-11-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001092227.3004747-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> PCI capability initialization runs before BAR resources are finalized,
> while driver binding is too late for driver-independent reset support.
> Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
> and before driver binding.
> 
> Cache BAR-relative HDM location, global control, decoder settings, and CXL
> Device DVSEC Control, then publish the completed cache under cxl_rwsem.dpa.
> Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
> changes.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   3 +-
>  drivers/cxl/core/pci.c      |  15 +-
>  drivers/cxl/core/regs.c     |   9 ++
>  drivers/cxl/core/resource.c | 277 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/probe.c         |   2 +
>  include/cxl/cxl.h           |  21 +++
>  tools/testing/cxl/Kbuild    |   1 -
>  8 files changed, 326 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 30470799e059..2335059f687a 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_RESET) += resource.o
> +obj-$(CONFIG_CXL_RESET) += regs.o resource.o
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
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9411694b93b3..5fef673ecd65 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -180,6 +180,16 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -191,8 +201,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
> +		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  		return 1;
> +	}
>  	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>  	ctrl |= val;
>  
> @@ -200,6 +212,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> +	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..ba1f942d20e1 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	}
>  
>  	map->reg_type = reg_type;
> +	map->bar = bar;
> +	map->bar_offset = offset;
>  	map->resource = pci_resource_start(pdev, bar) + offset;
>  	map->max_size = pci_resource_len(pdev, bar) - offset;
>  	return true;
> @@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
> +		.bar = -1,
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> @@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +	map->bar = -1;
> +	map->bar_offset = 0;
>  	if (index == CXL_INSTANCES_COUNT)
>  		return instance;
>  
> @@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 8d2fbc49a06f..c3f53c1b93fd 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,17 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/pci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -166,3 +174,272 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
> +
> +static int cxl_pci_hdm_dvsec(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENXIO;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);

Given the number of locations the cxl subsystem requests the dvsec, should we just store this at device init somewhere rather than walking the chain every time? Currently it's cached in cxlds->cxl_dvsec. Maybe this can go to a more common place in 'struct pci_dev'?

Also maybe this generic helper function can be shared with cxl_dvsec_rr_decode()?

> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap))
> +		return -ENXIO;
> +
> +	return dvsec;
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,

cxl_pci_hdm_read_decoder_settings(), given it's retrieving the 'settings'.

> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	target_or_skip =
> +		((u64)readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id)) << 32) |
> +		readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +
> +	rc = cxl_hdm_unpack_decoder(settings, id, ctrl, base, size,
> +				    target_or_skip);
> +	if (rc) {
> +		pci_err(pdev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
> +		*settings = (struct cxl_decoder_settings) {
> +			.config.id = id,
> +		};
> +
> +	return 0;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	size_t required;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return ERR_PTR(-ENXIO);
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, hdm_offset))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*decoder_count =
> +		cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (*decoder_count < 0) {
> +		iounmap(hdm);
> +		return ERR_PTR(*decoder_count);
> +	}
> +
> +	/* The last decoder's target-list high register must fit in the mapping. */
> +	required = CXL_HDM_DECODER0_TL_HIGH(*decoder_count - 1) + sizeof(u32);
> +	if (required > hdm_map->size) {
> +		pci_err(pdev,
> +			"CXL HDM decoder count exceeds mapped register block\n");
> +		iounmap(hdm);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	return hdm;
> +}
> +
> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	struct cxl_hdm_info *info =
> +		kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	for (int i = 0; i < decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->settings[i], hdm, i);
> +		if (rc)
> +			goto out_free;
> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	rc = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (rc != decoder_count) {
> +		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
> +			decoder_count, rc);
> +		rc = -ENXIO;
> +		goto out_free;
> +	}
> +
> +	iounmap(hdm);
> +	return info;
> +
> +out_free:
> +	kfree(info);
> +out_unmap:
> +	iounmap(hdm);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (command & PCI_COMMAND_MEMORY)
> +		return __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (!rc)
> +		return info;
> +
> +	if (IS_ERR(info)) {
> +		pci_err(pdev,
> +			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +			pcibios_err_to_errno(rc));
> +		return info;
> +	}
> +
> +	kfree(info);
> +	return ERR_PTR(pcibios_err_to_errno(rc));
> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	struct resource *bar;
> +	int dvsec;
> +	int rc;
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		if (pdev->hdm)
> +			return 0;
> +
> +	dvsec = cxl_pci_hdm_dvsec(pdev);
> +	if (dvsec == -ENXIO)
> +		return 0;
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS)
> +		return -ENODEV;
> +
> +	bar = &pdev->resource[map.bar];
> +	if (!pci_resource_len(pdev, map.bar) ||
> +	    (bar->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
> +	    resource_type(bar) != IORESOURCE_MEM || !bar->start || !bar->end)
> +		return -ENODEV;
> +
> +	struct cxl_hdm_info *read_info =
> +		cxl_pci_hdm_read_info(pdev, &map, dvsec);
> +	if (IS_ERR(read_info))
> +		return PTR_ERR(read_info);
> +
> +	struct cxl_hdm_info *info __free(kfree) = read_info;
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	/* Another initializer may have published while we read MMIO. */
> +	if (!pdev->hdm)
> +		pdev->hdm = no_free_ptr(info);
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_cache_init(pdev);
> +	if (rc)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_cache_init, "cxl_core");
> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	/* Unpublish before freeing so subsequent readers cannot use stale state. */
> +	pdev->hdm = NULL;
> +	kfree(info);
> +}
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..d866452222b6 100644
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
> +	pci_cxl_hdm_cache_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..752347464a4d 100644
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
> +	pci_cxl_hdm_cache_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e200c5c56b92..a1c63e031dd4 100644
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
> @@ -92,6 +93,9 @@ struct cxl_decoder_settings {
>   * @dvsec_ctrl: CXL DVSEC control register
>   * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>   * @settings: per-decoder programming state
> + *
> + * Publication through pci_dev.hdm and all mutable fields are protected by
> + * cxl_rwsem.dpa.
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> @@ -177,6 +181,8 @@ struct cxl_pmu_reg_map {
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> + * @bar: PCI BAR containing the register block
> + * @bar_offset: register block offset relative to @bar
>   * @reg_type: see enum cxl_regloc_type
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
> @@ -187,6 +193,8 @@ struct cxl_register_map {
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> +	int bar;
> +	resource_size_t bar_offset;
>  	u8 reg_type;
>  	union {
>  		struct cxl_component_reg_map component_map;
> @@ -195,6 +203,19 @@ struct cxl_register_map {
>  	};
>  };
>  
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e80500f457a9 100644
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


In general I'm noticing a few functions that takes a 'struct pci_dev' that does not need that in resource.c. In the future, I would like to extend cxl_test to this core code in order to cover most of the functions in resource.c and the reset mechanism. Do you mind taking a look at if things can be reorganized? I did a quick refactor of your series using LLM [1]. See if the shaping of that is acceptable for you. Essentially I had it organize into 3 parts. drivers/cxl/core/hdm_regs.c, drivers/cxl/core/hdm_state.c, and drivers/pci/cxl.c. Feel free to use any or none of the changes.

┌─────┬──────────────────┬───────────────────────────────────────────────┐
│  #  │      Patch       │                    Change                     │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│ 1-4 │ unchanged        │ Same commit objects, all Reviewed-by tags     │
│     │                  │ kept                                          │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Introduce        │ target_or_skip_reg_val replaced by an         │
│ 5   │ reusable HDM     │ endpoint-only settings struct with skip;      │
│     │ decoder settings │ switch commit takes the target list directly; │
│     │                  │  endpoints write the DPA Skip registers again │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Move HDM decoder │ New built-in hdm_regs.c, built with           │
│ 6   │  helpers to      │ obj-$(subst m,y,$(CONFIG_CXL_BUS)), so        │
│     │ built-in code    │ linking cxl_core no longer depends on         │
│     │                  │ CONFIG_CXL_RESET                              │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Share HDM        │ Unpacks the common config only; Target List   │
│ 7   │ decoder register │ and DPA Skip are read where they're used      │
│     │  unpacking       │ again                                         │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Reject           │                                               │
│ 8   │ overflowing HDM  │ Rebased only                                  │
│     │ decoder ranges   │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Refresh cached   │ Endpoint decoders only; CONFIG_CXL_RESET      │
│ 9   │ PCI HDM decoder  │ introduced here; two bug fixes (below)        │
│     │ settings         │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Cache endpoint   │ PCI-side code moved to the new                │
│ 10  │ HDM state during │ drivers/pci/cxl.c; cache and cxl_rwsem in the │
│     │  enumeration     │  new built-in hdm_state.c                     │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│ 11  │ Add CXL Device   │ Moved to drivers/pci/cxl.c, otherwise         │
│     │ Reset sequencing │ identical                                     │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Validate and     │                                               │
│ 12  │ synchronize HDM  │ Region-quiesce API in hdm_state.c, so the PCI │
│     │ ranges around    │  core never takes cxl_rwsem directly          │
│     │ reset            │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│ 13, │ Reject unsafe    │                                               │
│  15 │ scope / Expose   │ Rebased only                                  │
│     │ CXL Reset        │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Restore CXL      │ Decoder restore split into hdm_regs.c, which  │
│ 14  │ state after PCI  │ needs no pci_dev                              │
│     │ reset            │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤
│     │ Restore CXL      │                                               │
│ 16  │ state after CXL  │ Race fix. Found through testing.              │
│     │ bus reset        │                                               │
├─────┼──────────────────┼───────────────────────────────────────────────┤

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-type2-reset
