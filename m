Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054464;
	b=YeT158wCXgSeL2u6DDes6zcBl0NnwFJtvv+sKdp+tkDyBmiV6YkG13vbWAniutzVfIeQ
	 0YFLekR34qivPhoQ5KG4An/LHJPfJpqIIQ2vCclbV3so0g/yKyOt/y7Flf+qHE6mJPrKl
	 /zmYOjD9jW2vpWFJxz45QVCZfbZ++wj6gzTh+wBMdbqDi1DDXrPwbjnhkeKE0ENJ509Be
	 o6RUsy6VJT9w/fpIQ198vPplCk+4UFoRPTJF/dLxCr5sGf2s82LPYGTZ1WWA0CmAqbpys
	 vW/65ZNAlZskQ1O68fnsKsb5EruN5W6ie/R2OUH3C/hSqQw6dM9pHWkj+KM7Ta/g0XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054464;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dFWm6e8WOf4e9vJ05SLuu1gDsti2ZvObHv2CjraUpjY=;
	b=Pa5qJJqVgDkw4tPBLo/IJZtEjm4/I9IrclyVK6O/RdCDMQKMquIMF4mafOqNUfSuknpg
	 7xXG+AE0mpTsyn4/MECKmfw79X+8MedxD2ZYEgmPg+0yHD+NNF3zjnfGhAhWBeBH2EMvd
	 HmL7KukvqHwLYLdZquxfhK0Eypo6VbWpaSDwG0Vzhy+CLt0aCPC0Cs5DkViH4fSK5Zd5h
	 I2A4UDw9C6toMRpEDoTUyh9nI88JJtzHzAlXpbVDUUkARTkAVEAnXfRjku4vJfZWhoMK4
	 fOlQpqsJcj7k3ut1UmMlm3KWXr+v437l51EObH+TPtPgEP+D8CqxtgN4nY9iZLmRuDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eRGI1pwz;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F691606A31A;
	Mon, 26 Oct 2026 22:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F691606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eRGI1pwz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793054462; x=1824590462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9iQtd8pwX4yDXv/sgUfU8HTm44AdYrMGXsSFOnR7kP8=;
  b=eRGI1pwzau/8XD+m9AFfn8HMXNybxkic0SLqoYIH6Lo+DGE4G1dyyTOm
   68whfQ9Ohi85D9jA12wjRO0MUf6G1g08oBa5nObaLSav9x7c3sDaDQd2x
   C6pr1JzelqzUkFXsAkeb1+NIJi96dpwZ4dG2sEyMczHCYl1bBZxNErfyN
   dZw2QSfvmNwXz4gcMU9XEGhiU+int57ccAIuqCeKfOgVsQsKuXATsUAig
   +PwMMMG6EDfGGjIQMb69RW/j20625X6+xqQrM3BvMN/NuRm8kx0xgzBEQ
   vApt4Vrox/0cjWX9htwwj89awBgYLgB3u7mBhzW496g1dBfJsxWPkXXo9
   Q==;
X-CSE-ConnectionGUID: JAUpNU0dT8CyTM18Fnx42w==
X-CSE-MsgGUID: qrh9oZgbS3ug4olf1EH7yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1622819"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1622819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:41:02 -0700
X-CSE-ConnectionGUID: VLobcu99TI6vMFMviRH8qQ==
X-CSE-MsgGUID: 9cYevio4TsKQ/hwOQhwonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4345288"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.108.112]) ([10.125.108.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:41:01 -0700
Message-ID: <a2af3f10-e96d-4283-a378-6da11d4941f1@intel.com>
Date: Mon, 26 Oct 2026 15:41:00 -0700
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/16] cxl: Share HDM decoder register unpacking
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
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-8-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261011021422.3428136-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/26 7:14 PM, Srirangan Madhavan wrote:
> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
> 
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
> 
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h     |  3 ++
>  drivers/cxl/core/hdm.c      | 54 +++++++++-------------------------
>  drivers/cxl/core/hdm_regs.c | 58 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index fb14b222f3ca..d69864b25656 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -147,6 +147,9 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>  			     u64 targets, void __iomem *hdm);
>  int cxld_await_commit(void __iomem *hdm, int id);
>  
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 47cf49bcd2e5..1a19078e6c6c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -939,8 +939,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct cxl_decoder_config config;
>  	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> @@ -960,35 +960,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>  	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	rc = cxl_hdm_unpack_decoder(&config, cxld->config.id, ctrl, base, size);
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
> +	cxld->config = config;
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
> @@ -1022,23 +1011,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
> @@ -1053,7 +1025,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return 0;
>  	}
>  
> -	if (!committed)
> +	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
>  		return 0;
>  
>  	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index 53d2f236e49c..b6ee4becde8d 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -116,3 +116,61 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
> +
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size)
> +{
> +	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	enum cxl_decoder_type target_type = 0;
> +	int interleave_granularity;
> +	int interleave_ways;
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	u64 end;
> +	int rc;
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX)
> +		return -ENXIO;
> +	if (size && check_add_overflow(base, size - 1, &end))
> +		return -ENXIO;
> +	if (!size)
> +		end = base - 1;
> +
> +	hpa_range = (struct range) {
> +		.start = base,
> +		.end = end,
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
> +	*config = (struct cxl_decoder_config) {
> +		.id = id,
> +		.hpa_range = hpa_range,
> +		.interleave_ways = interleave_ways,
> +		.interleave_granularity = interleave_granularity,
> +		.target_type = target_type,
> +		.flags = flags,
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");

