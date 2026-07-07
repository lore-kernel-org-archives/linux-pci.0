Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4E389DE8;
	Tue,  7 Jul 2026 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460053; cv=none; b=jvyp3BVyKe92mW2zR4kTPDv3a7n67v88Z5XedCe/qEo3Vh/luYtSwefdndEheLAHKY+pqlGKnZyztWivXcPxpgsvv6hbrEGANOffmDzbRYAIhRsOkRjzxVPUo8Jct5hYt4cQBGD16JPnyNr/koV05IzTjYOT+whJ7S7znWMFAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460053; c=relaxed/simple;
	bh=HSaNuRyxV/OdOKxklzm9ZR1HPrQs4pu6Fg900PDRckM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T37CjnMpy7sefxgIpuWDSl2TCkDTfTH+PaY2ZTD78E+SRaXXd1vRsfOWHzZQAtiinZ2Z+Ds4+Yez49oPqeShTX9fCD4qL4u7Rav/4JJNCwcwYAEcuHP5uzj1aVT4rxLTfA/MZUlumODLAz1/sNs0ZF8SwaCX9l8MDUSbwUkpM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ55Yox0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ55Yox0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783460051; x=1814996051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HSaNuRyxV/OdOKxklzm9ZR1HPrQs4pu6Fg900PDRckM=;
  b=HZ55Yox0OWCqRVgUhwnASN2a54fsWssHPg11L1FwNvtZoQ/WOe/CmAPR
   NNwSmJi89B5/dHWr/nKkscQYMFImUWUyEIOctmR02SFus9bZQUN+EW4Aq
   l3ujTvIgPTNMB6GIFwtl42Lg1YNQtCzDjwzioWXc1Lzk9s1Qj4NDD1YC4
   1197y8V68pvPr4ezWiFalYiRzAAm8J48YRDNVHUJvxpBdd8SVbPyL9nvq
   3EnM74DpF2TPgQWjNBmQ1/BUpXmWOGk3CCuhDrZ6ecBEbCfFX0Rovtaau
   uJsL7glqdPpPFllf7suZldzDnA8z3nRQcCD6s9PKiu3EAxp01J8p71Id9
   w==;
X-CSE-ConnectionGUID: 4U3XhOKQQI215dTz/TuqMQ==
X-CSE-MsgGUID: QalCNkf7RT6SZ4ZLUJUdfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83231047"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83231047"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 14:34:10 -0700
X-CSE-ConnectionGUID: 2rBpFuWbQNyKsf8njnYlSQ==
X-CSE-MsgGUID: V1Ts+ja2Q16Xh9Ga33/6aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253608838"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 14:34:07 -0700
Message-ID: <a3213139-f91e-4aae-a25c-1f424c89d2c2@intel.com>
Date: Tue, 7 Jul 2026 14:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] cxl: Validate HDM ranges before CXL reset
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
 <20260703220508.546528-7-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:05 PM, Srirangan Madhavan wrote:
> Before reset, collect enabled cached HDM decoder ranges and reserve them
> with request_mem_region(). This rejects reset while affected CXL memory is
> busy and keeps the validation stable through reset.
> 
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue after
> the range reservation succeeds.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/reset.c | 240 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 239 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 7a9b1ecfadcf..fb741b66e502 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -10,6 +10,8 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -467,6 +469,231 @@ static const u32 cxl_reset_timeout_ms[] = {
>  #define CXL_CACHE_WBI_TIMEOUT_US 100000
>  #define CXL_CACHE_WBI_POLL_US 100
>  
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +	struct range hpa_range;
> +	struct resource *res;
> +};
> +
> +struct cxl_hdm_range_context {
> +	struct list_head ranges;
> +};
> +
> +static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
> +{
> +	INIT_LIST_HEAD(&ctx->ranges);
> +}
> +
> +static void cxl_hdm_range_context_destroy(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range, *next;
> +
> +	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
> +		list_del(&range->list);
> +		if (range->res)
> +			release_mem_region(range->hpa_range.start,
> +					   resource_size(range->res));
> +		kfree(range);
> +	}
> +}
> +
> +static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
> +			     struct pci_dev *pdev, const struct range *hpa_range)
> +{
> +	struct cxl_hdm_range *range;
> +
> +	if (hpa_range->end < hpa_range->start)
> +		return -EINVAL;
> +
> +	list_for_each_entry(range, &ctx->ranges, list)
> +		if (range->hpa_range.start == hpa_range->start &&
> +		    range->hpa_range.end == hpa_range->end)
> +			return 0;
> +
> +	range = kzalloc_obj(*range);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	range->pdev = pdev;
> +	range->hpa_range = *hpa_range;
> +	list_add_tail(&range->list, &ctx->ranges);
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
> +	int rc;
> +
> +	if (!info) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		struct cxl_decoder_settings *settings = &info->settings[i];
> +
> +		if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +			continue;
> +
> +		if (settings->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +			pci_err(pdev,
> +				"CXL reset does not support normalized address decoders\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		rc = cxl_hdm_range_add(ctx, pdev, &settings->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_len(struct pci_dev *pdev,
> +			     const struct range *hpa_range, u64 *len)
> +{
> +	if (sizeof(resource_size_t) < sizeof(hpa_range->start) &&
> +	    (hpa_range->start > (resource_size_t)~0ULL ||
> +	     hpa_range->end > (resource_size_t)~0ULL)) {

I'm seeing U64_MAX and ~0ULL being use interchangeably, even in the same function. Maybe just stick with just U64_MAX?

> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (hpa_range->end < hpa_range->start)
> +		return -EINVAL;
> +
> +	if (!hpa_range->start && hpa_range->end == U64_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}

if (range_len(&hpa_range) == 0) does the same thing right?

> +
> +	*len = range_len(hpa_range);
> +	if (sizeof(resource_size_t) < sizeof(*len) &&
> +	    *len > (resource_size_t)~0ULL) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (sizeof(size_t) < sizeof(*len) && *len > SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	return 0;
> +}

Just a stray comment. The excessive type size checking in this function, is there an expectation that we are running this code on a 32bit host?

> +
> +static int cxl_hdm_range_request(struct cxl_hdm_range *range)
> +{
> +	struct pci_dev *pdev = range->pdev;
> +	const struct range *hpa_range = &range->hpa_range;
> +	u64 len;
> +	int rc;
> +
> +	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
> +	if (rc)
> +		return rc;
> +
> +	range->res = request_mem_region(hpa_range->start, len, "cxl_reset");

Is the request_mem_range() the gate against the CXL ranges being actively used by the kernel?

DJ

> +	if (!range->res) {
> +		pci_err(pdev,
> +			"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		rc = cxl_hdm_range_request(range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
> +{
> +	struct pci_dev *pdev = range->pdev;
> +	const struct range *hpa_range = &range->hpa_range;
> +	u64 len;
> +	int rc;
> +
> +	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
> +	if (rc)
> +		return rc;
> +
> +	rc = cpu_cache_invalidate_memregion(hpa_range->start, len);
> +	if (rc)
> +		pci_err(pdev,
> +			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
> +			hpa_range->start, hpa_range->end, rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
> +					   struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	if (list_empty(&ctx->ranges))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		pci_warn(pdev,
> +			 "CPU cache synchronization unavailable; continuing without cache invalidation\n");
> +		return 0;
> +	}
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		rc = cxl_hdm_range_flush_cache(range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	rc = cxl_hdm_ranges_collect(ctx, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(ctx);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_flush_cpu_caches(ctx, pdev);
> +}
> +
>  static int cxl_reset_dvsec(struct pci_dev *pdev)
>  {
>  	int dvsec, rc;
> @@ -662,7 +889,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec;
> +	int rc;
>  
>  	dvsec = cxl_reset_dvsec(pdev);
>  	if (dvsec < 0)
> @@ -671,5 +900,14 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	return cxl_reset_execute(pdev, dvsec);
> +	cxl_hdm_range_context_init(&range_ctx);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (!rc)
> +			rc = cxl_reset_execute(pdev, dvsec);
> +	}
> +
> +	cxl_hdm_range_context_destroy(&range_ctx);
> +	return rc;
>  }

