Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4434A3A5;
	Tue,  7 Jul 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442746; cv=none; b=bB6gBNnVijxwVT5YzySb8Km4HmFtk3OZHQ3CM479xGiemIwT7VI5r09PM/9vqXcKP+WItcp6xrj0Xs1wNOOKPHi4NbByyXpAII4x6sRGSVLq+oVyTB39ADkdsGipkSG8jFkcNRcmZ7D8AnlEPqCoJAw6bpcMLGWHSLezCkl89f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442746; c=relaxed/simple;
	bh=sPtdr7fF6evB5zIk++PblAUQg/ef2lU2/WnAcimFuHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTo/BBDtTa64LIx2imXfkqbSY14O9j7mJyWAPKetT/3xL66WZQ0Finbkp65i42Q2AsLiZysxk4Uv4A70TKEtp6A5B+cKgBfdFEAFpzBf3vDAYKRUKUGmw7AseLcB1ZyK0dpqQ1TQZZa0156+2v/yu7jgkkXMK15An/2R4vcA+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZWFU/l0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZWFU/l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783442743; x=1814978743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sPtdr7fF6evB5zIk++PblAUQg/ef2lU2/WnAcimFuHs=;
  b=LZWFU/l0esQ/JAZFD4pmdOVhcFVcTFtIJ6MYdCl39RQaBC4yE5sRDplh
   5kbbxII5b8yEWq8ypXI72UYoxk9KSQCfg9vehT9Bi5uYEQP+xZVvPi+pw
   CmHYtEpIlqPe2tO3DIRjOtBv3Wvpeq+1prsw2VwbwMYjmwvoee0DJDt7d
   m+lmbAwC74RABQ3veYNsTPw4V8M8Q5ijUPGcw4DXKn0Wrm/lvUJ04gznh
   5EPXMdDASAmaVS4JgVc2863wLb0mzR+0PTyQSyy5J47xgpmWYgesgUtMc
   dBQat9Qfr8O/jXBdy+nNOENhOfaK4O1sUzC4iOL5Y23Pkf3X/EM2WtkAE
   g==;
X-CSE-ConnectionGUID: 3yhoiH/PR060XjquIv3TOQ==
X-CSE-MsgGUID: zHjK1KLER26GEX3HU5PhXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83968589"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83968589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:45:43 -0700
X-CSE-ConnectionGUID: CfRtoSOASOC96riKXIMTfg==
X-CSE-MsgGUID: zT7NbWFXSwqRGFhcTvn4bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278410245"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:45:41 -0700
Message-ID: <2bae4de2-8d5e-4bf2-8aef-eae2d903394d@intel.com>
Date: Tue, 7 Jul 2026 09:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] cxl: Cache decoder settings on PCI devices
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
 <20260703220508.546528-3-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:05 PM, Srirangan Madhavan wrote:
> Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
> enumerated, committed, or reset. PCI reset paths can use this snapshot to
> restore HDM programming without walking CXL topology during reset recovery.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 81 +++++++++++++++++++++++++++++++++++++++++-
>  include/cxl/cxl.h      | 12 +++++++
>  include/linux/pci.h    |  6 ++++
>  3 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fa978c297546..83cda63f76a5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,6 +84,76 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> +static void clear_hdm_info(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +
> +	WRITE_ONCE(pdev->hdm, NULL);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +	struct device *uport;
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		uport = cxlmd->dev.parent;
> +	} else {
> +		uport = port->uport_dev;
> +	}

This wants a helper given it happens open coded couple times in this patch. Maybe 'cxl_port_get_uport_dev()'? Also probably should take a device reference when the helper returns the device ptr.

DJ

> +
> +	if (!dev_is_pci(uport))
> +		return 0;
> +
> +	pdev = to_pci_dev(uport);
> +	info = devm_kzalloc(&pdev->dev,
> +			    struct_size(info, settings, cxlhdm->decoder_count),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->decoder_count = cxlhdm->decoder_count;
> +	WRITE_ONCE(pdev->hdm, info);
> +
> +	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
> +}
> +
> +static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
> +				     struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +	struct device *uport;
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		uport = cxlmd->dev.parent;
> +	} else {
> +		uport = port->uport_dev;
> +	}
> +
> +	if (!dev_is_pci(uport))
> +		return;
> +
> +	pdev = to_pci_dev(uport);
> +	info = READ_ONCE(pdev->hdm);
> +	if (!info || cxld->id >= info->decoder_count)
> +		return;
> +
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> +		info->settings[cxld->id] = cxld->settings;
> +	else
> +		info->settings[cxld->id] = (struct cxl_decoder_settings) {
> +			.id = cxld->id,
> +		};
> +}
> +
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -747,6 +817,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		return rc;
>  	}
>  	port->commit_end++;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -819,6 +890,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value = (hi << 32) + lo;
> +		cxld->targets = target_list.value;
>  		for (i = 0; i < cxld->interleave_ways; i++)
>  			cxld->target_map[i] = target_list.target_id[i];
>  
> @@ -1062,11 +1135,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	struct cxl_port *port = cxlhdm->port;
>  	int i;
>  	u64 dpa_base = 0;
> +	int rc;
>  
>  	cxl_settle_decoders(cxlhdm);
>  
> +	rc = devm_cxl_pci_setup_hdm_info(cxlhdm);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {
> @@ -1101,6 +1179,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 757d916a6330..84924ca06e52 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -121,6 +121,18 @@ struct cxl_regs {
>  	);
>  };
>  
> +/**
> + * struct cxl_hdm_info - PCI device HDM decoder programming cache
> + * @decoder_count: number of decoder settings entries
> + * @regs: mapped CXL component registers for this HDM decoder block
> + * @settings: cached per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	struct cxl_component_regs regs;
> +	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
> +};
> +
>  int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
>  
>  struct cxl_reg_map {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..7db2daf8597c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -334,6 +334,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_HDM
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -563,6 +566,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_HDM
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif

