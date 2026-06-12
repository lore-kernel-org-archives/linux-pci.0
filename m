Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B743AB47C
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260910; cv=none; b=AIrhemTjtAG4VuoIlbnCI4CSovyqcSTAnTbzdPjsy2BP4FeCVOsJi025V2efiHaq3y47DuZHw0N7sKXlhf28hIXa0CuSTcyBiOnv/FggjmjhUbGKtF9ycabKqvxfAEsrTPRJWtv9NlvG0WAiZaOHDNtro6Wc7Sv9upLYCldUDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260910; c=relaxed/simple;
	bh=sny6gtCPTebe7+aMFk6HVm73mJrTLWc+vwahxxW30yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0rfKxRyJxJ4AAQg0aabrlAS4t9wer7q/cA1ct/H6PqLIO/pnYG+UTPO47xK1FapNsjJq5BCN5+PbhAee8+88LfmDLWiaOjyobpennPERJIsRN7s/1hbabeakWO1cS9nZtTGoDayqhFyipj2JUkel9KXNacTT9hQ9nDjB505vEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e85phcXk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e85phcXk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf22c18ad3so98105ad.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781260906; x=1781865706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyKpUSmzhXA86dwYd5qyCKe1OI2XqC/1Gh0xGOzaDhE=;
        b=e85phcXk1K9leNPFo1wZEsC5nr3lko7DIgyyvSZRSPFdoEegnsrwaYm1Nw+U6cyIAv
         xw1/3Ze+EUm2P/h9YI7KH46n1g7Gyh9+ZOm7gBt1TzB7PtPb/RBKhstuxPYEtIKEEIiE
         edEIuXGHtPWbMLR6zhJAsNaH9himgVH+BZcPZ6BQTTUm774+PPYz3r+GQqBkmCrv0cWN
         gQHuKntSVzYprCBnRaIMVoeLpQ/DUOQn/e3C2zsGjPN/wfOLkLrQveb8FMmhAzq2j/ql
         HVk8RR/sdA8krZiSmLGValM51ij7dNKSaPevsG3pF7Mr82x/0un7HHJ1EeXXfC1REn8n
         zgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260906; x=1781865706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyKpUSmzhXA86dwYd5qyCKe1OI2XqC/1Gh0xGOzaDhE=;
        b=VzkBBmto0f16l769YXaXfK4dYLqiFm6cJkWz/65dg4OReLFOzH9Srs9ZCbmpSbbETT
         E8ANB0HAzjHmACrrDnWrec4XruHEdiBI6MaYk4XUdUFrJvYW7cykoyX6vdAOMZAdbqSk
         DU11uhYtX49XLu6UtsK+99uZS8AVTSMcJE2rgx6EFGK1onnAEDJ1hGO47RiIp+itF85j
         IyrP8YhIihgvymKsCOF98BEbn4ZdZuWjtGWe5YHs6dTlD4Ik65ENDL4NG4nO0UbGs+CH
         fCkI/3Sw0obJp6no45fndnXv77bjrD+W0+v6NFB8UTTKywIjvAuzD68hDNomyC7NswB3
         ZaNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f0gAt/CyQe9OACSXq7cEweUPJotAwN7Ol+OfHwwF5ufJq2brHfN184cvpMcuEFjFI920lVAvPL8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg9gHaB4YFQluqQ1iauX2VHRMwHiMqjgVVS6BevwYxv9gMDJW
	zAMYBHfEiEoRnjSNKn2fYSLL5mT6bj96dga/Zrb2BQCXKDyODTkFOONvZ46wF8wJiw==
X-Gm-Gg: Acq92OFs8PLFELvJ4Hx7Urw3qEtBWrBIrUhFgu5YjjfvzYzim2hEy+PDfObZGQfPNtJ
	zSmFBL0bxT+bkLZ+vJMIDhSqbEBwZ0HCpB6znC8hdPZ+4Evyi6pw+8DQCMUmPZX0KimU0aUFbzK
	PS4E8R2mlPv0Fi29WDKmqw4vcEoLnhmvhi+KfcGWXp4/u4ixHvCxZXwa4Z7r6VXOe68L5bjqPPP
	8yv8hhAxHI1r+ejY7TmznDQWdJtW0QvQRh9Svd7wHWqr5MyKi84Ybs2ith26entkzNmlpRGrZAr
	rdhcRQe4IPQhudDqVAmk1jb5QMzUlcmTazQ/fnb9cCuqLMNysc5SARq2h/uPFrnQhnbIgsAGl/5
	21hii2XEY9ayviQWid+J5kgv8FWsCXjF6N1t99rpSSptLff3309GsFk8ynijJTXlvomwb7rDyr/
	oFjKCbdH9dAAA6P6qBd2Z0sU4uaztBaohFlMRRXSjEIQrm3n5EB4nxSIBODrCh
X-Received: by 2002:a17:902:da81:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c3e1919896mr2258415ad.16.1781260905357;
        Fri, 12 Jun 2026 03:41:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acae2sm15759755ad.52.2026.06.12.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:41:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:41:36 +0000
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
Subject: Re: [PATCH v3 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <aiviYEi17tewEQg0@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-5-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-5-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:18PM +0100, Matt Evans wrote:
> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> the BAR mapping, and make the VMA fault handler look up PFNs from the
> corresponding DMABUF.  This supports future code mmap()ing BAR
> DMABUFs, and iommufd work to support Type1 P2P.
> 
> First, vfio_pci_core_mmap() uses the new
> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> callback is updated to understand revoked buffers, and uses the new
> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> fault address.
> 
> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> zaps PTEs (used on the revocation and cleanup paths).
> 
> CONFIG_VFIO_PCI_CORE now unconditionally depends on
> CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
> CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
> VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
> CONFIG_PCI_P2PDMA.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/Kconfig           |  5 +-
>  drivers/vfio/pci/Makefile          |  3 +-
>  drivers/vfio/pci/vfio_pci_core.c   | 75 +++++++++++++++++++-----------
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 12 +++++
>  drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
>  5 files changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185e..67a2ae1fbc04 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -6,6 +6,8 @@ config VFIO_PCI_CORE
>  	tristate
>  	select VFIO_VIRQFD
>  	select IRQ_BYPASS_MANAGER
> +	select PCI_P2PDMA_CORE
> +	select DMA_SHARED_BUFFER
>  
>  config VFIO_PCI_INTX
>  	def_bool y if !S390
> @@ -56,7 +58,8 @@ config VFIO_PCI_ZDEV_KVM
>  	  To enable s390x KVM vfio-pci extensions, say Y.
>  
>  config VFIO_PCI_DMABUF
> -	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> +	def_bool y if PCI_P2PDMA
> +	depends on VFIO_PCI_CORE
>  
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
[...]  
>  int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  				   struct vm_area_struct *vma,
> @@ -532,6 +538,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  	struct vfio_pci_dma_buf *tmp;
>  
>  	lockdep_assert_held_write(&vdev->memory_lock);
> +	/*
> +	 * Holding memory_lock ensures a racing VMA fault observes
> +	 * priv->revoked properly.
> +	 */

Nit: This comment should appear before the lockdep_assert_held_write()
Also, it is slightly verbose.. (not against it though).

>  
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>  		if (!get_file_active(&priv->dmabuf->file))
> @@ -549,6 +559,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  			if (revoked) {
>  				kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  				wait_for_completion(&priv->comp);
> +				unmap_mapping_range(priv->dmabuf->file->f_mapping,
> +						    0, priv->size, 1);

Have we run this series with lockdep enabled?
I guess it'd be nice to check with lockdep once..

Apart from these, 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
