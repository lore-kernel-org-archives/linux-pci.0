Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840274A0126;
	Tue,  6 Oct 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303238; cv=none; b=rQxS59RBXaBDUDQyEEWi275NkWFDr9t6snPeiiWWljwN6vsO5G7a59bLxWZgWy82q3fs9IZQNMj1XjwqtB76ywdWOg8Cd3+uCSHkERJNd9tJt4TwuvqtnkPdpG8PSgnd63XCF6e+i7cpGAaWl//4y8H+jFYlB0VD8NYloV0hU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303238; c=relaxed/simple;
	bh=ZYIXDLW4Ra+PX0mYATIt872O2Qb5mougQ5QLOr46I/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF5Fj/zEDxxStdlO1NYAn7sHbilqSlt5AypWKTqz32eYmW9sYvlkyY6LH+lRbQpQ9Jv/w8W8j/6f398AyRv/fTjECYQPv++/zk+LKXUz5o5cuYbvsLauve/NYvbSkKNpN0K4V7XKiMEz73nor7ikmB/nZJ9MzRez0gKJWR49hS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7cWSmNP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7cWSmNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791303237; x=1822839237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZYIXDLW4Ra+PX0mYATIt872O2Qb5mougQ5QLOr46I/o=;
  b=l7cWSmNPD9AqDJQhdn88XKcObsnJ1UD1tZ+JbqAA2GZcmfK6sDFe/lQo
   icLgXDcfBjxmgmZRF1lsw531iDyQF7yRdMKmLQcowt0zzB1EfN2ui6mgn
   TojB9Gu2cDmb+ZZoNglXFGhYHKdRdbb7K2l2A+0cQouwat55Pdm140JXF
   mozXqmDSiB4PoeR6lbyz8+Xzs1imGDcWowhhl2n4zWb39J5TNXsPWQi71
   KBNHO84yF2uMGKAGZY2ksuIZ0m94DHWLw5TlPFHMSqj98Ty0P0Rjuy9sp
   0tYtpoDItVoqneZetKu3QI3LfI9yxQ2NzAbsg3+Xu6810dNPlcUKSFB4S
   w==;
X-CSE-ConnectionGUID: 7c79lkVYSKyPNTBt9zCQzw==
X-CSE-MsgGUID: Lfwx8UEeSP2wa7HuZTH/FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="52727"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="52727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 09:13:56 -0700
X-CSE-ConnectionGUID: AXqU/1ZIT76ZgrtbZltyUg==
X-CSE-MsgGUID: H6ErxPe1TvqS3B3WGsal0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275836152"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 09:13:54 -0700
Message-ID: <f5c8a479-5c00-4a4b-8bfc-3f83f3df8c8f@intel.com>
Date: Tue, 6 Oct 2026 09:13:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
To: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, jgg@nvidia.com, aneesh.kumar@kernel.org,
 aik@amd.com, yilun.xu@linux.intel.com, iweiny@kernel.org,
 ming.li@zohomail.com, icheng@nvidia.com, bhelgaas@google.com,
 smadhavan@nvidia.com, ilpo.jarvinen@linux.intel.com,
 Smita.KoralahalliChannabasappa@amd.com, andriy.shevchenko@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-4-ankita@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261005070252.84810-4-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/5/26 12:02 AM, Ankit Agrawal wrote:
> The DevIf report range with range ID 0xffff describes the device's
> coherent (CXL) memory window and unlike every other reported range
> carries no BAR number. Recognize
> PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT and recover that window's
> address from the CXL side of the device instead of treating it as a
> BAR-relative offset.
> 
> pci_tsm_coherent_range() resolves the window from pdev->coh_resource[],
> snapshotted once with the committed CXL HDM decoders range. The
> range to IPA conversion is applied onto range_base/range_len using
> pdev->coh_resource[]. The ascending BAR order checks stay on the BAR
> path only. The coherent range is required to be the last report entry
> and is not part of the BAR sequence.
> 
> An HDM decoded window lives in the CXL Fixed Memory Window and is not
> part of a BAR. So by construction, no pci_dev resource contains it. So
> the function pci_tsm_coh_resource_contains() validates the range against
> pdev->coh_resource[] instead; the same known-good snapshot
> pci_tsm_coherent_range() already trusts.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Assisted-by: Claude:sonnet-5
> ---
>  drivers/pci/tsm.c       | 192 ++++++++++++++++++++++++++++++++--------
>  include/linux/pci-tsm.h |   4 +
>  2 files changed, 160 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index c8cfe89b6224..1d736b606a7c 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -904,6 +904,41 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
>  
> +#ifdef CONFIG_CXL_RESET

May want to move this to a header. Having KCONFIG ifdefs in .c is typically not preferred.

Also I do wonder if we want to put this code behind CONFIG_CXL_RESET. There's dependency of being able to run the reset stuff for a type2 device before passthrough to user space. But the attestation code is not part of reset code. Maybe putting it behind a different kconfig symbol with dependency on CONFIG_CXL_RESET?


> +/*
> + * pci_tsm_coh_resource_contains() - check a coherent range against the
> + * PCI-core coh_resource[] snapshot
> + * @pdev: device owner of @res
> + * @res: candidate coherent MMIO range to validate
> + *
> + * The coherent (CXL.mem) range isn't BAR-backed. So pci_resource_n()
> + * containment doesn't apply. Check against pdev->coh_resource[] instead.
> + *
> + * Return: true if @res falls within a populated coh_resource[] entry.
> + */
> +static bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
> +					  const struct resource *res)
> +{
> +	int i;
> +
> +	for (i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *coh_res = &pdev->coh_resource[i];
> +
> +		if ((coh_res->flags & IORESOURCE_MEM) &&
> +		    resource_contains(coh_res, res))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +#else
> +static bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
> +					  const struct resource *res)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_CXL_RESET */
> +
>  static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
>  {
>  	while (nr--) {
> @@ -936,7 +971,9 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>  		return -EBUSY;
>  
>  	for (i = 0; i < mmio->nr; i++) {
> -		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +		struct pci_tsm_mmio_entry *entry = pci_tsm_mmio_entry(mmio, i);
> +		struct resource *res = &entry->res;
> +		bool coherent = entry->flags & PCI_TSM_MMIO_F_COHERENT;
>  		int j;
>  
>  		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
> @@ -947,13 +984,22 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>  					     pci_name(pdev), IORESOURCE_MEM,
>  					     IORES_DESC_ENCRYPTED);
>  
> -		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> -			if (resource_contains(pci_resource_n(pdev, j), res))
> +		/*
> +		 * The coherent (CXL.mem) range isn't BAR-backed, so check it
> +		 * against pdev->coh_resource[] instead of pci_resource_n().
> +		 */
> +		if (coherent) {
> +			if (!pci_tsm_coh_resource_contains(pdev, res))
>  				break;
> +		} else {
> +			for (j = 0; j < PCI_NUM_RESOURCES; j++)
> +				if (resource_contains(pci_resource_n(pdev, j), res))
> +					break;
>  
> -		/* Request is outside of device MMIO */
> -		if (j >= PCI_NUM_RESOURCES)
> -			break;
> +			/* Request is outside of device MMIO */
> +			if (j >= PCI_NUM_RESOURCES)
> +				break;
> +		}
>  
>  		if (insert_resource(&encrypted_iomem_resource, res) != 0)
>  			break;
> @@ -985,6 +1031,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
>  
>  /* An interface report 'pfn' is 4K in size */
>  struct pci_tsm_devif_mmio {
> @@ -1003,6 +1050,44 @@ struct pci_tsm_devif_report {
>  	struct pci_tsm_devif_mmio mmio[];
>  };
>  
> +#ifdef CONFIG_CXL_RESET
> +/*
> + * pci_tsm_coherent_range() - resolve the device's coherent CXL window
> + * @pdev: device owner of the reported ranges
> + * @out_base: host physical (guest IPA) base of the coherent window
> + * @out_size: size of the coherent window
> + *
> + * The coherent range carries no BAR number, so its address comes from
> + * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
> + * decoders.
> + *
> + * Return: 0 with *@out_base / *@out_size set from the first populated entry,
> + * or -ENODEV if no entry is populated.
> + */
> +static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
> +				  u64 *out_size)

pci_tsm_retrieve_coherent_range()? Also, why not just pass in a 'struct range'?

DJ

> +{
> +	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *res = &pdev->coh_resource[i];
> +
> +		if (!(res->flags & IORESOURCE_MEM))
> +			continue;
> +
> +		*out_base = res->start;
> +		*out_size = resource_size(res);
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +#else
> +static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
> +				  u64 *out_size)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_CXL_RESET */
> +
>  /**
>   * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
>   * @pdev: device owner of MMIO ranges
> @@ -1040,7 +1125,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		return NULL;
>  
>  	for (i = 0; i < mmio_range_count; i++) {
> -		u64 range_off;
> +		u64 range_base, range_len, range_off;
>  		struct range range;
>  		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
>  		struct pci_tsm_mmio_entry *entry =
> @@ -1050,33 +1135,58 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		u32 attr = __le32_to_cpu(mmio_data->attributes);
>  		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
>  				    attr);
> +		bool coherent =
> +			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
>  
> -		if (bar >= PCI_STD_NUM_BARS ||
> -		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> -		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> -			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> -			return NULL;
> -		}
> -
> -		if (last_bar > bar) {
> -			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> -			return NULL;
> -		}
> -
> -		if (last_bar < bar) {
> -			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
> -
> -			/* Transition to a new bar */
> -			last_bar = bar;
> +		if (coherent) {
> +			if (i != mmio_range_count - 1) {
> +				pci_dbg(pdev, "Coherent reporting range is not last\n");
> +				return NULL;
> +			}
>  
>  			/*
> -			 * Determine the obfuscated base of the BAR. BAR
> -			 * offsets are never obfuscated.
> +			 * No BAR names the coherent range, so fail closed if
> +			 * neither a CXL region nor a committed HDM decoder
> +			 * resolves its address.
>  			 */
> -			reporting_bar_base = tsm_offset & ~mask;
> -		} else if (tsm_offset < last_reporting_end) {
> -			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> -			return NULL;
> +			if (pci_tsm_coherent_range(pdev, &range_base,
> +						   &range_len)) {
> +				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
> +				return NULL;
> +			}
> +
> +			/* Coherent range is last and not part of the BAR sequence. */
> +		} else {
> +			if (bar >= PCI_STD_NUM_BARS ||
> +			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> +				pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> +				return NULL;
> +			}
> +
> +			if (last_bar > bar) {
> +				pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> +				return NULL;
> +			}
> +
> +			if (last_bar < bar) {
> +				resource_size_t mask = pci_resource_len(pdev, bar) - 1;
> +
> +				/* Transition to a new bar */
> +				last_bar = bar;
> +
> +				/*
> +				 * Determine the obfuscated base of the BAR. BAR
> +				 * offsets are never obfuscated.
> +				 */
> +				reporting_bar_base = tsm_offset & ~mask;
> +			} else if (tsm_offset < last_reporting_end) {
> +				pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> +				return NULL;
> +			}
> +
> +			range_base = pci_resource_start(pdev, bar);
> +			range_len = pci_resource_len(pdev, bar);
>  		}
>  
>  		/* Per spec the tsm_offset never results in overflow / underflow */
> @@ -1086,20 +1196,28 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  			return NULL;
>  		}
>  
> -		range_off = tsm_offset - reporting_bar_base;
> -		if (pci_resource_len(pdev, bar) < range_off + size) {
> -			pci_dbg(pdev, "Reporting range larger than BAR size\n");
> +		/*
> +		 * Use tsm_offset directly for the coherent range instead of
> +		 * masking: an HDM decoder's size - unlike a BAR's - need not be
> +		 * a power of two. So masking could wrap an out-of-range
> +		 * offset back in-bounds. The bounds check below still catches it.
> +		 */
> +		range_off = coherent ? tsm_offset :
> +					tsm_offset - reporting_bar_base;
> +		if (range_len < range_off + size) {
> +			pci_dbg(pdev, "Reporting range larger than %s size\n",
> +				coherent ? "coherent range" : "BAR");
>  			return NULL;
>  		}
>  
> -		range.start = pci_resource_start(pdev, bar) + range_off;
> +		range.start = range_base + range_off;
>  		range.end = range.start + size - 1;
>  
>  		/* Only record the TEE ranges for later consideration by ioremap() */
>  		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
>  			      attr)) {
> -			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
> -				bar, &range);
> +			pci_dbg(pdev, "Skipping non-TEE range, %s %pra\n",
> +				coherent ? "coherent range" : "BAR", &range);
>  			continue;
>  		}
>  
> @@ -1107,6 +1225,8 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		entry->res.end = range.end;
>  		entry->res.flags = IORESOURCE_MEM;
>  		entry->tsm_offset = tsm_offset;
> +		if (coherent)
> +			entry->flags |= PCI_TSM_MMIO_F_COHERENT;
>  		mmio->nr++;
>  	}
>  
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index e54ad057fa8e..90bd8d1dd729 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __PCI_TSM_H
>  #define __PCI_TSM_H
> +#include <linux/bits.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/sockptr.h>
> @@ -204,10 +205,13 @@ enum pci_tsm_req_scope {
>   * @res: MMIO address range (typically Guest Physical Address, GPA)
>   * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
>   *		Translates report addresses to GPA.
> + * @flags: PCI_TSM_MMIO_F_* attributes for the range
>   */
> +#define PCI_TSM_MMIO_F_COHERENT BIT(0)
>  struct pci_tsm_mmio_entry {
>  	struct resource res;
>  	u64 tsm_offset;
> +	u32 flags;
>  };
>  
>  struct pci_tsm_mmio {

