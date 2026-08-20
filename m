Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEE3DC4D0;
	Thu, 20 Aug 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260401; cv=none; b=NDTgbgARmBYA4Ep0Ai7EZXXFSA2BSTAf2MdEudkggZucI1oBU5BvrpKBf+tLN2IF+m5ByMwdHTdSzXvkfIRXS4f+R158qeM3dWP2B78h6PvczJYBCAGLXNQk8/tyOgGUnwvD6ccbg9HuNu1QB39NTMMF+Ku5r8/jmJt2hZna4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260401; c=relaxed/simple;
	bh=TeC+biQ9D53dp7pyG9Q23+iLn1yPpF1vO5vBVKK5ZzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjZq7OY72P9NC+7QpV8HGKQQaAI8tuM6GsjSkWjh8e+EOOs3W1VpFZ1qq+TxJSX772vMVgjE57N00iD90BElTRFz7ju/m9oYk1EvMapTkjzoibUeFZFsSRqHwSjEHFWMau8hN9jHhwgqQvjCnLJlZ4vwJaBEFg0nR+c0cFXbJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj3GQ3Ux; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj3GQ3Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787260399; x=1818796399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TeC+biQ9D53dp7pyG9Q23+iLn1yPpF1vO5vBVKK5ZzM=;
  b=kj3GQ3UxgugO131JYQea7YHzxbCSLQxGmKhhjfON2MnaQYWdIPKPPbJR
   QL2xZ41Lz6l8sPTF4eTORhKhXWM7uco1T9uXY47/h9fn8m57TJeCrN88G
   5Vt38sVTDkStF9MV5C6r0vT7ZSLokAFOH/2Z/1yPl2jAHZJNLnFXyexo2
   Y9fCGJ+FhHsePmByelq9LpO5qEsky2yUcTQoNAPDcjyS/vguhoJ1jQ7h3
   QcxKKVxeRPwKQUimLIdn2JbOPSDjIdn8oYOL+N4KmLtKF+n9BdB36GStx
   yOYkO881s1J5u+wXKqO2PtpSgD/reuGbnXA0JSTc+qXCvrrrmM+vJHpS8
   g==;
X-CSE-ConnectionGUID: BdG3KrlCShqeGW3kAyrDOA==
X-CSE-MsgGUID: D3nbePB/Rvy+FwObVrqH4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87824856"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87824856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 14:13:18 -0700
X-CSE-ConnectionGUID: iKUHvIm6SP+rxOKc8IrzBA==
X-CSE-MsgGUID: dtBly2gsRsSfadBPJTzBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="296075717"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.63]) ([10.125.108.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 14:13:17 -0700
Message-ID: <81553384-2555-429e-8689-d6602b33c3d1@intel.com>
Date: Thu, 20 Aug 2026 14:13:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
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
 <20260804192958.1823952-2-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Move the low-level HDM decoder programming helpers from hdm.c into
> resource.c so they can be shared by later reset restore code.
> 
> Keep the existing decoder commit flow and register programming sequence
> unchanged. This patch is intended to be a mechanical move. Follow-on
> patches update the helper interface for reset restore.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig         |   4 ++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/core.h     |   2 +
>  drivers/cxl/core/hdm.c      | 124 +-------------------------------
>  drivers/cxl/core/resource.c | 138 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h           |  41 -----------
>  include/cxl/cxl.h           |  45 +++++++++++-
>  tools/testing/cxl/Kbuild    |   1 +
>  8 files changed, 191 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
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

Srirangan,
I have to apologize for yanking you around a bit here. Naming is hard. That config name still doesn't sit quite right with me as it causes confusion because there's hdm.o that's outside of it. What do you think of something like this for namings:
obj-$(CONFIG_CXL_RESET) += reset.o regs.o

> +	bool

I think with 'def_bool y', you can drop the select line earlier under CXL_BUS.

DJ

> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..0df4178bbbaa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(CONFIG_CXL_HDM) += resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 07555ae63859..cb6853a92a93 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -213,6 +213,8 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
> +void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
> +int cxld_await_commit(void __iomem *hdm, int id);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..6ae0b9f46ac0 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,10 +16,6 @@
>   * for enumerating these registers and capabilities.
>   */
>  
> -struct cxl_rwsem cxl_rwsem = {
> -	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> -	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
>  
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  {
> @@ -679,124 +675,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
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
> -{
> -	struct cxl_dport **t = &cxlsd->target[0];
> -	int ways = cxlsd->cxld.interleave_ways;
> -
> -	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> -	if (ways > 1)
> -		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> -	if (ways > 2)
> -		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> -	if (ways > 3)
> -		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> -	if (ways > 4)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> -	if (ways > 5)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> -	if (ways > 6)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> -	if (ways > 7)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> -}
> -
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
> @@ -835,7 +713,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  
>  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -		setup_hw_decoder(cxld, hdm);
> +		cxl_setup_hw_decoder(cxld, hdm);
>  
>  	rc = cxld_await_commit(hdm, cxld->id);
>  	if (rc) {
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> new file mode 100644
> index 000000000000..dd8bed3d3ff0
> --- /dev/null
> +++ b/drivers/cxl/core/resource.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
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
> +static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> +{
> +	struct cxl_dport **t = &cxlsd->target[0];
> +	int ways = cxlsd->cxld.interleave_ways;
> +
> +	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> +	if (ways > 1)
> +		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> +	if (ways > 2)
> +		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> +	if (ways > 3)
> +		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> +	if (ways > 4)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> +	if (ways > 5)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> +	if (ways > 6)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> +	if (ways > 7)
> +		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
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
> +EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
> +
> +void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
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
> +
> +EXPORT_SYMBOL_FOR_MODULES(cxl_setup_hw_decoder, "cxl_core");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..c795cce0fcbc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -264,49 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 016c74fb747c..05a8bc32138c 100644
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
> @@ -23,7 +25,48 @@ enum cxl_devtype {
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
> +	int id;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	unsigned long flags;
> +	struct cxl_region *region;
> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>  
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
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

