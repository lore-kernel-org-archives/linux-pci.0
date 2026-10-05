Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14A419FDA;
	Mon,  5 Oct 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236547; cv=none; b=QYd8lrb2TD9V+Iem6ca4dIUbwgJKLs/Nv93Rqz50pET2i1WIUW+ilCDbtH5va1bDDFr1chh8jTil9ox0zarcPvH5RE2vOt9Icnr3r4FvUJKyAtbtibvIU1XdIKcYXWad1dg3eCcWP/TWi/iSYSYRcvQk4Giq8AMDwBjH+45SXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236547; c=relaxed/simple;
	bh=TJGYwwxs1o+Ljf1Rslw7l/MAKRm7QDSew5GqbuJ8Ilw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grlA5P+0feNDefpq9fBd4W0tV4YA5tLtVbdwUOQPtJSenL2uAvKGx+TkaK/YekUmI4yTrgR5aZ1i+xR1l7qBOaldLs886ayfHKOJB296OeyRNYz5aUtoHKOGAssunLk8ncV4qtwfxAiJ4/evefbwCPsrvUR3Hh1JZUlQ+p74FFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2SEv17h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2SEv17h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791236546; x=1822772546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TJGYwwxs1o+Ljf1Rslw7l/MAKRm7QDSew5GqbuJ8Ilw=;
  b=l2SEv17h6IFnCQ9xZ8avTUH/oyxc+yZpPY1Bj8/kX7P/lH6rBiT9HTi/
   t5NIwAM+gwpsslK9Bqfq22zOVcqxWIhzNWUqcFvVLYyd4iED3HCLM1NzZ
   kWfGfN6BN4ptXVIkxEcROPWHo9hvHMOp9Z5y2pGs9LCOSM4QjqKmSS8L5
   91b+BS0cgLegNNIwDjmfBFmlywkb5gbm2KYbZadyKRfML54AoXP3MXlHa
   Ks4rXvGneXiSJoDw2iMfFWvFFE7l65mGGfVRTEENpbT4OnVDpZTH8xa8Q
   D2oDUS5k44IDAPTzNYfIz9SOkjzBbj7h+Z3O8OZeqhzow6duO9Nnv4OeF
   Q==;
X-CSE-ConnectionGUID: FAIZHsPpSbOFqiXpj3PlOQ==
X-CSE-MsgGUID: j3AN6WOqR6KpoekKReartg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91054671"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91054671"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 14:42:25 -0700
X-CSE-ConnectionGUID: kJce0kABTfGHogVUGQrWOA==
X-CSE-MsgGUID: 1c+57GCoRGiyp3/K5tjNag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="304870582"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.108.109]) ([10.125.108.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 14:42:23 -0700
Message-ID: <e55268cc-5b70-4109-b7b4-bbbaca7b13ea@intel.com>
Date: Mon, 5 Oct 2026 14:42:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/16] cxl: Move HDM decoder helpers to built-in
 resource code
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
 <20261001092227.3004747-7-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001092227.3004747-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> Move the refactored HDM programming helpers and cxl_rwsem from hdm.c to
> resource.c. Build resource.o under CONFIG_CXL_RESET so the helpers are
> available to built-in PCI code when CXL_BUS is modular. Export only the
> symbols used by cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig         |   4 ++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/hdm.c      |  93 -------------------------------
>  drivers/cxl/core/resource.c | 106 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 93 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..0cd704670735 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select CXL_RESET
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>  	select FWCTL if CXL_FEATURES
>  	help
> @@ -244,3 +245,6 @@ config CXL_ATL
>  	depends on ACPI_PRMT && AMD_NB
>  
>  endif
> +
> +config CXL_RESET
> +	bool

Can you add a comment here for this and say something like CXL_RESET can't be 'n' when CXL_BUS is active? There are things that should always build in resource.o and later regs.o that will be under the CXL_RESET symbol with this series.

DJ

> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..30470799e059 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(CONFIG_CXL_RESET) += resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3f21dfda146..629e3420ad0b 100644
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
> @@ -707,35 +702,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
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
> -static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -758,65 +724,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
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
> -static void setup_hw_decoder(void __iomem *hdm,
> -			     struct cxl_decoder_settings *settings)
> -{
> -	struct cxl_decoder_config *config = &settings->config;
> -	int id = config->id;
> -	u64 target_or_skip_reg_val;
> -	u64 base, size;
> -	u32 ctrl;
> -
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -	cxld_set_interleave(config, &ctrl);
> -	cxld_set_type(config, &ctrl);
> -	base = config->hpa_range.start;
> -	size = range_len(&config->hpa_range);
> -	target_or_skip_reg_val = settings->target_or_skip_reg_val;
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -	/* Target-list and endpoint-skip registers alias the same slot. */
> -	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> -	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> -
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
> -void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
> -{
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	setup_hw_decoder(hdm, settings);
> -}
> -
>  /*
>   * Endpoint skip and switch targets have different owners. Keep that state with
>   * its owning type and flatten it only into a transient register-programming
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> new file mode 100644
> index 000000000000..ff027cb89e57
> --- /dev/null
> +++ b/drivers/cxl/core/resource.c
> @@ -0,0 +1,106 @@
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
> +static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
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
> +static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
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
> +static void setup_hw_decoder(void __iomem *hdm,
> +			     struct cxl_decoder_settings *settings)
> +{
> +	struct cxl_decoder_config *config = &settings->config;
> +	int id = config->id;
> +	u64 target_or_skip_reg_val;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
> +	base = config->hpa_range.start;
> +	size = range_len(&config->hpa_range);
> +	target_or_skip_reg_val = settings->target_or_skip_reg_val;
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	/* Target-list and endpoint-skip registers alias the same slot. */
> +	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	setup_hw_decoder(hdm, settings);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");

