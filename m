Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26425385D86;
	Fri,  7 Aug 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113341; cv=none; b=E3Ie0MQJWkc8zDEpGUw8cNt/AefDptugzzGCxz+/4eF2XdMngtV8bsA9xF19J73+0vSDoyzGblvAsKRs8kykUxWgYPYvLp90aMgbTEhSkIt4e7Y4akizpWxoLjPGHcD1+G30extf4M4qQrNTtTjXZwgPfOOk26PqloPLg/IwRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113341; c=relaxed/simple;
	bh=C2OTVueqfd2/Jh/F3j/AcYAmMiVvJg8oGPsLPiXbAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPrY+TtAm1s2JEdWH6cDmgkwlItS9i5LePcy4o2LotjrY5NHPTa4dh/nW+vzY1R4qP0ZW5NDvX/biLl4KP2BkD08rNT1xCgbTFRClaEOTrAWaZEgWSsYu92gFV1XoBeWotV8+YtvNsYHOaE7OHCsCP9+SOrxc1FxXKFl5gOZbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMRexnow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMRexnow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8F41F00A3A;
	Fri,  7 Aug 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113339;
	bh=2BhZV9hE6NivFxtTnmzUAFdrm+S/v55unHEL9hiBJEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cMRexnow7w4cND1WHzXmInqfF9JPHr0OFaOfcFMfLDPLWqM95yJO6GT5giP9UfBSN
	 sCgS/b3UGDEXreE7wfXjCXMexszndFYMx0MfLOrwpDr4XQ6wbX2eBWVjREvqNKIfbR
	 ujtx+Y2qup3DcnLR+JWolSR8/oVsU4S/x9yVDSY60Em3B+khc6VjXCJb476ETdkXY0
	 hON1mQeOYIYFbfsdIKvMhlQ5ubeO7FxW0qTuifNw4+ORlpSkXZbsTHaqclBlHC8XMv
	 wB2S0M8+7e6YDpM7mYVsU1G+WuJUAVOdJGLharAsv+zZ5EvP8smbIUMwlZdYF9CHyh
	 xR0261f6GXvwQ==
Date: Fri, 7 Aug 2026 17:35:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/13] PCI/P2PDMA: Report ACS ports when the paths
 share no upstream bridge
Message-ID: <20260807143534.GA424187@unreal>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-2-0cec14812965@nvidia.com>
 <20260806113754.C38101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806113754.C38101F000E9@smtp.kernel.org>

On Thu, Aug 06, 2026 at 11:37:54AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unconditional host bridge whitelist warnings cause severe log spam during silent P2P provider discovery.
> --
> 
> --- Patch [2]: [PATCH v2 02/13] PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge ---
> commit b1b70f40984c0b642c7221458a704c5fa967c62e
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge
> 
> A provider and a client below different Root Ports share no upstream
> bridge, so the search ends without a match and the walk takes the
> host-bridge route directly. Neither path is examined for ACS, so no
> redirect diagnostic is emitted and the host-bridge whitelist warning
> stays suppressed.
> 
> Examine the paths before taking that route, so every redirecting port is
> named in the pci=disable_acs_redir= hint.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 2d3b380cc5781..801c183ae6b7e 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -740,8 +741,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  		dist_a++;
> >  	}
> >  
> > -	*dist = dist_a + dist_b;
> > -	goto map_through_host_bridge;
> > +	/*
> > +	 * The paths share no upstream bridge, so the request can only reach
> > +	 * the peer through the host bridge. Examine the client path anyway,
> > +	 * so the diagnostics below name every ACS port on both paths.
> > +	 */
> > +	no_common_upstream = true;
> >  
> >  check_b_path_acs:
> >  	bb = b;
> 
> [ ... ]
> 
> > @@ -761,6 +766,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  	*dist = dist_a + dist_b;
> >  
> >  	if (!acs_cnt) {
> > +		if (no_common_upstream)
> > +			goto map_through_host_bridge;
> > +
> >  		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
> >  		goto done;
> >  	}
> 
> [Severity: Medium]
> Will this change cause severe log spam during silent P2P discovery?

“Severe” is an exaggeration. The issue already existed prior to
this patch, which merely increased the number of log messages.

Thanks
