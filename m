Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73637CD3E
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740523; cv=none; b=tpSslJTSJM46yDl9E5vpRbAEr5m3vUSYtV17MkSoK0EHbjn/tZ11NA9A5rS17PqhpuBlFTGfl+BUc5XB8l2b6HQIrM0hPPidue/v079DwJsu6NgtQehOkjIrutt2KLTWyEc1Mw0Ci6imMlxxJ60qSqe0RBnj8tgZzZUQTW5HOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740523; c=relaxed/simple;
	bh=z90EAsHBp3T87dc5vzYBnv9l+t7eNynM373LelU/leo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE4D8TMCfBUqXtcJTecK2q6L6oeCi6XCWnlTET/0dwfieX2QvLs2JpvAL8/cZMIKbF+ewtKR6OIjSGIGy0S9Vd746GgyTJicfyieoM8vZMY8pHtc1UxA3sc0t4mzHo8xxcPTg5K8v9bWFaRimyN3iX8Sdv9eqI85YvccaWy1PUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sapvxkFO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sapvxkFO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1336742714fso19663c88.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Jun 2026 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780740520; x=1781345320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IAXiSA/ZV+jth47JKvQthC0sv+FXjXrt59JcT36/1Y=;
        b=sapvxkFOg8KrzeIy8nBqkb/4vWE9zWawPZmr3KqUM0OajI9jvBgwLxdDq6rMFJOWq2
         0wgALBmjx3WHC3gClFEgWeLtq/gyyUZoi26wGAFl94IBa1YYPCylG+uwkbbjqpeVrFO2
         7RA7xPrQqH0Ksm1h6BDeZGwPHihqEp6N+rZsNh4Ng+nKv+D8CQfLgU7w0d0fo++CS7ap
         mayxqsmdgWJKi1pgE5Q640thT0B2/QvLy4n/SXr/JSFsU01kTldNHmWvIwTivKVXrSJP
         tY3PRZLLPtX7kNmr7qGSV6VfdxkLgV4Kbq+TLen9/GGBM31Cbf5+SCQNLAzpGtsG2ePH
         KOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780740520; x=1781345320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IAXiSA/ZV+jth47JKvQthC0sv+FXjXrt59JcT36/1Y=;
        b=XL6NjdmQKQY6KctkIgCQY5Y4YNp5AE3rsQG3D2RDUX3Hy0qNgqgrHhhpwqALiwDoQj
         BhQbETst8pO2v+c1bAYEbbw13fKGAyMvjLYeS2tgOcxdpvF6rJ/nvnVMfCGnzdNXKXxn
         NrN5M7jqqh98ixtdYNexUPsV+VcuNGNnwf+mXxk43UeI20V79FLVML06Zy2IgBk5axEq
         e2vyY3wWTIycB/fE6eVqzTNQ8RfDNzzifHpnf+K/Apzfh5YKOrr/1lNebFGnRTG0amtT
         l0b/xpficLpHVr9rspdhnxiBgWTmmVeKygIm/DAe5QjGQyNrKdZW0Xg1KlWfDSQRe+JI
         oH6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UMfBmX3bZ9LYYrY9KWtaD4vGGIWNIWUONfFhswYaDaXc2AjpuKZ0rbrW0iZ/f9SVr3112nzRZ+kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzI+zTi6yzNotiGeJ0SLkXGtDZoARHBc5fmOEKdqVbpmSaWFeo
	QeLWHVvF2SMN+UY5Pigg5hOq+DMvAUR/6lfaoYgAGPDht0zTpCr3qrL2fw6mlJBogQ==
X-Gm-Gg: Acq92OE3RVAhtjlUQOVO4iTZuPZ/AWQC8ztPgYfdjCVFIPjoLyf84Wb/SWsr440MFTZ
	RGFW6GXdjcp2ERbHFMaWzeVZU/iOhp35SKWC3hHJdbCkNErFc4My30PnIcx38iuA/6btUxl451I
	93mPIoWEqmRyzGRGxNJl5+WDdgcvIFwkM4hU+lRSwHt7S70kxgOqKXiq8jJhEIn5VpnVRRVcN/p
	/Dvg6sNL7kELwLqbh+iEJP8phlA0O3i25YgnGzMbWMogK00afAXshtGCg48/UO4e95FaWUs7uor
	XGLf51q1QTKx2K/zBAqvlix8IUt+NBK2BFaE1/rg3AEgUrvfbfQqzro8GxnWa0AWPW+Z8mkZ1aa
	1CoNsoCwZA6OtTJHqogiSby8Mv5+qVU70XMUMj4PaRkvb//GzOMtEHOlHnG8nQZIASbQYVJTiyh
	cfEtkV+7BihFfyjlbYVAMz1G16MrHR24AkJ2OEVrPmHw4PN60UJ+bJpo6IGdk9O3d5/zXzLEE=
X-Received: by 2002:a05:7022:672a:b0:136:799c:bd1 with SMTP id a92af1059eb24-13807c512edmr207588c88.10.1780740519572;
        Sat, 06 Jun 2026 03:08:39 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm12388863eec.3.2026.06.06.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:08:38 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:08:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aiPxVxu2sUVQfG9D@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.
> 
> If a device is found in the xarray, the PCI core stores a pointer to its
> state in dev->liveupdate_incoming and holds a reference to the incoming
> FLB until pci_liveupdate_finish() is called by the driver.
> 
> This ensures proper lifecycle management for incoming preserved devices
> and allows the PCI core and drivers to apply specific Live Update
> logic to them in subsequent commits.
> 
> Drivers can check if a device is an incoming preserved device (e.g.
> during probe) by calling pci_liveupdate_is_incoming().
> 
> CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> domain and bdf can be guaranteed to fit in an unsigned long and be used
> as the xarray key.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pci/Kconfig            |   2 +-
>  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
>  drivers/pci/liveupdate.h       |   5 +
>  drivers/pci/probe.c            |   3 +
>  include/linux/pci_liveupdate.h |  13 ++
>  6 files changed, 251 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c618830cf61..0e262c0ceb43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	drivers/pci/liveupdate.c
> +F:	drivers/pci/liveupdate.h
>  F:	include/linux/kho/abi/pci.h
>  F:	include/linux/pci_liveupdate.h
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 10c9b65aa242..e68ae5c172d4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

I see that the static assertions in Patch 1 work because of the 64BIT
enforcement here. In that case, should we have the assertions check u64?

>  	help
>  	  Enable PCI core support for preserving PCI devices across Live
>  	  Update. This, in combination with support in a device's driver,
>

[...]

>  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>  {
> -	args->obj = phys_to_virt(args->data);
> +	struct pci_ser *ser = phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	int ret = -ENOMEM;
> +	u32 i;
> +
> +	incoming = kmalloc_obj(*incoming);
> +	if (!incoming)
> +		goto err_restore_free;
> +
> +	incoming->ser = ser;
> +	xa_init(&incoming->xa);
> +
> +	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
> +		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
> +		unsigned long key;
> +
> +		if (!dev_ser->refcount)
> +			continue;
> +
> +		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> +		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
> +		if (ret)
> +			goto err_xa_destroy;
> +	}
> +
> +	args->obj = incoming;
>  	return 0;
> +
> +err_xa_destroy:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);

I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
We may need a policy here, the options I have in mind are:

1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
   xArray alloc), it's a liveupdate failure. We can't retry liveupdate.

2. Retrying retrieve is allowed.

The only downside with option 1 is, the user may want flexibility due to
certain subsystems OR may choose NOT to use the proposed LUOd and instead
have its own user-space component which might try funny things or have a
different use-case.

In such a situation, the system may have transiently run out of memory
during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
allocate memory and temporarily runs out of the atomic pool). [Note we
removed it in IOMMU v1 [2] but subsystems may have a use-case for it]

If the kernel frees the KHO page on the first failure, it removes any
chance of recovery. :/

Thus, it might make sense to let the user decide if it wants to fail the
liveupdate or retry again based on the failure type / source?

[...]

The changes LGTM, except for policy-based, kho_restore_free discussion.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260522211333.D56A21F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260203220948.2176157-2-skhawaja@google.com/
