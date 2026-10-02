Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B331D366;
	Fri,  2 Oct 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977595; cv=none; b=KK2JST11EUOcIjpcq4PTfZcQe0lHGZQPFWlS7CZcnk4zTCvyWnx5Rlaadogc7Vz8iFepe2SsNJwmKiqmQDs5ZpDXHDlJKKl07LUN3Pom/s6RYn7yoSraS/0HCJh2wEYKrjV4P6br9CN54/OhbIockxLdfH42UujnTYSkr9dsHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977595; c=relaxed/simple;
	bh=fEtWUgOBbnlnzHaDVwHu5Cm5YPUkyyuz6fV3V57WppA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKAmX4Oz3K0qOOQcCwokUfPYOlq/Kd+Xo0TWYLUg0Ojq1W1LB62NGs+YP9w6n/1qyy8uGiLxIJ0GYH9jnYQY+YMLeLyPKg9ojrw4KHunt3eS+5FVDyex8JZyskj3DfOuOj53y2m47jtySA/pGv9Ae7HyAGGnbA+UhVaoAq94geg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAer+0Jp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAer+0Jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790977592; x=1822513592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fEtWUgOBbnlnzHaDVwHu5Cm5YPUkyyuz6fV3V57WppA=;
  b=jAer+0Jpg3M01psLLA7RdVIZG2cu31hwu/G3UvvWVz0aCgZlGVH5HwE+
   qCsO99wVxnIu6qFCEyAqg9o8Tvb0vbCB6SrMzPqGdWFxLwF0w0DFiTcKc
   ChW+J0bcp2F0jcpq2KpOOIcf54yvnx6pRB6wav4fxalW81L6A3YzB9XW1
   z3JnGjuJdBPUWHeWbbM0hB1E+DKK++4RYuwT0PBbXIQN6Q5k/HbhzIqRO
   mD3fAjyVe/QAxI+17C+rodopSqDDy3wNXpKDfqtZXU04sd+k/BOY2QmWe
   JR4BPRc+qNpjmpLgnL1muo5/5gZylH/eT4BjgqiHTNSBT1yPks4bMuPNw
   w==;
X-CSE-ConnectionGUID: CJeJQQfZQFOp3PIgbovSeA==
X-CSE-MsgGUID: ZN8I2dfPTAe/IbnSMHKvRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90883059"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90883059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:46:31 -0700
X-CSE-ConnectionGUID: BNce/BCKQC2j38vP7QdwxA==
X-CSE-MsgGUID: ZiWINYMtQL+PXYDqs7ATeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="284398309"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:46:30 -0700
Message-ID: <ad7f3467-2025-473f-bc9c-2870940b30e0@intel.com>
Date: Fri, 2 Oct 2026 14:46:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/16] cxl: Share HDM decoder register unpacking
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
 <20261001092227.3004747-8-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001092227.3004747-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate the
> range and interleave parameters in locals before publishing the complete
> settings, including enable/lock flags and the target-or-skip register
> value.
> 
> Use the unpacked settings in init_hdm_decoder(), retaining the target-list
> union and passing endpoint skip state to the existing DPA reservation
> helper.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/core.h     |  4 +++
>  drivers/cxl/core/hdm.c      | 68 +++++++++++--------------------------
>  drivers/cxl/core/resource.c | 57 +++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a3fddb2bed63..a0bef246121d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -142,6 +142,10 @@ extern struct cxl_rwsem cxl_rwsem;
>  void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
>  int cxld_await_commit(void __iomem *hdm, int id);
>  
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
> +			   u32 ctrl, u64 base, u64 size,
> +			   u64 target_or_skip_reg_val);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 629e3420ad0b..b6a8fe83d336 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -932,8 +932,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
> +	struct cxl_decoder_settings settings;
> +	u64 size, base, skip, dpa_size, lo, hi, target_or_skip_reg_val;

I don't think you need target_or_skip_reg_val here. You should be able to read and pass the single meaning variable with the change I suggested earlier and pass in to the appropriate branches depending on endpoint or switch. I think that's what the code did before the changes. In general just avoid using compound variable names for better code clarity.

DJ

>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> @@ -953,35 +953,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>  	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> +	target_or_skip_reg_val = (hi << 32) + lo;
> +	rc = cxl_hdm_unpack_decoder(&settings, which, ctrl, base, size,
> +				    target_or_skip_reg_val);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->config.id, ctrl, rc);
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
> -			 port->id, cxld->config.id);
> -		return -ENXIO;
> -	}
> +	cxld->config = settings.config;
> +	size = range_len(&cxld->config.hpa_range);
>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->config.hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
>  
>  	/* decoders are enabled if committed */
> -	if (committed) {
> -		cxld->config.flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->config.flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->config.target_type = CXL_DECODER_DEVMEM;
> -
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->config.id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -1015,38 +1008,19 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  		}
>  	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->config.interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->config.interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -
>  	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>  		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
>  		cxld->config.interleave_ways, cxld->config.interleave_granularity);
>  
>  	if (!cxled) {
> -		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> -		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
> +		target_list.value = settings.target_or_skip_reg_val;
>  		for (i = 0; i < cxld->config.interleave_ways; i++)
>  			cxld->target_map[i] = target_list.target_id[i];
>  
>  		return 0;
>  	}
>  
> -	if (!committed)
> +	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
>  		return 0;
>  
>  	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
> @@ -1056,9 +1030,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			port->id, cxld->config.id, size, cxld->config.interleave_ways);
>  		return -ENXIO;
>  	}
> -	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
> -	skip = (hi << 32) + lo;
> +	skip = settings.target_or_skip_reg_val;
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index ff027cb89e57..8dfeb12de8c9 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -104,3 +104,60 @@ void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
>  	setup_hw_decoder(hdm, settings);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
> +
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
> +			   u32 ctrl, u64 base, u64 size,
> +			   u64 target_or_skip_reg_val)
> +{
> +	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	enum cxl_decoder_type target_type = 0;
> +	int interleave_granularity;
> +	int interleave_ways;
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	int rc;
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX)
> +		return -ENXIO;
> +
> +	hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +
> +	if (committed) {
> +		flags |= CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			flags |= CXL_DECODER_F_LOCK;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> +			target_type = CXL_DECODER_HOSTONLYMEM;
> +		else
> +			target_type = CXL_DECODER_DEVMEM;
> +	}
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &interleave_ways);
> +	if (rc)
> +		return rc;
> +	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				&interleave_granularity);
> +	if (rc)
> +		return rc;
> +
> +	*settings = (struct cxl_decoder_settings) {
> +		.config = {
> +			.id = id,
> +			.hpa_range = hpa_range,
> +			.interleave_ways = interleave_ways,
> +			.interleave_granularity = interleave_granularity,
> +			.target_type = target_type,
> +			.flags = flags,
> +		},
> +		.target_or_skip_reg_val = target_or_skip_reg_val,
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");

