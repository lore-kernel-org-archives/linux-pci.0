Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC493090D5;
	Tue,  2 Jun 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432585; cv=none; b=uIhUPPjFcssncZO2uITB0cKTR3E6/P4c+16Vk9Aa6QmeBL+XJBW3vjjRdIdOlN7q1xzG1h5/tgHhwjy/Lh5iSV/3Njyy1cZKpV7/AkQqEG23j4I8LCgiiaT1+5NjDbTj1kgE4lAmIIDsaIgexysPX3gP8TR1ccSr3kbcxCGq+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432585; c=relaxed/simple;
	bh=j3+sVtrdrI/pmP8e4OQXVP+fBjUKXxX3Y/ZD27iQwHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdNCfr70SkrJT3TP9JN7GivbNJNsE+HOnp198si/vK/snT8/5rUhdiwdfk4Biw2FLJkbnd5ADXxpeLH1s0BMJ3SAj51uD3zWVAbrGeecjF3xVguh1VA7lkAJwjeav0I83q1Io9DtJ00hRzp4aKVCozCrl6PUXuDsFdrDwcOE6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLAN4dc5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLAN4dc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780432583; x=1811968583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j3+sVtrdrI/pmP8e4OQXVP+fBjUKXxX3Y/ZD27iQwHA=;
  b=JLAN4dc5fg7Cjh/zUKDb9dPaV2gFnYLReVOy/FBwU7nxczy2vPLJWqHg
   GbJxwEPMYIPOoDV3AbARcun1SOuonkfDNSaHgXqzo2mhWFS290KDXhaPX
   cCrQgg6Uvl+niKD2GIf04F8KISvCYMKTEsUllvkzI2pB+KaDlVxOEF9u1
   iNUfPSyG8EtsNHFxp3m7B0WSCvAOI2MLDuoeXTKy9TDOH5rXz2XcjMy1g
   8SjTr6N7AuXhj5S+ZAWlJRwSGMq3PhYPGEQ5KhVmqrs3lEG1FHHN8Bcrg
   cTSLSm/MiN0OXBIumsfVOxAAY31wiYR1m7xIHxyrX2noqWpuDx43aVj07
   A==;
X-CSE-ConnectionGUID: QyYfZdyGTU+yINkgLfprqg==
X-CSE-MsgGUID: GE9f+4vcQoqrzS/0IVgRtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91805679"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91805679"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:36:23 -0700
X-CSE-ConnectionGUID: gF4z35ffSWqDi7GwSfbr7g==
X-CSE-MsgGUID: KKIdP70+SsakD2zS1pR/iQ==
X-ExtLoop1: 1
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:36:21 -0700
Message-ID: <a076968e-7df9-493f-918a-9822e83700ea@intel.com>
Date: Tue, 2 Jun 2026 13:36:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] cxl: Add reset-idle and cache flush helpers
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-4-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Add helpers to collect the CXL regions affected by a memdev reset,
> verify that those regions are idle, and invalidate CPU caches for the
> affected address ranges before reset.
> 
> A memdev can participate in an interleaved region through multiple
> endpoint decoders. Track affected regions in a temporary xarray so each
> region is checked and cache-invalidated once per reset operation.
> 
> These helpers prepare the CXL.mem data path for reset. The actual reset
> orchestration and decoder restore flow are added separately.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..318744695f62 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,9 +4,11 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/xarray.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +928,171 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static int cxl_reset_system_ram_found(struct resource *res, void *data)
> +{
> +	return 1;
> +}

Reuse core/region.c:is_system_ram()?

DJ

> +
> +struct cxl_reset_region_context {
> +	struct xarray regions;
> +};
> +
> +static void __maybe_unused
> +cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
> +{
> +	xa_init(&ctx->regions);
> +}
> +
> +static void __maybe_unused
> +cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
> +{
> +	xa_destroy(&ctx->regions);
> +}
> +
> +static int cxl_reset_add_region(struct cxl_reset_region_context *ctx,
> +				struct cxl_region *cxlr)
> +{
> +	int rc;
> +
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	rc = xa_insert(&ctx->regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);
> +
> +	/* A region may be referenced by multiple affected endpoint decoders. */
> +	return rc == -EBUSY ? 0 : rc;
> +}
> +
> +static int cxl_reset_collect_region(struct device *dev, void *data)
> +{
> +	struct cxl_reset_region_context *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	return cxl_reset_add_region(ctx, cxled->cxld.region);
> +}
> +
> +static int __maybe_unused
> +cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
> +				 struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd || !cxlmd->cxlds)
> +		return -ENODEV;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		return 0;
> +
> +	return device_for_each_child(&endpoint->dev, ctx,
> +				     cxl_reset_collect_region);
> +}
> +
> +static bool cxl_reset_region_has_system_ram(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	if (!p->res)
> +		return false;
> +
> +	rc = walk_iomem_res_desc(IORES_DESC_NONE,
> +				 IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				 p->res->start, p->res->end, NULL,
> +				 cxl_reset_system_ram_found);
> +
> +	return rc > 0;
> +}
> +
> +static int cxl_reset_validate_region_idle(struct cxl_region *cxlr)
> +{
> +	struct resource *res = cxlr->params.res;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (cxl_reset_region_has_system_ram(cxlr)) {
> +		dev_err(&cxlr->dev,
> +			"Cannot reset while CXL memory is online as System RAM [%pr]\n",
> +			res);
> +		return -EBUSY;
> +	}
> +
> +	if (!device_trylock(&cxlr->dev))
> +		return -EAGAIN;
> +
> +	if (cxlr->dev.driver) {
> +		dev_err(&cxlr->dev,
> +			"Cannot reset while CXL region has an active driver\n");
> +		rc = -EBUSY;
> +	}
> +
> +	device_unlock(&cxlr->dev);
> +	return rc;
> +}
> +
> +static int __maybe_unused
> +cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
> +{
> +	struct cxl_region *cxlr;
> +	unsigned long index;
> +	int rc;
> +
> +	xa_for_each(&ctx->regions, index, cxlr) {
> +		rc = cxl_reset_validate_region_idle(cxlr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
> +{
> +	struct resource *res = cxlr->params.res;
> +	int rc;
> +
> +	if (!res)
> +		return 0;
> +
> +	rc = cpu_cache_invalidate_memregion(res->start, resource_size(res));
> +	if (rc)
> +		dev_err(&cxlr->dev, "Failed to invalidate CPU cache [%pr]: %d\n",
> +			res, rc);
> +
> +	return rc;
> +}
> +
> +static int __maybe_unused
> +cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
> +{
> +	struct cxl_region *cxlr;
> +	unsigned long index;
> +	int rc;
> +
> +	if (xa_empty(&ctx->regions))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +			pr_info_once(
> +				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> +			return 0;
> +		}
> +		pr_warn("Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
> +	}
> +
> +	xa_for_each(&ctx->regions, index, cxlr) {
> +		rc = cxl_reset_flush_region_cache(cxlr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

