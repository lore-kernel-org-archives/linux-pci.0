Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFD450901;
	Tue, 16 Jun 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624770; cv=none; b=pRlOvyJdw83oy0aCYNr1vX7X9Pm64d5fYY1d5m8E99gouExNM6NVl0trAQlskMTSbF42YwK4uLs2XZs0CB0BOba++aBORsz/bMWeeJizlHfCHAj3XMuohtxJ6QiOfrAwc85O97UqcrA7J+COBBBnLo7ibhgZ5HINBVfYCkmEIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624770; c=relaxed/simple;
	bh=fItsoDno4OXTl/roZip1JO0/Uy5m1LoydcJisLehhkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArzZRWimphsy7mkKHWJQoQErFOtPV8/HpBxlq3+i21LrXWYbLg/oorddvmMaZpXfhjPvH9n47c7pFo8gAdu7WbW+l5Msyuf5uWkStvFrrCFLTIMfQnLjnadb/RnU0KhTUWdrueBSuWsgfbKG1dJsAptJa790B4dojQfVUTE/GNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=THUOroZs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="THUOroZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1781624757;
	bh=j3l8PvO0raZl8FCiGfg/zxw+3QiENISLFXyCDIfAXL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THUOroZs0WczfHibO0A/qrPSHwa5YNdoYCeWJF2d/1CIECVXjkloXj7wLH3RAMrqd
	 5fczYcVAY5/pQy+4+jgY4kuVXiUvzSAMPKLcKb1C5w9H+cAzmY47/8bx3acg6k87j4
	 fWhZfAaafjgGWk3F2SAREOE3MsU3h3u2Wvysz2/iIQH1R8GKJhsXoFXbYm69HVXkRB
	 VhWj40L7/ojitg33igOa1igkbg9cSGVkGEkTixJmeB6SmBl5O2ZB/E1wXD9LyDkEa8
	 Kom/JzqnfzG5JdI7rGl9KPo/I/8vsIBaPI94iumvlLCPSeuLfYBHIH6aGkgJFoTfle
	 LbV6upvypwVdw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gfrtN6g3Dz4w1b;
	Wed, 17 Jun 2026 01:45:48 +1000 (AEST)
Message-ID: <e94aa97f-1aba-408e-8d3a-19f60b057b34@ozlabs.org>
Date: Tue, 16 Jun 2026 16:45:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Content-Language: en-GB
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-8-matt@ozlabs.org> <aixtd_7gDhf2kisJ@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <aixtd_7gDhf2kisJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Praan,

On 12/06/2026 21:35, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 04:43:21PM +0100, Matt Evans wrote:
> 
> Hi Matt,
> 
> [...]
> 
>> +	 *
>> +	 * With the goal of taking vdev->memory_lock in a world where
>> +	 * vdev might not still exist:
>> +	 *
>> +	 * 1. Take the resv lock on the DMABUF:
>> +	 *  - If racing cleanup got in first, the buffer is revoked;
>> +	 *    stop/exit if so.
>> +	 *  - If we got in first, the buffer is not revoked so vdev is
>> +	 *    non-NULL, accessible, and cleanup _has not yet put the
>> +	 *    VFIO device registration_.  So, the device refcount must
>> +	 *    be >0.
>> +	 *
>> +	 * 2. Take vfio_device registration (refcount guaranteed >0
>> +	 *    hereafter).
>> +	 *
>> +	 * 3. Unlock the DMABUF's resv lock:
>> +	 *  - A racing cleanup can now complete.
>> +	 *  - But, the device refcount >0, meaning the vfio_device
>> +	 *    (and vfio_pcie_core device vdev) have not yet been
>> +	 *    freed.  vdev is accessible, even if the DMABUF has been
>> +	 *    revoked or cleanup has happened, because
>> +	 *    vfio_unregister_group_dev() can't complete.
>> +	 *
>> +	 * 4. Take the vdev->memory_lock
>> +	 *  - Either the DMABUF is usable, or has been cleaned up.
>> +	 *    Whichever, it can no longer change under us.
>> +	 *  - Test the DMABUF revocation status again: if it was
>> +	 *    revoked between 1 and 4 return a SIGBUS. Otherwise,
>> +	 *    return a PFN.
>> +	 *  - It's not necessary to also take the resv lock, because
>> +	 *    the status/vdev can't change while memory_lock is held.
>> +	 *
>> +	 * 5. Unlock, done.
>>  	 */
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>> +
>> +	if (priv->revoked) {
>> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
>> +				     __func__, vmf->address, vma->vm_pgoff);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +
>> +	/* If the buffer isn't revoked, vdev is valid */
>>  	vdev = priv->vdev;
>>  
>> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> +		/*
>> +		 * If vdev != NULL (above), the registration should
>> +		 * already be >0 and so this try_get should never
>> +		 * fail.
>> +		 */
>> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
>> +			 __func__);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +
> 
> 
>>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> +		/* Revocation status must be re-read, under memory_lock */
>>  		if (!priv->revoked) {
>>  			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>>  							     vmf->address,
> 
> Wait, I noticed that the is_aligned_for_order() check from mainline was 
> removed here. Was that intentional? 
> 
> For hugepage faults (order > 0), we must ensure the PFN and address are
> properly aligned before calling vfio_pci_vmf_insert_pfn().
> 
> In the current upstream code, we have:
>   if (is_aligned_for_order(vma, addr, pfn, order))
> 
> Should we restore that check here?

The alignment check is done within the helper
vfio_pci_dma_buf_find_pfn(), which returns -EAGAIN if order > 0 and a
search result isn't usable due to alignment.  That leads to
VM_FAULT_FALLBACK here, ensuring vfio_pci_vmf_insert_pfn() isn't called
with anything weird.

>> @@ -1766,6 +1827,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>  			    __func__, order, pfn, vmf->address,
>>  			    vma->vm_pgoff, (unsigned int)ret);
>>  
>> +	vfio_device_put_registration(&vdev->vdev);
>>  	return ret;
>>  }
>>  
>> @@ -1774,7 +1836,7 @@ static vm_fault_t vfio_pci_mmap_page_fault(struct vm_fault *vmf)
>>  	return vfio_pci_mmap_huge_fault(vmf, 0);
>>  }
>>  
>> -static const struct vm_operations_struct vfio_pci_mmap_ops = {
>> +const struct vm_operations_struct vfio_pci_mmap_ops = {
>>  	.fault = vfio_pci_mmap_page_fault,
> 
> Nit: Instead of making this global, should we add a helper? E.g.:
> 
> void vfio_pci_set_vma_ops(struct vm_area_struct *vma)
> {
>      vma->vm_ops = &vfio_pci_mmap_ops;
> }

I'll give it a go, it would be nice to keep that encapsulated.

Thanks,


Matt


> [...]
> 
>> +
>> +static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>> +{
>> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>> +
>> +	/*
>> +	 * If we observe that the buffer is revoked now then refuse
>> +	 * the mmap().  This is a belt-and-braces early failure to
>> +	 * ease debugging a revoked buffer being used.  Userspace
>> +	 * might also race an mmap() against an explicit revocation,
>> +	 * or an action doing a temporary revoke; race scenarios are
>> +	 * still safe because the fault handler ultimately prevents
>> +	 * access to a revoked buffer if it isn't caught here.
>> +	 */
>> +	if (READ_ONCE(priv->revoked))
>> +		return -ENODEV;
>> +	if ((vma->vm_flags & VM_SHARED) == 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * dma_buf_mmap_internal() has asserted that the VMA is
>> +	 * contained within the DMABUF size before calling this.
>> +	 */
>> +
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>> +
>> +	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
>> +	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
>> +		     VM_DONTEXPAND | VM_DONTDUMP);
>> +	vma->vm_private_data = priv;
>> +	vma->vm_ops = &vfio_pci_mmap_ops;
>> +
>> +	return 0;
>> +}
>>  #endif /* CONFIG_VFIO_PCI_DMABUF */
>>  
> 
> Thanks,
> Praan
> 

