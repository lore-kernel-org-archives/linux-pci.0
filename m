Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29690399365;
	Thu, 20 Aug 2026 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268365; cv=none; b=re1JfLNw12hV5u2QgI9hRvBWOeH1dYBj9NYKXklgtbc+edJFgQ6bhrFijkE3RFXVqH8yFwl/Uk9v/VvUt87su22Wc8d0j1byjv7zVuZM9DxSzIRZ/YlsX94UqDKfgUQQ2mZdsyLZ37FcJ1w+nFm3PqE3YMKkBKkh3U9jkgOg+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268365; c=relaxed/simple;
	bh=mtT6CxxxyiLSd2iaxUz83lzhWlWTm8kRkduzEGQra6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxA59zpD/popaiEB+7oLt1RMhn6JjyFfjNeCPfLxxRU8f9PTEoGRrkrBMvebT+pNRYc6ihG7yNwdzm+ByFNBFg4nPgd4Ssxv6GdiRIT0zyKqk1r9+O00qYIJvgzUyCg/lLj9UqRGR52V821X0iT/o3IRghWliCxoD1ft6vhgdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eskyFGTZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eskyFGTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268363; x=1818804363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtT6CxxxyiLSd2iaxUz83lzhWlWTm8kRkduzEGQra6I=;
  b=eskyFGTZmtz1squ02InQcx0loI5vG0ZhBi9Liy2mLbN1yvjCNBV7ZK73
   NAz6ACvAm4SjBkqc+ZW5tKeuF7/zsgCv1qIZIjw951eMR7Kt8sl9BUZ3X
   Tqg7w2ZdkKlOofAdW1ykXv4AHbBrs7CgySsPXeq/B9K56kc7jy3NH7H9K
   LyOe7OzO31wwlJ/nETW1w6AL6S4i5KGt2xScJ5d9R5+BdZLMzhi2HNy6N
   LgVUDsMGoIzJlYdxm5z9KbPz6usrShp08rHCQN2qLsfS7UH77mZVc29uf
   SZGER67AFtllzY7RVpVXp7vf2uSDZoBQzDPGkY1+tvjKinUloBlPn+XmJ
   g==;
X-CSE-ConnectionGUID: 3yzdYTuQRqS+qC9rlczN0w==
X-CSE-MsgGUID: 8QEomjqkTbChbP5hYnax5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483153"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:26:02 -0700
X-CSE-ConnectionGUID: puW0arv2SnO5DpZ114CjlQ==
X-CSE-MsgGUID: H17ljdTiSBqyYPprTVFqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261904905"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.63]) ([10.125.108.63])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:26:00 -0700
Message-ID: <37454d24-5a79-4162-95ba-74ec709a2c11@intel.com>
Date: Thu, 20 Aug 2026 16:25:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/12] cxl: Share HDM decoder decode logic
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-4-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Add a helper to resolve a CXL port upstream PCI device for paths
> that need to associate CXL core state with the parent PCI function.
> 
> Move HDM decoder register decoding into a helper shared by normal CXL
> core enumeration and early PCI HDM cache setup. This keeps validation of
> base, size, interleave, target type, and enable state in one place before
> adding another HDM parser.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/core.h     |  4 ++
>  drivers/cxl/core/hdm.c      | 76 +++++++++++++------------------------
>  drivers/cxl/core/port.c     | 19 ++++++++++
>  drivers/cxl/core/resource.c | 45 ++++++++++++++++++++++
>  4 files changed, 94 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1426254e6657..9c54985fd4f3 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -155,6 +155,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>  
>  static inline struct device *port_to_host(struct cxl_port *port)
>  {
> @@ -216,6 +217,9 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm);
>  int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm);
> +int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
> +			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
> +			   bool *committed);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9047b190c35a..6e132b4f092b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -899,11 +899,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
> -	u32 ctrl;
> -	union {
> -		u64 value;
> -		unsigned char target_id[8];
> -	} target_list;
> +	u32 ctrl, tl_low, tl_high;
> +	struct cxl_decoder_settings settings;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -916,35 +913,31 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>  	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +	tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> +	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
> +				    ((u64)tl_high << 32) | tl_low, &committed);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->id, ctrl, rc);
> +		return rc;
> +	}
> +
>  	cxld->commit = cxl_decoder_commit;
>  	cxld->reset = cxl_decoder_reset;
> -
> -	if (!committed)
> -		size = 0;
> -	if (base == U64_MAX || size == U64_MAX) {
> -		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> -			 port->id, cxld->id);
> -		return -ENXIO;
> -	}
> +	cxld->hpa_range = settings.hpa_range;
> +	cxld->interleave_ways = settings.interleave_ways;
> +	cxld->interleave_granularity = settings.interleave_granularity;
> +	cxld->target_type = settings.target_type;
> +	cxld->flags = settings.flags;
> +	size = range_len(&cxld->hpa_range);
>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
>  
>  	/* decoders are enabled if committed */
>  	if (committed) {
> -		cxld->flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->target_type = CXL_DECODER_DEVMEM;
> -
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -984,33 +977,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  		}
>  	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> -	}
> -
>  	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>  		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> -		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> -		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
> +		if (cxld->interleave_ways > 8)
> +			return -ENXIO;
>  		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = i < 4 ?
> +				(tl_low >> (i * 8)) & 0xff :
> +				(tl_high >> ((i - 4) * 8)) & 0xff;
>  
>  		return 0;
>  	}
> @@ -1018,6 +995,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (!committed)
>  		return 0;
>  
> +	cxled->skip = settings.target_or_skip;

I'm concerned about here modifying cxled->skip without the DPA write lock. Should it be:
	skip = settings.target_or_skip;

And leave modification of cxled->skip to exclusively with devm_cxl_dpa_reserve()?

Also this change isn't mentioned by the commit log.

DJ

>  	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
>  	if (remainder) {
>  		dev_err(&port->dev,
> @@ -1025,9 +1003,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			port->id, cxld->id, size, cxld->interleave_ways);
>  		return -ENXIO;
>  	}
> -	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
> -	skip = (hi << 32) + lo;
> +	skip = cxled->skip;
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..b8bb6ac19cac 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -33,6 +33,25 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));
> +}
> +
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index dd5e0cc82da4..97cb136cb2ae 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -125,3 +125,48 @@ int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
> +
> +int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
> +			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
> +			   bool *committed)
> +{
> +	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	int rc;
> +
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = id,
> +		.target_or_skip = target_or_skip,
> +		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
> +			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
> +	};
> +
> +	if (committed)
> +		*committed = enabled;
> +	if (!enabled)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX ||
> +	    (size && base > U64_MAX - (size - 1)))
> +		return -ENXIO;
> +	if (enabled && !size)
> +		return -ENXIO;
> +
> +	settings->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +	if (enabled) {
> +		settings->flags = CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			settings->flags |= CXL_DECODER_F_LOCK;
> +	}
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &settings->interleave_ways);
> +	if (rc)
> +		return rc;
> +
> +	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
> +				    ctrl),
> +				  &settings->interleave_granularity);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");

