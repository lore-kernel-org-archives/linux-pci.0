Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FD3A3835;
	Wed, 29 Jul 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347568; cv=none; b=IUq+PyC9i/N9cpy4K3tZP2Qp1X+f+aJnR9Xo0WTd7psrJReaMQCwRDK92xFqwxCUUReZe7TQYawoMoope766WCwPSKUzpm9JZneMBwH1+apPl5bEUVSNXxx4HWmY7eMrjPxJEO4psK6+RLqR8el6NrTY3On7S3H1iJtvmlTOaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347568; c=relaxed/simple;
	bh=7jeyNwcaVsAjCERf9nPYRuHaQkV6ajFwqTzQ7VGbJH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifvYWqOUVE7iX9sJRL8QRzk4FKwLL/0Os0angkD02Yqn3ttI4ggkot+xtB442ML9gKr5KMpujPq1uKCQdKwN76ogMwrwN6ImfGLSBq9ILwbfMBqI+XPVKmBRQEyXl+T/rrHDA3z9CI1fUcm6dM0fZlHT0H481bLDgjtU6ceJdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=nvUT3I/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pFOiY6DC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="nvUT3I/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFOiY6DC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10D2C7A0188;
	Wed, 29 Jul 2026 13:52:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 13:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785347564;
	 x=1785433964; bh=GBitJTtcIqXnrlN3xd4UOvlCHqOUWjl/e++pPoM2e+Y=; b=
	nvUT3I/eju6BYAFes1UluAKSSTa9gxcKGopZrsY//+UJev5BmVFuZwMJtxc7pY1u
	1E6h6shzKo773F96KsOCPAJnRbbglOmzYp41NS075K2DZNGEfUlM3gdHcIzGvOFe
	FZIWAKhmYHp5L9oanKCJjDFuLPhUbJr61tI4Hy0Xqinucy6QB1LqpBBUqsCzTbN2
	qwTB/0Tj0ahZs8F2MTxtjUOcbBNGunTnA8g2SMkH9LmESoAb5gG9+hNJJ33o9TEn
	6JBux7tNPoMQ8vkTx/ekeoQPlPHjyZK/3au3iapmA2RZBATiAHvwc8DgkX3mhhTx
	l6hEowDd5JNNyWS6pQolAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785347564; x=
	1785433964; bh=GBitJTtcIqXnrlN3xd4UOvlCHqOUWjl/e++pPoM2e+Y=; b=p
	FOiY6DC4HSlPlZTURXA8sB0Qyl7rLUtVoXL/PpX1iFWsew5NspEIkswQNoVqa4/K
	a/sBtamQbY8QExuiFo7YJh0EJTXYWzlDrcw7mmlcR/CWGeuQdSShbkyNhZyEeIdU
	uunvAMWuIeWXMGMc2Nvij35/ZTHRTsAYRC4bHtMrQAuSUWF8tJWZFq4UDUWLk6OK
	ZZ2wYTCkZtwqEpOQ1Qoogm/K9RtM2TydWkS0IjGBmAuEBBS+K0dMon4l+bN/3m51
	Gk7Q6cpop5egWmyMpZBuKBSsMUmW0ImtqPCDBOdFBBP3MZVzk7wo5UOv4SyngCjK
	r8NQospnc4LOEmZw3d67g==
X-ME-Sender: <xms:7D1qau3_YIiSOXpDTHnAcF3cCFyOO8uWU6jWCXpjfHrDtjzTD7XFSQ>
    <xme:7D1qasj3AKsBcR680hZPThs3R8O77S5fsDBp-l3GB1jbqviHe-j2Frl0qYgs2RPO3
    8IUWY_G2_odkcwR7z_p8eVBh3aSsdFvjA8VjtC7Lb8PDl0Z5vsEYA>
X-ME-Received: <xmr:7D1qallWWNrdCGGUkAfjQhyVCuzJqpOyL061xPCRMkW6gR1grGH3wyNu95oLuA>
X-ME-Proxy-Cause: dmFkZTEEKmvm6usZpfT8gTSOJbqanlO3Pfaw1SwlI8f/Y1kQuB5PNxzg3aOh42AlQ5x0re
    mEkbtzhui+wLYtqWZK72Xd/sdJJEBvaXRotkM6Vk0bPPvLVaNTNCx4v9cPIE7guN0chqZG
    xBk0FjLQTleHOrHFXXErnyGCptkTDYgk7zSCFRUjOu4hbmap/73RGBIgA9cJ0wq9zAoT+n
    iQ8tOqSb+FQ4ww6H9mq9hRsOLrowOesvFEIXGg5PbgzKo3PTE5X8d/73KQfrp4YMVmYaaN
    ygTQrCIHZp6Q1vuJ9i+D5kwdZMjX9SfNAWiOB7hAYx70kmcGovcy9tx9FXQs3RN4UEbWH6
    /n+3VBkQ6EiDPpAo1vrM/bNhi8lepDnIpUdzPH/qnhE/PXluBtDQ6DNdqaXw1FOG/ikujT
    n3zi8HCtZ4xqpM9ZQUC4sx3Wqi7Zg9pFQb/FTppazPihg8lZ4A3lePE8RN86Z6sPn4i7p6
    E7VDlGiI4XJLeoVnNQiHPWiCmg5TWaGm57YV1ot/OdRJfYTchU8+pT0J7z1OYWXm0HrL7P
    drPeAlkXyKViajw7vo35RE5A425RY0t8w1zmwo7/kQCnyjuryGIQ/ahxP7qON8BfrobXZ+
    2X8YLEEAdt05nzOIvraay3u9hNQD8a2ce+n2uBhWTiLljknvvGcPFS6ZQ25A
X-ME-Proxy: <xmx:7D1qas_o3nXNiTWs0C-Hydox4QeMSM2urPic4LFIXY2c9HHXGUhcPg>
    <xmx:7D1qandmMb6PEi5epChKfk1Sp4csDuSzQdO09Ui_0HgZ0KJcUnCfhg>
    <xmx:7D1qau4lKJivkXxquMCBaW0P7e2aq9nsOckQbkhqHEiPX04n3xUvKA>
    <xmx:7D1qaj-rkjNIyeEX5xnwQbwLuv57_FYLjlJOHmyVPQ1A4eT8NWdWXQ>
    <xmx:7D1qaqi4SPYoQ0CdaHSwJY6ZCRZ8R7pd1h8cCkGnDkMs6gHDIDimz2yX>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:52:42 -0400 (EDT)
Date: Wed, 29 Jul 2026 11:52:10 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Message-ID: <20260729115210.753ab8ce@shazbot.org>
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-4-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 18:47:26 +0100
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

Nit, it would be useful to mention the addition of vma_pgoff_adjust
here and justification for it added here as a static zero versus later
in the series where its value is updated.

> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>  2 files changed, 160 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..7c047400dfd1 100644
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
> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long fault_addr,
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
> +	 * - A hugepage would cross the edge of the VMA,
> +	 * - A hugepage isn't entirely contained within a range
> +	 *   (including where it straddles the boundary between
> +	 *   ranges),
> +	 * - We find a range, but the final PFN isn't aligned to the
> +	 *   requested order.
> +	 *
> +	 * Upon failure, -EAGAIN is returned and the caller is
> +	 * expected to try again with a smaller order, which will
> +	 * eventually succeed (order=0 will always work).

We typically use -EAGAIN to indicate a transient error where the caller
should try again with the same args.  We're documenting here that
-EAGAIN means to try again with different args.  Why wouldn't we use
something like -ERANGE to indicate that?

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
> +	 * the effective offset.
> +	 */
> +
> +	const unsigned long pagesize = PAGE_SIZE << order;
> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long fault_offset;
> +	unsigned long fault_offset_end;
> +	unsigned long range_start_offset = 0;
> +	unsigned int i;
> +	int ret;
> +

AIUI, find_pfn should only act on a live dmabuf, but we're relying on
the caller to guarantee that it's live and not racing a revoke.  The
dmabuf is live if !revoked under memory_lock.  Should this annotate and
validate that requirement by adding a vdev arg so we can do:

	lockdep_assert_held(&vdev->memory_lock);
	if (priv->revoked) // later updated to status
		return -ENODEV;

This also removes one level of dereferencing in the below dev_warns,
which is otherwise a bit suspect without the validation.  I realize the
mmap path does the validation, but this is an exposed internal API, not
a static function there.  Thanks,

Alex

> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
> +		if (order > 0)
> +			return -EAGAIN;
> +
> +		/* A fault address outside of the VMA is absurd. */
> +		dev_warn_ratelimited(
> +			&priv->vdev->pdev->dev,
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
> +	ret = (order == 0) ? -EFAULT : -EAGAIN;
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
> +			 * Else order > 0; EAGAIN retries with smaller
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
> +			&priv->vdev->pdev->dev,
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
> index fca9d0dfac90..c8f6f959056a 100644
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
> @@ -114,6 +128,12 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>  }
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
> +			      struct vm_area_struct *vma,
> +			      unsigned long address,
> +			      unsigned int order,
> +			      unsigned long *out_pfn);
> +
>  #ifdef CONFIG_VFIO_PCI_DMABUF
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  struct vfio_device_feature_dma_buf __user *arg,

