Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396522301;
	Tue,  7 Jul 2026 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383747; cv=none; b=nM/HmYongwVhP5i9vGQtji+GKJu0Uh4N8lNujeGaH9rDszdInj4S7DXwiW840v2sYxSsGb+rMRWrPgeybXHdz6CRtBKrYz5sld3QEYOw+QJcEMg1mfNzB28PzZrbteJAeqCALuLWxaNSzsyi5DHRcGr5q0WKaHXn2G/nhTPDIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383747; c=relaxed/simple;
	bh=/jO4qytjAalu21b8tVuH9tW9VBbhouPVvUtNrvNULSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBghq6ro8va2ywEggpGelnZjtiChFMV7h450TqpUb2ZSwyE5pdv0C3Pmzn+i/3mI1fmbENUlTlfS5YRKBA9vepxShhaRG14Od7ElX7eKlZw9pgpYDloWBgoP6b3BSMxxwSlM81jBmLYWXZfQ12wcRfmc2QZXDCF4s52JpVEuRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3iP4Zoa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3iP4Zoa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783383746; x=1814919746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/jO4qytjAalu21b8tVuH9tW9VBbhouPVvUtNrvNULSI=;
  b=H3iP4ZoakQ9OidcXukqJTb7fAh8yYi/ZKbth0h7uFth2g14pDckUzbY5
   qkaTFMGhN+mBkwSBBl9jmijMUQF6PBKxOUmrK/di7sgspvOXcZea2SG0e
   6vWBLXTNKxqLevG6vxXjVoJ16EXDu+S7dwx49//raWVtog8krhdUSvMro
   kGQ1gdudt4Aw4SdpLtvOPytaeq3nzYRQAz2xcmI1WoK9HBQJ7k+X/PVz3
   u0OGV3cLnahJvRHE35aeXUTnjJILNdeweSG6E42gQyLFJw4SL185PRUmX
   7vZ8g5nlqB5j5pkutQ9iyzdg08pp6WD8ysAFn2LDfMwquRYxLM3a93jqg
   Q==;
X-CSE-ConnectionGUID: 220A72QlRAqexjdYWSrErQ==
X-CSE-MsgGUID: 5yfP0uxLTRGeF9rGAZzwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101447281"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="101447281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 17:22:25 -0700
X-CSE-ConnectionGUID: EKhccX1GRpO2FkmjdH+LqQ==
X-CSE-MsgGUID: Q+3trOLAQDurTXrUUNmYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257426054"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 17:22:22 -0700
Message-ID: <b7e43392-acdb-47d6-a4ba-45f319551b15@intel.com>
Date: Mon, 6 Jul 2026 17:22:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] cxl: Split decoder programming into a reusable
 helper
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
 <20260703220508.546528-2-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:04 PM, Srirangan Madhavan wrote:
> Move common HDM decoder settings to include/cxl/cxl.h and route the
> register programming sequence through cxl_commit(). This lets reset code
> restore cached HDM state without depending on private cxl_core types while
> keeping hdm.c in charge of the existing commit policy checks.
> 
> Build the low-level HDM helper under CONFIG_CXL_HDM so it is available even
> when cxl_core is modular.

Maybe this patch would be cleaner to review if there's a prep patch that move things that needs to be moved without the additional changes as well.

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig          |   4 ++
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/hdm.c       | 122 ++++-------------------------------
>  drivers/cxl/core/region.c    |   6 +-
>  drivers/cxl/core/reset.c     | 118 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h            |  43 ------------
>  include/cxl/cxl.h            |  55 +++++++++++++++-
>  tools/testing/cxl/test/cxl.c |  10 +--
>  8 files changed, 197 insertions(+), 162 deletions(-)
>  create mode 100644 drivers/cxl/core/reset.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..87d719ea1e14 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select CXL_HDM
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>  	select FWCTL if CXL_FEATURES
>  	help
> @@ -243,4 +244,7 @@ config CXL_ATL
>  	depends on CXL_REGION
>  	depends on ACPI_PRMT && AMD_NB
>  
> +config CXL_HDM
> +	bool
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..dc075cee0450 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(CONFIG_CXL_HDM) += reset.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..fa978c297546 100644
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
> @@ -255,11 +250,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  
>  	/* save @skip_start, before @res is released */
> -	skip_start = res->start - cxled->skip;
> +	skip_start = res->start - cxled->cxld.skip;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -	if (cxled->skip)
> -		release_skip(cxlds, skip_start, cxled->skip);
> -	cxled->skip = 0;
> +	if (cxled->cxld.skip)
> +		release_skip(cxlds, skip_start, cxled->cxld.skip);
> +	cxled->cxld.skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
>  	port->hdm_end--;
> @@ -388,7 +383,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		return -EBUSY;
>  	}
>  	cxled->dpa_res = res;
> -	cxled->skip = skipped;
> +	cxled->cxld.skip = skipped;
>  
>  	/*
>  	 * When allocating new capacity, ->part is already set, when
> @@ -679,35 +674,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
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
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -730,73 +696,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
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
> @@ -834,17 +733,20 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		}
>  	}
>  
> -	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -		setup_hw_decoder(cxld, hdm);
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		cxlsd_set_targets(cxlsd, &cxld->targets);
> +	}
>  
> -	rc = cxld_await_commit(hdm, cxld->id);
> +	rc = cxl_commit(&cxld->settings, hdm);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
>  		return rc;
>  	}
>  	port->commit_end++;
> -	cxld->flags |= CXL_DECODER_F_ENABLE;
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ce99f0650764..00f79b4862cb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,9 +2954,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	cxlds = cxlmd->cxlds;
>  	mode = cxlds->part[cxled->part].mode;
>  
> -	if (cxled->skip) {
> -		offset = cxled->dpa_res->start - cxled->skip;
> -		length = cxled->skip;
> +	if (cxled->cxld.skip) {
> +		offset = cxled->dpa_res->start - cxled->cxld.skip;
> +		length = cxled->cxld.skip;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  			rc = 0;
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> new file mode 100644
> index 000000000000..14f024098e82
> --- /dev/null
> +++ b/drivers/cxl/core/reset.c

While I can't come up with a better name for this file, putting decoder bits in reset.c just doesn't seem right. There has to be a better name to represent what's in this file. Especially against CONFIG_CXL_HDM. Maybe hdm_lib.c and CONFIG_CXL_HDM_LIB? idk....

> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> +
> +static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress uninitialized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n",
> +		      settings->interleave_ways))
> +		return;
> +	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      settings->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> + * committed or error within 10ms, but just be generous with 20ms to account for
> + * clock skew and other marginal behavior.
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +static int cxld_await_commit(void __iomem *hdm, int id)
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
> +static void setup_hw_decoder(struct cxl_decoder_settings *settings,
> +			     void __iomem *hdm)
> +{
> +	int id = settings->id;
> +	u64 target_or_skip;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(settings, &ctrl);
> +	cxld_set_type(settings, &ctrl);
> +	base = settings->hpa_range.start;
> +	size = range_len(&settings->hpa_range);
> +	target_or_skip = settings->targets;
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	/* Target-list and endpoint-skip registers alias the same slot. */
> +	writel(upper_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
> +{
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		setup_hw_decoder(settings, hdm);
> +	}
> +
> +	rc = cxld_await_commit(hdm, settings->id);
> +	if (rc)
> +		return rc;
> +
> +	settings->flags |= CXL_DECODER_F_ENABLE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f43abd1903ce..b433262ab256 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -252,49 +252,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
> -enum cxl_decoder_type {
> -	CXL_DECODER_DEVMEM = 2,
> -	CXL_DECODER_HOSTONLYMEM = 3,
> -};
> -
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
> -#define CXL_DECODER_MAX_INTERLEAVE 16
> -
>  #define CXL_QOS_CLASS_INVALID -1
>  
> -/**
> - * struct cxl_decoder - Common CXL HDM Decoder Attributes
> - * @dev: this decoder's device
> - * @id: kernel device name id
> - * @hpa_range: Host physical address range mapped by this decoder
> - * @interleave_ways: number of cxl_dports in this decode
> - * @interleave_granularity: data stride per dport
> - * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
> - * @flags: memory type capabilities and locking
> - * @target_map: cached copy of hardware port-id list, available at init
> - *              before all @dport objects have been instantiated. While
> - *              dport id is 8bit, CFMWS interleave targets are 32bits.
> - * @commit: device/decoder-type specific callback to commit settings to hw
> - * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> -struct cxl_decoder {
> -	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> -	struct cxl_region *region;
> -	unsigned long flags;
> -	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> -	int (*commit)(struct cxl_decoder *cxld);
> -	void (*reset)(struct cxl_decoder *cxld);
> -};
> -
>  /*
>   * Track whether this decoder is free for userspace provisioning, reserved for
>   * region autodiscovery, whether it is started connecting (awaiting other
> @@ -310,7 +269,6 @@ enum cxl_decoder_state {
>   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
> - * @skip: offset into @dpa_res where @cxld.hpa_range maps
>   * @state: autodiscovery state
>   * @part: partition index this decoder maps
>   * @pos: interleave position in @cxld.region
> @@ -318,7 +276,6 @@ enum cxl_decoder_state {
>  struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
> -	resource_size_t skip;
>  	enum cxl_decoder_state state;
>  	int part;
>  	int pos;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 016c74fb747c..757d916a6330 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>  #ifndef __CXL_CXL_H__
>  #define __CXL_CXL_H__
>  
> +#include <linux/device.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -23,7 +25,56 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
> +};
> +
> +/*
> + * Current specification goes up to 8, double that seems a reasonable
> + * software max for the foreseeable future
> + */
> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @skip: offset into @dpa_res where @cxld.hpa_range maps (endpoint)
> + * @targets: interleave position to dport mapping (switch)
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @flags: memory type capabilities and locking
> + * @region: currently assigned region for this decoder
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> + */
> +struct cxl_decoder {
> +	struct device dev;
> +
> +	struct_group_tagged(cxl_decoder_settings, settings, int id;
> +		struct range hpa_range;
> +		union {
> +			u64 skip;
> +			u64 targets;
> +		};

I don't like the moving of 'skip' from cxled to cxld just for convenience. It takes away of using skip intentionally with an endpoint decoder. Not only that, the type is changed. Same with targets.

DJ

> +		int interleave_ways;
> +		int interleave_granularity;
> +		enum cxl_decoder_type target_type;
> +		unsigned long flags;
> +	);
> +	struct cxl_region *region;
> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>  
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
> @@ -70,6 +121,8 @@ struct cxl_regs {
>  	);
>  };
>  
> +int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6..4db5071aa25a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -840,11 +840,11 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
>  		dbg_cxld(port, "restore", &td->cxled.cxld);
>  		cxld_copy(cxld, &td->cxled.cxld);
>  		cxled->state = td->cxled.state;
> -		cxled->skip = td->cxled.skip;
> +		cxld->skip = td->cxled.cxld.skip;
>  		if (range_len(&td->dpa_range)) {
>  			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
>  						  range_len(&td->dpa_range),
> -						  td->cxled.skip);
> +						  td->cxled.cxld.skip);
>  			if (rc) {
>  				init_disabled_mock_decoder(cxld);
>  				return rc;
> @@ -882,7 +882,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
>  
>  		cxld_copy(&td->cxled.cxld, cxld);
>  		td->cxled.state = cxled->state;
> -		td->cxled.skip = cxled->skip;
> +		td->cxled.cxld.skip = cxled->cxld.skip;
>  
>  		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
>  			td->dpa_range.start = 0;
> @@ -970,7 +970,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
>  			to_cxl_endpoint_decoder(&cxld->dev);
>  
>  		cxled->state = CXL_DECODER_STATE_MANUAL;
> -		cxled->skip = 0;
> +		cxled->cxld.skip = 0;
>  	}
>  	if (decoder_reset_preserve_registry)
>  		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
> @@ -1021,7 +1021,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
>  			to_cxl_endpoint_decoder(&cxld->dev);
>  
>  		cxled->state = CXL_DECODER_STATE_MANUAL;
> -		cxled->skip = 0;
> +		cxled->cxld.skip = 0;
>  	}
>  }
>  

