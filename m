Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3153C3A9
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933281; cv=none; b=ax6ACgkB62bINfKqo5sNwyYJXhLrJd7gykqaMDtPm+xNDpTX7nvSR3HcuqUFLxWEsAKJypS/x0JZiNpBW1hW/PrQhRN0p08W8qmXoCauBtlvRu4JMpbg7ASUUUNOTBu+oIKaAEzlbvKKTJxKSvQxOadYiL6M3g/lRrBoJr9sK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933281; c=relaxed/simple;
	bh=aJUbMo51Fo84x69LqMGta3YCryvENlLg9afLIEoPgYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3C5+RK94zyQ8coyWqtzDQO7hRaHYZAmskApt0maRf2jIFNexPzCeZUeib+IcR9HehESyw6XCGXJBVzQv2ArHhDqTYM16Asa6Uc86V5Vg617HhIz7sKbB3nl3X863ff40LEoQxkGlvQqwYupxB/OHkMK8ZHT+srmpzMJu8lEKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=uD0fPYoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ssFVSP8S; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="uD0fPYoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ssFVSP8S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D48E7A0266
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 19:14:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 19:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791933274;
	 x=1792019674; bh=3mVILoNFO302kVYfBZY05/6e2z9usB/QzLxXs0vvlMg=; b=
	uD0fPYoYdxy0MHfWLtsva8IqSjnROvGEsKf1UXjSPR/ZkxkvUiWURqOIUA5Pk/2M
	w+UH8Ows6fJXPirAhgO+7szWhayX56TlrOdQgYh1OiQ2U/Rf6OsrDNOR71hhGDtC
	v+CQ8swc9Gqd1w8d6/W6XT662mdWPn12cLx7mQoWKVWBf739gyBsHLWGqe3drrkA
	IcUIVByzlti9zEMdRIMXSBmk2gZHMsN7X9MF+/X43Q8PLRUmuB6Wtl1paV7yKaPh
	a/1RRify1pO1LNOKf5TY6RXXqHd85TRm0oWpHOsSwcPmD4LG7qsxl+DzWjjZOQ9k
	OLBNxu4W6rUp3es7LNTqHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933274; x=
	1792019674; bh=3mVILoNFO302kVYfBZY05/6e2z9usB/QzLxXs0vvlMg=; b=s
	sFVSP8SeekkY+MU5Rx8ny8AQwedU3LAMkvfPrqc0HCXH/ros60LrbmfR49OSxWq9
	vHiI9lTYVmUQGdilguPj/BWI3bVMyZR+r4U8NmUyroY0BZXc4WMc2tgnFgYVxWlh
	ON/hnkf9fDISBGbKYNQp47B0Sxi/Imj/78VJJhxADBaL1cdkpktioobBXEYtLDfV
	jBWmbeA//+WklQGZlygVuq+Ggx5gOTue9LZZ1afDp5CV3sOGLB991zmVOTZy8zKC
	1OEDSU3B7CAiw5biZt1k8dGoF7+SafVcu/xFYr5ihZDbPBXuxyluXG08X/ZiSTa/
	ycF/xz/52cgVI2bnTwXYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933274; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MR3u+uQG4UKzetbtYt/uSqJyBdh14hcg3twamkLo6DFVtQn
	h727d1gZ4P7UcbU81fz/YTIkoqvQ2w7qGfKIi6MTbjoOnAnpA1fLJojzWmC5fpqz
	Ynee3K/eZdx3IC7OExYQDrMr8jmNzcUyA3VLFrJgXZl38mAxi7sr96IIqYvssfk3
	tU19oCdE8/MA28tYn5CkJFhhy6xASspLyw9NTz5HoNQ39i1U3NIYs8OFYHbiAqEh
	Ju2V49KlX1DNy7bK87pcceVOXWUL5stIpwHcozlNQGa60eil0+TSCuotxVaJhSzv
	uYBUl39oJa2fm29NCmoTAxcUTXdKXpUcBwENHvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QWI/EjU44gUCOSb1vOa6OvekDV2UdEPruJocnUX0sks=:aJUbMo51Fo84x69LqMGta3YCryvENlLg9afLIEoPgYM=;
X-ME-Sender: <xms:WrvOagn9SG_dnWEUcIGw1LyfwizymLiuI5rADmsUmwTJYjXkFogASw>
    <xme:WrvOahfafh3zn7LtXhOTviXSkGpWk2LgrEZVI5vLvDVugoMj8PV9EaLblNIlzb4qC
    W3ZRYdheZmKW8pkJze7i30SfNgxDHe_NEIa5R2-qiN57fuwj58>
X-ME-Received: <xmr:WrvOaitr6eyCLwEYpDfiO-w4W7P9PFNVi2UVepAQ7blhQ5_OTCkdPO-zZlyrSg>
X-ME-Proxy-Cause: dmFkZTEsEdqyncKdAb+tznvmGJAc3xFu2RqSb4wPqCwSFsipA2GqrkMUf/sh4RS+vQVaXY
    D88qkqeCdrR1u/D7R9bf+HKy1rzl5Lur/lrFpJ0n7oEEzcnaUw2pcPO7HHR4cdMTWtcU2I
    tfdQf7q7ifKt7u7nZ3yIf1+wHly/3IDLwq9CYw0rrzFdh1SesHMV/xo7fafwaYLwMo7JOz
    strRDRy9NiqZlhsRhUH/0n0yJBRkNHlwCSBoRHF4WofCR3lpTBnbwEOxxSBE6hy0RyaJE5
    CbL35S3j1rFPZaQhKBSWDBh7DuVij57cMdMJ/HjNP0uuS0atZfOiwc+bY96NURx8g9J+NJ
    U+apZDuYY/JimVeCu6irreOnPhfPICQ0ezlUQ48KLhkbRKVhj6JJg1QTC8bNqJ3oignCXO
    hkR8BR86guMa+NDLiksoPCrMYLrnhhfcZoKUxF2bYnTpZoouVmXfn9c6bbfmTVO/Lt3zQa
    LL3wRw2cSm01ySy2O6vtCGYHNW9HlHPbYGHZAoqzzUeeqUUEyA9T+PfuTK0UpV8O0rvbPE
    seGOwCP95ScYo+oAi5qJsM5r6JG2T14Dm7F10q6nQkPYOkttniZGQzlAuo+qa/wqh2XJ5n
    li4f6W3jx4kGGtqWzA1DeUOE0jyNf9Xl/1XCFpNSyXwZM7ghkUziIDqyeKhg
X-ME-Proxy: <xmx:WrvOajDqYHHUpWd5ee-pDECMC9EQL5WHfyws1Z-MajHrr_Sftnlb2w>
    <xmx:WrvOatxy5aoPjaXqIb0h4_bWIG6fmo8GExz9_q2cow1PcxXkN08-5A>
    <xmx:WrvOaiKDBJYvi-udHJmSur6SE2GsOioEx6vZKu6TZc_Y-in_QfFb_w>
    <xmx:WrvOak5yQKXZkl0yOmYy31SkWElf_6rDvKQQVGg_0xjNr4L1Vyhz1w>
    <xmx:WrvOaoEg-YYeetvYXQfUpigdDqF62SJTmdk6mIFegChahukvSE4--CcU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:33 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:14:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 4/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Message-ID: <20261013171406.7dc8ba03@shazbot.org>
In-Reply-To: <20261006193643.76330-5-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
	<20261006193643.76330-5-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 20:36:32 +0100
Matt Evans <matt@ozlabs.org> wrote:

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
> This move also adds a new member, vma_pgoff_adjust; this is consumed
> by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
> Add it now to reduce the number of functions touched by later commits.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 166 ++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_priv.h   |  21 ++++
>  2 files changed, 174 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 847ee5cc78e7..9f10b10fc436 100644
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
> @@ -106,6 +93,159 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
> +			      struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long fault_addr,
> +			      unsigned int order,
> +			      unsigned long *out_pfn)
> +{
> +	/*
> +	 * Given a VMA (start, end, pgoffs) and a fault address,
> +	 * search the corresponding DMABUF's phys_vec[] to find the
> +	 * range representing the address's offset into the VMA, and
> +	 * its PFN.  vdev must be the device that the DMABUF priv was
> +	 * exported from; vdev->dmabuf_lock must be held, and priv
> +	 * must not be revoked.
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
> +	 * - A hugepage would cross the edge of the VMA,
> +	 * - A hugepage isn't entirely contained within a range
> +	 *   (including where it straddles the boundary between
> +	 *   ranges),
> +	 * - We find a range, but the final PFN isn't aligned to the
> +	 *   requested order.
> +	 *
> +	 * Upon failure, -ERANGE is returned and the caller is
> +	 * expected to try again with a smaller order, which will
> +	 * eventually succeed.
> +	 *
> +	 * It's suboptimal if DMABUFs are created with neighbouring
> +	 * ranges that are physically contiguous, since hugepages
> +	 * can't straddle range boundaries.  (The construction of the
> +	 * ranges should merge them in this case.)
> +	 *
> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
> +	 * To avoid double-offsetting in this scenario, subtracting
> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
> +	 * the effective offset.  This also removes the VFIO region
> +	 * index encoded in vm_pgoff for VFIO BAR mmaps.
> +	 */
> +
> +	const unsigned long pagesize = PAGE_SIZE << order;
> +	unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> +				 PAGE_SHIFT;
> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long fault_offset;
> +	unsigned long fault_offset_end;
> +	unsigned long range_start_offset = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	if (unlikely(!vdev))
> +		return -ENODEV;
> +
> +	/* This prevents the dmabuf revocation state from changing under us */
> +	lockdep_assert_held(&vdev->dmabuf_lock);
> +
> +	if (unlikely(priv->vdev != vdev || priv->revoked))
> +		return -ENODEV;

All but the lockdep here smells a bit like the hardening Leon mentions
in the previous patch.  There's only one caller of this, we'd segfault
there if vdev were NULL and the caller justifies how it knows vdev is
not NULL.  vdev is derived from priv->vdev, so the inequality can never
be true.  The lockdep annotation is good, but that also indicates the
caller is responsible for holding the revocation state stable, which
they've already checked.  I won't draw a hard line on these, but they
seem a bit pedantic.

> +
> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
> +		if (order > 0)
> +			return -ERANGE;
> +
> +		/* A fault address outside of the VMA is absurd. */
> +		dev_warn_ratelimited(
> +			&vdev->pdev->dev,
> +			"Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
> +			fault_addr, vma->vm_start, vma->vm_end);
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * fault_offset[_end] is the span within the DMABUF
> +	 * corresponding to the faulting page:
> +	 */
> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
> +					vma_off, &fault_offset) ||
> +		     check_add_overflow(fault_offset, pagesize,
> +					&fault_offset_end)))
> +		return -EFAULT;
> +
> +	/*
> +	 * Iterate over ranges in the buffer, summing their lengths:
> +	 * range_start_offset represents the current range's starting
> +	 * offset in the buffer (from 0 upwards).
> +	 *
> +	 * A failure for order == 0 is unexpected, and triggers a
> +	 * fault/warn.
> +	 */
> +	ret = (order == 0) ? -EFAULT : -ERANGE;
> +
> +	for (i = 0; i < priv->nr_ranges; i++) {
> +		size_t range_len = priv->phys_vec[i].len;
> +
> +		/* Early exit if range starts after the page end */
> +		if (fault_offset_end <= range_start_offset)
> +			break;
> +
> +		if (fault_offset >= range_start_offset &&
> +		    fault_offset_end <= range_start_offset + range_len) {
> +			/*
> +			 * The faulting page is wholly contained
> +			 * within the span represented by this range,
> +			 * so validate PFN alignment for the order.
> +			 * The if() condition ensures the pfn
> +			 * arithmetic won't overflow.
> +			 */
> +			unsigned long pfn =
> +				((fault_offset - range_start_offset) +
> +				 priv->phys_vec[i].paddr) >> PAGE_SHIFT;
> +
> +			if (IS_ALIGNED(pfn, 1 << order)) {
> +				*out_pfn = pfn;
> +				ret = 0;
> +			}
> +			/*
> +			 * Else order > 0; ERANGE retries with smaller
> +			 * order
> +			 */
> +			break;
> +		}
> +		range_start_offset += range_len;
> +	}
> +
> +	if (order == 0 && ret != 0)
> +		/*
> +		 * The address fell outside of the span represented by
> +		 * the (concatenated) ranges.  As setup of a mapping
> +		 * ensures that the VMA is <= the total size of the
> +		 * ranges this should never happen.  If it does, warn
> +		 * and SIGBUS.
> +		 */
> +		dev_warn_ratelimited(
> +			&vdev->pdev->dev,
> +			"No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
> +			fault_addr, order, vma->vm_start, vma->vm_end,
> +			vma->vm_pgoff, priv->nr_ranges, priv->size);
> +
> +	return ret;
> +}
> +
>  /*
>   * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>   * It allows the two co-operating drivers to exchange the physical address of
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 4e7162234a2e..786df3a81d9d 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -23,6 +23,20 @@ struct vfio_pci_ioeventfd {
>  	bool			test_mem;
>  };
>  
> +struct vfio_pci_dma_buf {
> +	struct dma_buf *dmabuf;
> +	struct vfio_pci_core_device *vdev;
> +	struct list_head dmabufs_elm;
> +	size_t size;
> +	struct phys_vec *phys_vec;
> +	struct p2pdma_provider *provider;
> +	u32 nr_ranges;
> +	struct kref kref;
> +	struct completion comp;
> +	unsigned long vma_pgoff_adjust;
> +	u8 revoked : 1;
> +};
> +
>  bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
>  void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
>  
> @@ -123,6 +137,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>  }
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
> +			      struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long address,

Nit, address in the prototype here is fault_addr in the actual function
definition.  Thanks,

Alex

> +			      unsigned int order,
> +			      unsigned long *out_pfn);
> +
>  #ifdef CONFIG_VFIO_PCI_DMABUF
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  struct vfio_device_feature_dma_buf __user *arg,

