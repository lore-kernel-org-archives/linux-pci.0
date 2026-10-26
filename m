Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053244;
	b=iSUKNjdVQBMSj1CU4Q6bEE/peKhSI/R2jLM9+NgvFDIdYzU2qhMRpJodCyX6QWA7io03
	 bXSxJVrHhy+GiGU5nn63uNhWGrnE80SzVQE4uWwq2R6SB4dEPNVIyt2kufqxLyCu+Nxla
	 HM1srZENkNSkVORFSJXTXLD/rC31cUOVCqkhZfdg828zojVytTMz8a/71Llp6tSxJ2nW2
	 NNiX4KmN1R4dMhgG1s6lRBNnI8ZjUr//RgmpJelZWAFicThGXxORmkjm1ksBJJfTr2ucU
	 Qtb7GGFdItBQEQmY5UeachRiv64fv1DHktO7qA+B91dQfaU+ES1182cBz+ATz7124mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053244;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=J1IJmvDa01QSZGhYxBDY3bGQUCSekk9qn6rmDBEQPMc=;
	b=RMt//lhWQiLd23DJPA2OFLNyjZRjBPDHTbkcA7tHmWGdqPY07esj5KWyxUwDMqfjtC/Z
	 Yr5bWoWfPVXUPoZ4gNYYHlijSn8XVKALgwjLKP48vZO7eA1tFlYcsrb+OuJ2Hufvf1Sr2
	 8+rgbsyWgJ30yw0pzGAZcY4gkuU6RohXo0olds3nYG20oeKsnZkXuwRKmFfPQb7Xhtkpb
	 tY1Ax2263GgQS0OGtw71TFtQpt5fLTONhLXuzsTC7a4fRgdYFjTiumTF6zU/3xVQPMkTi
	 m3hoRCqLVXCbQ3S4VK4YB8sZXg3i72ghztA5LP24GN2qO4n+pbeDYuWHwU3CSW3xReg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhDX5HDw;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC7606A31B;
	Mon, 26 Oct 2026 22:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DC7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhDX5HDw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793053243; x=1824589243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EJlzZkZWz6HoaDfqJJgBqkmd5+G1yi+X3R9UmIvYRT8=;
  b=bhDX5HDwOC1HICANHZjm+daEk0PRRYLCVHS77iYSpQ+XAGie6W/VKf0o
   PtD6reYfQkpeDJEhVX69oOz1AcobrN+FMBPlEr7wbEqcJgZzcimpVx840
   k+FeZU/g7ln6jCcVgccO5Gjbsa07Q1h6N972vx13oaBufMpmcZkWuHQgx
   Hwt/YZgP0f8mxL/QcdltpgB6Acotfw4Uyn2Nx6UayNUSUwPZRCZFxiYDi
   YsigwhLwndujUEY1m4151Wskw4iHqw+0nyWxH/+csjQbP00trirEUS4M1
   M2VyPwgN2fOLraIWCxFSGFMTIMh/JnFQdC5qNDQnucoyEsmlUNWnqNwDA
   w==;
X-CSE-ConnectionGUID: qRyXIBH0RIeKyYL1gC7ZUA==
X-CSE-MsgGUID: 4ALPiTR+QYmmaRNr5jdBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1621207"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1621207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:20:42 -0700
X-CSE-ConnectionGUID: NrXPwidtRxSMW0wYhxFsrg==
X-CSE-MsgGUID: aeDc91w0R7CUv5zhQIN8jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4766492"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.108.112]) ([10.125.108.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:20:40 -0700
Message-ID: <654f2205-5dd8-4169-88ca-cba3f2c4ddb6@intel.com>
Date: Mon, 26 Oct 2026 15:20:39 -0700
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
Subject: Re: [PATCH v15 05/16] cxl: Introduce endpoint HDM decoder settings
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
 <20261011021422.3428136-6-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261011021422.3428136-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/26 7:14 PM, Srirangan Madhavan wrote:
> Keep common decoder configuration in cxl_decoder_config and represent
> endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
> programming, but keep endpoint skip and switch target-list writes in
> their respective commit paths.
> 
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=20f9084b5b763238e2f18f629916bbbb46ec9f7d
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h |  8 ++++
>  drivers/cxl/core/hdm.c  | 96 ++++++++++++++++++++++++++++-------------
>  include/cxl/hdm.h       | 19 ++++++++
>  3 files changed, 93 insertions(+), 30 deletions(-)
>  create mode 100644 include/cxl/hdm.h
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 983d7690c3a5..fb14b222f3ca 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,6 +7,8 @@
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
>  
> +struct cxl_endpoint_decoder_settings;
> +
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
> @@ -139,6 +141,12 @@ struct cxl_rwsem {
>  
>  extern struct cxl_rwsem cxl_rwsem;
>  
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm);
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm);
> +int cxld_await_commit(void __iomem *hdm, int id);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9e05032a5426..7d3254a712e4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/hdm.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -707,7 +708,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
> @@ -716,12 +717,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 * Input validation ensures these warns never fire, but otherwise
>  	 * suppress unititalized variable usage warnings.
>  	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
> -		      cxld->config.interleave_granularity))
> +		      config->interleave_granularity))
>  		return;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> @@ -729,10 +730,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }
>  
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
>  {
>  	u32p_replace_bits(ctrl,
> -			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>  }
>  
> @@ -764,7 +765,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>   * clock skew and other marginal behavior
>   */
>  #define COMMIT_TIMEOUT_MS 20
> -static int cxld_await_commit(void __iomem *hdm, int id)
> +int cxld_await_commit(void __iomem *hdm, int id)
>  {
>  	u32 ctrl;
>  	int i;
> @@ -784,45 +785,80 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +static u32 cxl_hdm_write_range(void __iomem *hdm,
> +			       const struct cxl_decoder_config *config)
>  {
> -	int id = cxld->config.id;
> -	u64 base, size;
> +	u64 size = range_len(&config->hpa_range);
> +	u64 base = config->hpa_range.start;
> +	int id = config->id;
>  	u32 ctrl;
>  
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->config.hpa_range.start;
> -	size = range_len(&cxld->config.hpa_range);
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	return ctrl;
> +}
> +
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm)
> +{
> +	int id = settings->config.id;
> +	u32 ctrl;
> +
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> +	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm)
> +{
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	ctrl = cxl_hdm_write_range(hdm, config);
> +	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +static void
> +cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
> +			      struct cxl_endpoint_decoder_settings *settings)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	*settings = (struct cxl_endpoint_decoder_settings) {
> +		.config = cxled->cxld.config,
> +		.skip = cxled->skip,
> +	};
> +}
> +
> +static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	struct cxl_endpoint_decoder_settings settings;
>  
>  	if (is_switch_decoder(&cxld->dev)) {
>  		struct cxl_switch_decoder *cxlsd =
>  			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
>  		u64 targets;
>  
>  		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> -
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> +		cxl_commit_start_switch(&cxld->config, targets, hdm);
> +		return;
>  	}
>  
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxl_endpoint_decoder_snapshot(to_cxl_endpoint_decoder(&cxld->dev),
> +				      &settings);
> +	cxl_commit_start_endpoint(&settings, hdm);
>  }
>  
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> new file mode 100644
> index 000000000000..219b9bb67440
> --- /dev/null
> +++ b/include/cxl/hdm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#ifndef __CXL_HDM_H__
> +#define __CXL_HDM_H__
> +
> +#include <linux/types.h>
> +#include <cxl/cxl.h>
> +
> +/**
> + * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
> + * @config: common decoder configuration
> + * @skip: length of DPA space skipped before this decoder's DPA mapping
> + */
> +struct cxl_endpoint_decoder_settings {
> +	struct cxl_decoder_config config;
> +	u64 skip;
> +};
> +
> +#endif /* __CXL_HDM_H__ */

