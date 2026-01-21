Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606D4534AD;
	Wed, 21 Jan 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039957; cv=none; b=ijhA+qzi5R1UrXUKr9LqLUrBTNiGT2A/mnjZdy/vxGW6BmaUVQkEmKKmROiEmcq3gxRM+aIujPncenkwkn3d7rLnEFMDR1Tx+6qzvFH7KYfw7358eEip/9NsTU5l5hQY/A9iGabk9sS19CxbYMXC/g5ygfpy9N527oeWXHyTUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039957; c=relaxed/simple;
	bh=LqnEp1wtZlAaOjJu7IJmTVX15uAhqFsWciuIQziDmkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiTg1g4oQD12bCB+pCaUxaF0DYCyKtsDXb2V+Gb7KLe3pMQKvoKcCzl4UdenM2JQQ0PkRK41BX7NN3pjYkOWCuwrp71CLxcbOFKI28iRDaHiaic/tbxH4vfA+m0HOFd7VJ1aiEN+M7VSpRKQiNDUW7pKaYfKKaCt0SUxundIbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmILtSDz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmILtSDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769039954; x=1800575954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LqnEp1wtZlAaOjJu7IJmTVX15uAhqFsWciuIQziDmkc=;
  b=bmILtSDzkNeLe62HOWoxbpVJn5duXKFDnKQfYuWArUkeJb2geUmbBQfL
   QyFKFWFI8ExxN+ZNVhxj5Zm9u5IubalYmrmim808RqqjK12Ikz6DY9i3n
   4enk+sup40OkWtxZwAd4ADhrbo0+3csKPN9QWwd/H7FcZPIwyzDU6Fsm9
   75AT0jT7Byr5WwW1/C2nlwZNX8WRWqc65/H7Z3a8RBOKmUZbzc54AT26Q
   UW7HT8CCUjfJo4uVKTkneufqtoggjGm3LOnbLu+QzW2/9BfA0yX7JMHXz
   1QSBfWBUrPtJXp5VewiSy6vFKKm1EGfSpvXHAdsKJLCCG5831E6l31xzz
   Q==;
X-CSE-ConnectionGUID: PMk3TkV8SDGmbeipiGuz/Q==
X-CSE-MsgGUID: mB/czjwjRs6hivLu60bnGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70330818"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70330818"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 15:59:13 -0800
X-CSE-ConnectionGUID: XgWtVWhcROaI55FUX92vLQ==
X-CSE-MsgGUID: CHhFZhweSHqmPd+sQR7LTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211432001"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.97]) ([10.125.108.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 15:59:11 -0800
Message-ID: <8a252e91-3895-447d-b54c-9ce006595204@intel.com>
Date: Wed, 21 Jan 2026 16:59:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-8-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Flush host CPU caches for mapped HDM ranges after teardown and prepare
> sibling Type 2 functions on multi-function devices. The host cache
> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+
> invalidate on arm64 via memremap() and on_each_cpu(), matching the
> required ordering before reset.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/pci.c | 150 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 148 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e4134162e82a..f9cc452ccb8a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,10 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <linux/align.h>
> +#include <linux/cache.h>
> +#include <linux/cacheflush.h>
> +#include <linux/smp.h>
>  #include <cxl/mailbox.h>
>  #include <cxl/pci.h>
>  #include "cxlmem.h"
> @@ -1085,6 +1089,71 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
>  	return cxlds->type == CXL_DEVTYPE_DEVMEM;
>  }
> 
> +#ifdef CONFIG_ARM64

Please figure out some arch common way to do this. Really do not want CONFIG_$ARCH ifdefs sprinkled all over CXL code. Also this ARCH specific code probably does not belong under CXL anyhow.

DJ

> +struct cxl_cache_flush_ctx {
> +	void *va;
> +	size_t len;
> +};
> +
> +static void cxl_flush_by_va_local(void *info)
> +{
> +	struct cxl_cache_flush_ctx *ctx = info;
> +
> +	dcache_clean_inval_poc((unsigned long)ctx->va,
> +			       (unsigned long)ctx->va + ctx->len);
> +	asm volatile("dsb ish" ::: "memory");
> +}
> +#endif
> +
> +static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct resource *res;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	res = cxlr->params.res;
> +
> +#ifdef CONFIG_X86
> +	static bool flushed;
> +
> +	if (!flushed) {
> +		wbinvd_on_all_cpus();
> +		flushed = true;
> +	}
> +#elif defined(CONFIG_ARM64)
> +	void *va;
> +	size_t len, line_size = L1_CACHE_BYTES;
> +	phys_addr_t start, end, aligned_start, aligned_end;
> +	struct cxl_cache_flush_ctx flush_ctx;
> +
> +	start = res->start;
> +	end = res->end;
> +
> +	aligned_start = ALIGN_DOWN(start, line_size);
> +	aligned_end = ALIGN(end + 1, line_size);
> +	len = aligned_end - aligned_start;
> +
> +	va = memremap(aligned_start, len, MEMREMAP_WB);
> +	if (!va) {
> +		pr_warn("Failed to map region for cache flush\n");
> +		return 0;
> +	}
> +
> +	flush_ctx.va = va;
> +	flush_ctx.len = len;
> +	on_each_cpu(cxl_flush_by_va_local, &flush_ctx, 1);
> +
> +	memunmap(va);
> +#endif
> +	return 0;
> +}
> +
>  static int cxl_check_region_driver_bound(struct device *dev, void *data)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> @@ -1245,6 +1314,9 @@ static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
>  		return rc;
>  	}
> 
> +	device_for_each_child(&endpoint->dev, NULL,
> +			      cxl_region_flush_host_cpu_caches);
> +
>  	/* Keep cxl_region_rwsem held, released by cleanup function */
>  	return 0;
>  }
> @@ -1259,12 +1331,79 @@ static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
>  		up_write(&cxl_region_rwsem);
>  }
> 
> +static int cxl_reset_prepare_all_functions(struct pci_dev *pdev)
> +{
> +	struct pci_dev *func_dev;
> +	unsigned int devfn;
> +	int func, rc;
> +	struct pci_dev *prepared_funcs[8] = { NULL };
> +	int prepared_count = 0;
> +
> +	for (func = 0; func < 8; func++) {
> +		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
> +
> +		if (devfn == pdev->devfn)
> +			continue;
> +
> +		func_dev = pci_get_slot(pdev->bus, devfn);
> +		if (!func_dev)
> +			continue;
> +
> +		if (!cxl_is_type2_device(func_dev)) {
> +			pci_dev_put(func_dev);
> +			continue;
> +		}
> +
> +		rc = cxl_reset_prepare_memdev(func_dev);
> +		if (rc) {
> +			pci_dev_put(func_dev);
> +			goto cleanup_funcs;
> +		}
> +
> +		prepared_funcs[prepared_count++] = func_dev;
> +	}
> +
> +	return 0;
> +
> +cleanup_funcs:
> +	for (func = 0; func < prepared_count; func++) {
> +		if (prepared_funcs[func]) {
> +			cxl_reset_cleanup_memdev(prepared_funcs[func]);
> +			pci_dev_put(prepared_funcs[func]);
> +		}
> +	}
> +	return rc;
> +}
> +
> +static void cxl_reset_cleanup_all_functions(struct pci_dev *pdev)
> +{
> +	struct pci_dev *func_dev;
> +	unsigned int devfn;
> +	int func;
> +
> +	for (func = 0; func < 8; func++) {
> +		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
> +
> +		if (devfn == pdev->devfn)
> +			continue;
> +
> +		func_dev = pci_get_slot(pdev->bus, devfn);
> +		if (!func_dev)
> +			continue;
> +
> +		if (cxl_is_type2_device(func_dev))
> +			cxl_reset_cleanup_memdev(func_dev);
> +
> +		pci_dev_put(func_dev);
> +	}
> +}
> +
>  /**
>   * cxl_reset_prepare_device - Prepare CXL device for reset
>   * @pdev: PCI device being reset
>   *
>   * CXL-reset-specific preparation. Validates memory is offline, flushes
> - * device caches, and tears down regions.
> + * device caches, and tears down regions for device and siblings.
>   *
>   * Returns: 0 on success, -EBUSY if memory online, negative on error
>   */
> @@ -1283,6 +1422,12 @@ int cxl_reset_prepare_device(struct pci_dev *pdev)
>  		return rc;
>  	}
> 
> +	rc = cxl_reset_prepare_all_functions(pdev);
> +	if (rc) {
> +		cxl_reset_cleanup_memdev(pdev);
> +		return rc;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
> @@ -1291,10 +1436,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
>   * cxl_reset_cleanup_device - Cleanup after CXL reset
>   * @pdev: PCI device that was reset
>   *
> - * Releases region locks held during reset.
> + * Releases region locks for device and all sibling functions.
>   */
>  void cxl_reset_cleanup_device(struct pci_dev *pdev)
>  {
> +	cxl_reset_cleanup_all_functions(pdev);
>  	cxl_reset_cleanup_memdev(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
> --
> 2.34.1
> 

