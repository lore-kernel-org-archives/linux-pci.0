Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3024886E
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275828; cv=none; b=g7blOcYlr83d3GnYEcHZP0WVWcMSmvieBPyitjO0N3vWOwFDZkLD3Xu/SLQJ/6IhUdQN++bf3kqMv1xqBxY7hR+mYbFSHIRTWaesQowHBj6sJ1epiz3ozQh9RgPot2uvvsk6O5H/U4Jswwga5SwLnTJ4UdyxZ73fD30JL9InL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275828; c=relaxed/simple;
	bh=ktJEoejF4IYc2x2sx5hNzOusqn1PFWfmraLH5p9R6zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC4hd4ZJYFL7kHUOsk5IrSkUJmPhkaSd4PkZcnrabUdd39y5EPPJ5C6XL6TBbp4hGhTIZwGEu7nBrp6+NFAex/sKZYJCz+d3vh51Pe+F5S8BRo6UTC3FYMIuSw2zqt9kEjQc4sDmzBgYi7gqr1xYGTTCzsSLtzYamIWkD9UPkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcErODWZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcErODWZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b1a48855so117865ad.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781275826; x=1781880626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKPEKDhY7MEkgse5vNpBg59/8pjz1cpSSV/zhg7oF9E=;
        b=ZcErODWZ/U+nUPxMmEv908bsS0S53JqNsdPVrwuiUXQR6xzrpMlzDbRfWs4pDrRNBs
         XdFvi6Vfcgexc7xuhQ+AiCox+kc2p/4jATO1IZ5jzQ/OCsNMacY1Ru2+wjPS6/908v2a
         wu352v6ehffF9GmvaIpBuaUHhCADthkerJYsfoyRTPjT3fPBPUY8asxPuAllC895AvkM
         xnYS7MdHnCoFKPMlNN7M7T2cyIgMFlj+4IRISsh/7OPXKKAUF8iyMsE4gU2vq+MDKb7R
         yPNYS+4AwDVCaPrucN/dzPIBYUJz1xw4lb8BNJrE2Y/9Jl2dM63nz/l5fJVxwU2+nlsf
         B57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275826; x=1781880626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKPEKDhY7MEkgse5vNpBg59/8pjz1cpSSV/zhg7oF9E=;
        b=hFI4BIIgY9RHvT4ZSTxfhsH/BzWjdXAMm7PKFGhaf543d2Q+Axtp6r/8WUKoZqfvmx
         WRtDgJkdGAVZYeziYSbXpGyeE2k2AgHdqgWYf8jieIrRg9sR3ekQRNyFdeUV4/oPS80u
         OA5jOp1S4cTukAdEKguIrkipDNdfm53eUluXs/yoHkpwQ/+KPvcxYsQ/8MWvrr+6qlw4
         GaNAh21N/YWw6mKHc8CMA3gBFlpHRk/GguDiybD7TCnnrRXhvlWr2VnIvwloj3uazpoi
         JFijuU+xcLp0m7Gr8t4PVvqDDhXR4uC4ZbVAXmmDSqaFiwqyeUEyE5sz3SrBTxijlx/O
         83bA==
X-Gm-Message-State: AOJu0Yy1XC7RPi4nA3w5/NBotUE+MSNe+1ywYj0Na+2exUo37WKoR22u
	rRewY53AGOPzbkR8Q89BAgjnnKvpiVLC6Bz1uHZQcBLF3p18cyiQwCypUICKWailYQ==
X-Gm-Gg: Acq92OEjdktBRlhcbDTrxujM90N4bj0B4Z8Xt+z9fnsRa1Pf7FIZb/2xdb34vfKY7xk
	xLLJGGKantxHHfZddYCHDjoCGI8Fh9k/hJ8zoPUMcOfJKYKDOpKOdjupIbRn8cBauy8hhqlpDta
	l8Ax9fyOH5ngk9DoBNVQpLAJSJJ8rn7ivmvEOiz2eGZV38rw9dDjiVp4lN+uxFTri7uVWuZSzUj
	67WB7XVtZqNkeMZrP9Brx5wnf76ynkub4CThuj+mrtyAuz8CNipDNu/u2v0Rm8HF1yDER9W72Pc
	uwv3y7AMIqIybj1Wo/WT2hkmGBaTR8B6nkuhgGNCr1DweN/nhc2rDl5gPZZ2wWMkh151t+g7od8
	l7hXHY+cRh8GHhbaQdkBlbWnIF7be+dAbo6fKjcjo2gEXuJsUciq0RiF09Y78/KyBSjK5zvZXMM
	C/EJMhe5F8ofdAfJkU5e3HcfUJK/jFyl8kmR3tNUCknCbwDRAy7a/VjAtrzu04
X-Received: by 2002:a17:902:f78d:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2c405c8818bmr2171605ad.15.1781275825932;
        Fri, 12 Jun 2026 07:50:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm23848235ad.62.2026.06.12.07.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:50:25 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:50:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <aiwcquSgAonkh_6L@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
 <20260611221447.GH1066031@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611221447.GH1066031@ziepe.ca>

On Thu, Jun 11, 2026 at 07:14:47PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > Users utilize the standard sysfs p2pmem/allocate interface for managing
> > > > memory slices once a BAR is registered.
> > > 
> > > I'm shocked someone wants to use API, what are you expecting to do
> > > with it??
> > 
> > Our primary use-case is PCIe BAR (DDR / HBM) -> NFS via P2PDMA while the
> > PCIe device is managed by a user-space driver based on vfio-pci. While
> > kernel drivers (e.g.drm) can register BARs with ZONE_DEVICE natively to
> > enable this, VFIO currently lacks an equivalent mechanism.
> 
> I mean the weird sysfs mmap API. It is only useful if the device is
> basically pure memory with no functionality. You can't even learn what
> MMIO offset the returned allocation gives so it is almost completely
> useless.
> 
> nvme could use it because CMB is pure memory and you reference it by
> its MMIO address, but that doesn't apply to VFIO..
> 

Ack, I agree, sysfs allocation doesn't provide the offset-level control.
I'll pivot entirely to the DMABUF approach.

> > > > An alternative implementation has been explored which integrates with the
> > > > ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> > > > registering a BAR as a system-wide P2P provider, VFIO optionally
> > > > allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> > > > new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.
> > > 
> > > That's probably more sensible but you can't have a DMABUF mmap
> > > actually install non-special memory. The native vfio mmap still can,
> > > but not mmap on the dmabuf fd. That's still workable, just keep in
> > > mind.
> > 
> > Ack. I guess, we could have a separate mmap path in case of BARs that are
> > struct page backed which doesn't go through the dmabuf exporter.
> 
> The dmabuf export is perfectly fine, you just have to think very
> carefully about the mmap path.
> 
> I suppose if you build the proper revocation fence for zone device
> pages as part of the vfio implementation it would be OK for dmabuf
> mmap to expose them as well since it would have the right lifecycle
> model.
> 

Ack, I'll move forward with adding a flag to request a ZONE_DEVICE-backed  
DMABUF export (the 'Alternative Approach' mentioned in the cover letter).

And yes, I agree we need to ensure the mmap path is handled carefully
with the correct lifecycle in mind.

> That's the tricky thing with zone_device, you have to be careful to
> wait for all the page references to be put back at all the right
> times.

Yea, that's going to be tricky.. I'm thinking if we can have a zap model
there somehow? If the device is gone / going through a reset, we can
handle the refcounts accordingly?

> 
> Come to think of it, since the sysfs API cannot do that in the way
> VFIO wants I actually think you can't use it..

Ack. Baking this into the VFIO DMABUF allows us to enforce the right
lifecycle.

My plan for RFC v2 is to add a flag like VFIO_DMA_BUF_FLAG_ZONE_DEVICE
to struct vfio_device_feature_dma_buf which allows the caller to opt-in
to ZONE_DEVICE backing specifically for that export.

Does this opt-in flag sound like a reasonable uAPI or do you see any
concerns with this direction?

Otherwise, as you noted, the lifecycle and the mmap path remain the main
problems to solve.

Thanks,
Praan
