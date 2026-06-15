Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FD400DEB
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536087; cv=none; b=bTOzm880Hx7Ie45QPXTU35TunvqZPsu4DQSRy+kaBNFIz5eso5ZK9R56gIV8DUY0PovHyxbymdA82iGObnh63Jh5kr34Jwvt3R4gAYLlZ+CthwDhcRFGIWmWQQ32uGRJNniF+9gFNmTmQ3W+g2pUzxLvNnN/OTrs66iYxC85gVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536087; c=relaxed/simple;
	bh=iR2hSSDkL1kRTIBYK/+5XFgbHaciT/TvyEr2mqoFFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt7zTxdFksyfhNH+z4uEGsA2ZwRcCTTDvuDqHoKSsOVQ/DWhVq1TCLoKs4ZkMJXHz5Ulkr4M7KTEr8ngbrxHtITcxHpxyc7moF7EIGM6SdYc57ZpGxazOVcFRr8NMwSFGXKvsEb2RVJEM0KWO28AyD6BY5wEgXXLPKsqlXveubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpIHM/Uo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpIHM/Uo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2d865383so155075ad.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781536085; x=1782140885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeLNOUGcyQ4NWkfW/DAB6S96aMOzAOJTH9w4j6T6BeY=;
        b=lpIHM/UoPWhGGre6xBoqJOnXuAYe2NumKKsbVHJo9tbHk/Qkxc66vU82Z86UzTGpSQ
         0TA21fb26QKQkmxva7RTFoJOq7oMP0hwcPXMnIMxWCRTq1kt7PUE9CCyIinikPkgddQ9
         z5od++B4s6DkRsrWGKsyoAf0j1veM0C0yy2AvNBhJf2c3Jlr6Pl/tv58Z2KRkr5BNwHE
         5T9EddCE+8Eb00f0L6uykk7hGjS14McCnvUSDwqDBfuLmgdEN1YSKY4ugCH3EZL5dhq1
         9o7tIAN/j+FuX7UHYXZ1wscdJffSL10qumawN6xmRM89tBIFMCTFzij4xXBmsK3Rdkg/
         dx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536085; x=1782140885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeLNOUGcyQ4NWkfW/DAB6S96aMOzAOJTH9w4j6T6BeY=;
        b=VlulHD3rle8L++if3t+vXxzYWWS+8nxIc9dQDc2QSwxScyR29xHwg+ZljxdaMhJ95U
         DpwNiDdN8ntcOOSU0rdaPx+t5LWJGZejzfQH8loN4piScLJE9ZWYNUDam0GaibRF7qjh
         elm/Os0cVrd7kphAHPCfy5KZ1y9ObGdNf5QjqTY4NOIejnwEwyVw/6mWNOFLwyLb7Z00
         ppTkHPsNVQZTia00RXwM0H7x6qbdnj6bbOFxTfHcNQOfyhesqNd0NU7Z1I/Ljx0xySs3
         kNE/m0RGrZ1kTw9mvAUVNa8LbVT3x9DOIim28JeeDdoip9KQKD8ZWElieHtIOHDWkH+E
         O0vg==
X-Forwarded-Encrypted: i=1; AFNElJ/izHwewdxcVzh6aQQdFE2404PXvzGqDhYOtHtG7EE9EIg6mNQ0MhOkw08CE+dFi2g2wihTtcPq6xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGJLaABZCXr14SbzvJtwwIu4ghRdr1s2MdQSZcxQw8afpDq3c
	/sy6YWb8XQirM0JMe1zUwBW/7IGkQF7KV2ec83awgBmLVD/6+Nw/VwhKwyJzJgTNoA==
X-Gm-Gg: Acq92OHgEGBGC71J8WyDIbeEZdeZmLgHyCIFK1xzdrSNTnn4rPOYhimYzdQH3RbAgGl
	VXHgrgiJwTllPo7MC0FWdTzYsbApBHPeCnmy8fFfvAVFrSj2i5hlBqW0ayG1pYa5LkufY8UWxFo
	1eFPS3TcxuFNEEscwD/7WrkQwS9RX5XDuSufwxp6RIqF7Z9Y52TbFuj7DnsmVEtm6HMTKI6U6WG
	l6tOmBkfKQDPu+O1e5aV8p39adSepbf0TzLtr4q1Ces9lftYIEQl147se/IfFpzgbn+DKkEhHVF
	2f/l1S2gSQ+Oy11yxGtGVLqPvWc3recpbrDHShkuRUjf92+AG9d+oE/oOCqR/qiRsEp/faF7s6C
	wCi7GNf4Y9rFWaHBIhbzff+2NR3SDknLm/R5nJ89pvs3R2HQ7r9dON99/u+zkUcJCJMInqqeGxs
	UllPEYcEcSv8Cus6NC3BloWtQzSH27dX2ujz2W8DFJ1G+XW4TDqm5Z1yAp/vXg
X-Received: by 2002:a17:903:320b:b0:2c0:c3ac:fdf9 with SMTP id d9443c01a7336-2c69689a4aamr525115ad.14.1781536084472;
        Mon, 15 Jun 2026 08:08:04 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm102831385ad.21.2026.06.15.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:08:03 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:07:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <ajAVSx9gPz1KkIbF@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <aisa6H-a-176MXhC@google.com>
 <effb66ee-764b-4823-b6e4-c932a1f60f8d@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effb66ee-764b-4823-b6e4-c932a1f60f8d@ozlabs.org>

On Mon, Jun 15, 2026 at 03:27:01PM +0100, Matt Evans wrote:

Hi Matt,
> 
> On 11/06/2026 21:30, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 04:43:16PM +0100, Matt Evans wrote:
> >> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> >> find a PFN.
> >>
> >> This supports multi-range DMABUFs, which typically would be used to
> >> represent scattered spans but might even represent overlapping or
> >> aliasing spans of PFNs.
> >>
> >> Because this is intended to be used in vfio_pci_core.c, we also need
> >> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> >>
> >> Signed-off-by: Matt Evans <matt@ozlabs.org>

[...]

> >> +
> >> +	const unsigned long pagesize = PAGE_SIZE << order;
> >> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> >> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> >> +	unsigned long rounded_page_addr = ALIGN_DOWN(address, pagesize);
> >> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> >> +	unsigned long page_buf_offset;
> >> +	unsigned long page_buf_offset_end;
> >> +	unsigned long range_buf_offset = 0;
> >> +	unsigned int i;
> >> +
> >> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
> >> +		if (order > 0)
> >> +			return -EAGAIN;
> >> +
> >> +		/* A fault address outside of the VMA is absurd. */
> >> +		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
> >> +		     address, vma->vm_start, vma->vm_end);
> > 
> > This could flood dmesg if triggered repeatedly by userspace :( 
> > Since a fault outside the VMA is an invalid access that already results
> > in a SIGBUS, we could probably avoid the WARN here?
> > Perhaps pr_warn_ratelimited() should suffice?
> 
> I'm OK moving to a pr_warn_ratelimited().  Note though that this case is
> "genuinely impossible" currently and the check exists in case something
> changes elsewhere.  (Re your flood comment, am I missing a way for
> userspace to trigger this?  The scenario is a faulthandler for a VMA
> getting a VA outside the bounds of that VMA; such a fault address
> wouldn't match that VMA.)

I should've been explicit, I guess I worded it wrong, my bad.
I didn't mean that a user-space could hit this on it's own. However,
I meant to say if there's a bug in core mm during some future work,
dmesg being flooded by stackdumps gets messy (especially during dev) as
the underlying reason might get missed in the flood. Hence, I prefer
moving to pr_warn_ratelimited.

> 
> >> +		return -EFAULT;
> >> +	}
> >> +
> >> +	/*
> >> +	 * page_buff_offset[_end] is the span of DMABUF offsets
> >> +	 * corresponding to the faulting page:
> >> +	 */
> >> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
> >> +					vma_off, &page_buf_offset) ||
> >> +		     check_add_overflow(page_buf_offset, pagesize,
> >> +					&page_buf_offset_end)))
> >> +		return -EFAULT;
> >> +
> >> +	for (i = 0; i < priv->nr_ranges; i++) {
> >> +		size_t range_len = priv->phys_vec[i].len;
> >> +		phys_addr_t range_start = priv->phys_vec[i].paddr;
> >> +
> >> +		/*
> >> +		 * If the current range starts after the page's span,
> >> +		 * this and any future range won't match.  Bail early.
> >> +		 */
> >> +		if (page_buf_offset_end <= range_buf_offset)
> >> +			break;
> >> +
> >> +		if (page_buf_offset >= range_buf_offset &&
> >> +		    page_buf_offset_end <= range_buf_offset + range_len) {
> >> +			/*
> >> +			 * The faulting page is wholly contained
> >> +			 * within the span represented by the range.
> >> +			 * Validate PFN alignment for the order:
> >> +			 */
> >> +			unsigned long pfn = (range_start + page_buf_offset -
> >> +					     range_buf_offset) / PAGE_SIZE;
> > 
> > Minor nit: I'm aware that decent compilers convert pow(2) divides to >> 
> > However, we seem to be using `>> PAGE_SHIFT` across vfio-pci. E.g.:
> > 
> > return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
> > unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
> > 
> > Let's consider using the same pattern?
> 
> (Do you know of a compiler that both builds the kernel and does NOT
> perform this transformation?  I am confident that resulting object code
> will be OK here.)
> 

I guess most of the modern compiler do, I was just referring to the
style across the file. I don't have any strong opinion.

> In an earlier revision I was using shifts but they were fairly messy
> compared to this expression, which arises from a request by Jason.
> 

Yea, looking back at Jason's comment [1], I think he was mainly pointing out
that the common factor (PAGE_SIZE) could be grouped together. But again,
no strong feeling about this, just picked up a pattern across the file. 
If it breaks on some compiler we can fix it later..

> >> +
> >> +			if (IS_ALIGNED(pfn, 1 << order)) {
> >> +				*out_pfn = pfn;
> >> +				return 0;
> >> +			}
> >> +			/* Retry with smaller order */
> >> +			return -EAGAIN;
> >> +		}
> >> +		range_buf_offset += range_len;
> >> +	}
> >> +
> >> +	/*
> >> +	 * A hugepage straddling a range boundary will fail to match a
> >> +	 * range, but the address will (eventually) match when retried
> >> +	 * with a smaller page.
> >> +	 */
> >> +	if (order > 0)
> >> +		return -EAGAIN;
> >> +
> >> +	/*
> >> +	 * If we get here, the address fell outside of the span
> >> +	 * represented by the (concatenated) ranges.  Setup of a
> > 
> > Nit: double space before "Setup" and "But" below.
> 
> I liked Alex's response :-)  This is common practice for monospaced text
> since increasing inter-sentence spacing helps readability in paragraph
> blocks (see Documentation/ for many examples ...).
> 

Ack. :)

> >> +	 * mapping must ensure that the VMA is <= the total size of
> >> +	 * the ranges, so this should never happen.  But, if it does,
> >> +	 * force SIGBUS for the access and warn.
> >> +	 */
> >> +	WARN_ONCE(1, "No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
> >> +		  address, order, vma->vm_start, vma->vm_end, vma->vm_pgoff,
> >> +		  priv->nr_ranges, priv->size);
> >> +
> >> +	return -EFAULT;
> > 
> > The fall-through logic at the end feels a bit redundant.
> > 
> > If we've exhausted the phys_vec list without finding a match, returning
> > -EAGAIN for order > 0 seems like the correct fallback behavior.
> 
> This path can happen (for order > 0) e.g. mis-alignment of VA versus the
> PFN, i.e. is likely...
> 
> > However, the subsequent WARN_ONCE for the order == 0 seems unnecessary?
> > An out-of-bounds access is an error that should simply return -EFAULT 
> > (converting to SIGBUS) without polluting the kernel log with stackdumps?
> 
> ...but the only way this can happen, for order == 0, is if the VMA
> extends beyond the underlying resource.  For example, if the VMA is
> larger than the DMABUF size (the total length of phys ranges set up
> inside the DMABUF).  Both VFIO BAR mmap() and a DMABUF mmap() disallow
> mapping off the end of the underlying resource.  That is, this also
> "cannot happen" but if logic changes elsewhere then we will really want
> to know about hitting this case -- the check is not redundant.

I didn't mean to imply that the path itself is impossible or won't 
happen.. I just meant that the logic / structure felt a bit redundant at
the end of the function..

Instead of having the separate `if (order > 0)` block falling through to
the base case, I suggest it could be cleaner as:

	ret = order ? -EAGAIN : -EFAULT;

	if (ret == -EFAULT)
		pr_warn_ratelimited(...);

	return ret;

But again, that's a preference. I'd leave that to your judgement.

> 
> Still, it doesn't need a regdump/backtrace (at least while this is only
> called from one spot), so a pr_warn_* is better.
> 

Ack.

Thanks,
Praan
