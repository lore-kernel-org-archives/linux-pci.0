Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D33655C4;
	Tue, 22 Sep 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043338; cv=none; b=s9FOLmdi9URsM5k92eE78fa2EnqJEserW1ug6eH/KMKn/d3kk/mYylbtA7nglblaSozenq4qeqKgBi7NZnH5mRP9oCDgo4heQxlLxTcztyg/uyP5sV+rnyKqUesvhHUSBRCJsVxpmJ7ffaaFqokoG0G8m0fJ/vsH018zWuDbKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043338; c=relaxed/simple;
	bh=9bvVAXV9HNk/eHqtAL6ekY+WQy1otMNk5MknLDBI2Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvjnl3FFR/T4Cn2giofu+njoajsabFPY0fW4cx/DSNXt+PVD+Yk75J7pS+NEBFLGlXE4kJ37mV9EIStXrwYvSf/L/ZcpbbM001VQknAyMWlyDEG2kDg6VwXbPxLmvhzuoJXBj2LADH3KTfpMwuK47IbsOarZ+fzLrB4DvrMpiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WS+AHH67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rsmk5NvR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WS+AHH67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rsmk5NvR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9E967A0040;
	Mon, 21 Sep 2026 22:15:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 22:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043332;
	 x=1790129732; bh=Tf/SEbwXV7jFL7l5dMCsmZxiwKP29v7ou1UdtFQzPgo=; b=
	WS+AHH67WaiAbJeLIU/l4l3I6AAUO7TBNdvUY3xTkVRrW14WVgikYwdMzsHLhu9K
	myMIE21jQykyhohJ5BtUsxSYOmFfZ3mB0QFvVYcZ4KDDuoqCQoR/nMJ5IR6zl1zw
	TA+1NcBrsg8D3YTmYFxl10C2QJtd7lBY69LJhOXnA+1RvFy+R3JQFmenx37RpHt7
	23XwHOAna+NzA1al9H9jR1UMW3AejY5qDTKNts8+YQPvvRYg/AaG2Sng4+CahjOv
	khyTIUMxBVWywnkBH85mghJ1Zv9y7GuJt5trcwcAA6QsVZHS6H6RjRH8yg/jsGzJ
	KmJ4tVHYZWmeZP/PQw2Lsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043332; x=
	1790129732; bh=Tf/SEbwXV7jFL7l5dMCsmZxiwKP29v7ou1UdtFQzPgo=; b=r
	smk5NvRpwYY8dBs2aiRtC3XYudNEWXfJD2DEpAnHH77Lb1zBmlWWvfe8gi77mAgj
	N82rd1r5n4YzrRQohWV7ER7PXL/uWutTiNZNgrkoCsP0sV4NZPuxDKrGWT6sUoYE
	YWdmsdUhiHEgfPElM4k+1otfrW9wWZjgmO8aUDhkm6J9qTQ/uhX7UC/7Z/lfK1Ze
	cpYRGYokdkn0h5aOEJasd6aK7UbUcRk9ShctXSvuYKuI3RTQY1Rkr/OI8nuF7QHv
	emCf2ytGEHeB6X6YHJQENkZ4UyhiPryukOlZSFRPKL4ei6Nj0x2MLrgUK/bbapBz
	IKFSzyYoIL5lSskwV6v0g==
X-ME-Sender: <xms:xOSxasrsGAFNHQS8ThOaU2hSgM3bZRlIMMAeTGgW4eks_O3CLkF2wg>
    <xme:xOSxatffyiHCCj8f-er463PzkagFIIb0SWt3OU43GoadqHA2DwCVoAK2k2PvmMJp4
    0hLuDcCDy1PGglItBFXkufu7BYRG_Kx-PpNjIal_2UqiovcRW2IRA>
X-ME-Received: <xmr:xOSxavdE2EY7mcgvkZ7SJ4iBThJVEb3nTDpKTtmwTnhOscs5lxjBI0o_r26oYQ>
X-ME-Proxy-Cause: dmFkZTGoxwBj3gMs8aP3OtSmH8fpa7GIvf4hOnqoko3B7f8pxqS5H7LxH77IXdR6d3WuI+
    Z9z3CfoUQKhUFniD7Rf7fiqvJvZaxwi23b3LKCM1FYo0YHUqTk8Ph54TXb76GBBy5fGyB3
    oqC5JJGe5LoDDFzfoji7WB0jMmg4fksDOtYNR4RWwGVFKCKNqGSM8QOjrKGULyw+HiamTo
    t8iuP5PRmNKtxUV0UzEwx799GdCwOuUjbS84g95p799m8GpkwTsVGsDH/1sUaqdQLLvc9D
    Z2z27IHWdZ/KXQJuUCkXpOXRK1wImm+otqigYdSypL/jkRx+L2NChAfP8UHBNbtB8aiQUG
    w26RYZ1p69NkuFn2KNaB2HwI/f9QK0F6DQ8kU0K6K0ZJbdy0+V8+0vuse4vSa5eanzgfXH
    rBUqVwYvgybe4NZPlT0th0VtYonLNUr8iR9XTLzaROFlWh1dg4s0lVSYu7on2QoPVBH1M1
    Iy9AnEGmDOf0YiJ3qmstqENhbD2WdTK+MHummxXzXlivScl6PrUNqvJHWtdlhUO3jk3cQ/
    7MElMyBeMkX9SMmcCK30LT9f3s1L3SZqIvD2DmtqS2WRYyDTo9DuH7TE6DKEyzNpvmuYjl
    GdjiCERMj5MNiyVZ2vy1b0spBp/+QmXzjBAWwz29Xcsakv/A+GL3dUMDO7rQ
X-ME-Proxy: <xmx:xOSxajf_pkfnwVdAlo5v5_mVEwnaM0_s-Ks3jwldi4FGxhtSTfz9bw>
    <xmx:xOSxalqVqWfJT36EI2Vn2SZqoJUexurAuNZQ9ZsV6p8e_IMXmt_B3A>
    <xmx:xOSxajy-OUWY4bL4NYpqT7s5AbVYTKa-bz5RqhOtLAh7CZh-b_P53w>
    <xmx:xOSxarcDJX_Mu13LEf5wgiLgGciarWDf6elNHq6m9bztY4Rr9ExAdw>
    <xmx:xOSxamr0kkx-0pDMo10Z4sk75kmnsDgt5nXP8UHoTVlYoADbceJdznHk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:15:23 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:14:05 -0600
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
Subject: Re: [PATCH v5 18/27] vfio/cxl: Expose the HDM memory region to the
 guest
Message-ID: <20260921201405.16db1b89@shazbot.org>
In-Reply-To: <20260916183540.3813685-19-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-19-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:31 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 guest maps the device HDM memory to use its coherent
> CXL.mem. The HDM memory is a host physical range with no struct page,
> so the guest and KVM need a write-back mapping of it.
> 
> Register the range as an mmap-able region under
> VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id rather than a
> bespoke region type, per open because vfio_pci_core_disable() tears
> down all dynamic regions on close.
> 
> Own the resolved host physical range exclusively (IORESOURCE_EXCLUSIVE)
> so nothing, /dev/mem included, can map a conflicting cacheable alias
> that would fault the host once the range is mapped write-back.  There
> is no devm form of the exclusive request, so pair it with a devm
> release action.
> 
> vfio_pci_zap_bars() only unmaps the fixed PCI BAR range, so revoke
> mmap-capable device-specific regions there too.  Otherwise a
> Memory-Space disable, a D3 transition, or a reset would leave the guest
> a live mapping into quiesced device memory; the fault handler re-gates
> on device state before it inserts a pfn again.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 186 +++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c     |  37 ++++++
>  include/linux/vfio_pci_core.h        |   1 +
>  include/uapi/linux/vfio.h            |   4 +
>  4 files changed, 228 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 5c8a63833a43..5b65cac30aba 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -5,9 +5,13 @@
>   * Copyright (c) 2026 NVIDIA Corporation & Affiliates
>   */
>  
> +#include <linux/cleanup.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/range.h>
> +#include <linux/uaccess.h>
>  #include <linux/vfio_pci_core.h>
>  #include <cxl/cxl.h>
>  #include <cxl/pci.h>
> @@ -17,13 +21,144 @@
>   * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
>   * @cxlmd: memory device joined to the CXL topology at bind
>   * @hpa_range: host physical range of the HDM region
> + * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
>   */
>  struct vfio_cxl_state {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
>  	struct range hpa_range;
> +	bool hdm_valid;
>  };
>  
> +static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
> +					unsigned long addr)
> +{
> +	unsigned long mask = (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1;
> +
> +	return (vma->vm_pgoff & mask) + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +}
> +
> +static vm_fault_t vfio_cxl_mem_huge_fault(struct vm_fault *vmf,
> +					  unsigned int order)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vfio_pci_core_device *vdev = vma->vm_private_data;
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	unsigned long addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +	unsigned long pfn = PHYS_PFN(cxl->hpa_range.start) +
> +			    vfio_cxl_mem_pgoff(vma, addr);
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
> +
> +	if (is_aligned_for_order(vma, addr, pfn, order)) {
> +		scoped_guard(rwsem_read, &vdev->memory_lock) {
> +			/*
> +			 * Insert a PFN only for a known-good decoder whose
> +			 * media is ready and whose Memory-Space is enabled.
> +			 */
> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    cxl->hdm_valid && cxl->cxlds.media_ready)
> +				ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn,
> +							      order);
> +			else
> +				ret = VM_FAULT_SIGBUS;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static vm_fault_t vfio_cxl_mem_fault(struct vm_fault *vmf)
> +{
> +	return vfio_cxl_mem_huge_fault(vmf, 0);
> +}
> +
> +static const struct vm_operations_struct vfio_cxl_mem_vm_ops = {
> +	.fault = vfio_cxl_mem_fault,
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +	.huge_fault = vfio_cxl_mem_huge_fault,
> +#endif
> +};
> +
> +static int vfio_cxl_mem_mmap(struct vfio_pci_core_device *vdev,
> +			     struct vfio_pci_region *region,
> +			     struct vm_area_struct *vma)
> +{
> +	unsigned long mask = (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1;
> +	u64 req_start = (vma->vm_pgoff & mask) << PAGE_SHIFT;
> +	u64 req_len = vma->vm_end - vma->vm_start;
> +
> +	if (req_start + req_len > region->size)
> +		return -EINVAL;
> +
> +	/*
> +	 * CXL.mem is coherent memory, so leave the mapping write-back cacheable.
> +	 */
> +	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +	vma->vm_ops = &vfio_cxl_mem_vm_ops;
> +	vma->vm_private_data = vdev;
> +
> +	return 0;
> +}
> +
> +static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
> +			       char __user *buf, size_t count, loff_t *ppos,
> +			       bool iswrite)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	void *mem;
> +	ssize_t done;
> +
> +	if (pos >= range_len(&cxl->hpa_range))
> +		return -EINVAL;
> +	count = min_t(size_t, count, range_len(&cxl->hpa_range) - pos);
> +
> +	scoped_guard(rwsem_read, &vdev->memory_lock) {
> +		/*
> +		 * Same gate as the fault path: only touch the HDM range with
> +		 * the decoder in a known-good state AND Memory-Space enabled,
> +		 * or a host CPU access aborts as a fatal SError.
> +		 */
> +		if (!cxl->hdm_valid || !__vfio_pci_memory_enabled(vdev))
> +			return -EIO;
> +
> +		mem = memremap(cxl->hpa_range.start + pos, count, MEMREMAP_WB);
> +		if (!mem)
> +			return -ENOMEM;
> +		if (iswrite)
> +			done = copy_from_user(mem, buf, count) ? -EFAULT : count;
> +		else
> +			done = copy_to_user(buf, mem, count) ? -EFAULT : count;
> +		memunmap(mem);
> +	}
> +	if (done > 0)
> +		*ppos += done;
> +
> +	return done;
> +}
> +
> +/*
> + * The CXL regions carry no per-region state (region->data is the shared,
> + * devm-managed vfio_cxl_state), so releasing a region is a no-op.
> + */
> +static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
> +				    struct vfio_pci_region *region)
> +{
> +}
> +
> +static const struct vfio_pci_regops vfio_cxl_mem_regops = {
> +	.rw = vfio_cxl_mem_rw,
> +	.mmap = vfio_cxl_mem_mmap,
> +	.release = vfio_cxl_region_release,
> +};
> +
> +static void vfio_cxl_release_hpa(void *data)
> +{
> +	struct vfio_cxl_state *cxl = data;
> +
> +	release_mem_region(cxl->hpa_range.start, range_len(&cxl->hpa_range));
> +}
> +
>  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -120,6 +255,21 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  		goto err;
>  	}
>  
> +	/*
> +	 * Claim the range IORESOURCE_EXCLUSIVE so no conflicting cacheable
> +	 * alias can fault the host once it is mapped write-back; there is no
> +	 * devm form, so pair it with a devm release action.
> +	 */
> +	if (!request_mem_region_exclusive(cxl->hpa_range.start,
> +					  range_len(&cxl->hpa_range),
> +					  "vfio-cxl-hdm")) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +	ret = devm_add_action_or_reset(&pdev->dev, vfio_cxl_release_hpa, cxl);
> +	if (ret)
> +		goto err;
> +
>  	cxl->cxlmd = cxlmd;
>  	devres_close_group(&pdev->dev, NULL);
>  
> @@ -143,13 +293,49 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  	vdev->cxl = NULL;
>  }
>  
> +static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
> +			       const struct vfio_pci_regops *ops, size_t size,
> +			       u32 flags)
> +{
> +	u32 type = VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_CXL;
> +
> +	return vfio_pci_core_register_dev_region(vdev, type, subtype, ops,
> +						 size, flags, vdev->cxl);
> +}
> +
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	int ret;
> +
> +	/*
> +	 * vfio_pci_core_disable() frees all dynamic regions on close, so register
> +	 * them here per open rather than at bind. A failed first open never
> +	 * reaches close_device(), so unwind on error.

There's no unwind here.

> +	 */
> +	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
> +				  &vfio_cxl_mem_regops, range_len(&cxl->hpa_range),
> +				  VFIO_REGION_INFO_FLAG_READ |
> +				  VFIO_REGION_INFO_FLAG_WRITE |
> +				  VFIO_REGION_INFO_FLAG_MMAP);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The decoder is firmware-committed, so host access to the HDM range is
> +	 * safe. Open the access gate; reset and power transitions clear it until
> +	 * the decoder is restored.
> +	 */
> +	cxl->hdm_valid = true;
> +
>  	return 0;
>  }
>  
>  static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	cxl->hdm_valid = false;
>  }

If hdm_valid is set on open_device and cleared on close_device, how is
this not redundant to open_count?  It's totally superfluous everywhere
it's tested in this patch.

>  
>  static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ddd6807893fd..8913a9e24302 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1295,6 +1295,23 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_register_dev_region);
>  
> +/*
> + * Unregister the most recently registered dynamic region. Used to unwind a
> + * partially built region set on an open-time error; regions are otherwise
> + * released together in vfio_pci_core_disable().
> + */
> +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_region *region;
> +
> +	if (WARN_ON(!vdev->num_regions))
> +		return;
> +
> +	region = &vdev->region[--vdev->num_regions];
> +	region->ops->release(vdev, region);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_dev_region);

This is not a good interface, implicitly popping the last dev region
added.  The whole interface should change to push and pop semantics if
we're doing this, but we shouldn't do this.  It would be better to ask
to remove a specific region, identified by some compliment of the
creation parameters, with a memmove + collapse on the array.  Or
perhaps this justifies another data structure.

This is also unused in this patch.  Why's it added here?  This patch
already does too much.  We could have lead with read/write access and
followed with mmap support in another patch.

> +
>  static int vfio_pci_info_atomic_cap(struct vfio_pci_core_device *vdev,
>  				    struct vfio_info_cap *caps)
>  {
> @@ -1972,8 +1989,28 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
>  	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
>  	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
>  	loff_t len = end - start;
> +	unsigned int i;
>  
>  	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
> +
> +	/*
> +	 * The unmap above covers the PCI BARs; mmap-capable device-specific
> +	 * regions (e.g. a vfio-cxl HDM window) sit above that range, so revoke
> +	 * them here too, or a Memory-Space disable, D3/PM transition, or reset
> +	 * would leave the guest a live mapping into quiesced device memory.
> +	 * Callers hold memory_lock, so the region array is stable.

memory_lock doesn't protect the region array, it's allocated at
init/open and considered stable.  Like v4, this is arguing where it's
convenient that we need to guard against PM transitions while also
preventing PM transitions.  Why don't we just support PM?

> +	 */
> +	for (i = 0; i < vdev->num_regions; i++) {
> +		struct vfio_pci_region *region = &vdev->region[i];
> +		loff_t roff;
> +
> +		if (!(region->flags & VFIO_REGION_INFO_FLAG_MMAP))
> +			continue;
> +
> +		roff = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS + i);
> +		unmap_mapping_range(core_vdev->inode->i_mapping, roff,
> +				    region->size, true);
> +	}

There's an assumption here that doesn't seem well founded that a device
specific region that support mmap is necessarily dependent on the
memory enable state of the device.  We could have chosen to report the
coherent memory nvgrace uses as a device specific region, we know it's
not tied to memory enable.  We could support mmap on something like the
IGD OpRegion if we chose to map a whole page for it.  There's an
implicit dependency here that I don't see baked in to simply supporting
mmap.  Thanks,

Alex

>  }
>  
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 475a0ecf9e4f..39a28cc6ae8c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -198,6 +198,7 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
>  				      size_t size, u32 flags, void *data);
> +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e41437fa17ad..1bf86763c0f7 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -370,6 +370,10 @@ struct vfio_region_info_cap_type {
>   */
>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>  
> +/* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
> +/* CXL.mem HDM region of a Type-2 device, mmap-able */
> +#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
> +
>  /* sub-types for VFIO_REGION_TYPE_GFX */
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>  

