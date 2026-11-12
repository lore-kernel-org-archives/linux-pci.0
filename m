Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519353;
	b=WoBCxiZplhNME35vtUePtBrDSQdiXZzCq1LtcUkVr8j6mbbTLLkch/2RehOBeoy/zwE9
	 DNEk4EfWSdpAoQz2HteKsdw2fUZlKUfapqo8S6qoc8jj8IbMS7cCJz5kPNp08HtyKe7KV
	 +yOQS5TeGg1o1C3+Iz/ISPZ398sZmCIZR6WAt6/5ROC/rFSMniOLNUXoQzag/5J5CL6M5
	 Oz+FX5Kv8CAgYj//FOfVkNSdQ8IyzI9/xo9bxwt9dXgWmavMWRmBFki3EEbBe+TBXe2PI
	 ufB4HPFkvH0u1lk0mmxqwgnTCHVAfDlUdAZGVfaPvuSoad+qyrCpzfxeLHM/6tH6C5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519353;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UC30sGnYtiIq6XvO1InU15cyFxVK4lm9N2kZyIR1CCQ=;
	b=WBabeGgZqhHGLbfTchWonYP9N37xzeOLjXWfSJsAwJjmd39MPuo8gN174Ui3c0fu551Z
	 NY98isizxaORWW1/Vrq2Hrk6V0ASBMkqxuaoEx9/kbqkoMjigO+NqoK0gOGysGE0nkaB3
	 W/pgghKM40tbB3dsHgxax5YTzHxTVF3s+pgCAZUoaxsljq2yzKZvCSY0q8cdqyvWeRsvu
	 ydNfcIBMdamjfPIt62nO5OsM535Fg2JVN8dHJlwog+RSs8rOnAeTfjFVza8FvUSi3oCuJ
	 dHoNRVO+CExei9k3Q5pKLignf8hmcTF19iEX70MzB2ROSSUhZvXJ7iyn40bz6x08IAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M0wZcKkx;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA1606A31C;
	Thu, 12 Nov 2026 21:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M0wZcKkx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794519352; x=1826055352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CRuRizMfmnFBiA9pHWAZpC0Tg5U1X5QvtCsLixsWsLc=;
  b=M0wZcKkxF2NSzkrnqTHaNuKMbNXKFBJCLFr//NTGXZFSeA4Qq5dEtPca
   UuNIKP+ID7Dl1F3oGU0Gn2CUOuZGQcTd3Vw2DqEOb91lOkd5Aa6kLQQeI
   hXlhTGwUrKD3dbYHS0ItYmvnSZ/W3PXwJk3cjkFipUTwkD4VsQnza6/Wz
   wy0ACYfpe9E9kf92gBbBFnzO43iAK0EmzkA3gCknxPFXSW0VGYua/EfYE
   jor9ADsF0ALRMXCnvIwOygMsZpeF2hqYamqLqEkZpQDKgn87Z2Qmpwfvx
   qavLTt+CXjWhw20qPGNSkZaPrfAghwaJ1AAq95K3uKk//hOa//hVxcGXC
   w==;
X-CSE-ConnectionGUID: K01ltnayS+WUcFdCKJayqg==
X-CSE-MsgGUID: B6Jh3MmUSHS5gc8AlT6wug==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3351754"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3351754"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:35:52 -0800
X-CSE-ConnectionGUID: s4wExNETSUmdzDNYZnjwtA==
X-CSE-MsgGUID: m9MkmBakRBen2qGy5j0Fmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8754685"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.111.216]) ([10.125.111.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:35:50 -0800
Message-ID: <1c6e45dc-afc8-43ad-8dde-507b9a4b3522@intel.com>
Date: Thu, 12 Nov 2026 14:35:49 -0700
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
Subject: Re: [PATCH v17 07/19] cxl: Share HDM decoder register unpacking
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-8-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:59 AM, Srirangan Madhavan wrote:
> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
> 
> Read decoder base and size registers low then high through a shared
> helper used by enumeration and the reset snapshot.
> 
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
> 
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
Feel free to just drop this. Upstream no longer wants it. 

> Reviewed-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes in v17:
> - Initialize the zero-size end to base - 1 and document the zero-size
>   case, removing a branch (Richard)
>   https://lore.kernel.org/linux-cxl/auQ27s1rSCcbdRJ3@MWDK4CY14F/
> 
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
> ---
>  drivers/cxl/core/core.h     |  5 +++
>  drivers/cxl/core/hdm.c      | 65 ++++++++------------------------
>  drivers/cxl/core/hdm_regs.c | 74 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index fb14b222f3ca..ea539f00e55d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -147,6 +147,11 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>  			     u64 targets, void __iomem *hdm);
>  int cxld_await_commit(void __iomem *hdm, int id);
>  
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size);
> +int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
> +			 int id, u32 ctrl);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2c373dfbc070..5b5f5f22ea32 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -938,11 +938,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
> +	u64 size, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_config config;
>  	u32 remainder;
> -	int i, rc;
>  	u32 ctrl;
> +	int i, rc;
>  	union {
>  		u64 value;
>  		unsigned char target_id[8];
> @@ -953,41 +953,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  							which, info);
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> -	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
> -	base = (hi << 32) + lo;
> -	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
> -	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	rc = cxl_hdm_read_decoder(&config, hdm, which, ctrl);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->config.id, ctrl, rc);
> +		return rc;
> +	}
> +
> +	config.id = cxld->config.id;
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
> @@ -1021,23 +1005,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
> @@ -1052,7 +1019,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return 0;
>  	}
>  
> -	if (!committed)
> +	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
>  		return 0;
>  
>  	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index 53d2f236e49c..cc5d77c4abf5 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -116,3 +116,77 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
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
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	u64 end;
> +	int rc;
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX)
> +		return -ENXIO;
> +	/* A zero-size decoder maps no HPA; its range is empty at @base. */
> +	end = base - 1;
> +	if (size && check_add_overflow(base, size - 1, &end))
> +		return -ENXIO;
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
> +
> +int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
> +			 int id, u32 ctrl)
> +{
> +	u64 lo, hi, base, size;
> +
> +	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	base = (hi << 32) | lo;
> +	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	size = (hi << 32) | lo;
> +
> +	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");

