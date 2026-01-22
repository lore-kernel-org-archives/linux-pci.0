Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D031ED70;
	Thu, 22 Jan 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094564; cv=none; b=TDEhlXbX0Jzj7IAzEQrY9hyoWj1a3+zTQs3XkBTt42cDkYTD4kvAczAN2bCnYPcxv3XmlJEOUXUeY5KgWlAFHYZ59892OayVojn05qbbnnmRxtWw9lrjwMcyNpJek5oRXL1CZRrWW7D1AEBZijHdhsM2Nau0xAU8gMt6M1c/ZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094564; c=relaxed/simple;
	bh=sBWn/ACOFlyUNY+n5obBlPCDLEB/RqzQcV+1oOl4GfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcRW6OOBOwy/9emNs/XBL8PetJXvIeL6412FAFqefIgV+iVyOkD4a+oQg74pwFmZXxR5f4cg0ewo9VnYk9pypThIjldj+gSoZieH3awj0r5P9wXZNG0jgs3fPr1Hv0C18oWU3ZXHat2o+KnBgPvLWfizo5Ai3oJBS7AjOGZsbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuSjQBuf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuSjQBuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094562; x=1800630562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sBWn/ACOFlyUNY+n5obBlPCDLEB/RqzQcV+1oOl4GfQ=;
  b=kuSjQBufa3CPsvkO9pH0nb7KOyl9TjtHxiNZCcoVWNgWtRdphwEuHXm/
   TRmScw6GuNQ7vvHCR7hJueC+t2vzTL7QII6tUWRrdLVlEKNKSfjU4JBed
   qbknOFlcytY4NDHdzVuaHys2Ghs8rtLBnIM3GeLP3rhTRUMqj/PaQXYUG
   bemjSsYmgGkyKFUmt212o2/E5dIKTF4t1rZeIVpLxk5LAIIwKVZIX1CmO
   fcdlkp+laFxcL6WvAPEz8iStrmo+4HtnsdJ845EFc5aV2u5f9bo81Avx4
   6X9ctzoYjRvm9d3DAk1+sCF4aNUAyq40SoNxtESzAXcvCqC3RHakKy9pA
   Q==;
X-CSE-ConnectionGUID: O0xwrMr4QzeRfu2WGDuOlw==
X-CSE-MsgGUID: s8WKopXzSWSmhU2rxp/YOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81450103"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81450103"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:09:21 -0800
X-CSE-ConnectionGUID: mQOcxeAyTAyC82V0WiGXgg==
X-CSE-MsgGUID: 7y2TzyTFQ6yrdlQtc+vxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206005296"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.157]) ([10.125.108.157])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:09:20 -0800
Message-ID: <07fe8a58-7e31-4616-9463-e16efe9fcbb2@intel.com>
Date: Thu, 22 Jan 2026 08:09:19 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 huaisheng.ye@intel.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-11-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Extend state save/restore to HDM decoder and IDE registers for Type 2
> devices. The HDM/IDE blocks are located via the component register map,
> then preserved across reset to retain decoder configuration and IDE
> policy. This avoids losing HDM/IDE programming when cxl_reset is issued.

So the current implementation tries to save DVSEC, HDM decoders, and IDE registers (MMIO registers). This is not standard device reset and seems more usage specific. Given that is the case and the fact that the implementation keeps trying to pull very CXL specific bits into PCI core, maybe going through the PCI reset path isn't the right place? The whole thing would be significantly simplified if we add a 'reset' sysfs attribute to memdev and just do it from there? Thoughts? That would prevent CXL symbols keep being dragged into PCI and keep everything local for this specific usage. Probably should also add some text on the reasoning of saving of these MMIO registers.

DJ

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/regs.c |   7 ++
>  drivers/cxl/cxl.h       |   4 ++
>  drivers/cxl/pci.c       | 153 ++++++++++++++++++++++++++++++++++++++--
>  include/cxl/pci.h       |  43 +++++++++++
>  4 files changed, 201 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ecdb22ae6952..76d6869d82ea 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -93,6 +93,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_IDE:
> +			dev_dbg(dev, "found IDE capability (0x%x)\n",
> +				offset);
> +			length = CXL_IDE_CAPABILITY_LENGTH;
> +			rmap = &map->ide;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -212,6 +218,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.ide, &regs->ide },
>  	};
>  	int i;
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..a7a6b79755b3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -39,8 +39,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> 
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_IDE 0x4
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +#define   CXL_IDE_CAPABILITY_LENGTH 0x20
> 
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> @@ -214,6 +216,7 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *ide;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -256,6 +259,7 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map ide;
>  };
> 
>  struct cxl_device_reg_map {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7d6a0ef70b2d..eb735d0ae175 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -956,7 +956,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		dev_dbg(&pdev->dev, "RAS registers not found\n");
> 
>  	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
> -				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS) |
> +				    BIT(CXL_CM_CAP_CAP_ID_IDE));
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> 
> @@ -1203,18 +1204,126 @@ static int cxl_restore_dvsec_state(struct pci_dev *pdev,
>  	return rc;
>  }
> 
> +/*
> + * CXL HDM Decoder register save/restore
> + */
> +static int cxl_save_hdm_state(struct cxl_dev_state *cxlds,
> +			      struct cxl_type2_saved_state *state)
> +{
> +	void __iomem *hdm = cxlds->regs.hdm_decoder;
> +	u32 cap, ctrl;
> +	int i, count;
> +
> +	if (!hdm)
> +		return 0;
> +
> +	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> +	count = cap & CXL_HDM_DECODER_COUNT_MASK;
> +	count = min(count, CXL_MAX_DECODERS);
> +
> +	state->hdm_decoder_count = count;
> +	state->hdm_global_ctrl = readl(hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
> +
> +	for (i = 0; i < count; i++) {
> +		struct cxl_hdm_decoder_state *d = &state->decoders[i];
> +		u32 base_low, base_high, size_low, size_high;
> +		u32 dpa_skip_low, dpa_skip_high;
> +
> +		base_low = readl(hdm + CXL_HDM_DECODER_BASE_LOW(i));
> +		base_high = readl(hdm + CXL_HDM_DECODER_BASE_HIGH(i));
> +		size_low = readl(hdm + CXL_HDM_DECODER_SIZE_LOW(i));
> +		size_high = readl(hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
> +		ctrl = readl(hdm + CXL_HDM_DECODER_CTRL(i));
> +		dpa_skip_low = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
> +		dpa_skip_high = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
> +
> +		d->base = ((u64)base_high << 32) | base_low;
> +		d->size = ((u64)size_high << 32) | size_low;
> +		d->ctrl = ctrl;
> +		d->dpa_skip = ((u64)dpa_skip_high << 32) | dpa_skip_low;
> +		d->enabled = !!(ctrl & CXL_HDM_DECODER_ENABLE);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_restore_hdm_state(struct cxl_dev_state *cxlds,
> +				 const struct cxl_type2_saved_state *state)
> +{
> +	void __iomem *hdm = cxlds->regs.hdm_decoder;
> +	int i;
> +
> +	if (!hdm || state->hdm_decoder_count == 0)
> +		return 0;
> +
> +	writel(state->hdm_global_ctrl, hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
> +
> +	for (i = 0; i < state->hdm_decoder_count; i++) {
> +		const struct cxl_hdm_decoder_state *d = &state->decoders[i];
> +
> +		writel((u32)d->base, hdm + CXL_HDM_DECODER_BASE_LOW(i));
> +		writel((u32)(d->base >> 32), hdm + CXL_HDM_DECODER_BASE_HIGH(i));
> +		writel((u32)d->size, hdm + CXL_HDM_DECODER_SIZE_LOW(i));
> +		writel((u32)(d->size >> 32), hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
> +		writel(d->ctrl, hdm + CXL_HDM_DECODER_CTRL(i));
> +		writel((u32)d->dpa_skip, hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
> +		writel((u32)(d->dpa_skip >> 32), hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * CXL IDE register save/restore
> + */
> +static int cxl_save_ide_state(struct cxl_dev_state *cxlds,
> +			      struct cxl_type2_saved_state *state)
> +{
> +	void __iomem *ide = cxlds->regs.ide;
> +	u32 cap;
> +
> +	if (!ide)
> +		return 0;
> +
> +	cap = readl(ide + CXL_IDE_CAP_OFFSET);
> +	if (!(cap & CXL_IDE_CAP_CAPABLE))
> +		return 0;
> +
> +	state->ide_cap = cap;
> +	state->ide_ctrl = readl(ide + CXL_IDE_CTRL_OFFSET);
> +	state->ide_key_refresh_time = readl(ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
> +	state->ide_truncation_delay = readl(ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
> +
> +	return 0;
> +}
> +
> +static int cxl_restore_ide_state(struct cxl_dev_state *cxlds,
> +				 const struct cxl_type2_saved_state *state)
> +{
> +	void __iomem *ide = cxlds->regs.ide;
> +
> +	if (!ide || !(state->ide_cap & CXL_IDE_CAP_CAPABLE))
> +		return 0;
> +
> +	writel(state->ide_ctrl, ide + CXL_IDE_CTRL_OFFSET);
> +	writel(state->ide_key_refresh_time, ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
> +	writel(state->ide_truncation_delay, ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_config_save_state - Save CXL configuration state
>   * @pdev: PCI device
>   * @state: Structure to store saved state
>   *
> - * Saves CXL DVSEC state before reset.
> + * Saves CXL DVSEC, HDM decoder, and IDE state before reset.
>   */
>  int cxl_config_save_state(struct pci_dev *pdev,
>  			  struct cxl_type2_saved_state *state)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	int dvsec;
> +	int rc, dvsec;
> 
>  	if (!cxlds || !state)
>  		return -EINVAL;
> @@ -1225,7 +1334,23 @@ int cxl_config_save_state(struct pci_dev *pdev,
>  	if (!dvsec)
>  		return -ENODEV;
> 
> -	return cxl_save_dvsec_state(pdev, state, dvsec);
> +	rc = cxl_save_dvsec_state(pdev, state, dvsec);
> +	if (rc)
> +		return rc;
> +
> +	if (cxlds->regs.hdm_decoder) {
> +		rc = cxl_save_hdm_state(cxlds, state);
> +		if (rc)
> +			pci_warn(pdev, "Failed to save HDM state: %d\n", rc);
> +	}
> +
> +	if (cxlds->regs.ide) {
> +		rc = cxl_save_ide_state(cxlds, state);
> +		if (rc)
> +			pci_warn(pdev, "Failed to save IDE state: %d\n", rc);
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
> 
> @@ -1234,7 +1359,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
>   * @pdev: PCI device
>   * @state: Previously saved state
>   *
> - * Restores CXL DVSEC state after reset.
> + * Restores CXL DVSEC, HDM decoder, and IDE state after reset.
>   */
>  int cxl_config_restore_state(struct pci_dev *pdev,
>  			     const struct cxl_type2_saved_state *state)
> @@ -1257,7 +1382,23 @@ int cxl_config_restore_state(struct pci_dev *pdev,
> 
>  	config_locked = !!(lock_reg & CXL_DVSEC_LOCK_CONFIG_LOCK);
> 
> -	return cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
> +	rc = cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
> +	if (rc)
> +		return rc;
> +
> +	if (cxlds->regs.hdm_decoder && state->hdm_decoder_count > 0) {
> +		rc = cxl_restore_hdm_state(cxlds, state);
> +		if (rc)
> +			pci_warn(pdev, "Failed to restore HDM state: %d\n", rc);
> +	}
> +
> +	if (cxlds->regs.ide && (state->ide_cap & CXL_IDE_CAP_CAPABLE)) {
> +		rc = cxl_restore_ide_state(cxlds, state);
> +		if (rc)
> +			pci_warn(pdev, "Failed to restore IDE state: %d\n", rc);
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_config_restore_state, "CXL");
> 
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 2c629ded73cc..9f2a9ad10d75 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -4,11 +4,33 @@
>  #ifndef __CXL_ACCEL_PCI_H
>  #define __CXL_ACCEL_PCI_H
> 
> +/* HDM Decoder state for save/restore */
> +struct cxl_hdm_decoder_state {
> +	u64 base;
> +	u64 size;
> +	u32 ctrl;
> +	u64 dpa_skip;
> +	bool enabled;
> +};
> +
> +#define CXL_MAX_DECODERS 10
> +
>  /* CXL Type 2 device state for save/restore across reset */
>  struct cxl_type2_saved_state {
>  	/* DVSEC registers */
>  	u16 dvsec_ctrl;
>  	u16 dvsec_ctrl2;
> +
> +	/* HDM Decoder registers */
> +	u32 hdm_decoder_count;
> +	u32 hdm_global_ctrl;
> +	struct cxl_hdm_decoder_state decoders[CXL_MAX_DECODERS];
> +
> +	/* IDE registers */
> +	u32 ide_cap;
> +	u32 ide_ctrl;
> +	u32 ide_key_refresh_time;
> +	u32 ide_truncation_delay;
>  };
> 
>  int cxl_config_save_state(struct pci_dev *pdev,
> @@ -58,6 +80,27 @@ int cxl_config_restore_state(struct pci_dev *pdev,
> 
>  #define CXL_DVSEC_RANGE_MAX		2
> 
> +/* CXL HDM Decoder Capability Structure (Section 8.2.4.20) */
> +#define CXL_HDM_DECODER_CAP_OFFSET		0x0
> +#define   CXL_HDM_DECODER_COUNT_MASK		GENMASK(3, 0)
> +#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET	0x4
> +#define   CXL_HDM_DECODER_ENABLE		BIT(1)
> +/* CXL HDM Decoder n registers (Offset 20h*n + base) */
> +#define CXL_HDM_DECODER_BASE_LOW(n)		(0x10 + ((n) * 0x20))
> +#define CXL_HDM_DECODER_BASE_HIGH(n)		(0x14 + ((n) * 0x20))
> +#define CXL_HDM_DECODER_SIZE_LOW(n)		(0x18 + ((n) * 0x20))
> +#define CXL_HDM_DECODER_SIZE_HIGH(n)		(0x1C + ((n) * 0x20))
> +#define CXL_HDM_DECODER_CTRL(n)			(0x20 + ((n) * 0x20))
> +#define CXL_HDM_DECODER_DPA_SKIP_LOW(n)		(0x24 + ((n) * 0x20))
> +#define CXL_HDM_DECODER_DPA_SKIP_HIGH(n)	(0x28 + ((n) * 0x20))
> +
> +/* CXL IDE Capability Structure (Section 8.2.4.22) */
> +#define CXL_IDE_CAP_OFFSET			0x00
> +#define   CXL_IDE_CAP_CAPABLE			BIT(0)
> +#define CXL_IDE_CTRL_OFFSET			0x04
> +#define CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET	0x18
> +#define CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET	0x1C
> +
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>  #define CXL_DVSEC_FUNCTION_MAP					2
> 
> --
> 2.34.1
> 

