Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0C30D407;
	Sat, 22 Aug 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787405299; cv=none; b=ApxEMngsnPQl/mgb6OAwHn4zYOUrBJW8JSDwoV53WI2qPFBnpvIHUuhBGZPWmOGH719SAwwe5l0IH3lIBf7E+8erpe/YKM7QlAsXPsPkbwpS9dgGCvby2Oc89bwdoOP8iH8hh5SYTzs6u/2xyrVhbtLp/l+uaeY52aNa46+EwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787405299; c=relaxed/simple;
	bh=bgPEZ9uN/TXkMM0xTXhlzoeClL0x0+zvsp2fWM5nVDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze8SPaY+aLm2fpfSaBSLA5AiL5naJWeH4tNrwG8Ob6Cl818In0gp70EnTuoZu4g3bp/y2H4oe2uhtPWylG9Cw3XPpKuS246heJH0FMmYiJYpmWJy/rUD5xwzlvLm1jEMbWzvyHDAUPvza+HkbbnxPtmgJkJ3Q81jY0crRkJXAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fko+OphU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fko+OphU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313401F000E9;
	Sat, 22 Aug 2026 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787405298;
	bh=yWwaXn7tOkrDrEgmzM+mW3sXa2l4gShQYz0v02Xbnlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fko+OphULHzbse1EeoBK5eS425AV/A2wnS1eeUq6s16On8bgLInyI4+6hmOysFXGF
	 cjr9fzOHQnIhy9Zl1lXbzYlsX8Q02B8kCg4tDU7o5qYw8PTLYuYjYCi/rlfVOq0XPy
	 +0m1BENVCugA8/34SVEPDFEw8ZQ5yRlhNL0vsARg77m/Q7dKj9Bp1iP+dpMi7KGli+
	 016uTf1YByQhPRnSybEvosdHasIgh/RxsayTynl2f11M4PICtFCScHJZT/s3WL9nTk
	 wAXs51RvbKioF08zeFdlCgUjEFCEYHW3nrr3UC+ANhtXIzje6DV0Bj6l6cV4rpMsfI
	 byQUu/I+l/qPA==
Date: Sat, 22 Aug 2026 16:28:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
Message-ID: <20260822132810.GF66924@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
 <20260821200246.423701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821200246.423701F000E9@smtp.kernel.org>

On Fri, Aug 21, 2026 at 08:02:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional debug logging in the high-frequency P2PDMA mapping fast path causes severe log flooding.
> --
> 
> --- Patch [18]: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagnostics ---
> commit 6ad59be5d5d93d88cf70cbce85e9046d3c5b0adb
> Author: Leon Romanovsky <leon@kernel.org>
> 
>     PCI/P2PDMA: Log detailed ACS routing diagnostics
> 
> This commit adds detailed ACS routing diagnostics to assist in identifying
> P2PDMA mapping failures. It emits info-level logs covering path details,
> ACS controls, and cache state.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index e54901d21d8a2..b79eb4ce09f47 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> 
> [ ... ]
> 
> > @@ -1237,23 +1467,38 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct p2pdma_provider *provider,
> >  	struct pci_dev *pdev = to_pci_dev(provider->owner);
> >  	struct pci_dev *client;
> >  	struct pci_p2pdma *p2pdma;
> > +	unsigned long cache_index;
> > +	bool provider_state;
> >  	int dist;
> >  
> > -	if (!pdev->p2pdma)
> > +	if (!pdev->p2pdma) {
> > +		pci_info(pdev,
> > +			 "P2PDMA ACS debug: map lookup rejected; provider state is absent\n");
> >  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> > +	}
> >  
> > -	if (!dev_is_pci(dev))
> > +	if (!dev_is_pci(dev)) {
> > +		dev_info(dev,
> > +			 "P2PDMA ACS debug: provider=%s map lookup rejected; client is not PCI\n",
> > +			 pci_name(pdev));
> >  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> > +	}
> >  
> >  	client = to_pci_dev(dev);
> > +	cache_index = map_types_idx(client);
> >  
> >  	rcu_read_lock();
> >  	p2pdma = rcu_dereference(pdev->p2pdma);
> >  
> >  	if (p2pdma)
> >  		type = xa_to_value(xa_load(&p2pdma->map_types,
> > -					   map_types_idx(client)));
> > +					   cache_index));
> > +	provider_state = !!p2pdma;
> >  	rcu_read_unlock();
> > +	pci_info(client,
> > +		 "P2PDMA ACS debug: map lookup provider=%s index=%#lx cached=%s(%d) provider-state=%u\n",
> > +		 pci_name(pdev), cache_index, pci_p2pdma_map_type_name(type),
> > +		 type, provider_state);
> 
> [Severity: High]
> Does this code risk flooding the kernel log buffer and causing severe performance
> degradation?
> 
> Since pci_p2pdma_map_type() is invoked on the DMA mapping fast path (for
> example, once per P2PDMA I/O request via pci_p2pdma_state() in dma_map_sg()
> loops), this unconditional logging will execute on every single P2PDMA
> map lookup even when a cached route is successfully used.
> 
> Will this saturate the kernel log buffer and cause severe printk/console lock
> contention for any P2PDMA-capable block I/O or RDMA operation?

No, these are debug prints and are not enabled by default. ACS
successes and failures are deterministic, and a single operation is
sufficient to determine the cause of a failure.

Thanks

> 
> >  
> >  	if (type == PCI_P2PDMA_MAP_UNKNOWN)
> >  		return calc_map_type_and_dist(pdev, client, &dist, true);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com?part=18
> 
