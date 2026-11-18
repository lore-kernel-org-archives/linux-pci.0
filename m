Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016950;
	b=GdNCPrhMENSmIMwVz5sl8kX0wquox3tqtIYTLduul5rfD6vq/mVyWa8hoZYgsB1soZvp
	 +InjAmwOBIDbnv8MGmkDHduvI2oU6zG4+4jSOF9qnojODEhwD0dIHN1vTxL6cmAtwDht5
	 leVw5HdD5dHL9R6oUD0hnmuYwYMHKsauRMhygw93XGeQPjt/Bboyvr8HZHNxWvDKrPypl
	 sjX9gnKG29WBn/o0JDpMz5cv8NHK7tw8O179PlUdMvl85ZJamLSW4Ns5XEibWhBsjkoKW
	 9jqTjpLyX2VfPqtqdAEbQZTqbHkEEMzpoQdKo27w++DjZha8WWcVC2TPfWaYmQSNfVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016950;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FjZOki/PxbChN/kpkS56mEwjlmPMGGtTDbC5dO/f5VE=;
	b=kGMkL33yg721TVDyPN4oSHtmF1WZ1ShhIdT8aYej3V35EwtcVjVw5SNXx761Rf364vE0
	 rpMCXt6XpWkcr7Ao5euf/fO2VkEa2wwgBV5bP7am028yKyCdXyehAwREvC6OaaH+BaVh3
	 V1GXJq+DB6rOzqV/0dKrOeBwe2KRPokE/1CMak9CWuWYKc720x0bejBSAcBzB/8e+FWfY
	 +CxwYZA4bOTkpO0xxMO3cHdUOsQe9YeLlYE7QarHXslhFlsSSUT5oqJmCKZKqqjOJPnQa
	 8jt+VuEhxpCTazhFThNHscmuPjgtkSpp4+wCYw0wx5wpSPdC02sk4dLRMhNNn6L/uXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DelL2Ase;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5B606A331;
	Wed, 18 Nov 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DelL2Ase
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076AD1F000C4;
	Wed, 18 Nov 2026 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016950;
	bh=FjZOki/PxbChN/kpkS56mEwjlmPMGGtTDbC5dO/f5VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DelL2AseCkpI9pEwA1L5gY3UDxZ4DYa78FSdItn2+haIXyHKwqolDF9MxHW0qAI2U
	 uGaRVw8t2ioh7l/hl7O4t/jnQY9aWtWF0HCkkVr1mXPMCs0PUdw81JezykySJPjEaj
	 2nP+19nhBrZjLJPR/IYJJy52e53SrC4BjjM8C1FTgt7iIelEn9gZJitVhgpmfHjWjL
	 l/2srAkF43eDWCRIGaKXQKVrpeGUFw6uTPG1iqhNGa0AplApXrllzYbPz17vmnmehi
	 YAUHdHNQNA2KkI/iZ9/GXnbJmiprerrF9eoO4A4ELdrlaCE9Pmh8mS4n7OuCd5rYQO
	 wSCdMKJW26xmA==
Date: Wed, 18 Nov 2026 09:49:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <20261118154908.GA501396@bhelgaas>
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
In-Reply-To: <19551f22-84cd-4256-a24b-f26c61502368@linux.intel.com>

On Wed, Nov 18, 2026 at 03:49:30PM +0800, Baolu Lu wrote:
> On 11/18/2026 2:01 AM, Bjorn Helgaas wrote:
> > [+cc Danny and others because this is related to ongoing work at
> > https://lore.kernel.org/all/20261020181053.2646782-1-digonzal@google.com/]
> > 
> > On Sun, Apr 07, 2024 at 09:14:29AM +0800, Lu Baolu wrote:
> > > Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> > > devices") adds all devices probed by the iommu driver in a rbtree
> > > indexed by the source ID of each device. It assumes that each device
> > > has a unique source ID. This assumption is incorrect and the VT-d
> > > spec doesn't state this requirement either.
> > > ...
> > 
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -4299,9 +4299,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> > >        }
> > >        dev_iommu_priv_set(dev, info);
> > > -     ret = device_rbtree_insert(iommu, info);
> > > -     if (ret)
> > > -             goto free;
> > > +     if (pdev && pci_ats_supported(pdev)) {
> > > +             ret = device_rbtree_insert(iommu, info);
> > > +             if (ret)
> > > +                     goto free;
> > > +     }
> > 
> > This change is upstream as 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in
> > iommu probe path"), but I think there's a problem here.  Previously
> > the rbtree insertion was unconditional, so the unconditional remove in
> > the error path was correct.
> > 
> > After 89436f4f5412, the rbtree insertion is conditional.  If
> > intel_pasid_alloc_table() fails, we try to remove it even though it
> > may never have been inserted:
> 
> info->node is initialized with RB_CLEAR_NODE() before the insertion, and
> the remove helper checks RB_EMPTY_NODE() before erasing. If insertion
> was skipped, removal is a no-op, so this error path does not need
> another state check.

Seems like RB_CLEAR_NODE() and RB_EMPTY_NODE() are lacking
documentation: RB_CLEAR_NODE() isn't used at all by lib/rbtree.c and
Documentation/core-api/rbtree.rst doesn't mention it.

But I agree, this does look safe as-is, though requiring a little
inside knowledge of rbtree internals.

> > >        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> > >                ret = intel_pasid_alloc_table(dev);
> >                  if (ret) {
> >                          dev_err(dev, "PASID table allocation failed\n");
> >                          goto clear_rbtree;
> >                  }
> >      ...
> >      clear_rbtree:
> >          device_rbtree_remove(info);
> >      free:
> >          kfree(info);
> > 
> > > @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct device *dev)
> > >        struct intel_iommu *iommu = info->iommu;
> > >        mutex_lock(&iommu->iopf_lock);
> > > -     device_rbtree_remove(info);
> > > +     if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
> > > +             device_rbtree_remove(info);
> > 
> > This is also somewhat problematic because it relies on the assumption
> > that pci_ats_supported(X) always returns the same value it returned in
> > intel_iommu_probe_device().  That may be true today, but I don't think
> > you should rely on it.
> 
> Agreed. The release path should not re-evaluate pci_ats_supported().
> 
> > I think both issues could be solved if intel/iommu.c kept track of the
> > rbtree insertion itself, e.g., with a bit in struct
> > device_domain_info.
> 
> Sure. I will address this with a follow-up patch.

Great, thank you!

Bjorn
