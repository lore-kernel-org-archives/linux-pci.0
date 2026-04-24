Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F53DBD57;
	Fri, 24 Apr 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046904; cv=none; b=noNIvHZPiX0GCG38FPJqRrYeyNFEo5ykyzGuJJZ1OondCFTkGp0cPeGMAVGpU8+VmtNWRLj9WaxAFhNT41KN17DO3s8qpMjquH++aYFnOQzwu6QdHugdP1Dj5xa+eFHmQu7EgBu/3VtI1m/63suxb0xNIRheEouhj0nAe46rpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046904; c=relaxed/simple;
	bh=hGC9jnHTZV5EtsFQpRo2fI3KRRoZIvzL+Z9bPIl/ziI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TboDOU4cjv/WYgudDczIdaL+hLBtehj2ByZIIP7xBGt7bAD0iJO/QjreYpFXeMgssMjP/NGhI2gmJBmZU5/Ld8tvWXqMeD/yeHzMmIvljyKhx9U411lXSPXnXAyxsJiUp5Roo7oZrPCbWM1iSeYeLuKBpxOJjUjEGciFF5gWPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCvGPHa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCvGPHa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CA8C19425;
	Fri, 24 Apr 2026 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046904;
	bh=hGC9jnHTZV5EtsFQpRo2fI3KRRoZIvzL+Z9bPIl/ziI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hCvGPHa5RcLZR9Zd3hpo0lZutgG3asKWUUJvamKu41u/Fjo4LbsrmW7UoHwRiDHu+
	 hzFxLRZmfgyPkd83sux0ZbVwlh4LCIsrOb03UzLJ53B4xvrtD3svOB9RUh0z8aYLdY
	 hx5OC0/J6ZsF9xhIA7vOoTENcGmtyU6t3UtMeB6s/9RnYLhRgmL6Wu9YNZZsmc6Dsw
	 of2PZtPnjCO6c5cCbASofpSZlR2kQ5OXOV/tIaMoBz0qiHISJnssAWACJ228pNvHl1
	 K+ZPYNQiHETg7GHsz6vlHilobXpQmTvzcaoH78HfFJ3qcOwqla9HCDoVljUXKS9QPg
	 psseq8vPM7IYw==
Date: Fri, 24 Apr 2026 11:08:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260424160823.GA11106@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423173051.1999679-1-mattev@meta.com>

On Thu, Apr 23, 2026 at 10:30:51AM -0700, Matt Evans wrote:
> Extend the checks in pcim_p2pdma_init() and pcim_p2pdma_provider() to
> exclude functions that have pdev->non_mappable_bars set.
> 
> Consumers such as VFIO were previously able to map these for access by
> the CPU or P2P.  Update the comment on non_mappable_bars to show it
> refers to any access, not just userspace CPU access.
> 
> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> Signed-off-by: Matt Evans <mattev@meta.com>

Applied to pci/p2pdma for v7.2, thanks!  Will be rebased after
v7.1-rc1.

> ---
> 
> This arises from Alex Williamson's suggestion to test
> non_mappable_bars when getting the provider, with discussion here:
> 
>  https://lore.kernel.org/kvm/20260415181623.1021090-1-mattev@meta.com/
> 
> The goal was to prevent a hole where VFIO could export DMABUFs for
> BARs marked non-mappable, and to fix for all users of the provider
> rather than just VFIO.  Alex observed that non_mappable_bars should be
> taken to mean BARs weren't usable by the CPU _or_ peers and,
> considering that, its comment about userspace access wasn't quite
> right.
> 
> == Changes ==
> 
> v2:
>  - Also test non_mappable_bars in pcim_p2pdma_init(), as
>    otherwise pci_p2pdma_add_resource() will WARN_ON
>    pcim_p2pdma_provider() failing.
> 
> Niklas and Logan, I didn't re-add your R-B from v1 as (splitting
> hairs...) the code's changed.
> 
> v1:
>  https://lore.kernel.org/linux-pci/20260421174351.3897842-1-mattev@meta.com/
> 
> 
>  drivers/pci/p2pdma.c | 6 +++++-
>  include/linux/pci.h  | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c898542af8d..adb17a4f6939 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -262,6 +262,9 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
>  	struct pci_p2pdma *p2p;
>  	int i, ret;
>  
> +	if (pdev->non_mappable_bars)
> +		return -EOPNOTSUPP;
> +
>  	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
>  	if (p2p)
>  		return 0;
> @@ -318,7 +321,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
>  {
>  	struct pci_p2pdma *p2p;
>  
> -	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +	    pdev->non_mappable_bars)
>  		return NULL;
>  
>  	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..1e6802017d6b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -508,7 +508,7 @@ struct pci_dev {
>  	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>  	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
> -	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
> +	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> -- 
> 2.47.3
> 
