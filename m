Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3283A7F6F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452136; cv=none; b=Gi11NN2SiOHxN+ncnvUr0OVWCAImpl+aQ75vW3LtHGjeAD3TtgDIhlneYLcLaGXONVGNDBQb13KXhvP7ibglevIqCmyv8mw+I5vpuhW38cVKVOUcuFP1GTBZ4j25BGzD0o+2OuFlBZzidlfZTbk07A15Sm1uEzXT3/7Ibax3fDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452136; c=relaxed/simple;
	bh=6yC+aYDaiVvucEeJuv9ttiHtFPowCOdaom4mtrRN5FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2+an8JNj6zpFfdG/1hfCQmqtPM0RhJ7WlHm6GDELPns6l5UNhGyO+A/cNvHZp2rpjutQ223Lvgxo57hDcE8drOgDnjwN12kn8hZJOlG9dcAN68ySIagUEYtnZsGjxivcj6FHTRYaoLSQSLG4LQWy/jMD+s0vZKhKGmNLPc37ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKx/lxX1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKx/lxX1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso55115ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785452133; x=1786056933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
        b=jKx/lxX1tyKmvVhcYERq6+KdCUIDs6/X8kTSsYMlRRHvU8lsciTbyt1EaXmd8uJr/c
         OzikpzrXgkq03NwXlmMnr8gNVav0KpmCEko+S3IlmzA1P3UifsnYi+lvnSmvpgQrNd+p
         4sTJT4jP444Jjgc3Vpj/x44JwnAIvPFFCR55TxTxr2o2GTiUoKYS7GygNPFGYzhZorNh
         S9WEaznPnVLsxmaDNBNRr54aj5QVmAEDV9FVjtGjdqkYTp4WcKyAcOxNBvqL7qD0Iogu
         UasrdnAsn7xSm4NkbvzR0WyTzZGRxZIq5EgpuxSiSP1fUOXIOWjyEZofMRhwU7Pv3Yk/
         58RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452133; x=1786056933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
        b=atpQpDVklOiKsyxC4IrbCfSluaf9VTB4AuQzoxT91T5SCpdUaX4j6wGNykhvLQJI+Z
         ie/hGhhPK2kd16g5T3KzRcWFtt/mx7TW+DfJPMHtZFVPI/HzJAdxFn0VxJfhryI9211Y
         EKTeyaQpEy/gXYa20ze8K3CzB1N3RfLUo/BSJVtmG5XCSzLXfDqht933dwmwCvD89RsL
         aEf2a5ZSDF3HU57CIoLa6IFIeYhDRjsilwe72qgsPWnft7lNw1x9zh9ahbk6/G8AEo2C
         LxLtO1/AiNSeoIISSbC6ksWrCLo4vIOvxPBZFW60QZ6BKD+akCG7+5Bz3Y6MmGUNHp9q
         xlgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQnFI1mNzGCxdo+dPlybX+qhbM6oFPGs0p+MOcQ7dabO2XbmbIhZ4Z8sV3PpjREOdDR7UrPHFfcPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymytmrB8Q8JOmWKitgYrjvvZ7dSyurglSab2bDGfZwAzio/ZH0
	+aSv1XUSbDCUcyFt1Q9v1RZuSfHLYmsrMoDVEVmQaaOOqIzLL0KlWIXIh1gJXrGt/w==
X-Gm-Gg: AR+sD11wcLVObDNRtb8n9S/W0zrYFiZqilcTCPPscAZ7JFft9c2nzGUvYF/jjUF8M1E
	hVAyg4XQ8SI7k9llrwmPpgI4JoWRVhEvWugr37SL+fn0A/7W9akURqXAlqo6hNpHOmE4ql2xNb7
	l6qjRXhcZLQNuegjdmvvp+zektnjRVEvpJB8FsoXp1K+gQ0d8eQEfEpK+COH2deFMqfoUYLgPu8
	kSQfmWyUa68tjQPkoffKgs64HFsGklam0GmO/V3MG4nUG1kKAQae6Pkf2nHTkK4gMnzxvpaOcQ3
	oBENZouWfRQwN7cc96J8QrdXe6SqWHgjW1eCPtniNromUVIyg49eGujGhVYG+/FhppJuKHlyfgK
	6Ttf7y8qADxoArt3QVRPsN2oIf09wqP1wwkw+s0Ph64MjlFD/aZ4mdHoBYe11TCXUzo6MUMMCYf
	IK30O8zkg3PZEnW8KlOtZV+LOKESpe1yo8B5JuRSsbBI5RnMvLIuIued9sMunvnPcl5/aI8nbef
	CurBpE+Z80C4lGtM/Hh0Ezap94TWNIISPdLmGZFEBlY2g==
X-Received: by 2002:a17:902:f541:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2d04113beb1mr4399455ad.4.1785452132956;
        Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm29148088eec.21.2026.07.30.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:55:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <amvWXNRtviKEuUoV@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
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

Maybe I'm getting ahead of myself here.. but it seems like this
restricts us to only mapping DMABUFs at offsets < 1TB due to the 
VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
may not be a very distant future).

While I understand this mask is needed to drop the BAR encoding in the
high bits. 

My worry is, if in the future a user were to export a massive
contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
into it (passing an offset >= 1TB), this bitwise AND would silently drop
the high bits, leading to silent data corruption.

I think we should explicitly reject such an mmap with -EINVAL like:

+const unsigned long pagesize = PAGE_SIZE << order;
+unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;

+/*
+ * Prevent silent wrap-around if the user mmaps a DMABUF at an
+ * offset greater than the VFIO index mask allows.
+ */
+if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
+    return -EINVAL;

+vma_off &= VFIO_PCI_OFFSET_MASK;

> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long fault_offset;
> +	unsigned long fault_offset_end;
> +	unsigned long range_start_offset = 0;
> +	unsigned int i;
> +	int ret;
> +


Thanks,
Praan
