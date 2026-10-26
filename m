Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053936;
	b=enGQB/JvbiUF/KOM0Ae+wZNhsEAXMJJzcCweixnMOvjv2eVUHGSw88C3OtcPKM7jmECb
	 fA6b55hlNZvSC/lK+GORhHqhit7Cjvyb45UOapmYa2l/IniUGqizuxTdtXL94LC5MGW6t
	 ladmTG4Jpk2eSBQMxRreI70XPQKMz0Gk6G7cyPR90UCav9tTEnc5I4KsZm1J0PqTmhDvX
	 2A4+Bn4LvupqVRDcWMfaLa65o34QuYS5HqKXr0bow34b6a60BJUZe9wKg30RADxiK6piG
	 +8ctyie0jtNn1C6y1E3lA53pfM5asbCV/ml9kkeGeWZOlSw31bbuB22m2Cw0puvsTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053936;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cLWyp4JCuD0n/sHIvYTaOkagX1P6suKOkM2l66U9DLk=;
	b=e5/HEaOrvbbE2gkuD/aUm79FYExrgqbrtPeaVJdRtir6fZzcEBONGvRAbWrE8tWnvN9/
	 3NXIuQuFZ/zP4FwMtOCzNnZLkwMqpa5c72GEHnXU5z47KO1dRkod5aETl8botIZOAmNWu
	 8N2YO4OsWVloXRANHpCiG49CdpOE3CKbVnitLKA5sBKp7jXSNYbccF1ILYYe2KIRU/BCy
	 pyvXEQI5WleadmtqvXZpK/c0dfP3SvBMc/9QjGzRfs6WkTRx4gnoOuHxUaPGm14hwu5IF
	 Q/Duf6rW/1fEChOnteH0lmDUPfBZiX1dUkx1Gqyy8m8uB6vG/B4NtOyYAzhXosvQQWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PW1puUrE;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E7606A326;
	Mon, 26 Oct 2026 22:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PW1puUrE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793053935; x=1824589935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jo21Qoq9UGA6k7NJIthAgqltaVAzzA6uYBt4FNd6t8Q=;
  b=PW1puUrEwaT0SI8gRd/xg1wik8To6bkzSXbgJwgTRrmLhUN9tOBinT3M
   5FHwPSquGwP8UB2BYmtDWv1wnZa19eNsAWhi4tX27kdQXxJZE81DtO7GB
   PlYeqLkgyaUlI7T7DwYeXniTxPCt1rQU/6woLeN9DBkDJErfvb+B+0U+z
   AuHnkWCguIaghRNhL3hkYqsGbgVm0Zrd6x95TzQ2qISgQf0Pk3ayCtnxL
   +8I6Fdue0sqHD/LY0w82CnEymYvZ12dAIwDwYsnzTT1CD0HLU1kClx3mX
   Nzo6W2714NkVW40n14WKJ/IZkE7TeIp0I+Pfu1TKHIyUABSyEh2pL8nGG
   w==;
X-CSE-ConnectionGUID: P3nqnzRjSEaZYSJ9kW8Ukg==
X-CSE-MsgGUID: mpIJHFCBTtOXcECGXAzisA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1624895"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1624895"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:32:14 -0700
X-CSE-ConnectionGUID: v781UitdS2eH/hDNdGp3OQ==
X-CSE-MsgGUID: zxxLv0eMS7iGfuQkYj0nFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4410117"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.108.112]) ([10.125.108.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:32:13 -0700
Message-ID: <592fff89-feea-48f0-80b6-cab4efa1df17@intel.com>
Date: Mon, 26 Oct 2026 15:32:11 -0700
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
Subject: Re: [PATCH v15 06/16] cxl: Move HDM decoder helpers to built-in code
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
 <20261011021422.3428136-7-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261011021422.3428136-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/26 7:14 PM, Srirangan Madhavan wrote:
> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
> 
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
> 
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=e0b476ea99567fb5aa416eac0cf61bca20724880
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/hdm.c      | 102 +------------------------------
>  drivers/cxl/core/hdm_regs.c | 118 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 100 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm_regs.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..6703c1729396 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d3254a712e4..47cf49bcd2e5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -708,35 +708,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u16 eig;
> -	u8 eiw;
> -
> -	/*
> -	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> -	 */
> -	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", config->interleave_ways))
> -		return;
> -	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      config->interleave_granularity))
> -		return;
> -
> -	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -759,77 +730,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> - * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -int cxld_await_commit(void __iomem *hdm, int id)
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
> -static u32 cxl_hdm_write_range(void __iomem *hdm,
> -			       const struct cxl_decoder_config *config)
> -{
> -	u64 size = range_len(&config->hpa_range);
> -	u64 base = config->hpa_range.start;
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -	cxld_set_interleave(config, &ctrl);
> -	cxld_set_type(config, &ctrl);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -	return ctrl;
> -}
> -
> -void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> -			       void __iomem *hdm)
> -{
> -	int id = settings->config.id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> -	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> -	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
> -void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> -			     u64 targets, void __iomem *hdm)
> -{
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, config);
> -	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> -	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
>  static void
>  cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>  			      struct cxl_endpoint_decoder_settings *settings)
> @@ -846,6 +746,8 @@ static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
>  {
>  	struct cxl_endpoint_decoder_settings settings;
>  
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
>  	if (is_switch_decoder(&cxld->dev)) {
>  		struct cxl_switch_decoder *cxlsd =
>  			to_cxl_switch_decoder(&cxld->dev);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> new file mode 100644
> index 000000000000..53d2f236e49c
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include <cxl/hdm.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +/*
> + * HDM decoder register helpers are built in whenever CXL_BUS is enabled,
> + * including when cxl_core is modular. Callers provide any required locking.
> + */
> +
> +static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress unititalized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
> +		return;
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      config->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
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
> +EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
> +
> +static u32 cxl_hdm_write_range(void __iomem *hdm,
> +			       const struct cxl_decoder_config *config)
> +{
> +	u64 size = range_len(&config->hpa_range);
> +	u64 base = config->hpa_range.start;
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	return ctrl;
> +}
> +
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm)
> +{
> +	int id = settings->config.id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> +	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
> +
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm)
> +{
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, config);
> +	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");

