Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE653E30A
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986484; cv=none; b=ao/PFPcl0jWmQC6ebwAb6yey/Cn82dJak5dUvjDVobvLjEhF2p6WCf/IJg9Iez8D4Jd2F9BWkgTsaNkcYj4jYZSo+2uMuCtvSD3bps7FbUC7SbHpFQHDhyxeV9OJ91RMZ6E44OYDWQrnEOgH7lAiw1IRG+asVp4F/KMd3XIv+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986484; c=relaxed/simple;
	bh=RPKjO7r7COV1kj1mEX8DiND3M9FxBEUt2xywURu28N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BirlmiJV1YQC3HdEHf14BkBIbG3kFohKpbis7lAVUl4ZUxCfXftwKTyl1a2ClcYL0UukrP2/LtEpOyvdygRfPCjNY/rZabXiRghwI3dayRGZCRN4oWoQk51jPsqZSr/YAMF+K0EtZL4ZCjl6g6565uzxzmkWO3INDK/BGadv83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4yUBfWY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4yUBfWY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so35527835e9.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791986475; x=1792591275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bl4WvKQr9UWYn7bOh5TWEroVL/3JGDO8W7v/2+U1gfA=;
        b=e4yUBfWYhNXpF0F0HY5ImzmIfKYO+0wQm+IwqLqgo4YdYGxG12ttYr4YmCR/9iXTCl
         nj5iV6B3xIqeu24mEbWvedNQjVdV8ZEALCEAjbFXZ9g/zdvW6qknxwUbKiCWMqFuiIZB
         AK2l0d+q2YOFv4VuUv5IdoE9+3LA662uQ9zKawtVpdKuUgjBuWiJqpKWyqlH9hxnCVvC
         +71LGZYZqFGi0dV6FaEovYpLNsIQNgaRXlyz8VK3NtMnGniEkq/2RY8Cr2aisH3rGU9S
         t/a5pM3bwhU5lktLAR8eunjQh/OMSwZ8PtQdzevEE4mBWG4VzL9mselHHE20ztoerq/e
         k1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986475; x=1792591275;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bl4WvKQr9UWYn7bOh5TWEroVL/3JGDO8W7v/2+U1gfA=;
        b=N1sVx6ewFAAyyHtuU3n8+Wr2Ihnxo/QjIu4cDWbTqK8JtY7dbt8NIlT6vPIqxfUQ+I
         JJw/1OBk1dNSGGQc+QO1sUKOwLeCRMYyZOf3fhUWyWn5nEbODSR9qbP0mhCRYR/3HB4z
         i79XZ/MuyxRkgSZDh3+W0+8AOYPg1LfInPJs4aFFu9tYewl7DjcKmKaWj1GrwgNEQ1Wy
         g4EIPs4qlWgA7ne0iZ+hJA8Zh4+ZRBb99/Y9foiQhd7u9nI+F/B1GfZnU5Nn3fKOK0Tn
         /5chq/Ed4TEUzOsYrZGi0DktXrud/81by0sufVB+c/rRFI1UMZ5eJwJn9bR9tdRaE4sf
         xqeA==
X-Forwarded-Encrypted: i=1; AKwUvBzYD4EQSYmVfAmmYTwQeF9GriGhEhSf1dnhnS0iLhtrQJxXYXns2DbiojyCnqxa7VdvW3QqdNjmy/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9hgECnwepMPfk1vfavfU5CuHA5vSyh2DnCk+tIKvvsGByM9vT
	v9VQ6Fch0SkAQUXFUoGaW+dYKF6LPH11bNMSeHrVYpyttsCFrilCuCsGCnZR2RHJU2Q=
X-Gm-Gg: AYBFou3l35xh5kgxA9bN8I1/MDTIfTzHJUj9bGz8tZeaIcrewnu20L2XYd/RSlRq1cU
	bfrfsQaqRxIWYKp6kxfBLBpyAS2lnDvckkphUF6CK9Nxailg6qN3GLhvpo1lHb1WEcwLf39G3Q8
	+odRjBWm5LbbkuizaU6oXo8dU2lX+1OeAU8TPWPXJX9YrOSFjmiIwGE/umGVuut3gDscnmbMKQl
	y0I3JBCP3HRG0n8bt8KpTDYPrMTRVR3ITk0DKFUJIfjUmcHIWd7OVsK7kTEc7+XOoSrPRBVFMIz
	eiRzYMLz861o0FsRK9FyWTpKTNGeQe5QNLIh5qDVIMzdcGSmXpB4OOynP+5/wZXUWWoSNpk4xsR
	zcOclI8FHxlkBq/aKsqdnRN9PvAdV/ufl2/9BBoLnFgSIBfdvLSvNt0mXshm4grE5hW62x2T/6u
	LXtxRFyMkpKbyHf+cOqqTV0aExTUtMKzm9uqthNIuuZooMNfVHRhBv/fSpXpVDgOlYMVYYHRR5u
	aAaCp6iKhK7PVY19hqepig=
X-Received: by 2002:a05:600c:8184:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a18e4d854cmr283701345e9.31.1791986474223;
        Wed, 14 Oct 2026 07:01:14 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd07c276sm1997515e9.13.2026.10.14.07.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:01:10 -0700 (PDT)
Message-ID: <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
Date: Wed, 14 Oct 2026 17:01:08 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
To: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, jgg@nvidia.com,
 aneesh.kumar@kernel.org, aik@amd.com, yilun.xu@linux.intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 bhelgaas@google.com, smadhavan@nvidia.com, ilpo.jarvinen@linux.intel.com,
 Smita.KoralahalliChannabasappa@amd.com, andriy.shevchenko@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261005070252.84810-2-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5.10.26 г. 10:02 ч., Ankit Agrawal wrote:
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
> address is BAR aligned.
> 
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
> Assisted-by: Claude:sonnet-5
> ---
>   drivers/pci/tsm.c       | 236 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/ioport.h  |   2 +
>   include/linux/pci-tsm.h |  33 ++++++
>   kernel/resource.c       |   8 ++
>   4 files changed, 279 insertions(+)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 5fdcd7f2e820..c8cfe89b6224 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -9,11 +9,16 @@
>   #define dev_fmt(fmt) "PCI/TSM: " fmt
>   
>   #include <linux/bitfield.h>
> +#include <linux/overflow.h>
>   #include <linux/pci.h>
>   #include <linux/pci-doe.h>
>   #include <linux/pci-tsm.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
>   #include <linux/sysfs.h>
>   #include <linux/tsm.h>
> +#include <linux/unaligned.h>
>   #include <linux/xarray.h>
>   #include "pci.h"
>   
> @@ -898,3 +903,234 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
>   		       resp, resp_sz);
>   }
>   EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> +
> +static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
> +{
> +	while (nr--) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, nr);
> +
> +		/*
> +		 * Entries past the point where pci_tsm_mmio_setup() stopped
> +		 * (or that were never run through setup() at all, e.g. a
> +		 * caller that only wants the resolved range from
> +		 * pci_tsm_mmio_alloc()) were never insert_resource()'d, so
> +		 * res->parent is NULL. remove_resource() dereferences
> +		 * res->parent unconditionally.
> +		 */
> +		if (res->parent)
> +			remove_resource(res);
> +	}
> +}
> +
> +/**
> + * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
> + * @pdev: device owner of MMIO resources
> + * @mmio: container of an array of resources to mark encrypted
> + */
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
> +	if (i >= mmio->nr)
> +		return 0;

Shouldn't this check be if (i == mmio->nr -1 ) i.e all descriptors have 
been initialized, given the for loop condition i can ever be at most 
mmio->nr - 1 i.e the actual index of a descriptor?

<snip>
