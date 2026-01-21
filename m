Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE016332EB7;
	Wed, 21 Jan 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994414; cv=none; b=LRyhHIktDiG4nKc9qFEUc5QplfrbDIO0j9s4V1JVERCwOC3S2teEviihoPSseV6d59neqQ5eCM4yQca9X6fFVsweTL+5wVNIvRwxZuABzhyeIyUvSg0wxkdTwImAyGaK2ZMcEn3DyDSDuKQwQLPjGmVO5aNkup75iQGjSfren3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994414; c=relaxed/simple;
	bh=R3+USgyBM/rmVMHLbHOALUvlgSfDfE1wSRQ/35wMWW0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syOd1wyG4L8yGlViF8mGSo7iegdmHBq5+TbyLKGtpvhPvurJjQ2Z6mof1xyF8JyBUmHTHadg7edDzy9SMQbK730hneA1UqOCseV/4uWsZ/Oha+ItiJttY911T296OvH6M5orfIFbq6e/aTGgvjWVC6jzlmFVkSQ6H1PYMKEPiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx1tZ1YrLzHnHB7;
	Wed, 21 Jan 2026 19:19:34 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CB9AD40584;
	Wed, 21 Jan 2026 19:20:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 11:20:06 +0000
Date: Wed, 21 Jan 2026 11:20:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Message-ID: <20260121112005.00001e80@huawei.com>
In-Reply-To: <20260120222610.2227109-8-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:07 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Flush host CPU caches for mapped HDM ranges after teardown and prepare
> sibling Type 2 functions on multi-function devices. The host cache
> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+

That's not sufficient in general on arm64.  It might flush far enough
or there might be buffers beyond the point of coherence that are not
flushed.

Until there are clarifications from Arm we need something like the
agents in drivers/cache to do equivalent of wbinvd_on_all_cpus()
(be it on a PA range to making a tiny bit less horrible)

Or we need an opt in list for platforms where a flush to PoC is enough.

Needs to some sort of arch_ call as well, not hidden in the cxl driver.

I'd suggest a separate patch to add the necessary infrastructure for arm64
with the relevant maintainers and lists included.

It needs enough work to be something they'd consider that I haven't +CC them
on this version.

With that in mind I'll skip reviewing this patch for now.

Jonathan

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
> 

