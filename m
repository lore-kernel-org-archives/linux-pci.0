Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364640DB4B;
	Wed, 29 Jul 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319725; cv=none; b=E5j4/YkyBBLDM37h3mkU6+hDyW8vq/j3BL4o3gPWr6pz3faMw3ngxlsOcX0+xm/jVmyLGKsuYAxwc5xuzI+U2BWRRnfnft3GualR/NYOHn+AXnKb6EvIrFIRIPgIM2sk7pr/r+3zeV9Yz5dAdPS4TD3/pENWQQ7iZg610egmNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319725; c=relaxed/simple;
	bh=0PpHNsnzhe2zfdA+FJiXn/uvMnngC24W7GL/4gjnNcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuEsyl380IXsQ3Tl+PXRGKOa5B/o1zkHANwK6HLoJtQ7sd0PxNM+F0N8qDnM2HDLjEY2Srl/qvDSWvPH4axOn+GSFupurNAKT2tEc3nwNPl8hOuJIW6Ysn0isxRAyK3XU4I7274vOxauG0bjVGvS4ZV3v7B7dgw9T2RzhpU6+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG1EC1Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG1EC1Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A81F000E9;
	Wed, 29 Jul 2026 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319724;
	bh=R4pDNKLqHIaBBWNtEZelWW2DvKRxTtOSWeLWqmFNNxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mG1EC1MeG6CYmME+U3L7b4yQqwCJw23+E759aBZ4ccpLnQkxENlO5ropRj03sGmEe
	 g9UWSnbGmywcXZgcLdl1ZLvc0X2n4C50Ys6coE1s+0QdqTmzOb0tssZNnT0cxKJ3rO
	 T38H/QRf/VEX5IsIiwDKpxi3IanyOpBvsY8EPpgPih3Wu661jJkvHjrkSB29vUm/mv
	 X6mQjmjxMJuUGgyiUp1kjuHSMcREJmJ/yOE3QKP+4Br9zT4BFbqDUeyZ3sNCYzWwY9
	 Hc+JTQg9VlfXn/55qCNRboFkKIxzh0RipD5Gj0tx1hXIf1STPdXCcNVFIV8mauFyJu
	 g3sS2tjv7v0sw==
Date: Wed, 29 Jul 2026 13:08:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <20260729100840.GM12003@unreal>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
 <20260728163343.2a39a8d1@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728163343.2a39a8d1@shazbot.org>

On Tue, Jul 28, 2026 at 04:33:43PM -0600, Alex Williamson wrote:
> Hi Leon,
> 
> Please see below...
> 
> On Wed, 15 Jul 2026 18:47:24 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
> > Preparing for a refactor in a subsequent patch, split the pool-related
> > release code into a new pci_p2pdma_release_pool() function.
> > 
> > This allows future compile-time selection of a null implementation for
> > pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> > P2P-related files.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  drivers/pci/p2pdma.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index b2d5266f8653..498bca257419 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
> >  	.folio_free = p2pdma_folio_free,
> >  };
> >  
> > +static void pci_p2pdma_release_pool(struct pci_dev *pdev,
> > +				    struct pci_p2pdma *p2pdma)
> > +{
> > +	if (!p2pdma->pool)
> > +		return;
> > +
> > +	synchronize_rcu();
> 
> Sashiko notes[1] a high, preexisting issue here that looks like it was
> introduced via 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P
> functionality from memory allocation").  That commit creates a two-tier
> scheme where the optional memory allocation capabilities, such as the
> pool, live above a core layer.  Prior to that commit, this synchronize
> RCU call was unconditional.  Making it conditional on the pool suggests
> it was only considered relevant to the optional layer.
> 
> However, map_types, which remains in the core layer, is RCU referenced.
> Was the synchronize_rcu() call here miscategorized into the optional
> tier?  Should it instead have remained unconditional?

I remember this concern when I wrote the patches and wanted to remove
RCU entirely. I revisited the Sashiko report, but reached the same
conclusion again.

The "bug" reported by Sashiko does not exist. The two-layer split
ensures that p2p is bound to the driver's lifecycle. As a result,
pdev->p2pdma is assigned and cleared only once during the lifetime of
pdev.

In this case, the RCU primitives are effectively NOPs, since nothing
will ever update that pointer.

I still needed to keep rcu_dereference() in
pci_p2pdma_map_type() to satisfy static analyzers, which would
otherwise complain about accessing an RCU-protected pointer without the
proper annotations.

RCU is used only in the sysfs flow.

Thanks

> 
> We might need a precursor Fixes: patch to this series that makes it
> unconditional in pci_p2pdma_release(), so that it remains there with
> this refactor rather than becoming part of this new pool release
> function.  Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/all/20260715180521.3CDD61F00A3A@smtp.kernel.org/
> 
> > +	gen_pool_destroy(p2pdma->pool);
> > +	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> > +}
> > +
> >  static void pci_p2pdma_release(void *data)
> >  {
> >  	struct pci_dev *pdev = data;
> > @@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
> >  
> >  	/* Flush and disable pci_alloc_p2p_mem() */
> >  	pdev->p2pdma = NULL;
> > -	if (p2pdma->pool)
> > -		synchronize_rcu();
> > +	pci_p2pdma_release_pool(pdev, p2pdma);
> >  	xa_destroy(&p2pdma->map_types);
> > -
> > -	if (!p2pdma->pool)
> > -		return;
> > -
> > -	gen_pool_destroy(p2pdma->pool);
> > -	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> >  }
> >  
> >  /**
> > @@ -946,8 +950,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
> >  	struct pci_p2pdma *p2pdma;
> >  
> >  	/*
> > -	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
> > -	 * ensure pdev->p2pdma is non-NULL for the duration of the
> > +	 * Pairs with synchronize_rcu() in pci_p2pdma_release_pool()
> > +	 * to ensure pdev->p2pdma is non-NULL for the duration of the
> >  	 * read-lock.
> >  	 */
> >  	rcu_read_lock();
> 
