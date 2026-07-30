Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6543A7FF;
	Thu, 30 Jul 2026 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422293; cv=none; b=mApTcmPC977XDI1e5adeeuPC4CIH6k55NKwPl5zyLhfIALL6S4dzZ4No0TloseDagbL8sDfJjnr6zoUsIRcHKI/9LDPbIMyF+W4wVAA4lVMfd1n6bnYAEOOjFyHJrx0SgBqOC6RD3IRnfICWsi2NWeUXEVDcnqEyRho3BUL9rzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422293; c=relaxed/simple;
	bh=nA82i2GVeUC9mMUAzm+S3h9CjKK0eP9OVCkyoeZwHz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQlc8xk/nwJfHVJgCFth2qTcmlmtEXf429hCvlahYbL8uTCaL3Li2oQG5WNjCxpTo7apstoYQiX86rJm4Plq1lN8xrjiff/ONRCOD/hohhVGC6uFb2D7F/RhvzY/YHdPTXpWo7xt0N3i4rJDs5js5cu+UveceZDQL5HSfm3LbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=K+6kWfbg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="K+6kWfbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785422288;
	bh=fqTNWLR/d4veAAEFMUn2oRRZ4bmdwkTJqL3WSF90f08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+6kWfbg+RV5riYpu8WAFkO2J3ZnuYjyAPxZ+5Kx6sxFDtAk+wJSbEH+aZiK4E1Ai
	 Ut71/O6g0OUeunrTyC67Ky8LhBHNZO2CraFSp9FrzEK/b2sOAxKvSiTCyMuHQafc1z
	 fYi+PpDmrjPsbU5uYZcyidSE3CaQU/dQSMospNauiZFUDMgpH+UN/MypmoSzrcfjHV
	 952oEJFMIpoF3W1kFZORtAX7q/XbZ9Ve0rT9Ho0gA1ZWE5W4INcAQptn7jrnlOmw1Y
	 SPnvXTuYL2PzYsTsZYXXTBtgSmDfAz/s5erQgPEDTx/qVC61Wf6QSRATFWEK1wi1/m
	 0Ln7AWFoLIdkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h9sHp3gLYz4wSW;
	Fri, 31 Jul 2026 00:37:56 +1000 (AEST)
Message-ID: <19020474-0856-4684-b2a3-b60d67c5903e@ozlabs.org>
Date: Thu, 30 Jul 2026 15:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-7-matt@ozlabs.org>
 <20260729115202.15ac87c5@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260729115202.15ac87c5@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 29/07/2026 18:52, Alex Williamson wrote:
> On Wed, 15 Jul 2026 18:47:29 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> Since converting BAR mmap()s to using DMABUFs, we lose the original
>> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
>> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>>
>> This applies only to BAR mappings via the VFIO device fd, as
>> explicitly-exported DMABUFs are named by userspace via the
>> DMA_BUF_SET_NAME ioctl.
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 46b3cf5dc94b..51606ff3cdc6 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/dma-buf-mapping.h>
>>  #include <linux/pci-p2pdma.h>
>>  #include <linux/dma-resv.h>
>> +#include <uapi/linux/dma-buf.h>
> 
> Is this required?  It seems unused.

No, good catch.  That originally pulled in DMA_BUF_NAME_LEN in the
previous version snprintf'ing here.  Removed.

>>  
>>  #include "vfio_pci_priv.h"
>>  
>> @@ -486,6 +487,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>  {
>>  	struct vfio_pci_dma_buf *priv;
>>  	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
>> +	char *bufname;
>>  	int ret;
>>  
>>  	priv = kzalloc_obj(*priv);
>> @@ -498,6 +500,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>  		goto err_free_priv;
>>  	}
>>  
>> +	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
>> +			    dev_name(&vdev->vdev.device), pci_name(vdev->pdev),
>> +			    res_index);
>> +
>> +	if (!bufname) {
>> +		ret = -ENOMEM;
>> +		goto err_free_phys;
>> +	}
>> +
>>  	/*
>>  	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>>  	 * start of the VMA corresponds to byte 0 of the DMABUF and
>> @@ -516,7 +527,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>  	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>>  	if (!priv->provider) {
>>  		ret = -EINVAL;
>> -		goto err_free_phys;
>> +		goto err_free_name;
>>  	}
>>  
>>  	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
>> @@ -524,7 +535,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>  
>>  	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>>  	if (ret)
>> -		goto err_free_phys;
>> +		goto err_free_name;
>>  
>>  	/*
>>  	 * Ownership of the DMABUF file transfers to the VMA so that
>> @@ -539,8 +550,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>  	vma->vm_file = priv->dmabuf->file;
>>  	vma->vm_private_data = priv;
>>  
>> +	spin_lock(&priv->dmabuf->name_lock);
>> +	kfree(priv->dmabuf->name);
>> +	priv->dmabuf->name = bufname;
>> +	spin_unlock(&priv->dmabuf->name_lock);
> 
> This is simple, but shouldn't it really have a sanctioned, exported
> dmabuf helper rather than open coding this handling?  Thanks,

Hm, okay that's reasonable.  I've refactored dma_buf_set_name() and used
it from here (separating out a userspace-string-copying version for the
original ioctl usage).

Thanks for looking at the rest of v5 also.


Matt


> 
> Alex
> 
>> +
>>  	return 0;
>>  
>> +err_free_name:
>> +	kfree(bufname);
>>  err_free_phys:
>>  	kfree(priv->phys_vec);
>>  err_free_priv:
> 

