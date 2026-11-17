Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938484;
	b=0mErttGCZAa5qKhzZGrNysWKmnnBQP9l0vrkbSlXKmHgXcWMZ9iHYPVBp1z+OU5bTyrq
	 92YOzIAxPZSx+SJRUgrVGde3Mn4qZt6ggIL9UMgFiSM6ipcUowwfeDOkhAqrD+duWodhW
	 EFKPRunm0liD1IJcelxdSAzGbG+Bsij2QlWp5jX8rKexTkS0Oeo6adDucYrOVjjfx+N8N
	 rAJvf3CcgED57FpPVjrKZOpmeocNsdkUK9fRiwVEqew8BkRdbIUC1edA78g4aCj/qgXz2
	 vclFaue3sHiDsrKLyompshcL6q3YNxd7BgEyzlTCXDiwguS/Z7+2OsUIaTTYcX7/nuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938484;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u0yBsR2j+byO1XQSHA/npmzmeYHqJ0uWC0jlof706e0=;
	b=xfE1EMHQxMeOPQ2YGesMA23fgJKVPoU/ALPQJABdYg6HfLcVSe/QsZYY+qN7vyTzBo9E
	 B50q6/5J3QRrDop8uGWmfXJq1at5fCxkJrNWocvQ0hgfQeX+Z6NcgAyiKZgM4e2sxHK/G
	 TaNoVy1S5N1ydKfQmFRLRFrdu6XcpsX/ZtIa9SeqHIbnAtdxrAczj+Ni9DhT3jLxkMre7
	 v8WTebTPmlS5JgHr2gXVgx7qxYEVZ2E1axy8gIHZ3wVpnQ41nORdbZ9xzxowuPgFpEw9H
	 3ysAiNfZYmosDBdpbHARBwgrA27S2IhQ7hiprsn8o/0WEJ2f+evazb/frLpAlIndqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gt/AS8jm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17D606A331;
	Tue, 17 Nov 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gt/AS8jm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A1B1F000C5;
	Tue, 17 Nov 2026 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938484;
	bh=u0yBsR2j+byO1XQSHA/npmzmeYHqJ0uWC0jlof706e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gt/AS8jmyhjrcbnKpMFFZA3bZO8tYcap5Bff7dDzEM40GYkBvaxeBXz0GBotJIN3F
	 OlEPv/wBnb5tVC5StPRS7uu5K+LyCBD/T3yZZbWqca8nwpBmRfIAGAnp6fPBJ2df8a
	 A28qUJxnub8XGLJWFueF6CWZSbTOpwfVCSBU+ddUTP0NY9Db7GAOU9D40ApbiKyUq3
	 z9yjQlDBbn77w1UgNnFYVxx6L4U5E7O7nl05+uElDkRsI2xwdBWAN6V48rOsFXrWnL
	 iXcOENLlPL2DugxtWDNQBlrBDft91bRwrItxonTVkko/uQcDJrlVuJALCfl1fmAcPM
	 Gv/NlbVBBVksQ==
Date: Tue, 17 Nov 2026 12:01:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Danny Gonzalez <digonzal@google.com>,
	David Decotigny <decot@google.com>,
	Sheena Mohan <sheenamo@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Message-ID: <20261117180122.GA427856@bhelgaas>
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
In-Reply-To: <20240407011429.136282-1-baolu.lu@linux.intel.com>

[+cc Danny and others because this is related to ongoing work at
https://lore.kernel.org/all/20261020181053.2646782-1-digonzal@google.com/]

On Sun, Apr 07, 2024 at 09:14:29AM +0800, Lu Baolu wrote:
> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> devices") adds all devices probed by the iommu driver in a rbtree
> indexed by the source ID of each device. It assumes that each device
> has a unique source ID. This assumption is incorrect and the VT-d
> spec doesn't state this requirement either.
> ...

> +++ b/drivers/iommu/intel/iommu.c
> @@ -4299,9 +4299,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>       }
>  
>       dev_iommu_priv_set(dev, info);
> -     ret = device_rbtree_insert(iommu, info);
> -     if (ret)
> -             goto free;
> +     if (pdev && pci_ats_supported(pdev)) {
> +             ret = device_rbtree_insert(iommu, info);
> +             if (ret)
> +                     goto free;
> +     }

This change is upstream as 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in
iommu probe path"), but I think there's a problem here.  Previously
the rbtree insertion was unconditional, so the unconditional remove in
the error path was correct.

After 89436f4f5412, the rbtree insertion is conditional.  If
intel_pasid_alloc_table() fails, we try to remove it even though it
may never have been inserted:

>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>               ret = intel_pasid_alloc_table(dev);
                if (ret) {
                        dev_err(dev, "PASID table allocation failed\n");
                        goto clear_rbtree;
                }
    ...
    clear_rbtree:
        device_rbtree_remove(info);
    free:
        kfree(info);

> @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct device *dev)
>       struct intel_iommu *iommu = info->iommu;
>  
>       mutex_lock(&iommu->iopf_lock);
> -     device_rbtree_remove(info);
> +     if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
> +             device_rbtree_remove(info);

This is also somewhat problematic because it relies on the assumption
that pci_ats_supported(X) always returns the same value it returned in
intel_iommu_probe_device().  That may be true today, but I don't think
you should rely on it.

I think both issues could be solved if intel/iommu.c kept track of the
rbtree insertion itself, e.g., with a bit in struct
device_domain_info.

>       mutex_unlock(&iommu->iopf_lock);
>  
>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> -- 
> 2.34.1
> 
