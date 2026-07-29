Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263ED39EF23;
	Wed, 29 Jul 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347565; cv=none; b=b+xF0X01yeocrDaKbSSeQ/aHu7KTymcYCLwSY1bMPGovAHvXUNyQy+bI/M8zizocVGbmvCDBexo5IsJ/61qA7Ie5OTo6AXq2T7/i7Fxj/mfWdpo/YroOxUjUZnHcU7SECiuEIeDV0g5EbGeDTwHnm0xQFXMnPJKKc/JpUPA2S6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347565; c=relaxed/simple;
	bh=UmoCyoW1+B65IpGMS+VGdlWV5NUjzcYcNkcddFzWlnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN3YgNxs+X356psHGTBfyS+Y0cRhO6JehYlHOht1NxtTOuq34ZD3eM4K2VKOt5aAqHJMQ7q1VCc7Fboyl9f7FwMRHMYadF6LkR7vyp+x2a0kQgRbGWqQf7v/IDrDzmZJxP8kdhdlVtj1osTWscTFAVkJpZjHlimugUcOE8qZ+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=sqREERo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjBg0u0c; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="sqREERo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjBg0u0c"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCFFA7A015D;
	Wed, 29 Jul 2026 13:52:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 29 Jul 2026 13:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785347561;
	 x=1785433961; bh=swpO+bNIco0ihJ3x/W/Pu1/SVkczokwLjjxdBh5qjHw=; b=
	sqREERo8HzAmvXZHFuCj/SlyWZZB8UeN9C2HchMSbnX2sjmZl8T2z0v1JusVXpSD
	hdBlqEqFYdFsy2kNz+f8ByGoYqXWKw1BS/MSuqVNSGoYYAMYOv4IOIFdX/U0bVlG
	8GEuLLbUo9eu5bewbnyfde3texnd/KwvK3yZQhD9Ry5SKNqDjDeW5SoKV7ydU9l0
	yWbtxU9CYTFlSzroDd9MZbJXgD36AYA7SUaFxTjR198DlgJLeU+AXMTIqAdRCMz/
	iuh6FbWaVQ2oLvjdgn/7Kx+h5FqPClNiJfrhUNvqKQixZdqIn1OqoVNxhdRvca+5
	kztMO5PH3pU4dNmBMNlLhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785347561; x=
	1785433961; bh=swpO+bNIco0ihJ3x/W/Pu1/SVkczokwLjjxdBh5qjHw=; b=O
	jBg0u0cnLP9y7Dy3mEv7rKGlf4B6JOqXu8v121NKWu4hwUOKTdsKSORAz7p4Vv+z
	m+BpGCPldcGZmnhLsc+wJNoXZ0IDqwBA/ZDym83aFOoc/BQk70an9WQ1QdZE4M3H
	vtPA5yAMo6uVYPq14Orwrxa1gwdCmQB7b50D/yTYpe8HSqE/V1YZ7IE4izzHorEu
	PbEvoMI9oeg7crTD4qJJS8uf7J8f6FrgzvZX/acCa/SePdhlc2cBJTdoPM77j8lX
	h86xK/cxk5EmuJrY2S93DWFabBSeUsUut0Ytb8Y3W9Yq1WcbuP+KOqKBXsT3RLp1
	FN2fcnGiaojXWpUQ8TCuQ==
X-ME-Sender: <xms:6T1qavKkLD7eR7SBOITsKnAFzHv_9eV92nCi2NM7pEXVoMkmdoV2ww>
    <xme:6T1qajvNPNBgpRp3C_2DKaHojFclwxQcdwMAhpMy7oEb5zFoWPclERhQHaIgVTYp_
    BbpNnBe68G-JzGlHnSaTfPYCnMU2OKGFGCz6AOox9kXifjmhLwBCwI>
X-ME-Received: <xmr:6T1qagmTTP_XoWjfpN4CoktfY6stCqT3jhnSvnJlcVGOqjTj-W2anOYtL7h_wg>
X-ME-Proxy-Cause: dmFkZTEEKmvm6usZpfT8gTSOJbqanlO3Pfaw1SwlI8f/Y1kQuB5PNxzg3aOh42AlQ5x0re
    mEkbtzhui+wLYtqWZK72Xd/sdJJEBvaXRotkM6Vk0bPPvLVaNTNCx4v9cPIE7guN0chqZG
    xBk0FjLQTleHOrHFXXErnyGCptkTDYgk7zSCFRUjOu4hbmap/73RGBIgA9cJ0wq9zAoT+n
    iQ8tOqSb+FQ4ww6H9mq9hRsOLrowOesvFEIXGg5PbgzKo3PTE5X8d/73KQfrp4YMVmYaaN
    ygTQrCIHZp6Q1vuJ9i+D5kwdZMjX9SfNAWiOB7hAYx70kmcGovcy9tx9FXQs3RN4UEbWtE
    3K3KDGkznqKjYQsSX/IsdTEKcHLf8ZTBrc1kvNbfpB0t4LBiGUOi7/IROIHgGuXY3y0tl9
    BFEeK96JLUeIVgqBQ5e4Nz0uRkqCUMwlp9cYPA0rb5CG8mAe5gZ+jaMDw0QTCCnLnW0Jr6
    6fAji32cEBoDlQAPFOAIZY20wWs5NLmUXY24ZiMAvijjpELbFFAxTQKi8B+a0PXANCXMxJ
    1UUEvQoF7v7P9hM+uW8GdkzNl0vc2fZq6s1hzPaaPmfktxrBrgSLiU+3HZlBGCOuXaPpMS
    EdOJGXzIUGBYf4QhuB6DNQ5UJ1bhVK2sOVcskyLlKBxFhuIMN34k4k+rP1Nw
X-ME-Proxy: <xmx:6T1qain9SgKcWGIXJs-Y-bEKMoystX2kw6RS5VcWq6a-4UTBGNrJ_w>
    <xmx:6T1qarg7idyfLpPbW4_aiUBnkUlQMETXGvrlcRSIPz2f61mvOMLKWA>
    <xmx:6T1qakFutMxP9D3z5TP4tK0lhtMsLrE33Tw1G1c5Vp3Y_Q1TS9QpuQ>
    <xmx:6T1qamZNPJ-KkRvn8RQqHYhOvU_L4VC06iAKgFXNu07YZFKR0IttTw>
    <xmx:6T1qaiuMZR5lUMAOC-vCbCPd2z_AH1r3iiEa_y9o84b84x56Ay7EfScS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:52:39 -0400 (EDT)
Date: Wed, 29 Jul 2026 11:52:02 -0600
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
Subject: Re: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Message-ID: <20260729115202.15ac87c5@shazbot.org>
In-Reply-To: <20260715174737.15287-7-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-7-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 18:47:29 +0100
Matt Evans <matt@ozlabs.org> wrote:

> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
> 
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 46b3cf5dc94b..51606ff3cdc6 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -4,6 +4,7 @@
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/dma-resv.h>
> +#include <uapi/linux/dma-buf.h>

Is this required?  It seems unused.

>  
>  #include "vfio_pci_priv.h"
>  
> @@ -486,6 +487,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  {
>  	struct vfio_pci_dma_buf *priv;
>  	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
> +	char *bufname;
>  	int ret;
>  
>  	priv = kzalloc_obj(*priv);
> @@ -498,6 +500,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  		goto err_free_priv;
>  	}
>  
> +	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
> +			    dev_name(&vdev->vdev.device), pci_name(vdev->pdev),
> +			    res_index);
> +
> +	if (!bufname) {
> +		ret = -ENOMEM;
> +		goto err_free_phys;
> +	}
> +
>  	/*
>  	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>  	 * start of the VMA corresponds to byte 0 of the DMABUF and
> @@ -516,7 +527,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>  	if (!priv->provider) {
>  		ret = -EINVAL;
> -		goto err_free_phys;
> +		goto err_free_name;
>  	}
>  
>  	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> @@ -524,7 +535,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  
>  	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>  	if (ret)
> -		goto err_free_phys;
> +		goto err_free_name;
>  
>  	/*
>  	 * Ownership of the DMABUF file transfers to the VMA so that
> @@ -539,8 +550,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	vma->vm_file = priv->dmabuf->file;
>  	vma->vm_private_data = priv;
>  
> +	spin_lock(&priv->dmabuf->name_lock);
> +	kfree(priv->dmabuf->name);
> +	priv->dmabuf->name = bufname;
> +	spin_unlock(&priv->dmabuf->name_lock);

This is simple, but shouldn't it really have a sanctioned, exported
dmabuf helper rather than open coding this handling?  Thanks,

Alex

> +
>  	return 0;
>  
> +err_free_name:
> +	kfree(bufname);
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:

