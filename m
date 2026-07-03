Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D5305968
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099971; cv=none; b=Benl9t+5WBkdNab5tRIL47ajr/q3LjCFWFeHAxH7LytlF0DNlOMEdoC10AdBPv4mHnMJTZv5VJcmm0v/zTuq0+/haQnEUTvaBr29kcZu6weuYaAZ6J/rSeGg/nEMhVXnwzW5PjcAEErZUFEQhHR5eVdj64f4PFSNnmsXrBg8QUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099971; c=relaxed/simple;
	bh=Wcpl1M8C6rbl+gWtOZA3jLQB6f728HV5z3+kNftSXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukTTcWJu+Irz/kJYpkAmKb90iV9PfvxcFag/Gvu5yvBDVr2jO/3F4stNXGvtavKwN4qySNCkQBIalINu5NutZBZLd0GgAw574xSxoZmSYgZh/VhObGz4Xy1J+szjZZgvFkUD1itUAHlTBNpYLykvbMBykD2uq/8ShJ1Xg6iAzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mF1sVXMO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mF1sVXMO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so5414281cf.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783099969; x=1783704769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=mF1sVXMOMvgQrEnwIMqB4rY7uKNNPHHW+R+o0znH9WS0jEM7MZIf+ecJ0/qLq8jPvN
         vzRc3UN8Gq9LdcPJla0jj0lihaWdydDDuPiknHRO1irv6GcFJHK/0GbmBuW+y9xeAJ3N
         WlGbcSggJ6kW+KZntqyr4HnCXCPlQiwTIrz77E1tIT/bB30Z0ObKmrW4i1AgRJXGwmdJ
         X9kuKH4lUeBuRXn6m5GQSzvvgCQtvqCkFdTigKl9qByon+KreNc+XXE536/tmda5hU82
         cXr+0NYMK1I4qXU1MNlA7nOCUgYeI8Na0eN1sBCIgycVP5FNlehXzx3rvvWxqxOHWUFM
         WdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099969; x=1783704769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=V1AqxHNLxUGP4nDCIabamWAUiY+wrRuRGtrkEff7SfHIJXDPoYaLE7oq+VbV0CNtfG
         GSnFjBBdjRRrQejqG4H5hf0YL7aMwP2XDiFqOyqg0gwOl7MrFplr392QRyA7LKfGxsD9
         BrH8ONg4wFiuhwgi0KdmnxRRcDmrFbJBTgoMYMTRkxVFFovIb17101qlvxjVtCplawJQ
         p3uLHppq06sJmYtgFUdWUEL3IWJSpI6z9ROiyozWh4nEM71cfj6bF1RzanxvWnT5xO8Y
         2r3hiNsspiCpsUGbLa5CNWeltK/lY6EY9tOqTIe8MxiVNz5TdwxSHbtfWxUNwBmNUCNa
         nCWA==
X-Forwarded-Encrypted: i=1; AFNElJ8h2NNnXi0vtzq5pqv7BDAfjfl6BT58SsMD/5EgWNxnQMaoKDoNKvjyRD+mb3fJ/bh+N/8y+mE3pYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCTyGpZVEe5IsVl9VTVI2AWsA99yv5lkDzfFGvuQ8xX6c4Mvk
	Mi4r0oR09cVcy9QHrviSd//KqHw6/IwPYY06sCD+fIRnz5lYwek/xoef+iCOHveqdzdAtAcvbnV
	jCGmp
X-Gm-Gg: AfdE7clHiHzb+qs3BLJTmTSPy0lLCEe4L+YLMb8K4oxc0lYgDcqOcFR9sabaxi2VtPB
	knMSSEO/wgrPp8BFjsLSaJW3DKo8zv82+SnOF7YeY+Qky2s5uvkyrvrzm1q+NOl8ClV7m/6YgNw
	iDPcpVlz+QzDV9xaXfMTIwVKbTZQzqJXb/NQSR4nx5LMGGQbo+0w7c9SrpOia4yKbAMmy0ipWc6
	UjYIXdqnuh2WB4aRcGMkLWejAiNXOjSJT9fDZF6IFSCzY1fJ3jfiODq4UaGC5Q1twN6LrVgDhxr
	HTKHLSExytIi0yLvjqXZz/hbEwEqP9bT8Es7p9dfMdrH8EycWnd+hGL3ob1kvwHwENdBQAcJRln
	BxyBF8cDiFRcXXR8EErBTRS7R9jxp7EfIzSuLKt40r3RCs++aIfbHWnqkNpjnyK5+iDK93hEPd4
	vcsAe7G50NP22IPxs0Qe74VWFZ1ucH2dHKnQzGFg04K7imLI6CjGheOUdJowxhd6ZDBUw=
X-Received: by 2002:a05:622a:290:b0:51c:e14:87a7 with SMTP id d75a77b69052e-51c4c214c01mr7650981cf.28.1783099969076;
        Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9ad1fsm58402856d6.47.2026.07.03.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:32:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhku-00000008Ink-0GPL;
	Fri, 03 Jul 2026 14:32:48 -0300
Date: Fri, 3 Jul 2026 14:32:48 -0300
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
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260703173248.GB1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>

On Fri, Jul 03, 2026 at 12:05:17AM +0800, Yu Zhang wrote:

> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;

This CAP isn't necessary anymore

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev = to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev = dev;
> +	vdev->hv_iommu = hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));

This can probably just be PAGE_SHIFT

Also ATS shouldn't be enabled until a translation is installed,
otherwise the driver cannot participate in the ATS error handling
Nicolin is working on.

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);

No necessary, the caller does it

> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	WARN_ON_ONCE(1);
> +	return generic_device_group(dev);

I think you can just return failure here instead of WARN_ON ?

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

IMHO I would change this around to have a single function that accepts
a struct hv_input_configure_device_domain as input and does both of
the hypercalls inside. Then here it is easy to directly construct the
hv_input_configure_device_domain for blocking and identity.

I'd be happy if this never touched domain_type, drivers shouldn't be
touching that.

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

I don't see anything reading this, I don't expect this to be used?

The max_iova_width has to be passed into the iommupt creation, which
it does:

 +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 +	cfg.common.hw_max_oasz_lg2 = 52;
 +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
 +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
 +	if (ret)

So just delete hv->iommu->geometry.

Also, VT-D has weirdness where the HW can require a 4 level table but
only a 3 level worth of IOVA width is being used. This was a
real-world bug we hit when converting to iommupt. This interaction
with the HV doesn't seem able to represent that.

> +	/*
> +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> +	 * hypervisor to advertise a non-empty subset of exactly those.
> +	 */
> +	if (!hv_iommu_cap.pgsize_bitmap ||
> +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> +		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> +		       hv_iommu_cap.pgsize_bitmap);
> +		return -ENODEV;
> +	}

This can just be

if (!(hv_iommu_cap.pgsize_bitmap & PAGE_SHIFT)) {
		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
		       hv_iommu_cap.pgsize_bitmap);
}		return -ENODEV;

Which is all you really need. If the HV doesn't support 1G it is
perfectly fine, the iommupt page bitmap is already masked by this. 

> +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");

Don't log someting so vauge?

Jason
