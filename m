Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317E331A77
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296515; cv=none; b=gJl1CTtU18oobctS09UVJ/+oXuk3hf5pJDWz/MRHnEY5ShD7CbuYL6LU47F2Q9WVp97xXxKTR39Mhep96utvIfCWx6VS5r87dT3FOh9AnkRYQzu6jvZycUefXTKxsCWyV1rAOSiERjMVo3MzQi0uZJZalLrFQRyk81FoJGM07YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296515; c=relaxed/simple;
	bh=d/H3YUSb7Xb1BXZue09+f2TQu7Z0YTKfeZLnWE2Bm04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzWF5JBARolLw+uU2gHkRdeIVY4QEABYf27N2dOnsY7Xmi//GCsEIXQ/CtfFOBeQoDU+VW51LJU522qs0q0+yxQunAG0yO6NHVldUdgTn8/Pyk7yjtnIONbAjjXD+EqhPkCvpSGjjA/JMckm5UOD4gFj1ilwjKBx8g07fpwdQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bf1IRcem; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bf1IRcem"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2911f93cso3985ad.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781296512; x=1781901312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddJRP/HCOdDtAL2h34nFkdEDW/TddVVb74Su299sjvc=;
        b=Bf1IRcemp1hYaNxcUVtYW68sDRnZYEcsCQDryryZ9/e4OLKXXuQd0C4AFEJVIBhnnC
         YYz3n5YyE2cwCL673BHHZdAmMMCV2rJh30K5/ELnWMXMW5p4mw+EEVuHihPso8cX4zO+
         owPDJZj7quli1+SufjuW5pqt7p2UxLtCPO53fZ0fHtJFiGvUyU2h3h3zg++rMFIxkk+l
         A53pyBpKBlitemTBsxliPHlzIjlt6Dyvv0Ho1NyUOclPmz6FOt1aRzssDoXjXzVixe2b
         ppz9ecpt+S6foWA1jF8kjqVh90KfzFEanra1VssYH3CHb1Upc5xYIPKnz7B1kSOr64AJ
         1rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296512; x=1781901312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddJRP/HCOdDtAL2h34nFkdEDW/TddVVb74Su299sjvc=;
        b=JwbA1isHeKI6LwdOj69rqkKWe2MCLX+mt1RaTZ5WoNu/tr2EkzBnOGg60a8N2JXv0m
         N86rzMFe2b6U0L2GZpo5PEd2EtfDcS3bxZy4iCZB6aHmiOY2rTPwZWiplCG2znGr2/sN
         T2jcWlr3fpC/I0da9LP8vRU34RbWI8QbsM+QlM2hhz3ZHaY76uOdLvpbfQJBvoe0KMWo
         95PDyUDcZhRzcHovovWuhHqtwn8U9UVvHWQT4kBnmsRAOkuqHFaIk0JgYwwDeBgCuivR
         EsZoqdA9N2xeqX4qVIRWE4LCGyQvnFMIgKmHPDtPwtU9Q7EwurLtV4/W6GKUER0YJaz3
         Vo8w==
X-Forwarded-Encrypted: i=1; AFNElJ/ioswAi32RJ0m6hkMAtcN2E72UW/gSbdM1zhj1OE7cTVda6xBOy8cCCB7avzprXr1c6GpTiI8IlS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MNFnp+E+H/iSDle16qLqK4mSO7mkdtY9Igfvw0FBCtlSzP39
	+P/AG8cqwO4ea10zZsrM8ouu/fZLXqkxwvE5HJtRroph/9QQQhidrjZIHqu+6yVZ2g==
X-Gm-Gg: Acq92OGNKYSOXe2a6YKf29n1Dz4DvvZ0RzL9IGS+41zTy+Iax++Gh1js27cGjoxfOET
	LOryYGBeDAzY4YKo+yoxz7t6uGT3JOhdeA1wKFMpe2QomcfyXffEU44YBDGsu5ybFYPH5b1saYp
	C+fhUTyU6pj0Ril7BNurfaxOnkfSrZDcv9/Hdje5zDl+MK7HAFpJHaYY64q+zdjezUZ0nADXA3e
	OyXhTiM4pYZEoDiqM8UcSAU2Vae+H8H+Upup3iI6DCPqCV8j1jPTY8qy5rIalsCwoY0EyXWcwPr
	BNdMLopa1mgoF1y+3MA+DAbkZpiCxeF/GeOpFxsPajBkUxjynr7J5Gjg6hKueS1u8BpHb/ALhK+
	TMR7EvnhRd2zsnxv9ORa/ZU1frutTB64FRP6p8Pjv5eZWdeSFzr61fzOl9uk5mcIBkdMZKt+dKn
	S66ueQMjYjA1d0Jvy3CXoMmzgVPDTeCVTBqaT0YUv3mmZGgv5vebwTn4RlWL5r
X-Received: by 2002:a17:902:e743:b0:2c1:ee6e:4e4d with SMTP id d9443c01a7336-2c665142269mr504685ad.30.1781296511981;
        Fri, 12 Jun 2026 13:35:11 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0f19sm28160925ad.10.2026.06.12.13.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:35:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 20:35:03 +0000
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
Subject: Re: [PATCH v3 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <aixtd_7gDhf2kisJ@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-8-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-8-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:21PM +0100, Matt Evans wrote:

Hi Matt,

[...]

> +	 *
> +	 * With the goal of taking vdev->memory_lock in a world where
> +	 * vdev might not still exist:
> +	 *
> +	 * 1. Take the resv lock on the DMABUF:
> +	 *  - If racing cleanup got in first, the buffer is revoked;
> +	 *    stop/exit if so.
> +	 *  - If we got in first, the buffer is not revoked so vdev is
> +	 *    non-NULL, accessible, and cleanup _has not yet put the
> +	 *    VFIO device registration_.  So, the device refcount must
> +	 *    be >0.
> +	 *
> +	 * 2. Take vfio_device registration (refcount guaranteed >0
> +	 *    hereafter).
> +	 *
> +	 * 3. Unlock the DMABUF's resv lock:
> +	 *  - A racing cleanup can now complete.
> +	 *  - But, the device refcount >0, meaning the vfio_device
> +	 *    (and vfio_pcie_core device vdev) have not yet been
> +	 *    freed.  vdev is accessible, even if the DMABUF has been
> +	 *    revoked or cleanup has happened, because
> +	 *    vfio_unregister_group_dev() can't complete.
> +	 *
> +	 * 4. Take the vdev->memory_lock
> +	 *  - Either the DMABUF is usable, or has been cleaned up.
> +	 *    Whichever, it can no longer change under us.
> +	 *  - Test the DMABUF revocation status again: if it was
> +	 *    revoked between 1 and 4 return a SIGBUS. Otherwise,
> +	 *    return a PFN.
> +	 *  - It's not necessary to also take the resv lock, because
> +	 *    the status/vdev can't change while memory_lock is held.
> +	 *
> +	 * 5. Unlock, done.
>  	 */
> +
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
> +
> +	if (priv->revoked) {
> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
> +				     __func__, vmf->address, vma->vm_pgoff);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	/* If the buffer isn't revoked, vdev is valid */
>  	vdev = priv->vdev;
>  
> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
> +		/*
> +		 * If vdev != NULL (above), the registration should
> +		 * already be >0 and so this try_get should never
> +		 * fail.
> +		 */
> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
> +			 __func__);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	dma_resv_unlock(priv->dmabuf->resv);
> +


>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
> +		/* Revocation status must be re-read, under memory_lock */
>  		if (!priv->revoked) {
>  			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>  							     vmf->address,

Wait, I noticed that the is_aligned_for_order() check from mainline was 
removed here. Was that intentional? 

For hugepage faults (order > 0), we must ensure the PFN and address are
properly aligned before calling vfio_pci_vmf_insert_pfn().

In the current upstream code, we have:
  if (is_aligned_for_order(vma, addr, pfn, order))

Should we restore that check here?

> @@ -1766,6 +1827,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>  			    __func__, order, pfn, vmf->address,
>  			    vma->vm_pgoff, (unsigned int)ret);
>  
> +	vfio_device_put_registration(&vdev->vdev);
>  	return ret;
>  }
>  
> @@ -1774,7 +1836,7 @@ static vm_fault_t vfio_pci_mmap_page_fault(struct vm_fault *vmf)
>  	return vfio_pci_mmap_huge_fault(vmf, 0);
>  }
>  
> -static const struct vm_operations_struct vfio_pci_mmap_ops = {
> +const struct vm_operations_struct vfio_pci_mmap_ops = {
>  	.fault = vfio_pci_mmap_page_fault,

Nit: Instead of making this global, should we add a helper? E.g.:

void vfio_pci_set_vma_ops(struct vm_area_struct *vma)
{
     vma->vm_ops = &vfio_pci_mmap_ops;
}

[...]

> +
> +static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	/*
> +	 * If we observe that the buffer is revoked now then refuse
> +	 * the mmap().  This is a belt-and-braces early failure to
> +	 * ease debugging a revoked buffer being used.  Userspace
> +	 * might also race an mmap() against an explicit revocation,
> +	 * or an action doing a temporary revoke; race scenarios are
> +	 * still safe because the fault handler ultimately prevents
> +	 * access to a revoked buffer if it isn't caught here.
> +	 */
> +	if (READ_ONCE(priv->revoked))
> +		return -ENODEV;
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * dma_buf_mmap_internal() has asserted that the VMA is
> +	 * contained within the DMABUF size before calling this.
> +	 */
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +
> +	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
> +	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
> +		     VM_DONTEXPAND | VM_DONTDUMP);
> +	vma->vm_private_data = priv;
> +	vma->vm_ops = &vfio_pci_mmap_ops;
> +
> +	return 0;
> +}
>  #endif /* CONFIG_VFIO_PCI_DMABUF */
>  

Thanks,
Praan
