Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87E3A3E78;
	Fri, 21 Aug 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350379; cv=none; b=cCRfhHn//lgYMVGvr6Y4QJCLV+E85FT/9QT7UbX13x9m2kWirciHHMj5K3cI7FFP03IdCP8SGKoAxxA0jvUVJ2fg7mcMQ8/eMpg+YcWNbHRvY1xwmElsug3L2CsZQ/wquF6/Wx42KP8rngC2FHUxxRns5T6UMyLYYvEXVjUYX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350379; c=relaxed/simple;
	bh=E8Unyr7mOvnL6CPMia9HS18lXZLDTbEOagir59D1l6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP6tuvu8XYTsHDv2Fiu3e3aJPM9t8Vn0LGvwxUumbOgVLtTrt9n4DrOS08BVjlO1NB4MtmEY2XPz29r52fAXDVXombfHSbMpx3x7VoiwnQiR7Vmddj8es6nFEzBsXWla04N3InlgY/7Cpqc0FaoE6j1jepMvX7CQtPuuuGxBSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIwVgMyw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIwVgMyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787350378; x=1818886378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E8Unyr7mOvnL6CPMia9HS18lXZLDTbEOagir59D1l6Q=;
  b=KIwVgMywKrwdrsz6cCTLD1ouLTu+BVNUvHt7oARuWy2Rhhna2xeaaKcf
   X8Ko7COJeQakc3GnESTu9gT3VoONbBMRlj65gXbtGFkDNP6i4BnHoQ47W
   mLNGY+Nknhy7rh1EfPxtJXhQnWYbk4rgJuXaZ5uUbY/LgmUjzGqSGjwwr
   4WLoHfvhAdYKmCwtqnl0xr63IvVa8SZGapnBbT1rATAcU2pjLayQ1/6yu
   Oe73r9y09D2ntTxaSWkQyvR0Ui6RS4TBg0uApHYl6ql0CvYdfA8ZJCzF1
   XwWYhMlvg0aaeN09ja7mkdLBwQu7wLrI7ygQ6ESbAY5CGbqejzXnkRgKY
   w==;
X-CSE-ConnectionGUID: XcSPLdYvQTCGLB0w30JdzA==
X-CSE-MsgGUID: ooDYWAaSQZy4x8iLCkBDoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87825262"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87825262"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:12:57 -0700
X-CSE-ConnectionGUID: 6SfwUM5ZTte6z7SXHO59Xw==
X-CSE-MsgGUID: j/QihXdoRYySS7GXw2hlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="262737901"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.117]) ([10.125.108.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:12:54 -0700
Message-ID: <8d26e993-1c04-4609-be0d-f26449c490cf@intel.com>
Date: Fri, 21 Aug 2026 15:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
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
 <20260804192958.1823952-5-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
> 
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 114 ++++++++++++++++++++++++++++++++++++++++-
>  include/cxl/cxl.h      |  12 +++++
>  include/linux/pci.h    |   6 +++
>  3 files changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6e132b4f092b..ec988e7b7c0c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,6 +84,110 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> +static int cxl_pci_hdm_info_match(struct pci_dev *pdev, int decoder_count,
> +				      bool *present)

Maybe this should just return a bool based on match.

bool cxl_pci_hdm_decoder_count_match()?

> +{
> +	struct cxl_hdm_info *info;
> +	int rc = 0;
> +
> +	*present = false;
> +	down_read(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (info) {
> +		*present = true;
> +		if (info->decoder_count != decoder_count) {
> +			pci_warn(pdev,
> +				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +				 info->decoder_count, decoder_count);
> +			rc = -ENXIO;
> +		}
> +	}
> +	up_read(&cxl_rwsem.dpa);
> +
> +	return rc;
> +}
> +
> +static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)

I'm not sure if this function name makes sense. Nothing is being setup here. I think the above function should just be __cxl_pci_hdm_decoder_count_match() and this function can just be cxl_pci_hdm_decoder_count_match(). Or just collpase the two into a single function.

> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	bool present;
> +
> +	if (!pdev)
> +		return 0;
> +
> +	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
> +}
> +
> +static u64 cxl_switch_target_list(struct cxl_switch_decoder *cxlsd)

cxl_switch_get_target_list()

> +{
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	u64 targets = 0;
> +	int ways = min(cxld->interleave_ways, cxlsd->nr_targets);
> +
> +	/* target_map[] holds the raw list before target[] is resolved. */
> +	for (int i = 0; i < ways && i < 8; i++) {
> +		u8 port_id;
> +
> +		if (cxlsd->target[i])
> +			port_id = cxlsd->target[i]->port_id;
> +		else
> +			port_id = cxld->target_map[i];
> +
> +		targets |= (u64)port_id << (i * 8);
> +	}
> +
> +	return targets;
> +}
> +
> +static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
> +				 struct cxl_decoder_settings *settings)
> +{

Probably a good idea to add
lockdep_assert_held_write(&cxl_rwsem.dpa);

> +	*settings = (struct cxl_decoder_settings) {
> +		.id = cxld->id,
> +		.hpa_range = cxld->hpa_range,
> +		.interleave_ways = cxld->interleave_ways,
> +		.interleave_granularity = cxld->interleave_granularity,
> +		.target_type = cxld->target_type,
> +		.flags = cxld->flags,
> +	};
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		settings->target_or_skip = cxled->skip;
> +	} else if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		settings->target_or_skip = cxl_switch_target_list(cxlsd);
> +	}
> +}
> +
> +static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
> +				     struct cxl_decoder *cxld)

cxl_hdm_cache(or save)_decoder_info()?

> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	struct cxl_hdm_info *info;
> +
> +	if (!pdev)
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info || cxld->id >= info->decoder_count)
> +		return;
> +
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> +		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
> +	else
> +		info->settings[cxld->id] = (struct cxl_decoder_settings) {
> +			.id = cxld->id,
> +		};

Use {} for if/else since the else part is multi-lines. Although given that you have to set the id either way, maybe have a helper function cxl_decoder_settings_init() that does it so you don't need the else branch.

DJ

> +}
> +
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -767,6 +871,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -839,6 +944,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1058,11 +1164,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	struct cxl_port *port = cxlhdm->port;
>  	int i;
>  	u64 dpa_base = 0;
> +	int rc;
>  
>  	cxl_settle_decoders(cxlhdm);
>  
> +	rc = cxl_pci_setup_hdm_info(cxlhdm);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {
> @@ -1097,6 +1208,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		cxl_hdm_info_set_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 85e895d9b31c..703285966946 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,18 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +/**
> + * struct cxl_hdm_info - PCI device HDM decoder programming cache
> + * @decoder_count: number of decoder settings entries
> + * @settings: cached per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
> +};
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..a8e5cec96bae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -335,6 +335,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_HDM
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -562,6 +565,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_HDM
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif

