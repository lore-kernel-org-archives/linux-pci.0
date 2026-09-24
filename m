Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863B377567;
	Thu, 24 Sep 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269346; cv=none; b=W1lkEZy6Dr/46XnB/ME8m9FU8Jg2f93DpJJIHXUXQCxSDZT+pNMD5h/N5tqB/ZsuhMn0jY6OHCT/ZSsSdZYqv4fNHirN5tzfECos1hrNKDNs6Qcfs9QrWEpgc9/8P1DoqbcEgV6MmRAXYZ3zkXENLTxZaPV2kWw9PjCo1N2qSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269346; c=relaxed/simple;
	bh=kzOSS1XrrJyhZlZ5TKyjiQBp0246QYA5urvw4uVFPIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVhjcS03XTNuv+4FEou4/i/qmFwra/TluoIazF8He9QheHweKlxUsC7z7nLqMuJ4s5y/nLM43V7DDXIPWL9P1quyT9rt1w/rXLnUcGRpcLEyOsij0fRkiC2E/L8uQPQKwLL3830o2DYKhohytAxeiOBnU2dzBpPTnhNG0x6s69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw7/YfYS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw7/YfYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790269344; x=1821805344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzOSS1XrrJyhZlZ5TKyjiQBp0246QYA5urvw4uVFPIk=;
  b=Tw7/YfYSypmFDMUcJu4NcVJSJp2ayQw+jUQ9AyhhBF3MynaceoQtaMKp
   kaEXBs2q6GCSgfJ1+u52eGNpUwv2f/tFSUeuYTW+pOoj7zftuajuECDL/
   UglFmMSqEqmBS5etHXZA/h/vPtfSm7ZjSBHWXYalrLldC9LMdTTEreMeJ
   hS35gwL2f3pxr0EI2h+ILkHNnZw0a8bftnfT44NWJFWnKpqJsEJNGzmU5
   LyOnVNsyRWP5SkaznUghoitSIDNa/Z4+VOrlBdwuA8fUxQbUV66oXVqDR
   p/5cwbg+R2yCRwOuAnDMBbyDt7eemW3/zybIyZuQT1NVu8cYcHdCEFZcH
   A==;
X-CSE-ConnectionGUID: tvxJoATQQtasV3+diK8mhQ==
X-CSE-MsgGUID: fmEVCIPFTnKvPjzVX/4p5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107433577"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="107433577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:02:24 -0700
X-CSE-ConnectionGUID: BpgPOxxrTWycHfsR6r7XYA==
X-CSE-MsgGUID: Swk0XdBDRdG8rNISbOxOVQ==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:02:22 -0700
Message-ID: <1389355d-0e87-41d5-a759-4558dbb0688a@intel.com>
Date: Thu, 24 Sep 2026 10:02:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/15] cxl: Move HDM decoder programming helpers
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
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-4-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 1:39 AM, Srirangan Madhavan wrote:
> Move the HDM decoder programming helpers and cxl_rwsem from hdm.c to
> resource.c for reuse by reset restoration. Keep their behavior unchanged
> and expose only the cross-object helpers within cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/core.h     |   4 ++
>  drivers/cxl/core/hdm.c      | 103 +--------------------------------
>  drivers/cxl/core/resource.c | 110 ++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild    |   1 +
>  5 files changed, 117 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..57995777af0d 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -6,6 +6,7 @@ ccflags-y += -I$(srctree)/drivers/cxl
>  CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
> +cxl_core-y += resource.o
>  cxl_core-y += pmem.o
>  cxl_core-y += regs.o
>  cxl_core-y += memdev.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 983d7690c3a5..9c6d4b99f787 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -139,6 +139,10 @@ struct cxl_rwsem {
>  
>  extern struct cxl_rwsem cxl_rwsem;
>  
> +int cxld_await_commit(void __iomem *hdm, int id);
> +void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt);
> +void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 39fe283cbc74..008f04f0ca25 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,11 +16,6 @@
>   * for enumerating these registers and capabilities.
>   */
>  
> -struct cxl_rwsem cxl_rwsem = {
> -	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> -	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
> -
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  {
>  	int rc;
> @@ -707,36 +702,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> -{
> -	u16 eig;
> -	u8 eiw;
> -
> -	/*
> -	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> -	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> -		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      cxld->interleave_granularity))
> -		return;
> -
> -	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
> -static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> +void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
>  	int ways = cxlsd->cxld.interleave_ways;
> @@ -758,73 +724,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> - * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -static int cxld_await_commit(void __iomem *hdm, int id)
> -{
> -	u32 ctrl;
> -	int i;
> -
> -	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> -			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> -			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -			return -EIO;
> -		}
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return 0;
> -		fsleep(1000);
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> -{
> -	int id = cxld->id;
> -	u64 base, size;
> -	u32 ctrl;
> -
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -
> -	if (is_switch_decoder(&cxld->dev)) {
> -		struct cxl_switch_decoder *cxlsd =
> -			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
> -
> -		cxlsd_set_targets(cxlsd, &targets);
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
> -	}
> -
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> new file mode 100644
> index 000000000000..68d40f745acc
> --- /dev/null
> +++ b/drivers/cxl/core/resource.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +
> +static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress unititalized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> +		return;
> +	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      cxld->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> + * committed or error within 10ms, but just be generous with 20ms to account for
> + * clock skew and other marginal behavior
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +int cxld_await_commit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	int id = cxld->id;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	/* common decoder settings */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	cxld_set_interleave(cxld, &ctrl);
> +	cxld_set_type(cxld, &ctrl);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> +		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> +		u64 targets;
> +
> +		cxlsd_set_targets(cxlsd, &targets);
> +		writel(upper_32_bits(targets), tl_hi);
> +		writel(lower_32_bits(targets), tl_lo);
> +	} else {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> +		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> +
> +		writel(upper_32_bits(cxled->skip), sk_hi);
> +		writel(lower_32_bits(cxled->skip), sk_lo);
> +	}
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..6c09932587ce 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> +cxl_core-y += $(CXL_CORE_SRC)/resource.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o

