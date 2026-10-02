Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4B1F938;
	Fri,  2 Oct 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790985476; cv=none; b=F0pxPIsy+Np0nyVQtgO2IOa8f7WMyzEjanh5Uwrbzx/e6LMA1FgcJ4/xhyM0iLLSIbivjlt2VbJ84A/ClzclmerCZE8mSr4ftQZhft3SqIXp8w6eMCpTEKkAaYF0CDGo26Nsu8dMrSrsPTdZe+nO6+dmL49BmEW4x+oE+z1eLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790985476; c=relaxed/simple;
	bh=3nUcFROvnFrIVmiERC1HTVfCqP0nxNJMr2n8zO2lnA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg50/dhxVFX8R6r+ssou/4XW2/l2aENrQwptLe3BVBSUVPq/5u2CrlUH1VfBbKgsy3oyssTOf4mEDROLkw0XcwAIRI/s0RDTIZnWEtruaaAFwE3+24+uZolZOwI1E29bJpySq3caaU2Pk8SJ2l5EjyhzE/D9ENNbuKRN6DRq2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwjga7cC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwjga7cC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790985475; x=1822521475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3nUcFROvnFrIVmiERC1HTVfCqP0nxNJMr2n8zO2lnA8=;
  b=Rwjga7cCHUELrHGpjkK3uNJcSm0UUjwcpOakuEMB9nUNirBg53I4MRU1
   Ye4FaYkO2FP/Dr6klkClJTpHcPBtvrb7LCYBo0uAGr8UuIgTlfSqPG4rp
   EPt1/GoCbUox2Z0Q/Gp4Pp5w6HsRu0YLgPoG18sdk8Ma35xMkZ4ASl45v
   87gIr6hLg0dcwpjQhL2LZ+dVwLTph/3FPm6NZduP9hhkfM2D019uRUGtg
   wg4BYONtijDQhukXWL9VXOEoYh/qQpoWk+Jp2QPJ7ZoqX6Mh4x+6J8tTD
   BcVuG7pA+V4mF/G9bnC8U5gP7ZR7Yb3dM/KmYsXY+Dq/h0mBcuoGzbgR2
   A==;
X-CSE-ConnectionGUID: oGOVswvBQaKK40h3jjxpNg==
X-CSE-MsgGUID: HtCdaH1MT8OSOhvaOCJ45g==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90967019"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90967019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 16:57:54 -0700
X-CSE-ConnectionGUID: fUdsXD40Rq+CwkXiGS58Bw==
X-CSE-MsgGUID: 8QbEIFLbS6G+MMZMIfw8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="281087790"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 16:57:53 -0700
Message-ID: <48d34fdc-d891-4175-81df-2217068176dd@intel.com>
Date: Fri, 2 Oct 2026 16:57:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/16] cxl: Refresh cached PCI HDM decoder settings
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
 <20261001092227.3004747-10-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001092227.3004747-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      | 22 ++++++++++++++++
>  include/linux/pci.h    |  6 +++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b6a8fe83d336..d6b3afbffa3e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -753,6 +753,44 @@ static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
>  	}
>  }
>  
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;

reverse xmas tree pls.

> +	struct cxl_decoder_settings *settings;
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(port);

You can move this outside of declaration block. It's one of the exceptions. 

Also, is there any reason to reference a PCI device specifically? Can't you just get the 'struct device' and use exclusively that in this function? Prefer to keep the function neutral here rather than hard code it to PCI and I don't see anything specific to PCI that needs the hard coding. core/hdm.c should use 'struct device'. It does not have a PCI dependency before this. Also you may break cxl_test as it uses platform devices instead of PCI devices.

As an aside, can you please do me a favor and run cxl_test for your series? Having it passing all regression tests is one of the requirements for us to accept CXL patches. We will help you fix any issues crop up if you need it. Of course adding new regression tests for reset to test the new core functions would be awesome and much appreciated. 

> +
> +	if (!pdev || !hdm)
> +		return;

Go ahead and do the block like:

	struct pci_dev *pdev __free(pci_dev_put) =
		cxl_port_get_uport_pci_dev(port);
	if (!pdev)
		return;

	if (!hdm)
		return;


> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info)
> +		return;

Could use a blank line here.

> +	if (cxld->config.id < 0 || cxld->config.id >= info->decoder_count) {

Maybe just create a local ptr for cxld->config given all the places you need to access its members.

> +		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
> +			 cxld->config.id, info->decoder_count);
> +		return;
> +	}
> +
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	settings = &info->settings[cxld->config.id];
> +
> +	/*
> +	 * A disabled decoder's software object may retain its old range and
> +	 * target state. Leave only the decoder id in the cached settings so stale
> +	 * state is not restored as an enabled decode.
> +	 */
> +	*settings = (struct cxl_decoder_settings) {
> +		.config.id = cxld->config.id,
> +	};
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE)
> +		cxl_decoder_snapshot(cxld, settings);
> +}
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> @@ -804,6 +842,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->config.flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -876,6 +915,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1086,6 +1126,23 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	int i;
>  	u64 dpa_base = 0;
>  
> +	if (is_cxl_endpoint(port) && hdm) {
> +		struct pci_dev *pdev __free(pci_dev_put) =
> +			cxl_port_get_uport_pci_dev(port);
> +
> +		if (pdev) {
> +			guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +			if (pdev->hdm &&
> +			    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
> +				pci_warn(pdev,
> +					 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +					 pdev->hdm->decoder_count, cxlhdm->decoder_count);
> +				return -ENXIO;
> +			}
> +		}

So we can't have a 'struct pci_dev' in core/hdm.c without breaking cxl_test. I think we can move this block into a helper function that's in core/pci.c. Maybe call it something like cxl_check_cached_decoder_settings(). I'm open to ideas. That way cxl_test can create a mock function and override it. See something like cxl_await_media_ready() in tools/testing/cxl/ on how to fixup cxl_test. Until we add support code for decoder saving etc in cxl_test, it can just do nothing now.

DJ
> +	}
> +
>  	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> @@ -1124,6 +1181,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 67c81be47fbb..e200c5c56b92 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -82,6 +82,28 @@ struct cxl_decoder_settings {
>  	u64 target_or_skip_reg_val;
>  };
>  
> +/**
> + * struct cxl_hdm_info - cached CXL HDM state for a PCI device
> + * @decoder_count: number of entries in @settings
> + * @hdm_bar: PCI BAR containing the HDM decoder capability
> + * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
> + * @hdm_size: size of the HDM decoder register block
> + * @global_ctrl: HDM decoder global control register
> + * @dvsec_ctrl: CXL DVSEC control register
> + * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
> + * @settings: per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	u16 dvsec_ctrl;
> +	bool dvsec_ctrl_valid;
> +	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..7bb37fcb556d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_RESET
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -566,6 +569,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_RESET
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif

