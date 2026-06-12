Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91430382F0F
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256014; cv=none; b=HKrhbLkosGmCOnfiGdSy5Ay9qs3tEugPEdb+ZiJ0EfD7+JiVTB40CPbgU78JvzdUy73pt9se3qA+BSalduaUYioTnhd3U6+g/sqQHG/6FdYQIZo2RxuJYgKic0TslhzKFcmonsV7ckCdHcNEnfpHmcVjbo6NgmxaLt3xp9jci9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256014; c=relaxed/simple;
	bh=nK8oSt5EIh86hjy16VZ5ws+ZIcIDCfDkVWMJvoB+yNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No524UtH/+bx6VflfkY25+KQ+lSqhcWyDxuLTn10hqj0k5pbkAX7d3r/oaYJt1GG5/Bs09IGpLMrRmJpzWHK/dq5Lta3ptrU+C5sgPdyfJiYRofoRi3Jz65AmNHVJgf04HiYA24Pb7HvlJ3SQNTDskQea3Hmlwn8vhjaEw6t8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRzzMYYL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRzzMYYL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so85405ad.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781256010; x=1781860810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvPmlCR2+M8z2It1PyWjRPyBRhJXBH/RxmRhWYVyMeM=;
        b=fRzzMYYLXoLbwa6O4DDeOA1Dd721HBWwlMWYDllZUFJ/PTywZdsB5Nwlzv5k7x2d0R
         WvHhTKPMyLGoqFR3dXk4MZlKcgQ+ayEvfB5xvC5obxLWlwNHu2z7b0SjDke0/huZR6Dy
         rACpzpT2wiXVJNFA67ImFhSZr9+neZziK6J2yoh4qRgMtwPT/ZfW3hNtyxHfc/fsRD3g
         GFcOs2i1hCawvKj3RLmbnBeGgbQr7dOlEft+MKhsSkeo4F880mzkcKN8W80Ip0Lby3e9
         4s7LNmv9oz+vhxUaKaLOH7e/ZpmkbxeE0XuEbJaU1jhwkOtaSukQ+7t//wS7/4pyvAFv
         1Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781256010; x=1781860810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvPmlCR2+M8z2It1PyWjRPyBRhJXBH/RxmRhWYVyMeM=;
        b=qfMzVbd/JgTd8vbe2C8olM0y0KRtGPj75RbMUxWzu5CeP7Ol3+sNl5C+DAgkNZ1vTq
         qxdXpNvtIsjlIg0TU17JWgj2hn8d6CgcdqDuQvzM7r/Sba10RG6o2kKnoHrjmC+XmSYp
         XXJb9HZmILvVRUQYxt45E1hbB6AM2BYFe7eynuf/Afd5ADo/0whoOuz2bgerx0HNCXPK
         9DRhMqgn2N8hJ2G6rhi6PhPm54u4rfTg2F3HVrIUSw4gIuRI23nsB9gCQvqTk+iDhtsr
         0KSsCXTNnAADQwhbzfwifCLJ74gf4nMQGesZND++FQagfjHb7orLamipY14bGDUAE+Ae
         gpHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XW5x0rCEOs3wELv/vMMfZ6X3ONeCOID4aVuMpr0oq4FIf3a9O8RUKuZYxtH6j8l0km1+HG8vOlLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XuhON1XHXwBvBft/KiMjvBIWvH8/vJAkSxGBbyi+7LEBsWEz
	njNbjtmgYq/SJv3FTP7oZJkk2JWlaDGv/FJgUdaf0gkVv9k4KXY3G97oKoW/A4xwUw==
X-Gm-Gg: Acq92OHsN+AGiP74CO/lQyGUYqgnxHDBGF+vJ/2AUNoyPWtqtAV83PMxpMLZY7lYfkY
	J5+qaiclQYOPPX2LArOfEKiU2D4QKVEicCsFPWYxujQNcIGOgySdmsWQWJdhD8fy50HBm2b12ig
	TYJvz2FEBDkIX3VgcNaMtKQbIkamYClpjYY1df3gjJ9G/rsAwsy2nBKzoKsqmCblEc4qi5uZY1G
	VZ/IxeWhoqHcX3nDgNpGeEsPslU6JkIrELoHthE44ChXglqE1k3dgjVE4j9CiIYLswDHbUA07We
	9OmeMF1MJI2Vzbyafrr6iQpZGRts7qkEwsFimpjWl78bCsgrz0LehX6GAq38oWGxmx8lgb61krH
	Kwpy+Ig+76y+tEeq5njacme0kflAaYt+xZ1hcVDLQVK0HzO0gs/sQF8NRLKtLt1l1jwbKVjMNqm
	NjFBWtt08Ce2miWg45+MbzVtUecCMN4MUft/N84fFpBNeOHNzZWQvgOPvO61jdx+YSKEhBJdg=
X-Received: by 2002:a17:902:e811:b0:2bf:139c:dcf3 with SMTP id d9443c01a7336-2c405c8817fmr1345405ad.19.1781256009183;
        Fri, 12 Jun 2026 02:20:09 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd17f5sm1476657b3a.39.2026.06.12.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:20:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:20:01 +0000
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
Subject: Re: [PATCH v3 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Message-ID: <aivPQcSlolwptnB6@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-4-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-4-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:17PM +0100, Matt Evans wrote:
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
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 142 +++++++++++++++++++++++------
>  drivers/vfio/pci/vfio_pci_priv.h   |   5 +
>  2 files changed, 117 insertions(+), 30 deletions(-)
>

[...]

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

I appreciate this comment. Thanks for being clear!

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
