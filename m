Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E301202C48
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884303; cv=none; b=Oai1re6AUn/Y2px0RcKNQRG1cNHk7NSwGkGGrwhClAAjMtR9Y+4QMPahg8PNpRRhUOQEGp9/nrW5gHp1ZUp60FETx1FA2L5mCfwgfvIDTYEDX3NvLKvL5GDvCBD6bSTwr82yrh5WRwl9rbcOaU+fpUbi0hp2jHOY1dCBC60eweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884303; c=relaxed/simple;
	bh=zEB0iV2Z2zPsc+Q1ndCMHhq/Wgbjwf3tOg6xW5GmCPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nugBc/knoxwz+40qym7zvQRm48y3odavgTK6U8m709ZOvisITK9PrqYicP2yV91DiCNXqjjNb7/R+zUfWYQGxgKdVDrdqG7KlQXJiERrUZ0KCpKiCC+1PGp3iGyNvBeiK2UGo7qG2CtN1JEpAZSnfGnr+s4kD/npwVzFmAo493M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pTJ0kFQ6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pTJ0kFQ6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so5033406d6.1
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884300; x=1779489100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEFCQaRYLTA1e6mz4i4vUabso8iGraCDY6RgSEP/y8E=;
        b=pTJ0kFQ6QUzczX1F31n/UyuwPr2dATfD/3gLouc7uFtdD83lGR/nPrSnWIpK3L8nN4
         LOYBuxgeRbFp1opOvpAoxzsFB+peyftO1F/7jJ+DRqno1vgh6utOODFUxhS7wbQrztKZ
         +pyxoojeH0BvK3lfMptgwX9wBNBaOGhmyvuwnKZ4JC84NK4O0L53v5ZJfCGWwl1qq9YU
         QF3p7lZdQ0IcQm3udR/ZFDp0Axoxjrh1JSRCYMWs1ymCvzWZ9m8h+PqSC9mlILNI1hii
         zAD29NIhYqo8TIkiDXTw6CWLe/6W1Cg/mkF6ak6XjKyUH2zMmosgG87IS+WLfkSkxhEz
         oOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884300; x=1779489100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEFCQaRYLTA1e6mz4i4vUabso8iGraCDY6RgSEP/y8E=;
        b=bEyGnM33+JiMEvvj9+udGl5XoB+j6slGkNHhl8H/u8LH6B/cSdOcIRSIA168gJWjXn
         WENBFOrwawsc5tWgAbQfELEBSRvwyTlE3hhLZwBWCIrQr27w/pd4hht9JlPLcDJhhl07
         +mesqu44koVHNqt83Nfj7nkARCKYLRsMmeYcdJ3tGFniBr1FIUZzO5vLypGDR3sjtcyF
         asumag7U1CvNy+hY7kfSXsGxvHmjpVJJ2AbDaSsugy8a6zlTO8bC0ldAasNKvdtNhtU7
         ymRdR+Re8KqvTstF2zHYrgDkqpJc0gdu1OucgCNaO+OWH9UlIllDGlRIhBxY4AoXIXxt
         Vi/A==
X-Forwarded-Encrypted: i=1; AFNElJ/tFKcooEcoBGPQY3x4jIJhnFdnMxqZ2r99cT18n6w7/1BTG6fyQOJtRiW8cCnsCQGVuoR76vbx8jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Xgry7NWLPrQOmuwpnLnO+KwkaCaryroUDFIl3st6CgPhjuiW
	vcnCiQxoei6+u1HqiTNcJ0cGGx2a6KvUIcFG853Voibprcc41+nC+9YvQbiu43OCnBE=
X-Gm-Gg: Acq92OFXR+C4Hxk0QRvnbmG5oyFchSWj4q13QmnOcjdamV0IgEKXvMVgPxBJANj+E8d
	K29RVJYYj29Msce0nQxhLb07ELxh9VDVHJ9axxQ72+8EShA8ufZ/sZ/NAUzrPkFajBZb2CLIG3/
	IwBhmD9buSoEpY3/WkPw359xl3+gxW7qhsI0LfKNX51WTgSJRPsJkVzsMj3zWnS8zswDPvpq/iM
	6OaQssfzaxZtdcrdT5ihOgudH7GWlHJL4pvSsPvUMav5IqL+270bpMdFiafh88tDMm1CLbhs8M9
	/A8baRJ/hypqYiZTiM+cQY2nCwGIQzoeTyVIUUHgK/dnqapac/JbKQQvbf98KYzILgWPgze9tXH
	XQXes3BjXLtZwigPmizqToOKs8Zp73a+r8HD/5tBNyMSIPhUaTiTSMPOkEJ3cwRViH45/lO7VGG
	nzIYACyQyyiGnlkA4oyrjjiiapf9J7+jyvVvbnAex3qljdObVEw2nc4uyulrspA97ZYnLzwksUG
	vcOEA==
X-Received: by 2002:a05:6214:1bcc:b0:8bd:de6d:c331 with SMTP id 6a1803df08f44-8ca0f643048mr101202536d6.17.1778884300407;
        Fri, 15 May 2026 15:31:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2cfsm64136276d6.15.2026.05.15.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:31:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO14F-00000008E1i-1465;
	Fri, 15 May 2026 19:31:39 -0300
Date: Fri, 15 May 2026 19:31:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260515223139.GK7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:07AM +0800, Yu Zhang wrote:
> +/*
> + * Identity and blocking domains are static singletons: identity is a 1:1
> + * passthrough with no page table, blocking rejects all DMA. Neither holds
> + * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
> + */
> +static struct hv_iommu_domain hv_identity_domain;
> +static struct hv_iommu_domain hv_blocking_domain;
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;

Please follow the format of other drivers and statically initialize
these here instead of in C code.

> +static struct iommu_ops hv_iommu_ops;
> +static LIST_HEAD(hv_iommu_pci_bus_list);
> +static DEFINE_SPINLOCK(hv_iommu_pci_bus_lock);
> +
> +#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
> +#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
> +#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_5LVL)
> +#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)

prefer to see static inlines

> +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev) || vdev->hv_domain != hv_domain)
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	dev_dbg(dev, "detaching from domain %d\n", hv_domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	if (hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64)) {
> +		local_irq_restore(flags);
> +		dev_warn(&pdev->dev, "no IOMMU registration for vPCI bus on detach\n");
> +		return;
> +	}
> +	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);

FWIW the hypervisor cannot implement the linux attach semantics if it
has detach/attach. It must support simply 'attach' which atomically
changes the translation. With detach you have a confusing problem if
errors happen in the middle of the sequence the device is left in an
unclear state. You should at least document what state the hypervisor
is supposed to leaave the translation iin during these failures..

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	set_dma_ops(dev, NULL);

Does the driver really need to mess with set_dma_ops ? I'd rather not
see that in new iommu drivers if at all possible :|

> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain = &hv_identity_domain;
> +
> +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	hv_domain->domain.type = IOMMU_DOMAIN_IDENTITY;
> +	hv_domain->domain.ops = &hv_iommu_identity_domain_ops;
> +	hv_domain->domain.owner = &hv_iommu_ops;
> +	hv_domain->domain.geometry = hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;

identity doesn't use geometry or pgsize_bitmap

> +	/* Default stage-1 blocked domain */
> +	hv_domain = &hv_blocking_domain;
> +
> +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> +	if (ret)
> +		goto delete_blocked_domain;
> +
> +	hv_domain->domain.type = IOMMU_DOMAIN_BLOCKED;
> +	hv_domain->domain.ops = &hv_iommu_blocking_domain_ops;
> +	hv_domain->domain.owner = &hv_iommu_ops;
> +	hv_domain->domain.geometry = hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;

Nor does blocked

> +#define INTERRUPT_RANGE_START	(0xfee00000)
> +#define INTERRUPT_RANGE_END	(0xfeefffff)
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region = iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> +				      0, IOMMU_RESV_MSI, GFP_KERNEL);

Surprised these constants are not discovered from the hv?

> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}

Full invalidation only huh?

> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
> +	.attach_dev	= hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
> +	.attach_dev	= hv_iommu_attach_dev,
> +};

Usually I would expect these to have their own attach
functions. blocking in particular must have an attach op that cannot
fail. It is used to recover the device back to a known translation in
case of cascading other errors.

> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
> +	.attach_dev	= hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
> +	.iotlb_sync = hv_iommu_iotlb_sync,
> +	.free = hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_cfg cfg = {};
> +
> +	hv_domain = kzalloc_obj(*hv_domain, GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret) {
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hv_domain->domain.geometry = hv_iommu_device->geometry;

geoemtry shouldn't be set here, it is overriden by
pt_iommu_x86_64_init() with the exact page table configuration

> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width = 48;
> +	}
> +
> +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> +		.aperture_start = 0,
> +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> +		.force_aperture = true,
> +	};
> +
> +	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	/* Only x86 page sizes (4K/2M/1G) are supported */
> +	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap &
> +				  (SZ_4K | SZ_2M | SZ_1G);
> +	if (hv_iommu->pgsize_bitmap != hv_iommu_cap->pgsize_bitmap)
> +		pr_warn("unsupported page sizes masked: 0x%llx -> 0x%llx\n",
> +			hv_iommu_cap->pgsize_bitmap, hv_iommu->pgsize_bitmap);

IKD if you need this logic, the way the page table code is used it
just sort of falls out naturally that other page sizes are ignored.

> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};

You should retain the build assertions here

Jason
