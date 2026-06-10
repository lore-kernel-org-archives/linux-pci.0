Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F50331A41;
	Wed, 10 Jun 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116801; cv=none; b=Xa1xuMqHMbPtYiaEdigWCucXY2+GjqLpqcD6cdJsggrQeXNsMFmoHr/TvX4g4h2CvkUw/vqCDWlj6zuOJ9tVZC4bFPtyjaO2NS/P9HkMHVe5VdkMUy9kSwU6nJKcKGiy+DUR0Y/sLXhWaqhf9kSsOF/KKuDunFDmB4i9gPn1UV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116801; c=relaxed/simple;
	bh=pcqvCel3cIid7Uxi8NGfFZNo5OffXfeC6iaAMBMqxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8CUAPlbHCUie+Y74IpYsovBA3gqSBdX1cCs0N1wT90MZll4C2WINV/VnLV65+/LHoC3mKj+q6VsWLPa3UvrEuyuZCdplbWVIS9NUPymdXv8mQJKiJ9YLbC+KuVPdrjNOpiE/JgEb9W850vIUm1VuIFvOWWxL8pwsd9T6A7DXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXQg2sOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXQg2sOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD661F00893;
	Wed, 10 Jun 2026 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116800;
	bh=2O7wrREt4oiDQ0b6njA5QsbmFiFGcobC6ew3dRXWqcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AXQg2sOUQCvZAEJpOUDjFxgGFGvNfk8Y+NFsIF1/5oh/Jf0NM00X8fx1vrkj5uHRU
	 OlivCH41ngLCnSfN3Chi7Nbnl211nqRmBag5EgqKauDJGnoTKxPiAeXPg3Im9QJr7C
	 G/Mq1DzVMYclnYZohJe3cwSTZr098ztfrRB47bVZbuSTaTrtVEE98yEqSH9XqmKUs9
	 3yot7t6yapyBUqRxmz6sKh59pKB+J1q5svMihAX9BkJwa/BC5TRn3xH7sUWMMWKBlM
	 mSJOMDo83XjooT0ElGcgMVQVMiOomdtvmuTfggBaGn8mtlW19fIc56coy6MYgdanRT
	 AW/Wmn8mfjmvA==
Date: Wed, 10 Jun 2026 21:39:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <20260610183954.GK327369@unreal>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-2-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-2-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on 1, without having a hard
> dependency on 2.
> 
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE).  Then, drivers can enable any
> additional P2P features with the original CONFIG_PCI_P2PDMA (available
> when CONFIG_ZONE_DEVICE is set).
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  MAINTAINERS                |   2 +-
>  drivers/pci/Kconfig        |  10 ++--
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/p2pdma.c       | 109 ++--------------------------------
>  drivers/pci/p2pdma.h       |  29 +++++++++
>  drivers/pci/p2pdma_core.c  | 118 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |  24 ++++----
>  include/linux/pci.h        |   2 +-
>  8 files changed, 174 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/p2pdma.h
>  create mode 100644 drivers/pci/p2pdma_core.c

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
