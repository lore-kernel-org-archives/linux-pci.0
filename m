Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921643A7F7;
	Tue, 22 Sep 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068633; cv=none; b=eSKOqVAijqSz4qjYWt9lcGYNA9COLpUQpCopwyCCuvxj1SJ+/WGYSwa6PsgW3mqDj65PQV0tekwv3RL/tePaJNJc/re9EGAH133+QOwmXTQUN0OJWm5Ii1x7SY39q+NuC8rzNxJmcktaE0GnQri+pYw+q5JdzPS69eG3aX0wcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068633; c=relaxed/simple;
	bh=ZEhZYMajqwZikpYWb3+/WDgXSy6OI38mIgdCRa2+T70=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hNpvHG2SPQT/cgZpqfC3ATghq5qef29VP6Xbr2Z0O4W9Algn5o9OrJ8g16kxrtN80oFq7g0BCm58IFGnhkZJS8oqYU6lHO5kz7F/Kyka8JHAFaGY2juOpdEhAOKItqc0kHRVKvRoc3Y8Zpc6cxf0pBDHOBT+nccWUd/6Rlr3Ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=soyMt4TB; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="soyMt4TB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z5GYnOnSGcSKNwDiiRexS9zq+lbg3axWa1qqGQO0mCY=;
	b=soyMt4TBZTX3bnKsYc3vkS8kmMPAj5hPMImlXTpemmmblScVL7dt6azHYbmgQ0E/jKYNrWt7w
	ZvpAA6lWTFtPES3som4HXCKUMumiBIVnWRtHVoIAJxJjmU8B3uefKt9GouhWS1oHtQf1K87ZJRJ
	A50vpLzBXFPzvAaG5CZ0nds=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hpvLl0ZTyzpT0b;
	Tue, 22 Sep 2026 17:05:03 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 3894A202E6;
	Tue, 22 Sep 2026 17:16:59 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 17:16:57 +0800
Subject: Re: [PATCH v6 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
To: Matt Evans <matt@ozlabs.org>
CC: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Kevin Tian
	<kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, Mahmoud Adam
	<mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
	<kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-6-matt@ozlabs.org>
 <1d59a556-c131-4608-e194-d51be3259541@huawei.com>
 <4f26dd49-0985-4049-a1fe-6a0a493c7a51@ozlabs.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <f8eb95a8-875e-fb31-a2a2-ffa1c531dedb@huawei.com>
Date: Tue, 22 Sep 2026 17:16:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4f26dd49-0985-4049-a1fe-6a0a493c7a51@ozlabs.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/21 21:24, Matt Evans wrote:
> Hi Longfang,
> 
> On 15/09/2026 13:16, liulongfang wrote:
>> On 2026/9/12 5:41, Matt Evans wrote:
>>> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
>>> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
>>> commit by VFIO's ordinary mmap() path.
>>>
>>> This function transfers ownership of the VFIO device fd to the
>>> DMABUF, which fput()s when it's released.
>>>
>>> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
>>> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
>>> this new VFIO_BAR mmap().
>>>
>>> By exchanging the VMA file, we lose the original device path in
>>> /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented synthetic
>>> 'filename' for BAR mappings based on the cdev, plus BDF, plus resource
>>> index.  (This does not apply to explicitly-exported DMABUFs which are
>>> named by DMA_BUF_SET_NAME.)
>>>
>>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>>> ---
>>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 211 +++++++++++++++++++++++------
>>>  drivers/vfio/pci/vfio_pci_priv.h   |   5 +
>>>  2 files changed, 171 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> index 9f10b10fc436..faa9239e66f8 100644
>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> @@ -3,6 +3,7 @@
>>>   */
>>>  #include <linux/dma-buf-mapping.h>
>>>  #include <linux/pci-p2pdma.h>
>>> +#include <linux/dma-buf.h>
>>>  #include <linux/dma-resv.h>
>>>  
>>>  #include "vfio_pci_priv.h"
>>> @@ -82,6 +83,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>>  		up_write(&priv->vdev->dmabuf_lock);
>>>  		vfio_device_put_registration(&priv->vdev->vdev);
>>>  	}
>>> +	if (priv->vfile)
>>> +		fput(priv->vfile);
>>>  	kfree(priv->phys_vec);
>>>  	kfree(priv);
>>>  }
>>> @@ -246,6 +249,167 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
>>>  	return ret;
>>>  }
>>>  
>>> +/*
>>> + * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
>>> + * for tracking (meaning cleanup or revocation will zap it), and take
>>> + * a vfio_device registration.
>>> + */
>>> +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
>>> +				  struct vfio_pci_dma_buf *priv, u32 flags)
>>> +{
>>> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>> +
>>> +	if (!vfio_device_try_get_registration(&vdev->vdev))
>>> +		return -ENODEV;
>>> +
>>> +	exp_info.ops = &vfio_pci_dmabuf_ops;
>>> +	exp_info.size = priv->size;
>>> +	exp_info.flags = flags;
>>> +	exp_info.priv = priv;
>>> +
>>> +	priv->dmabuf = dma_buf_export(&exp_info);
>>> +	if (IS_ERR(priv->dmabuf)) {
>>> +		vfio_device_put_registration(&vdev->vdev);
>>> +		return PTR_ERR(priv->dmabuf);
>>> +	}
>>> +
>>> +	kref_init(&priv->kref);
>>> +	init_completion(&priv->comp);
>>> +
>>> +	/* dma_buf_put() now frees priv */
>>> +	INIT_LIST_HEAD(&priv->dmabufs_elm);
>>> +
>>> +	/*
>>> +	 * dmabuf_lock synchronises access (R) or updates (W) to the
>>> +	 * vdev->dmabufs list and to bars_revoked (see below).  The
>>> +	 * revocation state of DMABUF elements in the list is written
>>> +	 * holding both dmabuf_lock(W) and resv, and tested with
>>> +	 * either.
>>> +	 *
>>> +	 * (memory_lock, if held ->) dmabuf_lock -> resv
>>> +	 *
>>> +	 * NOTE: memory_lock is strictly avoided here, to avoid a
>>> +	 * dependency on memory_lock when mmap_lock is held, when
>>> +	 * mmap() leads to export.  vfio-pci variant drivers are
>>> +	 * permitted to hold memory_lock across actions that might
>>> +	 * fault (such as user access); a deadlock could result when
>>> +	 * that fault path attempts to take mmap_lock (if held by an
>>> +	 * export waiting for memory_lock).
>>> +	 *
>>> +	 * vdev->bars_revoked tracks the BAR revocation status updated
>>> +	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
>>> +	 * follows the same criteria that later update the DMABUF
>>> +	 * state (BAR zap, etc.).
>>> +	 */
>>> +	lockdep_assert_not_held(&vdev->memory_lock);
>>> +
>>> +	down_write(&vdev->dmabuf_lock);
>>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>>> +	priv->revoked = vdev->bars_revoked;
>>> +	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>>> +	dma_resv_unlock(priv->dmabuf->resv);
>>> +	up_write(&vdev->dmabuf_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>> +				   struct vm_area_struct *vma,
>>> +				   u64 phys_start, u64 req_len,
>>> +				   unsigned int res_index)
>>> +{
>>> +	struct vfio_pci_dma_buf *priv;
>>> +	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
>>> +	char *bufname;
>>> +	int ret;
>>> +
>>> +	priv = kzalloc_obj(*priv);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>>> +	if (!priv->phys_vec) {
>>> +		ret = -ENOMEM;
>>> +		goto err_free_priv;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Maximum size of the friendly debug name is
>>> +	 * vfio1048575:ffff:ff:1f.7/5 = 26.  This fits within
>>> +	 * DMA_BUF_NAME_LEN, so dma_buf_set_name() below won't fail.
>>> +	 */
>>> +	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
>>> +			    dev_name(&vdev->vdev.device), pci_name(vdev->pdev),
>>> +			    res_index);
>>> +
>>> +	if (!bufname) {
>>> +		ret = -ENOMEM;
>>> +		goto err_free_phys;
>>> +	}
>>> +
>>> +	/*
>>> +	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>>> +	 * start of the VMA corresponds to byte 0 of the DMABUF and
>>> +	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
>>> +	 *
>>> +	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
>>> +	 * vma_pgoff_adjust, so that ultimately a fault's offset from
>>> +	 * the start of the _VMA_ has a consistent usage whether the
>>> +	 * VMA originates from an mmap() of the VFIO device here or a
>>> +	 * direct DMABUF mmap().  Note vma_pgoff_adjust also includes
>>> +	 * the encoded VFIO region index, which cancels out the index
>>> +	 * encoded in vm_pgoff.
>>> +	 */
>>> +	priv->vdev = vdev;
>>> +	priv->size = req_len;
>>> +	priv->nr_ranges = 1;
>>> +	priv->vma_pgoff_adjust = vma->vm_pgoff;
>>> +
>>> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>>> +	if (!priv->provider) {
>>> +		ret = -EINVAL;
>>> +		goto err_free_name;
>>> +	}
>>> +
>>> +	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
>>> +	priv->phys_vec[0].len = priv->size;
>>> +
>>> +	ret = vfio_pci_dmabuf_export(vdev, priv, O_RDWR);
>>> +	if (ret)
>>> +		goto err_free_name;
>>> +
>>
>> In the current patch, the PCIe device's BAR2 configuration space can be mapped as a DMABUF.
>> However, on an OS with a 64K page size, if a VF device's BAR2 is smaller than 64K,
>> a problem arises where the space is forced to page-align to 64K, it will causing the VM to
>> access memory beyond the actual size of the VF device's BAR2 space.
>>
>> How does your solution handle these cases where the BAR2 space is smaller than the Host OS's page size?
> 
> Even on a 4K host, there can be BARs < PAGE_SIZE so 64K (or 16K) hosts
> aren't a new case.  These small BARs cannot be mmap()ed and DMABUFs
> cannot be exported from them.  (vfio_pci_core_mmap() errors out when
> !bar_mmap_supported[index].  And, a DMABUF needs to be an aligned
> multiple of PAGE_SIZE, plus vfio_pci_core_fill_phys_vec() won't allow a
> DMABUF to be created off the end of a BAR.)
> 
> So, although this series allows a DMABUF to be mmap()ed, the preexisting
> checks prevent a sub-page DMABUF from existing and so there is no new
> route to mapping a sub-page BAR.
> 
> What's the concern on BAR2 specifically, out of interest?  This logic is
> applied to all resources equally, and tests pci_resource_len(...) so
> there shouldn't be a PF/VF distinction either.
>

However, the typical boundary check found in VFIO, such as:

if (req_start + req_len > phys_len)
	return -EINVAL;

seems to be missing here.

Thanks.
Longfang.

> 
> Matt
> 
>>
>> Thanks.
>> Longfang.
>>
>>> +	if (dma_buf_set_name(priv->dmabuf, bufname)) {
>>> +		/* Shouldn't happen, but don't leak if it does: */
>>> +		dev_dbg_ratelimited(&vdev->pdev->dev,
>>> +				    "Failed to set map name '%s'\n",
>>> +				    bufname);
>>> +		kfree(bufname);
>>> +	}
>>> +
>>> +	/*
>>> +	 * Ownership of the DMABUF file transfers to the VMA so that
>>> +	 * other users can locate the DMABUF via a VA.  Ownership of
>>> +	 * the original VFIO device file being mmap()ed transfers to
>>> +	 * priv, and is put when the DMABUF is released.  This
>>> +	 * intentionally does not use get_file()/vma_set_file()
>>> +	 * because the references are already held, and ownership
>>> +	 * moves.
>>> +	 */
>>> +	priv->vfile = vma->vm_file;
>>> +	vma->vm_file = priv->dmabuf->file;
>>> +	vma->vm_private_data = priv;
>>> +
>>> +	return 0;
>>> +
>>> +err_free_name:
>>> +	kfree(bufname);
>>> +err_free_phys:
>>> +	kfree(priv->phys_vec);
>>> +err_free_priv:
>>> +	kfree(priv);
>>> +	return ret;
>>> +}
>>> +
>>>  /*
>>>   * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>>   * It allows the two co-operating drivers to exchange the physical address of
>>> @@ -364,7 +528,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>  {
>>>  	struct vfio_device_feature_dma_buf get_dma_buf = {};
>>>  	struct vfio_region_dma_range *dma_ranges;
>>> -	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>>  	struct vfio_pci_dma_buf *priv;
>>>  	size_t length;
>>>  	int ret;
>>> @@ -424,49 +587,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>  	kfree(dma_ranges);
>>>  	dma_ranges = NULL;
>>>  
>>> -	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>>> -		ret = -ENODEV;
>>> +	ret = vfio_pci_dmabuf_export(vdev, priv, get_dma_buf.open_flags);
>>> +	if (ret)
>>>  		goto err_free_phys;
>>> -	}
>>> -
>>> -	exp_info.ops = &vfio_pci_dmabuf_ops;
>>> -	exp_info.size = priv->size;
>>> -	exp_info.flags = get_dma_buf.open_flags;
>>> -	exp_info.priv = priv;
>>> -
>>> -	priv->dmabuf = dma_buf_export(&exp_info);
>>> -	if (IS_ERR(priv->dmabuf)) {
>>> -		ret = PTR_ERR(priv->dmabuf);
>>> -		goto err_dev_put;
>>> -	}
>>> -
>>> -	kref_init(&priv->kref);
>>> -	init_completion(&priv->comp);
>>> -
>>> -	/* dma_buf_put() now frees priv */
>>> -	INIT_LIST_HEAD(&priv->dmabufs_elm);
>>> -
>>> -	/*
>>> -	 * dmabuf_lock synchronises access (R) or updates (W) to the
>>> -	 * vdev->dmabufs list and to bars_revoked (see below).  The
>>> -	 * revocation state of DMABUF elements in the list is written
>>> -	 * holding both dmabuf_lock(W) and resv, and tested with
>>> -	 * either.
>>> -	 *
>>> -	 * dmabuf_lock -> resv
>>> -	 *
>>> -	 * vdev->bars_revoked tracks the BAR revocation status updated
>>> -	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
>>> -	 * follows the same criteria that later update the DMABUF
>>> -	 * state (BAR zap, etc.).
>>> -	 */
>>> -	down_write(&vdev->dmabuf_lock);
>>> -	dma_resv_lock(priv->dmabuf->resv, NULL);
>>> -	priv->revoked = vdev->bars_revoked;
>>> -	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>>> -	dma_resv_unlock(priv->dmabuf->resv);
>>> -	up_write(&vdev->dmabuf_lock);
>>> -
>>>  	/*
>>>  	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
>>>  	 * will be released.
>>> @@ -477,8 +600,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>  
>>>  	return ret;
>>>  
>>> -err_dev_put:
>>> -	vfio_device_put_registration(&vdev->vdev);
>>>  err_free_phys:
>>>  	kfree(priv->phys_vec);
>>>  err_free_priv:
>>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>>> index 48d9f574a3df..3ec676e12e21 100644
>>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>>> @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
>>>  	size_t size;
>>>  	struct phys_vec *phys_vec;
>>>  	struct p2pdma_provider *provider;
>>> +	struct file *vfile;
>>>  	u32 nr_ranges;
>>>  	struct kref kref;
>>>  	struct completion comp;
>>> @@ -134,6 +135,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
>>>  			      unsigned long address,
>>>  			      unsigned int order,
>>>  			      unsigned long *out_pfn);
>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>> +				   struct vm_area_struct *vma,
>>> +				   u64 phys_start, u64 req_len,
>>> +				   unsigned int res_index);
>>>  
>>>  #ifdef CONFIG_VFIO_PCI_DMABUF
>>>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>
> 
> .
> 
