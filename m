Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51925F988;
	Fri, 11 Sep 2026 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121670; cv=none; b=f4ACX5JcCXu5K2OwWG2++LnxoQrfiT7Xe/l7Ba9S94S95Zl9Qc173pzBFKoN9C9qELcxvVoZmbHbgTxKoL0zEZC2R81f+4CQnIuNhE4LbKm6EuU6qdrn28ehV+eZkmdY561CeCyYnFycfEnlPeaeOXp23zAOv11FVa6Ne/IvkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121670; c=relaxed/simple;
	bh=daeWscnDx8dvB2eHlBMWLHfgY76C9iXHjaQk+JLvD3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip0kFFmA/vJn1Nl9dlCrHtKrGgU3EAtcHv2Val3SkjhRo0vgsOY6Jp5PDZchV0OBCg3j7iW4ToVCKLYcblA7zIqbM1f/4IAoo85bMqvqr3KqmJctyzWl+ZDMs58ymJTIzK6PcbumRhWf6KhZ02tTqJeVG+CSc8JY6V9fGyamuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5edpecb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5edpecb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750961F000FF;
	Fri, 11 Sep 2026 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789121665;
	bh=/8SBSkfDIT5inX8znNv36k3+4QJE7DDTEEWhUMNpLsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G5edpecbHai7xsNmPGseVCWkqSuxOm6A3dRPaWn6dKdIbJyaQ/PlgmG5Alfa8w9r3
	 gTgMrEmYUca9kvz6ZFpSUu4Lwp0RhyS+Ojb4SeEaGwQmLECOlUzkCx6YwQNhZmhBcu
	 Ugiqaz/85lGP0rwb7Mp9LHkjN8b8i28j2ShqxPUonaf0URtForyzNQPT3pL7vScDcN
	 YauzywErdVBQd7NnyB1ghkWUrCM/gY+uw9QDOQPIFNtscqgr7pLhkBLeOoxVl1PmsT
	 QXAm5Sy5222LAdmgoMZ0RRphALcM2HkKKiFIes02inuFHRV4v2jT/zO1e4uluxMZiS
	 uRz4YT1Aq4Vfg==
Date: Fri, 11 Sep 2026 12:14:21 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in
 prefetchable windows
Message-ID: <aqPUfUuu1YKCvKnI@red-moon>
References: <20260910143440.3865663-2-ardb+git@google.com>
 <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
 <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
 <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>

On Fri, Sep 11, 2026 at 12:27:25PM +0300, Ilpo Järvinen wrote:
> On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
> 
> > 
> > On Thu, 10 Sep 2026, at 19:31, Ilpo Järvinen wrote:
> > > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
> > >
> > >> From: Ard Biesheuvel <ardb@kernel.org>
> > >> 
> > >> The prefetchable vs. non-prefetchable distinction is a relic of
> > >> conventional PCI, to denote from which regions PCI-PCI bridges were
> > >> permitted to perform speculative readahead.
> > >> 
> > >> For software compatibility reasons, PCI Express inherited the Type 1
> > >> header and models PCIe root ports as PCI-PCI bridges. However, this
> > >> readahead behavior does not exist in PCIe, and so this distinction has
> > >> mostly become meaningless on the bridge level.
> > >> 
> > >> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
> > >> 'prefetchable' designation has been removed from the specification
> > >> entirely, on the basis that it is obsolete, and is being abused to
> > >> inform memory mapping attributes and other device/BAR level properties
> > >> that it was never intended for.
> > >> 
> > >> Given the limited range for non-prefetchable windows in the Type 1
> > >> header, and the fact that the distinction no longer exists for PCIe,
> > >> resource allocation performed by firmware may result in non-prefetchable
> > >> 64-bit BARs being allocated inside prefetchable bridge windows.
> > >> 
> > >> Linux rejects such allocations ("can't claim; no compatible bridge
> > >> window") when it encounters them, but will usually fail to produce an
> > >> alternative allocation, given that firmware wouldn't have placed them
> > >> there in the first place if there was sufficient space in the
> > >> non-prefetchable window.
> > >> 
> > >> So at the very least, let's not reject such allocations when they were
> > >> made by the firmware.
> > >> 
> > >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> > >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >> ---
> > >> Link: https://github.com/tianocore/edk2/issues/13104
> > >> 
> > >>  drivers/pci/pci.c   | 3 ++-
> > >>  include/linux/pci.h | 4 ++--
> > >>  2 files changed, 4 insertions(+), 3 deletions(-)
> > >> 
> > >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > >> index b2879a6be5f8..e33eb9f3a139 100644
> > >> --- a/drivers/pci/pci.c
> > >> +++ b/drivers/pci/pci.c
> > >> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
> > >>  			 * not, the allocator made a mistake.
> > >>  			 */
> > >>  			if (r->flags & IORESOURCE_PREFETCH &&
> > >> -			    !(res->flags & IORESOURCE_PREFETCH))
> > >> +			    !(res->flags & IORESOURCE_PREFETCH) &&
> > >> +			    !pci_is_pcie(dev))
> > >>  				return NULL;
> > >>  
> > >>  			/*
> > >
> > > I was more thinking along the lines of always setting IORESOURCE_PREFETCH 
> > > for 64-bit BARs on PCIe devices but I've not had time to look at that/test 
> > > how many things would break as a result. ...It would seem much simpler 
> > > solution to differentiate PCI from PCIe while keeping the existing logic 
> > > without adding similar pci_is_pcie() checks everywhere.
> > >
> > 
> > I agree that the code changes would be much simpler.
> > 
> > However, would this impact the PCI metadata observed by all consumers,
> > including userspace,
> 
> Yes, it will impact userspace. But quoting you from above:
> 
> "is being abused to inform memory mapping attributes and other device/BAR 
> level properties that it was never intended for."
> 
> What does the userspace then do with the information? Does it qualify 
> under "it was never intended for"?

The issue is the resulting mmap in the kernel- we can end up mapping
MMIO regions that don't tolerate side-effects with NormalNC attributes on arm64
(that's what WC is on arm64 and in turn WC is detected in places - eg sysfs -
through IORESOURCE_PREFETCH), which can end up in mayhem because those mappings
allow eg speculative reads.

Hopefully, this is not an issue in kernel drivers because drivers *should* know
what a BAR is and should ignore the resource flag as far as mem mappings are
concerned.

> > and drivers that may expect a certain BAR layout,
> 
> ??? Would that even be spec compliant??
> 
> > and/or base decisions about memory attributes on this?
> 
> The point is to consider them 64-bit window eligible so yes, kernel would 
> definitely be basing decision on that but that's intentional.
> 
> > In particular, I am concerned about non-prefetchable BARs that actually
> > have side effects on read, being mapped with WC (or Normal-NC on arm64)
> > semantics, where the interconnect may widen, combine or reorder accesses.
> 
> So on a more concrete terms, you're referring to the check in 
> proc_bus_pci_mmap()? And the one in __pci_resource_attr_is_visible() + 
> pci_dev_resource_wc_is_visible()? I suppose that wouldn't work then.

Indeed, I don't want to speak for Ard but that's exactly a couple of places
where things can go haywire. Then there is PCI drivers even though I don't
think we should have a problem there but as Ard replied, who knows, see above.

Lorenzo

> So if just setting IORESOURCE_PREFETCH is not workable, how about adding a 
> getter for res->flags which adds IORESOURCE_PREFETCH into the returned 
> flags if it's PCIe device and (in the end) use the raw value only in those 
> places that actually care about wc distinction. What I don't want to see 
> us adding that pci_is_pcie() everywhere.
> 
> -- 
>  i.

