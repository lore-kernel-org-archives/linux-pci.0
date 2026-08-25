Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A842882DE;
	Tue, 25 Aug 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689831; cv=none; b=p/W/84je7/wcE9/xXwnWkSgfaiS45MMFT+f/dNI+OhqYgNNv4aGsHxoExxntuuLH13QNg4xFxCyzMIRBJUyY3IuTmw67cMmsXjpptKZlUKB0w4ITT/LIwM5HugjB7pzY47+LMt2bis0GYgZH/1xlpew5lAzJy/LS/gHVfEgA2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689831; c=relaxed/simple;
	bh=K7nvKCXDpav/CxTlyXvfojH1thK8FF0VObGbU2Y6Ybc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUfNy9itV0dLNjaHa0TLsNcSHqILrTWH02m/w5XYd4jm//SpIQL3wJPkozn/AGQYNP8OeQz9uoTTXu/XFzUV1PnpY0J7vkwU+n6tiLUaDpUzCe5trRkyM2FooScO5lx0e6HhfRt+uxUsedXBr5jXKnJRwdOiddVdbFmyQmCLxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8TZOU9V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8TZOU9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787689829; x=1819225829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K7nvKCXDpav/CxTlyXvfojH1thK8FF0VObGbU2Y6Ybc=;
  b=i8TZOU9VGn9noAjEdNDYesGDXI/sTh2DTrPg2IMXj5x0ymZT8VPScMKz
   jxF8o6IyqGOYDZjlJCK1jilqV897Y0ZUXeRZ5J+X2W4yYcGo9zxtFWT9H
   fUVkvRfXLx6ZtancxNpNC3CSeMCBikKURVlCLTznbm/aVxngsJEpslE3Q
   J2Jlhq5FDJyh6HMu+On4pkRjxLZUjwtA6SkeiLbAVesnzqSexMtLs5GQ5
   x1TOFa14eptITAoM9hb7sdH+KXlJzuby19XqwrS7Up3DXcM9AIsoL34nx
   NQGwZkcSRn0lY6g7alc8i1UdirxxvSfLSBiT8BAfS/P5k5K+X0tX697Kz
   w==;
X-CSE-ConnectionGUID: 3+jxhJmXSqqq89Xy7QhdvQ==
X-CSE-MsgGUID: 4vEOOwdzQw+XQGgFeNl9Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="113702997"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="113702997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:30:28 -0700
X-CSE-ConnectionGUID: q8GnpRTWRAWqscwbVOrtmg==
X-CSE-MsgGUID: V4YOKuDpRgiOF/imJgQGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="271177222"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:30:27 -0700
Message-ID: <2b6302e6-18e6-42de-9489-014c4beb25c4@intel.com>
Date: Tue, 25 Aug 2026 13:30:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/12] cxl: Validate HDM ranges before CXL reset
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
 <20260804192958.1823952-8-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
> 
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue
> after the range reservation succeeds.
> 
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 250 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 249 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index c10e84b240a0..6d4528f77c53 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -10,6 +10,8 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -501,6 +503,224 @@ static const u32 cxl_reset_timeout_ms[] = {
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

Maybe more clear if using
	if (range_len(hpa_range) == 0)
> +		return -EINVAL;
> +
> +	list_for_each_entry(range, &ctx->ranges, list)
> +		if (range->hpa_range.start == hpa_range->start &&
> +		    range->hpa_range.end == hpa_range->end)

I think range_contains() would work here?

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
> +	struct cxl_hdm_info *info;
> +	int rc;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
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
> +	if (hpa_range->end < hpa_range->start)
> +		return -EINVAL;
> +
> +	if (hpa_range->start > RESOURCE_SIZE_MAX ||
> +	    hpa_range->end > RESOURCE_SIZE_MAX) {

Given that above you established that (end >= start) couple lines above, you really only need to test end here.

> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	*len = range_len(hpa_range);
> +	if (!*len || *len > RESOURCE_SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (*len > SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	return 0;
> +}

This function is doing too much. I suggest you rename it cxl_hdm_range_validate() and drop the *len parameter. And just assign len from range_len(hpa_range) once it's validated. I'll paste a diff at the end as a suggestion.

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
>  static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
>  {
>  	int dvsec, rc;
> @@ -534,6 +754,20 @@ static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
>  	return dvsec;
>  }
>  
> +static bool cxl_reset_hdm_available(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	/*
> +	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
> +	 * reset-method probes and reset requests can test availability without
> +	 * a CXL driver bound to the device.
> +	 */
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	return info && info->hdm_size;
> +}
> +
>  #define CXL_RESET_CTRL2_CMD_MASK \
>  	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>  
> @@ -736,7 +970,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec;
> +	int rc;
>  	u16 cap;
>  
>  	dvsec = cxl_reset_dvsec(pdev, &cap);
> @@ -746,5 +982,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	return cxl_reset_execute(pdev, dvsec, cap);
> +	if (!cxl_reset_hdm_available(pdev))
> +		return -ENOTTY;
> +
> +	cxl_hdm_range_context_init(&range_ctx);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (!rc)
> +			rc = cxl_reset_execute(pdev, dvsec, cap);
> +		cxl_hdm_range_context_destroy(&range_ctx);
> +	}
> +
> +	return rc;
>  }

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index a05e1fc80430..e398ce73608c 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -800,6 +800,7 @@ struct cxl_hdm_range {
 	struct list_head list;
 	struct pci_dev *pdev;
 	struct range hpa_range;
+	u64 len;
 	struct resource *res;
 };
 
@@ -870,13 +871,55 @@ static void cxl_hdm_range_context_destroy(struct cxl_hdm_range_context *ctx)
 	}
 }
 
+/*
+ * Bound the range twice: request_mem_region() takes resource_size_t while
+ * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
+ * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT.  range_len() can also reach
+ * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
+ * resource_size_t is 64-bit, which the !len test catches.
+ */
+static int cxl_hdm_range_validate(struct pci_dev *pdev,
+				  const struct range *hpa_range)
+{
+	u64 len;
+
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	if (hpa_range->end > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	len = range_len(hpa_range);
+	if (!len || len > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (len > SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	return 0;
+}
+
 static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
 			     struct pci_dev *pdev, const struct range *hpa_range)
 {
 	struct cxl_hdm_range *range;
+	int rc;
 
-	if (hpa_range->end < hpa_range->start)
-		return -EINVAL;
+	rc = cxl_hdm_range_validate(pdev, hpa_range);
+	if (rc)
+		return rc;
 
 	list_for_each_entry(range, &ctx->ranges, list)
 		if (range->hpa_range.start == hpa_range->start &&
@@ -889,6 +932,7 @@ static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
 
 	range->pdev = pdev;
 	range->hpa_range = *hpa_range;
+	range->len = range_len(hpa_range);
 	list_add_tail(&range->list, &ctx->ranges);
 
 	return 0;
@@ -927,50 +971,13 @@ static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
 	return 0;
 }
 
-static int cxl_hdm_range_len(struct pci_dev *pdev,
-			     const struct range *hpa_range, u64 *len)
-{
-	if (hpa_range->end < hpa_range->start)
-		return -EINVAL;
-
-	if (hpa_range->start > RESOURCE_SIZE_MAX ||
-	    hpa_range->end > RESOURCE_SIZE_MAX) {
-		pci_err(pdev,
-			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
-			hpa_range->start, hpa_range->end);
-		return -EOVERFLOW;
-	}
-
-	*len = range_len(hpa_range);
-	if (!*len || *len > RESOURCE_SIZE_MAX) {
-		pci_err(pdev,
-			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
-			hpa_range->start, hpa_range->end);
-		return -EOVERFLOW;
-	}
-
-	if (*len > SIZE_MAX) {
-		pci_err(pdev,
-			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
-			hpa_range->start, hpa_range->end);
-		return -EOVERFLOW;
-	}
-
-	return 0;
-}
-
 static int cxl_hdm_range_request(struct cxl_hdm_range *range)
 {
 	struct pci_dev *pdev = range->pdev;
 	const struct range *hpa_range = &range->hpa_range;
-	u64 len;
-	int rc;
 
-	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
-	if (rc)
-		return rc;
-
-	range->res = request_mem_region(hpa_range->start, len, "cxl_reset");
+	range->res = request_mem_region(hpa_range->start, range->len,
+					"cxl_reset");
 	if (!range->res) {
 		pci_err(pdev,
 			"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
@@ -1001,14 +1008,9 @@ static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
 {
 	struct pci_dev *pdev = range->pdev;
 	const struct range *hpa_range = &range->hpa_range;
-	u64 len;
 	int rc;
 
-	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
-	if (rc)
-		return rc;
-
-	rc = cpu_cache_invalidate_memregion(hpa_range->start, len);
+	rc = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
 	if (rc)
 		pci_err(pdev,
 			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
-- 
2.54.0


