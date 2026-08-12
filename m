Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C5372B3B;
	Wed, 12 Aug 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574407; cv=none; b=XpcbxC9cxCjYNDdg5Nz9NEqozRaoEvd3Y3a2kjKmgFS8TMeyTeYWhLbWN8biuAuqMxHMLd+2EveV2iP02PqUMgI+SoC+wWZhtRL8udsysl7q/MAsAQFKeCr1pvS5ToCJWlENDnIJRFEKAq7z53U18v82EqegWif97ClcCef2lqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574407; c=relaxed/simple;
	bh=i/eSOFUaVUKwk4edog8JpVGUGpBv18JTWxQo1FL1RXU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NYQOg84iLMCnKpF50eqCuZ1RyMp4skS8/2xsoBP5cueUnpN0NKpFr47iJQidpjCFkKSRE0AkJmxTUNpFH90qY92iBNQ9xDkYvSvut04Ib8Ztha+Virxisz/TMCSSUXO2v6G5NYToAbTf9umnn/UD7qSKYOKKiw3CLCxZAPDhPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=amBR/Dzq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="amBR/Dzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1786574395;
	bh=XVsUu3tsHs6oSwLbOes7bXb8mj23Ww3t9I48ZF2EW90=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=amBR/DzqHYxHedmI/MAjV7etZP0uKz39g6lBa9knw2QQwtqI/IscZz3CHbI7F1tY5
	 fDxq5d9MbGfYEayVysXohbOXox3iJ0BVm6HiDKQHIBsQkUS0D/zznTobKWQu/w12Zy
	 ehRGn06ZPpe945t2+QnuLJl/YN/0LE7ipfCSlUdLtyKUdWQ8VRfQ+6EQpw2qleKIOX
	 FB1/7AGplj1PHtxXiTGsfPbLkOiCHEFF95KDTZmwsOYDJxnPwFVOUzm5cOzM8ES4hH
	 nlcYYPUDGisCzPrNiDWiURHP5Ph1Znqw+jTQ8ZUKafQBfFA/JoJeoRk92fZe2QZb2V
	 tM5MIxnlwO4GA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hL3Mf6z7Vz4w1d;
	Thu, 13 Aug 2026 08:39:42 +1000 (AEST)
Message-ID: <9a615f22-c0d4-46ae-9654-db11e94e5fec@ozlabs.org>
Date: Wed, 12 Aug 2026 23:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-5-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-5-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex, Leon, Kevin, Praan,

On 15/07/2026 18:47, Matt Evans wrote:
> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> commit by VFIO's ordinary mmap() path.
> 
> This function transfers ownership of the VFIO device fd to the
> DMABUF, which fput()s when it's released.
> 
> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> this new VFIO_BAR mmap().
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 142 +++++++++++++++++++++++------
>  drivers/vfio/pci/vfio_pci_priv.h   |   5 +
>  2 files changed, 117 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 7c047400dfd1..74c02794bfe2 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  		up_write(&priv->vdev->memory_lock);
>  		vfio_device_put_registration(&priv->vdev->vdev);
>  	}
> +	if (priv->vfile)
> +		fput(priv->vfile);
>  	kfree(priv->phys_vec);
>  	kfree(priv);
>  }
> @@ -233,6 +235,45 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
>  	return ret;
>  }
>  
> +/*
> + * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
> + * for tracking (meaning cleanup or revocation will zap it), and take
> + * a vfio_device registration.
> + */
> +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
> +				  struct vfio_pci_dma_buf *priv, u32 flags)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +
> +	if (!vfio_device_try_get_registration(&vdev->vdev))
> +		return -ENODEV;
> +
> +	exp_info.ops = &vfio_pci_dmabuf_ops;
> +	exp_info.size = priv->size;
> +	exp_info.flags = flags;
> +	exp_info.priv = priv;
> +
> +	priv->dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(priv->dmabuf)) {
> +		vfio_device_put_registration(&vdev->vdev);
> +		return PTR_ERR(priv->dmabuf);
> +	}
> +
> +	kref_init(&priv->kref);
> +	init_completion(&priv->comp);
> +
> +	/* dma_buf_put() now frees priv */
> +	INIT_LIST_HEAD(&priv->dmabufs_elm);
> +	down_write(&vdev->memory_lock);
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
> +	priv->revoked = !__vfio_pci_memory_enabled(vdev);
> +	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
> +	dma_resv_unlock(priv->dmabuf->resv);
> +	up_write(&vdev->memory_lock);

It looks like a local Claude review (kreview) genuinely found a problem
here.  There seems to be a new deadlock scenario because vfio-pci's
mmap() now does the DMABUF export and now takes vdev->memory_lock:

nvgrace-gpu forwards mmap() of regular BARs on to vfio_pci_core_mmap(),
so it takes vdev->memory_lock for write here with mm->mmap_lock held for
write.

But the nvgrace-gpu driver's MMIO accessors,
nvgrace_gpu_{read,write}_mem(), rely on holding vdev->memory_lock for
read across the device readiness check and the device access, e.g.:

 nvgrace_gpu_read_mem():
    takes memory_lock(R)
    nvgrace_gpu_check_device_ready()
       nvgrace_gpu_map_and_read():
          // The copy accesses the device
          copy_to_user(...)         <-- could fault

That fault hits lock_mm_and_find_vma() and tries to take
mm->mmap_lock for read.  That waits on another thread that's already
started an mmap() and holds mm->mmap_lock for write but has blocked on
the faulting thread's vdev->memory_lock.  ABBA and boom.

Yuck.  I'm glad this was found now, at least. :|

A possible way forward:

Please can I have some expert advice on whether the DMABUF export really
must hold vdev->memory_lock for _write_ or could relax to hold it for
_read_ in the function above:

 - It's protecting the __vfio_pci_memory_enabled() test vs adding the
buffer to the list (could be read)
 - It's upholding the invariant of priv->revoked not changing without
holding both memory_lock & resv, but no one can see the DMABUF yet
 - It's protecting the list-add against a concurrent revoke/cleanup
 - It's protecting the list-add against another concurrent export

If vfio_pci_dmabuf_export() could instead hold memory_lock for read,
then nvgrace-gpu (or other future vfio-pci variant drivers!) can also
hold it for read, and the deadlock is avoided.

The revoke/cleanup paths hold vdev->memory_lock for write, so wouldn't
run concurrently, but there'd be a new problem of protecting against
another concurrent export.  Perhaps a new vdev->export_lock held (only)
in this function around vdev->memory_lock could address that.

The other variant drivers seem to be OK in this regard.  Solving this in
the core seems the right approach; at any rate, I don't think the
nvgrace-gpu side can be relaxed.

There'd still be the strong constraint that the drivers must avoid
taking vdev->memory_lock for write.  How to enforce this?

What are your thoughts on this problem/solution?  Am I missing any nuances?


Many thanks,


Matt


> +
> +	return 0;
> +}
> +
>  /*
>   * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>   * It allows the two co-operating drivers to exchange the physical address of
> @@ -351,7 +392,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  {
>  	struct vfio_device_feature_dma_buf get_dma_buf = {};
>  	struct vfio_region_dma_range *dma_ranges;
> -	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct vfio_pci_dma_buf *priv;
>  	size_t length;
>  	int ret;
> @@ -411,34 +451,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	kfree(dma_ranges);
>  	dma_ranges = NULL;
>  
> -	if (!vfio_device_try_get_registration(&vdev->vdev)) {
> -		ret = -ENODEV;
> +	ret = vfio_pci_dmabuf_export(vdev, priv, get_dma_buf.open_flags);
> +	if (ret)
>  		goto err_free_phys;
> -	}
> -
> -	exp_info.ops = &vfio_pci_dmabuf_ops;
> -	exp_info.size = priv->size;
> -	exp_info.flags = get_dma_buf.open_flags;
> -	exp_info.priv = priv;
> -
> -	priv->dmabuf = dma_buf_export(&exp_info);
> -	if (IS_ERR(priv->dmabuf)) {
> -		ret = PTR_ERR(priv->dmabuf);
> -		goto err_dev_put;
> -	}
> -
> -	kref_init(&priv->kref);
> -	init_completion(&priv->comp);
> -
> -	/* dma_buf_put() now frees priv */
> -	INIT_LIST_HEAD(&priv->dmabufs_elm);
> -	down_write(&vdev->memory_lock);
> -	dma_resv_lock(priv->dmabuf->resv, NULL);
> -	priv->revoked = !__vfio_pci_memory_enabled(vdev);
> -	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
> -	dma_resv_unlock(priv->dmabuf->resv);
> -	up_write(&vdev->memory_lock);
> -
>  	/*
>  	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
>  	 * will be released.
> @@ -449,8 +464,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  
>  	return ret;
>  
> -err_dev_put:
> -	vfio_device_put_registration(&vdev->vdev);
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:
> @@ -460,6 +473,75 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	return ret;
>  }
>  
> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> +				   struct vm_area_struct *vma,
> +				   u64 phys_start, u64 req_len,
> +				   unsigned int res_index)
> +{
> +	struct vfio_pci_dma_buf *priv;
> +	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
> +	int ret;
> +
> +	priv = kzalloc_obj(*priv);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
> +	if (!priv->phys_vec) {
> +		ret = -ENOMEM;
> +		goto err_free_priv;
> +	}
> +
> +	/*
> +	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
> +	 * start of the VMA corresponds to byte 0 of the DMABUF and
> +	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
> +	 *
> +	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
> +	 * vma_pgoff_adjust, so that ultimately a fault's offset from
> +	 * the start of the _VMA_ has a consistent usage whether the
> +	 * VMA originates from an mmap() of the VFIO device here or a
> +	 * direct DMABUF mmap().
> +	 */
> +	priv->vdev = vdev;
> +	priv->size = req_len;
> +	priv->nr_ranges = 1;
> +	priv->vma_pgoff_adjust = vma_pgoff;
> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
> +	if (!priv->provider) {
> +		ret = -EINVAL;
> +		goto err_free_phys;
> +	}
> +
> +	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> +	priv->phys_vec[0].len = priv->size;
> +
> +	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
> +	if (ret)
> +		goto err_free_phys;
> +
> +	/*
> +	 * Ownership of the DMABUF file transfers to the VMA so that
> +	 * other users can locate the DMABUF via a VA.  Ownership of
> +	 * the original VFIO device file being mmap()ed transfers to
> +	 * priv, and is put when the DMABUF is released.  This
> +	 * intentionally does not use get_file()/vma_set_file()
> +	 * because the references are already held, and ownership
> +	 * moves.
> +	 */
> +	priv->vfile = vma->vm_file;
> +	vma->vm_file = priv->dmabuf->file;
> +	vma->vm_private_data = priv;
> +
> +	return 0;
> +
> +err_free_phys:
> +	kfree(priv->phys_vec);
> +err_free_priv:
> +	kfree(priv);
> +	return ret;
> +}
> +
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  {
>  	struct vfio_pci_dma_buf *priv;
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index c8f6f959056a..06dc0fd3e230 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
>  	size_t size;
>  	struct phys_vec *phys_vec;
>  	struct p2pdma_provider *provider;
> +	struct file *vfile;
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> @@ -133,6 +134,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>  			      unsigned long address,
>  			      unsigned int order,
>  			      unsigned long *out_pfn);
> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> +				   struct vm_area_struct *vma,
> +				   u64 phys_start, u64 req_len,
> +				   unsigned int res_index);
>  
>  #ifdef CONFIG_VFIO_PCI_DMABUF
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,

