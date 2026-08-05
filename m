Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDE3F326E;
	Wed,  5 Aug 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920812; cv=none; b=nBiFyq8KIzJ9WnjOxNA+132vqt0Netvf13sEx9WlGDTb7scRrEdOHmb+ZTcRAlEfq1sLNm5lNh07f/0WHyAJRVPMFC4cDUZS6lAboZ1E+ja2dI4OrA+LghF85aj0dBWsgRnaMMUtMPlWf2IrUgvruZt8XRe3PUfuPTAh0Fw92QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920812; c=relaxed/simple;
	bh=6ULmfgGm/6PkjvPT8MztTypZT/gsCiM4msnZQhL74Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPdkWoIT/xEArRtEH+kQ9ARe0tMr3EWAuYZiu8kA1tg1dSJH9lY9N4WZj1Ke4v+XQmiG6d7TDWW8KmWZ9ZyHV2JrL5zMG4kfs9pYUj2+LbN2ZoACQ6SKswg1llD/9Y2/M2IERELeqRUTC3xqOSKPI3lULwgO01VpiNaR8/bT1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLtTQ2bF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLtTQ2bF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3281F000E9;
	Wed,  5 Aug 2026 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920809;
	bh=h+inmSss70iOjx8T7Tc+O2oE/UL2EDBuic2L1hxny08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NLtTQ2bFAn/5DdRAwk7wjJzUuKJEJ3DwFTWUgckvU4K4EzosB49jPXNbVmTYhJnXm
	 AI4NglBpwsrxAKF3NsbRR610dSoxlHL8m4kc6DSL1LP0vhQjiyybiA6gbUPOA/qpGE
	 7hMPXhhfBZWI0fJA684YinO6WFuw/o0WbisfJxm41V/9x2b0ss+9BntLb0PoKBKTHa
	 /L0c3URaJg8Eim6mO5Dr7XA0MZ7sp+o7Cbe1OLH/zisHvc+b/u49dG6LEk2iULHYNK
	 yvCSw88xYpbK6kwOJpHa2iIsI6JbbV8UP1I33TlWgwYM7k1zno1TbAZNDq6cHlO2mf
	 W46XrrMWkUOdQ==
Date: Wed, 5 Aug 2026 12:06:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	"Claude Opus 4.8" <noreply@anthropic.com>
Subject: Re: [PATCH 10/13] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
Message-ID: <20260805090643.GC23431@unreal>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-10-a7c5eb64fff6@nvidia.com>
 <461ab877-a5ab-44bd-8c24-1a77e42e9746@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461ab877-a5ab-44bd-8c24-1a77e42e9746@deltatee.com>

On Tue, Aug 04, 2026 at 04:07:27PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-02 09:09, Leon Romanovsky wrote:
> 
> >  static enum pci_acs_p2pdma_state
> >  pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
> >  {
> > -	int pos, ret;
> > +	int egress = 0;
> >  	u16 ctrl;
> >  
> > -	pos = pdev->acs_cap;
> > -	if (!pos)
> > +	if (!pdev->acs_cap)
> >  		return PCI_ACS_P2PDMA_DIRECT;
> 
> I don't necessarily disagree with the change, but removing pos in this
> patch seems unnecessary and makes the patch more difficult to review
> than it needed to be.

I usually combine small cleanups, but I'll restore pos here in
the next version if I repost this patch.

> 
> > @@ -1046,6 +1047,22 @@ resource_size_t pci_min_window_alignment(struct pci_bus *bus,
> >  void pci_acs_init(struct pci_dev *dev);
> >  void pci_enable_acs(struct pci_dev *dev);
> >  int pci_acs_egress_ctrl_set(struct pci_dev *pdev, struct pci_dev *target);
> > +
> > +/*
> > + * Peer-to-peer routing decision for an ACS-capable ingress port, per
> > + * PCIe r7.0, sec 6.12.3, table 6-11.
> > + */
> > +enum pci_acs_p2pdma_state {
> > +	PCI_ACS_P2PDMA_DIRECT,		/* peer-to-peer permitted directly */
> > +	PCI_ACS_P2PDMA_REDIRECT,	/* redirected upstream to host bridge */
> > +	PCI_ACS_P2PDMA_NOT_SUPPORTED,	/* no usable peer-to-peer route */
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
> > +enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
> > +						  int egress);
> > +#endif
> 
> One minor weird whitespace issue here. Probably the empty line should
> come after #endif
> 
> 
> But both of these are very minor points, so:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks

> 
> 
> 
