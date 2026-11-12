Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527373;
	b=T/V3hxdWy/g5j+v0GhQfeKhLFpIYuszrswXT62kX7+adazaCQ6+UbALm3MqZXvHf6/7Y
	 V3yFn4kMtyBiK6/Moqln0PZGdZma9pcxSWovPL4S7utUz7AAvOFw1eFI0fXm8HpP+D8UL
	 J9kS3RKsG9wqMTvjv0JYIq08PQxlXBmgqwHs3FqJkAM0vljOTMvv+3/EPy2ia99v9dm08
	 V0Pbq1XgI6CK4TT1naPsczG5U2q9n1BT9Sky23gXQmu62Sf84zQz2qIIOu/u99gWN6kKK
	 8WFK8UzeksOTmsPz5jXBOXrXuJZdg0UgvtKEECWkO4Lhw/cewRZyUdIm67wsiX5i0zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527373;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kCaNw5eRaBRwjcLXTE3JL4PVNoPNDMQQUQLGaZbHGXw=;
	b=H6GD7V3yA7k5zCVl5Ur4v5HIVWSExnBN6ZD8uKXd+V1+MTEv/ky0HHXG9ZOGQLFCP5KV
	 +g7kkyHSRdYkNbUlY/z2uvkrPjjx7xr3A+emZZt1OWl02vG8SbtW5mdsYiq9akUq1D5ZY
	 zqyjwr2SuZQdPrKRUozU8g0EQXuOg1kkNAwzoG6uWR6o8/oGsOf6QkJ9Tau5BfFXup8Po
	 tA+u2J5D9bzpPhA9+zSyDrcf2li3hCT81GttxG+mc2CUYG5SgFt7oeyMTvkdgGNchdXaz
	 obY5GIhxpzDTYffJPoTFptDZ5bgWdHF9RYHP4tK+skl88b2ibdaoybZvMmphdZDphXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KO94zEM4;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB70606A31C;
	Thu, 12 Nov 2026 23:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KO94zEM4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794527373; x=1826063373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LDTlgoTiXXPqULWE834iHtRR+DdZfRL5mgHiLZgHS7I=;
  b=KO94zEM4m22WKsa4oFwZTcslwg3eBxTwKT1ITmw2fPhUaDE5mSLD+zWI
   ujJKctErh8QxvrHrJp8xYFnFKaFG6avXKRn8HI3QsxIkDuoQBsnGae5aK
   SLzCoHuCeUjx5vyxLn1+mBMgmAagkMMJp0dD7Y+4UybvaByz0efMCkKSx
   H3YQHYQlLCDGqaTncmT+awChsfgG8YRfiOywE3FYTwVfc3kjmXSN/sC74
   fnw7a7o+VPK5I8QxlNU7AiyL1LzIWM+d1IBy0vyNweha1Ud2poOrujGK4
   e2GpR9RJ9XS1vnLpMpkx6XnalRI6I4lxHWsKO+oK3r7sqnjYOZYeSBoZO
   w==;
X-CSE-ConnectionGUID: Pfvhf3ZlRvyFBZnRxbA5Zg==
X-CSE-MsgGUID: y5KVO1I3RIeP7YemhVijgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3247782"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3247782"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:49:32 -0800
X-CSE-ConnectionGUID: u6GHNGKtRReKeINebfksyg==
X-CSE-MsgGUID: yItJD5dmQG6m6BtvGQiJ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8613663"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.111.216]) ([10.125.111.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:49:30 -0800
Message-ID: <bb459b23-0f26-4371-9228-9e69e061260d@intel.com>
Date: Thu, 12 Nov 2026 16:49:28 -0700
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
Subject: Re: [PATCH v17 08/19] cxl: Move cxl_rwsem into built-in code
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
 <20261105185917.2667656-9-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:59 AM, Srirangan Madhavan wrote:
> Keep the region and DPA locks available to built-in CXL state management
> when cxl_core is modular.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/Makefile    |  2 +-
>  drivers/cxl/core/hdm.c       |  5 -----
>  drivers/cxl/core/hdm_state.c | 15 +++++++++++++++
>  3 files changed, 16 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm_state.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 6703c1729396..9971efb237fb 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 5b5f5f22ea32..85f9abf58a42 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -17,11 +17,6 @@
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
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> new file mode 100644
> index 000000000000..c9cc019902ef
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/export.h>
> +#include <linux/rwsem.h>
> +
> +#include <cxl/hdm.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");

