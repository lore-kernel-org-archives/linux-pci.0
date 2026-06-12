Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CC383305
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273185; cv=none; b=XimiPCLG3G3MVuJuXkTyVfzt5TK0+3qEKx4aiEBSX6yseep0CTiYEsSSOUwpw6C4jMRFw/vtbpme4KCNxIrRe9LxuaBNSYuMN8xtHBBteWVeWXe4sQEycN9B1uHrjfwec/4FgRp+7jOSHDXMHCr92FX1hh0WpKKf5fgOHley8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273185; c=relaxed/simple;
	bh=8nGRcelhCMsBP5e+Ti6pgha8vZKPOQWb1Xzagxo6dR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlHbsFt1BebYKUQuC0gG0fQUTBDEn+m31udl9vIy6C4gh86lvbvRzVz5MsLCoCogdiTqMBiVPk54OIuV7sLU3QdT6g4nen85sNGKR+tkTRMDa115M6tjxGpwpcvxp2qKMDscI1X4YEcfhWDeyqmQecLaRSDzPe1G6Yqp8mHf7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7MvQXrP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7MvQXrP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf22c18ad3so119885ad.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781273184; x=1781877984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gWNes2hHFmdqgzisSBTrBhiO7t0Lprwi8AqbjigE24=;
        b=m7MvQXrP5FFeGc1nXMIYk+a4X8itmrWVegIOWowNV9rAshzHeltu3Bed8cXCOPVc+q
         8qidSDuQhAIJOHwCIx4jRnzrDHORHEhizuJ+UgUNx8XV0FkP5yKsvRAlsSQ5TIO1E8lC
         KpQsX1DPsDhJvf/sy5nTzM/OMZ83w8OvRyaFXda5P7Ra0RGL2aHqaBU7LFG8k4snI1bQ
         eiiJZ7yrEHbsXb5yvCHQGz994pSiRo/Pdhh4J2Sse1gcY0D8AXEKesTggOZ3H2jSyXSO
         PpEH7xWuVwh1HzA3tob7KDuuQvXSZnPDRHa1Ooh3Q7zb5DoXaR9K/gSaBEe+HcEshp8/
         cyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273184; x=1781877984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gWNes2hHFmdqgzisSBTrBhiO7t0Lprwi8AqbjigE24=;
        b=f/7JEBNu5LsiPur7ed8yTb97hWehqfm3zasBs1EPGy0zObpFPsNXHPVRIyRa4u6ZRA
         igmSRmvJpRZncR8iiIa3+0pEgdXLgl2egTPStqSPBak/i+L1i0WRwlDHyQWIrP6rw/5h
         oSIC/FfoSvooMIIssroFkenrnuHTKCMo3ZqU11P09EG+UnWz6C7n/T+3+3bZUFqxyo21
         gZ1cbQ896fIDB1W7GAaafwR2BrfCQdJGiqyo39KGygdU7lwBekEXY16v6n0DspTpf7KR
         x/AkSFTA2kXXenfr3gdAmDf1CtPQM9L+ukeBUXA8PPbl3GDIAtwFWkU78Fn/694cv3EC
         rULg==
X-Forwarded-Encrypted: i=1; AFNElJ9Da8aloDpEV6QZmjnB2HCIl8vqBI7ciV5T0RRHluKukApVosvAzOyLxkWNW4BkI0faaAJ1DVoS9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2c5nsQXJUuZwaof9WEpsHfMXVnemnTpuyUSD8I0DERkPrLMTp
	cf3P+PtcIC5MvQ13nFuTHAy/cg7xqfw4aIyh+1lF8aNtSUUx8P2Hbtgfyp4TFYra3w==
X-Gm-Gg: Acq92OG7CEgnZiG+HZNCxo5kbuQOXLREolLLUBQXMDo0gzduj6+IilI6NA3ld3JOciE
	aZFVTzmyRCaAG30IDEjtZpVkvADIAZ3VuQ5gtor6IKDVXf+WpY/JLSFUDOgr33k34+bP+PihAmg
	H3Fgg2u3RKxIQbP1vTe+9qz27FVy2OwYzg8vsU2sRywhcsp9hsqY0AowAPvu3bRqlO3UomKodcK
	6YKctvvyDkHjJIuurQTfreqokXaIlsiKYGYraUueB520j/6mtYNsXQLzaQ/WJp98vd7XIfoI7N6
	QMuU7F3HwE7cbvWB61XAQeRtlkasVY4SgAIaC4DSz3hpu4I+pGkB28dmH1/K5ZMA+IqyA+qfCRu
	FNTpF2rxZ1hfO6+pNmowv1bT7vLU4U/+Q4g+Zs09hFZIT23fFuom6mba1vRf3AtpHLrgfhjZ+00
	ITkuj4x11uPpxyfml5+gTSq4nlE9vH0sLbPHrGSH9ojNDSBT9RiGeClrefeErnTkZfRe4bgqM=
X-Received: by 2002:a17:903:46c6:b0:2bd:6dad:3df9 with SMTP id d9443c01a7336-2c405f85829mr1700165ad.23.1781273183096;
        Fri, 12 Jun 2026 07:06:23 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5dcsm2325236a91.9.2026.06.12.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:06:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:06:14 +0000
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
Subject: Re: [PATCH v3 5/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Message-ID: <aiwSVk4n9mCQEln2@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-6-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-6-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:19PM +0100, Matt Evans wrote:
> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
> 
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 2fd3629789bf..8f7f1b909b94 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -4,6 +4,7 @@
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/dma-resv.h>
> +#include <uapi/linux/dma-buf.h>
>  
>  #include "vfio_pci_priv.h"
>  
> @@ -470,6 +471,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  {
>  	struct vfio_pci_dma_buf *priv;
>  	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
> +	char *bufname;
>  	int ret;
>  
>  	priv = kzalloc_obj(*priv);
> @@ -482,6 +484,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  		goto err_free_priv;
>  	}
>  
> +	bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
> +	if (!bufname) {
> +		ret = -ENOMEM;
> +		goto err_free_phys;
> +	}
> +
> +	/*
> +	 * Maximum size of the friendly debug name is
> +	 * vfio1234567890:ffff:ff:3f.7/5 = 30, which fits within
> +	 * DMA_BUF_NAME_LEN.
> +	 */
> +	snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
> +		 dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
> +

Nit: Could we instead use:

	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
	                    dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
	if (!bufname)
	    ret = -ENOMEM;
	    [...]

>  	/*
>  	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>  	 * start of the VMA corresponds to byte 0 of the DMABUF and
> @@ -500,7 +516,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>  	if (!priv->provider) {
>  		ret = -EINVAL;
> -		goto err_free_phys;
> +		goto err_free_name;
>  	}
>  
>  	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> @@ -508,7 +524,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  
>  	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>  	if (ret)
> -		goto err_free_phys;
> +		goto err_free_name;
>  
>  	/*
>  	 * Ownership of the DMABUF file transfers to the VMA so that
> @@ -523,8 +539,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	vma->vm_file = priv->dmabuf->file;
>  	vma->vm_private_data = priv;
>  
> +	spin_lock(&priv->dmabuf->name_lock);
> +	kfree(priv->dmabuf->name);
> +	priv->dmabuf->name = bufname;
> +	spin_unlock(&priv->dmabuf->name_lock);
> +
>  	return 0;
>  
> +err_free_name:
> +	kfree(bufname);
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:

Apart from that,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
