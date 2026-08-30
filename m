Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0521CC5C;
	Sun, 30 Aug 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788081302; cv=none; b=ZL36VJxo5Kwpu8fe8/PD7mGFRwd1/uiHAKp0YEebeF2UuwjgyFml2GpqETC6XK4CDpkZquOEY6M2o8PsoxctXEvzMVLd9kffm2pChECHQM2eukbgudSPgHwBhmQZStHQsoPeKTNtsRbRhe01B2ythwZprGmviGo+Fj57jNq2LXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788081302; c=relaxed/simple;
	bh=1XQ+f2Gl37kFF5KFC7j3ce+V+kY9h7N26GClr0Qe5fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyNwy1SGB4VdrdyjYQjP9lCFF3a0i96fDC2rfmdKWZiZVT3hdHO/m1bi6GWlIdtFi39LmEBZXEXLQMYjLB1w2vHUUVTm107J4GP7YUV4FQinRL6c0rm5uKweNi9rJT5pPSoVeeRQyQ6lsaT9+2E0BYCmzt1CF5lCbB7gl9HnBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDa7j5sB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDa7j5sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E1D1F000E9;
	Sun, 30 Aug 2026 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788081300;
	bh=rPp2OT/PhibfUcKJNdOviFxwsm8XzNErNmszA+p7SLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UDa7j5sBM+w1WCVvzyyxdgZ0dckSKywp1Yl2ZB4enA37jLSF4Z7BDTRWGbyw4L8V+
	 hwXBOgmmE8EP2HfuMdSq1+dCdY98o2iDETjLiw8q+oa/d7t7K5TtJJzkNGSyRPIo7F
	 j5wEfrw4LPaGoHCbhPhtobwRrC6dGwfxguKA0qyccJatgyDnLn9fovDiJRW/zuH332
	 PDcug/z7F+MPCd3poDRS/YZM73BaKA/D1XdkgMDzqnxhqBzdg+IU+tEnUeX3T32I8t
	 oHfSrETSRhFhdpTJcm0M4oY7HVsu1PITrMpmbsQc7JhbucFEJG/ftqXTZQ24X3UwBV
	 fq/cy0wJi9WzA==
Date: Sun, 30 Aug 2026 12:14:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, Matt Evans <matt@ozlabs.org>
Subject: Re: I
Message-ID: <20260830091456.GD24140@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
 <d559d41c-5cba-4a95-bc8b-b1f78a49a18c@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d559d41c-5cba-4a95-bc8b-b1f78a49a18c@deltatee.com>

On Mon, Aug 24, 2026 at 02:29:34PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-21 13:38, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > pdev->p2pdma has two lifetime models. Provider-based entry points are
> > quiesced by their driver before remove completes. pci_p2pmem_find_many()
> > and the p2pmem sysfs attributes can race with unbind and therefore rely
> > on the teardown grace period.
> > 
> > Document publication, teardown, and how the grace period protects both
> > the struct pci_p2pdma object and its optional gen_pool.
> > 
> > Tested-by: Tushar Dave <tdave@nvidia.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: Matt Evans <matt@ozlabs.org>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/pci/p2pdma.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index a77ef9deb3c6..49bc8cf06240 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -21,6 +21,39 @@
> >  #include <linux/seq_buf.h>
> >  #include <linux/xarray.h>
> >  
> > +/*
> > + * Lifetime and RCU usage
> > + *
> > + * Within one driver bind, pdev->p2pdma is published exactly once, by
> 
> Is published the right verb here? Seems like we use published for
> different purposes in p2pdma and calling pcim_p2pdma_init() publishing
> reads strangely.

It should probably say "pdev->p2pdma is set exactly once".

> 
> > + * pcim_p2pdma_init(), and cleared exactly once, by the pci_p2pdma_release()
> > + * devres action that the same function installs. It is never re-pointed at a
> 
> "It is never re-pointed at" is some strange wording. I had to read it a
> few times to understand what it is saying.

Sorry about that. AI + non-english speaker = "re-pointed".

> 
> > + * second struct pci_p2pdma, so a reader that observes a non-NULL pointer
> > + * always observes the same, fully initialised object. That object is devres
> > + * memory allocated before the action is installed, so devres frees it only
> > + * after pci_p2pdma_release() has returned.
> 
> I don't quite follow the point of this paragraph. It's like it's
> building to some kind of gotcha, but all it seems to be saying is is the
> life cycle of pdev->p2pdma is the same as the lifecycle of pdev.

Yes

> 
> > + * Most exported entry points reach pdev->p2pdma through a struct pci_dev or a
> > + * struct p2pdma_provider owned by the provider driver, and
> > + * pcim_p2pdma_provider() requires callers to drop those references before the
> > + * driver's remove() completes. Those cannot run concurrently with
> > + * pci_p2pdma_release(), and their rcu_dereference() calls are simply how an
> > + * __rcu pointer is read.
> > + *
> > + * pci_p2pmem_find_many() and the p2pmem sysfs attributes are the exceptions.
> > + * The first walks every PCI device, so it can reach a provider whose driver is
> > + * unbinding: pci_get_device() pins the struct pci_dev, not the driver. The
> > + * second is reachable from userspace until sysfs_remove_group() runs at the end
> > + * of the release. pci_has_p2pmem() must dereference the object to determine
> > + * whether it owns a gen_pool, so even a poolless object must remain alive until
> 
> Maybe a hyphen with pool-less or maybe better to use plain language: "so
> even a device without a pool must remain alive..."

I will try to simplify the language.

> 
> > + * that RCU reader exits. The sysfs group is created with the pool.
> > + *
> > + * The grace period in pci_p2pdma_release() first protects the struct
> > + * pci_p2pdma itself from being freed while pci_has_p2pmem() is using it. For a
> > + * pool-backed provider it also fences the gen_pool: gen_pool_alloc_owner()
> > + * walks pool->chunks under RCU and gen_pool_destroy() frees those chunks
> > + * without waiting for a grace period of its own, so pci_alloc_p2pmem() and
> > + * p2pmem_alloc_mmap() hold rcu_read_lock() across the allocation.
> > + */
> >  struct pci_p2pdma {
> >  	struct gen_pool *pool;
> >  	bool p2pmem_published;
> > @@ -235,9 +268,19 @@ static void pci_p2pdma_release(void *data)
> >  	if (!p2pdma)
> >  		return;
> >  
> > -	/* Flush and disable pci_alloc_p2p_mem() */
> > +	/*
> > +	 * Stop new RCU readers and wait for readers that observed p2pdma before
> > +	 * allowing devres to free it. This is required even without a pool,
> > +	 * because pci_has_p2pmem() dereferences every non-NULL p2pdma it finds.
> > +	 * For a pool-backed provider this also fences gen_pool_destroy().
> > +	 */
> >  	RCU_INIT_POINTER(pdev->p2pdma, NULL);
> >  	synchronize_rcu();
> > +
> > +	/*
> > +	 * The grace period also ensures no RCU reader can still be accessing
> > +	 * map_types here.
> > +	 */
> >  	xa_destroy(&p2pdma->map_types);
> >  
> >  	if (!p2pdma->pool)
> > @@ -255,6 +298,9 @@ static void pci_p2pdma_release(void *data)
> >   * for a PCI device. It allocates and sets up the necessary data
> >   * structures to support P2PDMA operations, including mapping type
> >   * tracking.
> > + *
> > + * The state is published once per driver bind and torn down by a devres
> 
> I still find the use of "published" here a bit odd and I'm not sure what
> "state" it is referring to.

published == assigned.

> 
> > + * action on unbind. Repeated calls for the same device are a no-op.
> >   */
> >  int pcim_p2pdma_init(struct pci_dev *pdev)
> >  {
> > @@ -786,6 +832,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
> >  	}
> >  done:
> > +	/*
> > +	 * pci_p2pmem_find_many() reaches this with a provider whose driver may
> > +	 * be unbinding, so the store runs under RCU: pci_p2pdma_release()
> > +	 * clears the pointer and waits for readers before destroying
> > +	 * map_types. See "Lifetime and RCU usage" above.
> > +	 */
> 
> I don't know, but this seems like we're just describing basic RCU usage
> here. I'm not sure I personally find much value in the comment.

It was mainly intended to help AI review P2P patches according to the
lifetime model.

> 
> >  	rcu_read_lock();
> >  	p2pdma = rcu_dereference(provider->p2pdma);
> >  	if (p2pdma)
> > 
> 
> Thanks,
> 
> Logan
