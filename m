Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87412E739C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209844; cv=none; b=KMToXuZaSjTlawHE34zSCuaQX6cLDOYNYn4zXa1ZP5Wy8OgP+vGZrd4djCPd57edNbH2teCwc3QGThtqS+zOfRR1OQxmQE6t/95Z/TQy2dTI6sg0bs5ZcUXEBnGsApkEIry4UaS/wlkMaGzmMMXyCBukXlTVe1NwdUW1631Im98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209844; c=relaxed/simple;
	bh=lV0APC2Q40R0+8rJBHhGtOzbEJq9+wSP+YtjJIHFsGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7v8bIseQSZGeIS8y7kqS6Fggp/sCLeULL+cIEdWbNdBXUaXtYQW00D2pplbLbe2P0pXM1LhB5TPzQgkOFpw1ZocGRsjKiZBHYu5F+S7acRggVQ26atOxfX7dveveRL6q4c8dAwMRIzwzldY74F48tTsmrflB7yOsrlb48qXyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWfOpwZx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWfOpwZx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2911f93cso6125ad.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781209841; x=1781814641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O89fLhwmUexwr334yt/hIAtfe9wNMTELN1E0wgrm87U=;
        b=nWfOpwZxIUP99J4xNrGGATsknuIG+E02zwK+w+bq+MJtsqMF2UGogyB34tOsmJD8/i
         OAv2hs5WzCrtLXTMZK4RGFDcCJgfkrftDF5AJwVvPiJ6hCYCRuFajsvfFRNafi3pzSdH
         xfyDAFk7PUQ/mEgrnZwq+Ql754Bk+WDP7SUoC445MThEGzXqkTxwahGxSZopnIerGBK3
         Fe9InJSk/jWL+5t9QVO/lSyzpdszcBLgXgYWHnuPceXhNym1eOJoyxbBa6bqBLiCK9+9
         NiaA3D19TwVDN3Ty61inltkca+ojcSI+YacqYf85wX0E7sL022UIxEwlcD4NzirwFoIA
         uH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209841; x=1781814641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O89fLhwmUexwr334yt/hIAtfe9wNMTELN1E0wgrm87U=;
        b=hIfT0kxVlWsa8qcpxkL6vd7sz+E7WA0opF/oUvHzc1wFWIhxO/UTVhDBF/8ZdC0JPZ
         C4niQKSgObs/mIogrrQjHQPKZlXy/TFAhUSqOjbP6wgAVTffqg7Tip9inkq8Y3EoqkOX
         crGJBUTLtxt52UeBskLUPP5osG9l6g0+d6b2N1nNBDCTMDZ6PREqUTMXGYhQVEvmcjBW
         XZ780wtmXB+nhrtfa0f9meVDDehEYAs4Ccip5IzJjiZu6n9FwpH9aS03/O+Yt2zxMB35
         kx+L/+Mbeti0d+60YQ+GEefwi3eHt4yw3OqwjZ6Amz+qmHyfxy70/I7nh6EXdvud39da
         l6MQ==
X-Forwarded-Encrypted: i=1; AFNElJ/geE6u6snAJoykLag3hJeeQwgdrfaUY9s74Wi7Z00TVBJiezR7ZUmbf9c3wtDQIzeBpli0E3kMdvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+jkplklNUGAOAZMBSK8juAm6eLZMSYyzuQWe2P4kcKxqEMem
	DBFde56Kmfaq9rjc+NYjg1GW0l49jvrkp/dt/bFqBuOn7KI5RUF6IaOxLeci3CPe2A==
X-Gm-Gg: Acq92OHY0kreiG5x8R0aX0wf4TkPNX9fGV7FKIsly33/J/LdOCv+AGs19FQdTldJWBS
	ihavPhwtqkO2bSZtq1IesYrByJn6OUlEWpvI9RyLT8yZ/jBLKf1nNBf+8AFzHY+rWBl6VBNLsjt
	TLCfLR8tlNTL7YMIBnkvMxEKQUhRpiFgOrcoTqUJpU54s4KeUNFbFNJQEsdcO6Cq0dMjKE/eMWg
	cO6fZrpaDmAsfp0UP3dwgyMiqtzQ17dEwPEWXlHtVONReUoJRggKmTCxpafXR/T23w8rd4LDY13
	Yz4agxutox4W6xWLgJhKNGex/XCTF6oeDV+/I123LWQpqsGlRP8KHmnaIO1Nx7OXJFCChM88hle
	N3C3tni0bTH43obuTec/D9nsuLpTANHXMZEMLqV2zxlpL2JywHx3538ymkeQEeRfNXx4x9ZwLMk
	nqV343bxEKM5pvCGMCajoW+i73aX2jBQ4yPtbq2aQCXoQ+R/XQ3lsYJpAxTR0Q
X-Received: by 2002:a17:902:ef47:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c405c8b1bcmr130535ad.13.1781209840425;
        Thu, 11 Jun 2026 13:30:40 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df6esm311256825ad.48.2026.06.11.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:30:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:30:32 +0000
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
Message-ID: <aisa6H-a-176MXhC@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-3-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:16PM +0100, Matt Evans wrote:
> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
> 
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
> 
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 137 ++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_priv.h   |  20 +++++
>  2 files changed, 144 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..9e5e865f6fb6 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -9,19 +9,6 @@
>  
>  MODULE_IMPORT_NS("DMA_BUF");
>  
> -struct vfio_pci_dma_buf {
> -	struct dma_buf *dmabuf;
> -	struct vfio_pci_core_device *vdev;
> -	struct list_head dmabufs_elm;
> -	size_t size;
> -	struct phys_vec *phys_vec;
> -	struct p2pdma_provider *provider;
> -	u32 nr_ranges;
> -	struct kref kref;
> -	struct completion comp;
> -	u8 revoked : 1;
> -};
> -
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  				   struct dma_buf_attachment *attachment)
>  {
> @@ -106,6 +93,130 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long address,

Nit: s/address/fault_addr ?

> +			      unsigned int order,
> +			      unsigned long *out_pfn)
> +{
> +	/*
> +	 * Given a VMA (start, end, pgoffs) and a fault address,
> +	 * search the corresponding DMABUF's phys_vec[] to find the
> +	 * range representing the address's offset into the VMA, and
> +	 * its PFN.
> +	 *
> +	 * The phys_vec[] ranges represent contiguous spans of VAs
> +	 * upwards from the buffer offset 0; the actual PFNs might be
> +	 * in any order, overlap/alias, etc.  Calculate an offset of
> +	 * the desired page given VMA start/pgoff and address, then
> +	 * search upwards from 0 to find which span contains it.
> +	 *
> +	 * On success, a valid PFN for a page sized by 'order' is
> +	 * returned into out_pfn.
> +	 *
> +	 * Failure occurs if:
> +	 * - The page would cross the edge of the VMA
> +	 * - The page isn't entirely contained within a range
> +	 * - We find a range, but the final PFN isn't aligned to the
> +	 *   requested order.
> +	 *
> +	 * (Upon failure, the caller is expected to try again with a
> +	 * smaller order; the tests above will always succeed for
> +	 * order=0 as the limit case.)
> +	 *
> +	 * It's suboptimal if DMABUFs are created with neigbouring
> +	 * ranges that are physically contiguous, since hugepages
> +	 * can't straddle range boundaries.  (The construction of the
> +	 * ranges vector should merge such ranges.)
> +	 *
> +	 * Finally, vma_pgoff_adjust is used for a DMABUF representing
> +	 * a VFIO BAR mmap, which is created from the start of the
> +	 * offset region.
> +	 */
> +
> +	const unsigned long pagesize = PAGE_SIZE << order;
> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> +	unsigned long rounded_page_addr = ALIGN_DOWN(address, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long page_buf_offset;
> +	unsigned long page_buf_offset_end;
> +	unsigned long range_buf_offset = 0;
> +	unsigned int i;
> +
> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
> +		if (order > 0)
> +			return -EAGAIN;
> +
> +		/* A fault address outside of the VMA is absurd. */
> +		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
> +		     address, vma->vm_start, vma->vm_end);

This could flood dmesg if triggered repeatedly by userspace :( 
Since a fault outside the VMA is an invalid access that already results
in a SIGBUS, we could probably avoid the WARN here?
Perhaps pr_warn_ratelimited() should suffice?

> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * page_buff_offset[_end] is the span of DMABUF offsets
> +	 * corresponding to the faulting page:
> +	 */
> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
> +					vma_off, &page_buf_offset) ||
> +		     check_add_overflow(page_buf_offset, pagesize,
> +					&page_buf_offset_end)))
> +		return -EFAULT;
> +
> +	for (i = 0; i < priv->nr_ranges; i++) {
> +		size_t range_len = priv->phys_vec[i].len;
> +		phys_addr_t range_start = priv->phys_vec[i].paddr;
> +
> +		/*
> +		 * If the current range starts after the page's span,
> +		 * this and any future range won't match.  Bail early.
> +		 */
> +		if (page_buf_offset_end <= range_buf_offset)
> +			break;
> +
> +		if (page_buf_offset >= range_buf_offset &&
> +		    page_buf_offset_end <= range_buf_offset + range_len) {
> +			/*
> +			 * The faulting page is wholly contained
> +			 * within the span represented by the range.
> +			 * Validate PFN alignment for the order:
> +			 */
> +			unsigned long pfn = (range_start + page_buf_offset -
> +					     range_buf_offset) / PAGE_SIZE;

Minor nit: I'm aware that decent compilers convert pow(2) divides to >> 
However, we seem to be using `>> PAGE_SHIFT` across vfio-pci. E.g.:

return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;

Let's consider using the same pattern?

> +
> +			if (IS_ALIGNED(pfn, 1 << order)) {
> +				*out_pfn = pfn;
> +				return 0;
> +			}
> +			/* Retry with smaller order */
> +			return -EAGAIN;
> +		}
> +		range_buf_offset += range_len;
> +	}
> +
> +	/*
> +	 * A hugepage straddling a range boundary will fail to match a
> +	 * range, but the address will (eventually) match when retried
> +	 * with a smaller page.
> +	 */
> +	if (order > 0)
> +		return -EAGAIN;
> +
> +	/*
> +	 * If we get here, the address fell outside of the span
> +	 * represented by the (concatenated) ranges.  Setup of a

Nit: double space before "Setup" and "But" below.

> +	 * mapping must ensure that the VMA is <= the total size of
> +	 * the ranges, so this should never happen.  But, if it does,
> +	 * force SIGBUS for the access and warn.
> +	 */
> +	WARN_ONCE(1, "No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
> +		  address, order, vma->vm_start, vma->vm_end, vma->vm_pgoff,
> +		  priv->nr_ranges, priv->size);
> +
> +	return -EFAULT;

The fall-through logic at the end feels a bit redundant.

If we've exhausted the phys_vec list without finding a match, returning
-EAGAIN for order > 0 seems like the correct fallback behavior.

However, the subsequent WARN_ONCE for the order == 0 seems unnecessary?
An out-of-bounds access is an error that should simply return -EFAULT 
(converting to SIGBUS) without polluting the kernel log with stackdumps?
Can we instead convert this to a pr_warn or something? Something like:

	ret = order ? -EAGAIN : -EFAULT;

	if (ret == -EFAULT)
		pr_warn_ratelimited("No range for addr 0x%lx...\n", address);

	return ret;

(with appropriate comments)

Thanks,
Praan
