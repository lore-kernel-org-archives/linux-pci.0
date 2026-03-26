Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5251F0E29;
	Thu, 26 Mar 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537263; cv=none; b=o1p/lyaddI8CylGSAY9zaop7sDnsd8WBS7iCOJeguQCSEjlE1m1JTMo+K7rYPJF2SxAe6S79XDDZw9Ci8fi+zmPVrQxttqb8ea/ODEVdfA28eRFk/w5Sn69SaUxP90OqkfXFoLFzrlX7a1SI7UxHmaaHlvD7xMa5+wTh8VrpKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537263; c=relaxed/simple;
	bh=uI9MNPdYl2qeJy2pXhMeCNu//MkAd1POrXug5aIHWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLb6cGahCYq0SbvZjNPoB84FmVlMJNAoUcjPsDYF0eOE8Mxbp3DzSyFF+6hdfBVtYRc9KhANnf6m1+TPBhW7JMe0s4f4swpIpqqrcjRSDaH/bapVLZnSog82iq6jo8V45MOB3uKpDp4EeG/lOoo0fCfpZcLFq6IdK0sAYGnMYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+kFz+WE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+kFz+WE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79464C19423;
	Thu, 26 Mar 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774537263;
	bh=uI9MNPdYl2qeJy2pXhMeCNu//MkAd1POrXug5aIHWY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w+kFz+WERn3ujSYopOv/94SQsVwhgKZer/eC+2dqGDF1Fv5QNhftEgUH/eBI6vYnb
	 Bjrsiu4mA6DUkIrtIAgJW/Tv6baMxohxfX9r+H73kSSOofEGkKwIWnGTw400wzDJH5
	 xnWxF69fu3XAYwl5M7Ds/B6ZQ0hb6sXBssHo05ls=
Date: Thu, 26 Mar 2026 16:00:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <2026032621-astound-mounted-07a6@gregkh>
References: <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
 <20260325115607.GB67624@nvidia.com>
 <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
 <20260326120046.GG67624@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326120046.GG67624@nvidia.com>

On Thu, Mar 26, 2026 at 09:00:46AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 25, 2026 at 06:27:04PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > [..]
> > > > Right, the potential to see in-between states concerns me because TSM
> > > > uAPIs would have fully enabled the device to wreak havoc, meanwhile
> > > > dev->trust is still showing the device at some lower level of trust. So
> > > > I think trust modification needs to be synchronous with privileges
> > > > granted/revoked.
> > > 
> > > If an iommu is present then the device will still be blocked even
> > > though it is in RUN, I'm not sure this synchronicity is so important.
> > 
> > Oh, maybe we are just quibbling about where the mechanism lives. The
> > "unblock DMA" step in current preliminary patches is currently behind
> > the "struct pci_tsm_ops::accept()" op which also handles transitioning
> > the device to RUN / T=1. It is a bus callback.
> > 
> > However, if the IOMMU layer is enlightened to block/unblock DMA on trust
> > setting then the TDISP "unblock DMA" step can be factored out of this bus
> > callback and into the IOMMU trust responder.
> 
> Yes, I would prefer this because it makes the whole IOMMU mechanism
> entirely general and not tied to TDISP - which I think is sort of what
> Greg is pushing on too.

That is what I am going to _require_ here :)

> > I assume this would also expect that encrypted MMIO mappings are also
> > not established while trust is less than "TCB"? That would require some
> > additional enabling to catch attempts to establish an encrypted mapping
> > that the hardware is prepared for, but dev->trust is not, all without
> > needing to modify the driver to worry about this difference. Drivers
> > would just see ioremap() failure in this case.
> 
> Hmm.. I don't know if this matters. Once we decide to use the device
> the MMIO should be mapped in the correct way, whatever that is.
> 
> If we decide to eventually allow a lower trust while T=1 then that
> should be taken to mean the user wants all the features protecting the
> communication channel but also all the IOMMU features restricting what
> memory the device can access.
> 
> Remember there are two parallel things here, one is T=1 which is
> designed to protect against hypervisor and physical attacks, the other
> is the trust level and iommu which would be able to protect against
> attacks from an attested device itself.
> 
> Even if you are in a T=1 environment you may still decide you don't
> really trust the device firmware that much and would prefer to have it
> more restricted.
> 
> For example, if you have a system with a NVMe drive then all the data
> on the drive is probably still encrypted and has be CPU-decrypted
> before it can be used. It would be reasonable to run in T=1 and attest
> the drive to limit attack surface but also use the IOMMU to limit NVMe
> access to only the memory used to bounce to the CPU decryption as an
> additional fortification.
> 
> This is why I am tending to prefer that the kernel's view of trust
> level and the physical HW capability are somewhat orthogonal
> things. Even if the HW has high security the user may still prefer
> that the kernel distrust.

I agree, that's a good way of putting this.

greg k-h
