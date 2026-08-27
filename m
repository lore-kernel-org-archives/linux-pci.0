Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F13D75CF;
	Thu, 27 Aug 2026 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870255; cv=none; b=c6tOntqneh7xj6CjORsvo1VNxVjyT7IBoiEBUYFp6oqTVDTCWhW6yq770N2+SlGRysxGsdch4XmsHMXqfECOk8Ln5gXLmmUxBPbmp2SVwYDmi3wiKc+b6SvIPfljCgvNsDDCPR4Q31qH8OMnVIgPnyO+tW3zgy3jot53mClepLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870255; c=relaxed/simple;
	bh=p1DhIwgHkyC/+qU0441ubEQ/B51A67fFmS+Yo1sEkvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmuLIixoiu/CJd9gCiEFbedLOi59+IMzZtcUumRrCiBOLLiaMfSP7+HS3rIyXihiRQeY6LX2OfcGs4fqk+hDEctqej5RbOdYSpk/8CuIpm2XVMiMBJ2OxNj4eJBW0CBPYkEtr9WPO2IlbA/0QI1ptNAds8vPvY7XZK3JsKbmmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=djBle8Sv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRScJFwk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="djBle8Sv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRScJFwk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA44D7A0253;
	Thu, 27 Aug 2026 18:37:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 18:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787870242;
	 x=1787956642; bh=dakfc/rmFKMGOT0sMdXXsPc2Gkm9QF/BBftWQyxnpIU=; b=
	djBle8SvoXu41Ghwlm6OQf4Hkvy0vWpWs1Aa+aCsmtebjPJPIJIeXOa21CPKSfKl
	x/CY3PnKrIMWztN4AVzlXuRpbPsJ/KzIV47xST0kpqHZwhcyQsBuWX1HF9htgd80
	7Ip+0e3Bux6JmIfyBbTLZXstoCQ8TJnQHswcjZzOMF9/ukE8gkyn9W0JMxlgCpsJ
	ehRsvFZlP0JvSrNDAr8948Ql9Lwyhn/Gra2RTI+VDdM8DhVkO6kiJbbKWYVyH0r+
	rokP22c9tDLrLOd4obOV/Sjd9cs8UgfzAMe2mJd3pGW2onruy4/YOv/PeJyh966K
	w9hSjJvqAfr31iNO029KKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787870242; x=
	1787956642; bh=dakfc/rmFKMGOT0sMdXXsPc2Gkm9QF/BBftWQyxnpIU=; b=m
	RScJFwkczWwS31ubqh11Rm11AjNnnCsMk7px6v3+twIKv4ZZsLB0EVr3utk1twiA
	D1bQyor+2kiyGnbiHgxtTChVjxXKCsQmu3/7jIUHezELHeIyE/ajJ3hEUnNfFalM
	2qdDDId+k1MXtZycSn1BKjOqizHaCE+S8ZvbIYXlW5sJjWg5DxjkecIpbxT03iVF
	kYi0haqQrJ8q5gQ2rv04XK6qCyscJ6EFW+sBI/xY59XpcWR1pd41nmA9Z7UoYjF7
	12HFS+NhDFQqsqwNundLYAu3PyrArM9qUUguBQk8N9AGDr17vGDqEkHyuwyDN2y6
	toWZpUJQ5BxuO/0BVqcxw==
X-ME-Sender: <xms:IryQaihglGVpnSWYGBPRP5t2c31iC4atrRiNOkZHMIFrKgNGaM7iZQ>
    <xme:IryQagqcEDEHciIn6Gx8nG3p2f3QDdPQAklL2eWr68c_pU0RqnT1TzprOMSXoLjOn
    TcX7xSmtOv1RkH-yvoCMxs1G-u2SN0UWI2iFqTNDppokw_U8-tTUZI>
X-ME-Received: <xmr:IryQahf-syTDgtCz30uoQaxlNAzktC8dZlWg1Q5V5AlcT4mXEHnmmT2fXStIeQ>
X-ME-Proxy-Cause: dmFkZTE58lQ9dphN4MDlYdxE/mBrD74TsRzGaXwdp/mC+QURr2jErIhK8xN+DJ5mAHdH1q
    N5lP9sc0SixyzfuB1e9SzrYXb7AeJmUkqTpdP2KdUEFJNH7ZB0MSdOA6ZwxvUh8lqezwdb
    mMUWIxxS9971jzVcbBmkAT3ve8ogkX5rex0HYgoG2Mchg0aNuxeg8D/m3K8z5Bde2cJAhp
    4rkK8ccZQHH2jTJ3qdYMAwH95UAiBKLW1BKyOtuzuh+Cdrs9haHEvmHPlnTwY9xs1HLxCr
    7bcLTc4AjrHj8H8qvO7Fbz4MmgZOLEEf5cgApDG5EbPbm6Joo0OCxBMTmyVWgnPRxD2fAh
    J+sCgvFLKrnhHE7J0DHheDmY3HuKR/vUkWlhCFkkSEWkCVGhLzCTYwE8xc5gNPqAesU2P7
    6bvYnmzLDmM2xIiQwO/jX6B4IFlsijS09/yn+gyfccmTFxSWIJPy+YJYdwspdFZr3xti/F
    v5crdVYPCXA8r6vnjkp/ZGtzyUOPfgF8jJ6TA/wCpF+ILb6/p57i7Ld1xEB+ivGPWTptUm
    ZbcoQwHBrSDltLU14Y3iztb1DvZsQo9zhRyeMEMxyUmun5lySkj3v7rITyxBy6aBv2Zb79
    7iPzA59v7AF3VAQDnGNyTK5CwUO4sF1r3N5aiYa2zw0e09BApdp9GRCWSjNA
X-ME-Proxy: <xmx:IryQajemR1i9Q7EmNB7Xq_iga2drRLv3RpVKTRyjJgO7WwMHfsjFqQ>
    <xmx:IryQanfncuxnKjBGfRmWQVyMW5Gz8watk5qTA4g4jriEQUIvORpW_Q>
    <xmx:IryQapr4JGAQAELSTmAUTYT8PjKVBKvvTRt4nGDghaU7qdlsbm8QHg>
    <xmx:IryQanyA7uvxCcN29YX4xy50UnFraw2U1jdeXoRKTX51ACVU399s3A>
    <xmx:IryQapdCU73ZaYl-u3aS-_1-mN7f0LPhyzUv6X6MrJUeTZegqBKeHnxj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 18:37:19 -0400 (EDT)
Date: Thu, 27 Aug 2026 16:37:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 12/27] vfio/pci: Let a provider exclude a BAR
 sub-range from mmap
Message-ID: <20260827163717.6b9c1752@shazbot.org>
In-Reply-To: <20260813093631.2288172-13-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-13-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:16 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Some devices expose registers in a BAR that must be reached only through
> a trap, not a direct guest mapping. A CXL Type-2 device's HDM decoder
> block is one: mapping it would let userspace reprogram the physical
> decoder that governs host memory decode. Give a provider a way to mark a
> BAR sub-range off-limits to mmap; it is advertised as a sparse-mmap
> region and refused in the mmap path, while the provider's own region
> still serves it.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   | 72 ++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 13 ++++++
>  drivers/vfio/pci/vfio_pci_priv.h   | 13 ++++++
>  include/linux/vfio_pci_core.h      |  6 +++
>  4 files changed, 104 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 0f9b5dfeea66..49dfbdaf3f05 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1009,6 +1009,67 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
>  	return vfio_info_add_capability(caps, &header, sizeof(header));
>  }
>  
> +/*
> + * A provider can keep a BAR sub-range off mmap (for example a CXL device's
> + * trapped HDM decoder block). Callers hold the resource so /dev/mem is already
> + * blocked; this only governs the vfio mmap path.
> + */
> +void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev, int bar,
> +				    u64 start, u64 len)
> +{
> +	vdev->mmap_exclude_bar = bar;
> +	vdev->mmap_exclude_start = start;
> +	vdev->mmap_exclude_len = len;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_set_mmap_exclude);

If we're going to go to the trouble of creating vfio-pci-core
infrastructure for handling excluded ranges, I'd rather see it handled
more generically.  One excluded "mmap" range per device is limited,
leaves MSI-X vector table existing as a separate implementation,
doesn't accurately describe what it does since it's excluded for both
mmap, read/write, and ioeventfds, and doesn't make use of the existing
x_start/x_end infrastructure we already have in read/write paths.

I think we should probably create a list of excluded ranges, each
containing a BAR index, start, size, and flags.  The flags are
necessary to manage mmap vs read vs write exclusions, where MSI-X only
excludes read/write, but this feature wants to exclude them all.

All existing use cases of msix_start/size would be migrated to this new
interface.  Handling in vfio_pci_bar_rw() would also need to account
for multiple excluded ranges per BAR (HDM exclusion adds that as a
possibility), iterating for any access extending beyond the intersecting
exclusion. mmap would generically fail any intersecting range with the
mmap exclusion flag set and region info would iterate the same set of
exclusions in generating the sparse mmap capability.

This would also correct the behavior of the next patch that
intersecting read/write accesses generate errors rather than fill reads
with -1 and drop writes.  Thanks,

Alex

> +
> +/* Advertise the BAR as mmappable minus the excluded sub-range. */
> +static int vfio_pci_mmap_exclude_cap(struct vfio_pci_core_device *vdev,
> +				     int index, struct vfio_info_cap *caps)
> +{
> +	u64 bar_len = pci_resource_len(vdev->pdev, index);
> +	u64 excl_start = ALIGN_DOWN(vdev->mmap_exclude_start, PAGE_SIZE);
> +	u64 excl_end = ALIGN(vdev->mmap_exclude_start + vdev->mmap_exclude_len,
> +			     PAGE_SIZE);
> +	struct vfio_region_info_cap_sparse_mmap *sparse;
> +	int nr_areas = 0, i = 0, ret;
> +	size_t size;
> +
> +	/*
> +	 * mmap is page granular, so the mmappable areas must stop at the page
> +	 * boundaries enclosing the excluded sub-range. The byte-granular
> +	 * exclusion still governs the fault and read/write paths; only the
> +	 * advertised mmap areas round out to whole pages.
> +	 */
> +	if (excl_start > 0)
> +		nr_areas++;
> +	if (excl_end < bar_len)
> +		nr_areas++;
> +
> +	size = struct_size(sparse, areas, nr_areas);
> +	sparse = kzalloc(size, GFP_KERNEL);
> +	if (!sparse)
> +		return -ENOMEM;
> +
> +	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> +	sparse->header.version = 1;
> +	sparse->nr_areas = nr_areas;
> +
> +	if (excl_start > 0) {
> +		sparse->areas[i].offset = 0;
> +		sparse->areas[i].size = excl_start;
> +		i++;
> +	}
> +	if (excl_end < bar_len) {
> +		sparse->areas[i].offset = excl_end;
> +		sparse->areas[i].size = bar_len - excl_end;
> +	}
> +
> +	ret = vfio_info_add_capability(caps, &sparse->header, size);
> +	kfree(sparse);
> +	return ret;
> +}
> +
>  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
> @@ -1157,6 +1218,13 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  				if (ret)
>  					return ret;
>  			}
> +			if (vdev->mmap_exclude_len &&
> +			    info->index == vdev->mmap_exclude_bar) {
> +				ret = vfio_pci_mmap_exclude_cap(vdev, info->index,
> +								caps);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  
>  		break;
> @@ -1851,6 +1919,10 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	if (req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> +	/* An excluded sub-range is reachable only through its trap, not mmap. */
> +	if (vfio_pci_bar_is_excluded(vdev, index, req_start, req_len))
> +		return -EINVAL;
> +
>  	/*
>  	 * Ensure the BAR resource region is reserved for use.
>  	 */
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..51983105d38b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -177,11 +177,24 @@ int vfio_pci_core_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
>  				  size_t nr_ranges)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> +	unsigned int i;
>  
>  	*provider = pcim_p2pdma_provider(pdev, region_index);
>  	if (!*provider)
>  		return -EINVAL;
>  
> +	/*
> +	 * A provider (e.g. vfio-cxl) can exclude a BAR sub-range that must be
> +	 * reached only through its trap. The mmap and read/write paths already
> +	 * refuse it; reject a DMA-BUF export overlapping it too, so a device fd
> +	 * holder cannot map the excluded registers to a peer and bypass the trap.
> +	 */
> +	for (i = 0; i < nr_ranges; i++)
> +		if (vfio_pci_bar_is_excluded(vdev, region_index,
> +					     dma_ranges[i].offset,
> +					     dma_ranges[i].length))
> +			return -EINVAL;
> +
>  	return vfio_pci_core_fill_phys_vec(
>  		phys_vec, dma_ranges, nr_ranges,
>  		pci_resource_start(pdev, region_index),
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index fca9d0dfac90..902d17815ab6 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -44,6 +44,19 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
>  
> +/*
> + * A provider (e.g. vfio-cxl) can carve a sub-range out of a BAR that must be
> + * reached only through its trap, never the direct BAR.  Returns true when
> + * [start, start + len) on this BAR overlaps that excluded range.
> + */
> +static inline bool vfio_pci_bar_is_excluded(struct vfio_pci_core_device *vdev,
> +					    int bar, u64 start, u64 len)
> +{
> +	return vdev->mmap_exclude_len && bar == vdev->mmap_exclude_bar &&
> +	       start < vdev->mmap_exclude_start + vdev->mmap_exclude_len &&
> +	       start + len > vdev->mmap_exclude_start;
> +}
> +
>  #ifdef CONFIG_VFIO_PCI_VGA
>  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 117cd67995d8..43755b91880f 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -162,6 +162,10 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	/* BAR sub-range a provider keeps off mmap, reached only through a trap */
> +	int			mmap_exclude_bar;
> +	u64			mmap_exclude_start;
> +	u64			mmap_exclude_len;
>  };
>  
>  enum vfio_pci_io_width {
> @@ -176,6 +180,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
>  				      size_t size, u32 flags, void *data);
> +void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev, int bar,
> +				    u64 start, u64 len);
>  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);

