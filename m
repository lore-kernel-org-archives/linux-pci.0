Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76A324B31;
	Mon,  9 Mar 2026 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097280; cv=none; b=gnygVXme5rbK4+fSq+wJ7X/UpYNTDVbR2iaX1s4jGO+4+WV2IT+y3Zxuy08mHx3ecdkNMSDnTYdjAqfXRGCRgp9X9zwcLYAqrQUnTFwQmc3xKD0yQKRVGbRj27yYdCFgbEMMGmxqt74XTt9x+uvj8ZaRW1W7WZrgRyfk27NtXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097280; c=relaxed/simple;
	bh=QVCqYgorRc+eOnixSmTBz5Y9UNLl1SzGj9L/GKqbqtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgSld1upKz9lRRoSydk1tIqFbrtHQaOaTKn9V2/HCYWhM2TQxf8wvtH69zHmsO1zanhUHUwqEsvrjtzJxmKT2yBAzUr9kPCPX+LAZzi/Jz/ybcdN/Mp8okxksB5zlJq1WbYH4HrpNc73XfIGiSwy4CFPqkcJkJQrSwl0wTZq78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqaEqxUU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqaEqxUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773097279; x=1804633279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVCqYgorRc+eOnixSmTBz5Y9UNLl1SzGj9L/GKqbqtU=;
  b=TqaEqxUUXvvVvef3812/1Y8fMWHd8vUddti/q4gDyAy68/5dfloD9FdC
   PdwqJ+qaGZRbiyi0UamGwkuKIjSwfSX7wrMrJ7ck/b0+2URUSVAfnXonx
   L1mDsk2cX+IMRPv1PYLI7XxGvfkX1ERGMxupAXyM2r8Mjq8G06Um/D6CD
   xKUbAQPVbeFDujlXRAdRnk/kLL5b1W57ypjJcdZrtKbagC6yfDoIMx5Nk
   f7N8Jd58V30iWbrWcrO3Fh0CFz8vZQMtqH2PuKpS1tDdPG+XIoElcNzYt
   qjhZAVzEk8bncO3daDSRThqywliEwMhQYIgw4MlGFRuLlQkGHW/m0PSDh
   w==;
X-CSE-ConnectionGUID: fAdlOsxvT6+TipYTcWjNZw==
X-CSE-MsgGUID: /s3rpNnmSYCodHjSI+u/WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73834736"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73834736"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:01:18 -0700
X-CSE-ConnectionGUID: F9gWGLFHTcyLogPZwfFzlQ==
X-CSE-MsgGUID: orqJx6kuRTuYchWStN1ZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="257827687"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:01:17 -0700
Message-ID: <506cd1e6-f79a-44f4-b959-aa1df0a3ec5e@intel.com>
Date: Mon, 9 Mar 2026 16:01:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl: Add memory offlining and cache flush helpers
To: smadhavan@nvidia.com, bhelgaas@google.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net
Cc: alwilliamson@nvidia.com, jeshuas@nvidia.com, vsethi@nvidia.com,
 skancherla@nvidia.com, vaslot@nvidia.com, sdonthineni@nvidia.com,
 mhonap@nvidia.com, vidyas@nvidia.com, jan@nvidia.com, mochs@nvidia.com,
 dschumacher@nvidia.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-4-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306092322.148765-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 2:23 AM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add infrastructure for quiescing the CXL data path before reset:
> 
> - Memory offlining: check if CXL-backed memory is online and offline
>   it via offline_and_remove_memory() before reset, per CXL
>   spec requirement to quiesce all CXL.mem transactions before issuing
>   CXL Reset.
> - CPU cache flush: invalidate cache lines before reset
>   as a safety measure after memory offline.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 110 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f96ce884a213..9e6f0c4b3cb6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,6 +4,8 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/memory_hotplug.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> @@ -869,3 +871,111 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
> 
>  	return ctx.count;
>  }
> +
> +/*
> + * CXL Reset support - core-provided reset logic for CXL devices.
> + *
> + * These functions implement the CXL reset sequence.
> + */
> +
> +/*
> + * If CXL memory backed by this decoder is online as System RAM, offline
> + * and remove it per CXL spec requirements before issuing CXL Reset.
> + * Returns 0 if memory was not online or was successfully offlined.
> + */
> +static int __maybe_unused cxl_offline_memory(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	struct cxl_region_params *p;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +	if (!cxlr)
> +		return 0;
> +
> +	p = &cxlr->params;
> +	if (!p->res)
> +		return 0;
> +
> +	if (walk_iomem_res_desc(IORES_DESC_NONE,
> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				p->res->start, p->res->end, NULL, NULL) <= 0)

This function is performed per endpoint. So if a region is backed by multiple endpoints, wouldn't this memory offline operation be performed over the same region on every related endpoint instead of just once? Maybe a temp xarray during the reset process that keeps track of the regions that are being hit with reset?

> +		return 0;
> +
> +	dev_info(dev, "Offlining CXL memory [%pr] for reset\n", p->res);
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	rc = offline_and_remove_memory(p->res->start, resource_size(p->res));
> +	if (rc) {
> +		dev_err(dev,
> +			"Failed to offline CXL memory [%pr]: %d\n",
> +			p->res, rc);
> +		return rc;
> +	}
> +#else
> +	dev_err(dev, "Memory hotremove not supported, cannot offline CXL memory\n");
> +	rc = -EOPNOTSUPP;
> +	return rc;
> +#endif

Same comment as Alex. ifdef in C files are not preferred. Maybe a helper function can be used and stubbed out when !CONFIG_MEMORY_HOTREMOVE.

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cxl_reset_prepare_memdev(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	struct device *dev;
> +
> +	if (!cxlmd || !cxlmd->cxlds)
> +		return -ENODEV;
> +
> +	dev = cxlmd->cxlds->dev;
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		return 0;
> +
> +	return device_for_each_child(&endpoint->dev, NULL,
> +				      cxl_offline_memory);
> +}
> +
> +static int __maybe_unused cxl_decoder_flush_cache(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	res = cxlr->params.res;
> +	cpu_cache_invalidate_memregion(res->start, resource_size(res));

Same comment as offline memory. Cache being invalidated per region for every decoder. Probably not something you want to do.

DJ

> +	return 0;
> +}
> +
> +static int __maybe_unused cxl_reset_flush_cpu_caches(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd)
> +		return 0;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint || IS_ERR(endpoint))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return 0;
> +
> +	device_for_each_child(&endpoint->dev, NULL, cxl_decoder_flush_cache);
> +	return 0;
> +}
> --
> 2.43.0
> 

