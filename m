Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576365;
	b=RfpV+RwbtV5yYU3z+bBhazQzOlJanQJggAyQIl20S++v2q4er5orDNTeaKAFL2fF1ptG
	 XB/BlIOl3H3uWdghOnHa4ZKP1lx3Ft7cRxXcp4gSdVcFY1VFLpyjZGprEi7Jx9rrTD0bq
	 wi/a9ltSQoU4PmycO8r+3efk4vrNQP+V7fmFYs487GG3+K96OIpWHkVzfSQ7TfiuJuw8L
	 p9yaex3vGD7mIEjQ2MlZjTpCvgzq1MPv0y1fynTV6BOkbFuSWEIwrFT6s7X8uw2Zcc5nd
	 Fqxa8lU5OSCPwWM2lrGR9Gl+pCgnnSzxpV6w33iM0tuJZKYTu5tn8RLmOhDTZ8KG/Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576365;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uozLgHIJcCRVIWGDkYXRUzxamxNdBt+/LrMuLz+mwMI=;
	b=kQjOyHovK9lNfsXUsjbxEWupYeq6V+xhTpVDUZfdbp+REmgyUn92+Y94mh5RSqGfbPNU
	 VDgsMrLhlkt4E7YW/HxS7g5VFg3nNvUF08tlNxfjexXltCV0Ok+9BdP9CNJiGmuOz2UJC
	 dP+WCf2cIgJV2+7fmOCuj4yWk0qwzlERDj/cA1akXAszsye2FlRj/3SSMP6KCazCaTAee
	 MZolefCFIISvMrWInO/Id89NvXI2w9LE9Y3xK4SvMAgyyxUZGDKxEvEoosvXOrcxZS28b
	 qRxN815+t02bMv5vK5e46wS/fN3gETDsGIYKnhCObjo4W9B4EdjxEQ3tm2HhYbR/7Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gduD1r5A;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA3606A339;
	Fri, 13 Nov 2026 13:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDA3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gduD1r5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794576364; x=1826112364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHDAA9GQ4cle8mcEUojmH66XcPzPvCOf30Osct56EHk=;
  b=gduD1r5AnvwflVvtZveQnXzKMIvXEzKXzhs1ZHf/HFwdsNAyr8Wzk4BE
   JnKkBXo78AVaPLvrkmxvV//e/rqyaBy+9JVEaWoAJUWzTEUahOelGJ9u3
   iJUYG9cmrWHaYElzCJXMs/MEnMAMRbRPekPYH3y467QmpUbyjRDIcjTE0
   QO4CjYDddHiw5ODVLLXaiRBnBLw9QJ9n9o3WJ3+lWzbwJdNJk/TBfeO2m
   ijmFYeuLy4KyOUPBt6oEaw66BRPdTU9xW6e9mSbKHhHQB3QVUUQwud1HE
   VxKvvOE4Ctaiz1z7xFHXrTQzXDVxR4j1q9BBGqL6j+nefvJ7D165m9plB
   A==;
X-CSE-ConnectionGUID: ryXcCur4T5+hrAx54OAOCA==
X-CSE-MsgGUID: 1hzw80O1TyqbC3PdSyI3ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3391427"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3391427"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 05:26:04 -0800
X-CSE-ConnectionGUID: Er+W26QyRNC/UrHD4NE/dg==
X-CSE-MsgGUID: QkWApvgoRmGXBcHIZhw0QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10698097"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa011.fm.intel.com with ESMTP; 13 Nov 2026 05:25:58 -0800
Date: Fri, 13 Nov 2026 21:17:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, jgg@nvidia.com, aneesh.kumar@kernel.org,
	aik@amd.com, iweiny@kernel.org, ming.li@zohomail.com,
	icheng@nvidia.com, bhelgaas@google.com, smadhavan@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev,
	terry.bowman@amd.com, nik.borisov@suse.com, brads@mainlining.org,
	lukas@wunner.de, rrichter@amd.com, gourry@gourry.net
Subject: Re: [RFC PATCH v2 1/5] PCI/TSM: Create MMIO descriptors via TDISP
 Report
Message-ID: <avcN9pz4mCRKA5zM@yilunxu-OptiPlex-7050>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-2-ankita@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105152909.53452-2-ankita@nvidia.com>

On Thu, Nov 05, 2026 at 03:29:05PM +0000, Ankit Agrawal wrote:
> After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
> expected to populate the TDISP GET_DEVICE_INTERFACE_REPORT response
> payload for the device.
> 
> Add pci_tsm_mmio_alloc()/pci_tsm_mmio_free() to parse that report into
> a set of encrypted MMIO ranges, and pci_tsm_mmio_setup()/
> pci_tsm_mmio_teardown() to mark those ranges as encrypted in iomem via
> a new encrypted_iomem_resource tree (IORES_DESC_ENCRYPTED). With those
> descriptors the TSM driver can use pci_tsm_mmio_setup() to inform
> ioremap() how to map the device per the device expectations. The VM
> is expected to validate the interface with the relying party before
> accepting the device for operation.
> 
> pci_tsm_mmio_alloc() also recovers the obfuscated starting address for
> each encrypted MMIO range, since the VM is never disclosed the HPA
> that correlates to the GPA of the device's MMIO. The obfuscated

I think we need to make clear why we need to parse the obfuscated
addresses like this. IIUC what the guest really needs are the BarID &
the offset within the Bar, so that it knows exactly where the MMIO range
lies. That requires the obfuscation never affects the address bits
for the in-Bar offset. Thus the MRO should be Bar aligned. And since
there is only one MRO across all MMIO ranges, it has to be aligned to the
largest Bar size.

> address is BAR aligned.

The obfuscated address is not BAR aligned, the MRO should be Bar aligned.

> 
> BAR alignment is not mandated by the PCI TDISP specification. So this
> relies on the TSM implementation: the MMIO reporting offset (MRO) it
> programs must be a multiple of the largest BAR size so that the
> in-BAR offset of a reported range can be recovered as
> (reported address % BAR size). Arm CCA specifies this in DEN0137
> section A9.6.2 ("This algorithm assumes that the MRO value is a
> multiple of the BAR size") and recommends the RMM pick
> MRO = x * 2^n with 2^n >= the largest BAR size.
> 

I think the following doesn't belong to the changelog, could be put
under ---

> Based on an original patch by Aneesh Kumar K.V [1], and cherry-picked
> from Dan Williams' upstream commit [2]. Major functional differences
> from Dan's posting is due to the lack of evidence-store infrastructure
> yet (device_evidence / DEVICE_EVIDENCE_TYPE_REPORT). The
> pci_tsm_mmio_alloc() takes the raw report bytes directly from the caller
> instead of pulling them from a device evidence store.
> 
> Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
> Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [2]
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> ---
>  drivers/pci/tsm.c       | 239 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioport.h  |   2 +
>  include/linux/pci-tsm.h |  33 ++++++
>  kernel/resource.c       |   8 ++
>  4 files changed, 282 insertions(+)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 5fdcd7f2e820..d074bfd18d40 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -9,11 +9,16 @@
>  #define dev_fmt(fmt) "PCI/TSM: " fmt
>  
>  #include <linux/bitfield.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/pci-tsm.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/tsm.h>
> +#include <linux/unaligned.h>

Didn't find it needed.

>  #include <linux/xarray.h>
>  #include "pci.h"

[...]

> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> +{
> +	int i;
> +
> +	device_lock_assert(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	for (i = 0; i < mmio->nr; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +		int j;
> +
> +		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
> +			break;
> +
> +		/* Only require the caller to set the range, init remainder */
> +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
> +					     pci_name(pdev), IORESOURCE_MEM,
> +					     IORES_DESC_ENCRYPTED);
> +
> +		for (j = 0; j < PCI_NUM_RESOURCES; j++)

You've changed to pci_dev_for_each_resource in Patch 3, why not change
it here? Then Patch 3 would be clearer.

> +			if (resource_contains(pci_resource_n(pdev, j), res))
> +				break;
> +
> +		/* Request is outside of device MMIO */
> +		if (j >= PCI_NUM_RESOURCES)
> +			break;
> +
> +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
> +			break;
> +	}
> +
> +	if (i == mmio->nr)
> +		return 0;
> +
> +	mmio_teardown(mmio, i);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
> +

[...]

> +/**
> + * struct pci_tsm_mmio_entry - an encrypted MMIO range
> + * @res: MMIO address range (typically Guest Physical Address, GPA)
> + * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
> + *		Translates report addresses to GPA.
> + */
> +struct pci_tsm_mmio_entry {
> +	struct resource res;
> +	u64 tsm_offset;

As mentioned [1], could you replace tsm_offset by mmio_range_index
according to this patch [2]

[1] https://lore.kernel.org/all/atIY1Joa%2F%2F+hCRcr@yilunxu-OptiPlex-7050/
[2] https://lore.kernel.org/all/20260924041032.1096569-8-zhenzhong.duan@intel.com/


Others LGTM.

BTW: Is it possible we merge this patch alone when we collect enough
reviews? This is about PCIe TSM and several other series depend on it.


Thanks,
Yilun
