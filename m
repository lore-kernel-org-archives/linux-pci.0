Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E473C3F5D;
	Sat, 22 Aug 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787405477; cv=none; b=GCkazGpPWx+hvIaWAiQMOYnPIdxYOJBCAt0hDJJkjSJ70NLtDhbj9fRe0m5Sz/pjRJ3BL1kmoiwPo2U4QJ3txsAcW9dzTwNbMAciadK48d0l3CJA9VLgOR49T/+YHl2iEdmjyf5Dd+1ZxT3Az3VGLTEjMH2ie795g/Tts+wA4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787405477; c=relaxed/simple;
	bh=k+EdF9W8FT6uEL8cHTJYqoVPdYZgo///iFdWp6PMzwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjodWqwuwps60/EZ56FZQ+8DUyA89O6d3H0UIA6zxJMLZwVaIqFX5yd8XT2R/+xcL+gnuaDE7/xIslX+17DvwV9+XhFHgOjiKkqb/G8IwSyDJQrJpmHgkWaB7GoYpU6uFZ0THpiGkfA/or3R9M61GdG6kvJFi3EWm95tXZivbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ3qq31D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ3qq31D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4001F000E9;
	Sat, 22 Aug 2026 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787405475;
	bh=S2DuH4LkYbaqUVT/6CF+JD0DdMCMGyHDRttcKAoUA48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lJ3qq31DvMKP7tg6UljDAmE/XKBqeb11a3Uh2uZ7liAxzpRN66UjTw5T3tJ8oIbER
	 lPdcuyAv6K/JipiFExdBQC9soKfvDlTV++oe2EFm0tXyhyYqc5c1jtnA3KcnkUE/mc
	 cDCGXPDiolQFfS+J+KEUtR+nUJoXY+l+L2fEJTtRcLhZoGqmdk+D7n4W2nqFHKItov
	 d/tXFbPlcJipiqWDkrLWczVOlZ5yMwXUbepcijSn5WVLPQl5UscXzCKARuTm1Q2f7X
	 Y45wIptw4eaRjYG+G0DjY0ft7s9wTjv0IfsEfciCyla55jycIi3aVW02HZZRwaPRxH
	 5MSAgWznU/u0w==
Date: Sat, 22 Aug 2026 16:31:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing from
 ACS control bits
Message-ID: <20260822133109.GG66924@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
 <20260821195404.5A4901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821195404.5A4901F000E9@smtp.kernel.org>

On Fri, Aug 21, 2026 at 07:54:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ACS Egress Control (EC) is incorrectly bypassed for Completion TLPs, violating the PCIe specification and allowing unworkable P2P DMA paths to be mapped as direct.
> --
> 
> --- Patch [11]: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits ---
> commit e4c8e3c20c328ff7022188129cc2873b1613420b
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
> 
> This commit modifies the P2PDMA ACS redirection check to separate the logic
> for Request and Completion TLPs. It evaluates Request Redirect for client
> requests and Completion Redirect for provider read completions.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index a364008bbf504..1eda7b2135d70 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> 
> [ ... ]
> 
> > @@ -536,26 +538,35 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
> >  	return NULL;
> >  }
> >  
> > -/*
> > - * Check if a PCI bridge has its ACS redirection bits set to redirect P2P
> > - * TLPs upstream via ACS. Returns 1 if the packets will be redirected
> > - * upstream, 0 otherwise.
> > - */
> > -static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
> > +enum pci_acs_p2pdma_state {
> > +	PCI_ACS_P2PDMA_DIRECT,
> > +	PCI_ACS_P2PDMA_REDIRECT,
> > +};
> > +
> > +enum pci_acs_p2pdma_tlp {
> > +	PCI_ACS_P2PDMA_TLP_REQUEST,
> > +	PCI_ACS_P2PDMA_TLP_COMPLETION,
> > +};
> > +
> > +static enum pci_acs_p2pdma_state
> > +pci_acs_p2pdma_state(struct pci_dev *pdev, enum pci_acs_p2pdma_tlp tlp)
> >  {
> >  	int pos;
> >  	u16 ctrl;
> >  
> >  	pos = pdev->acs_cap;
> >  	if (!pos)
> > -		return 0;
> > +		return PCI_ACS_P2PDMA_DIRECT;
> >  
> > -	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
> > +	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
> > +		return PCI_ACS_P2PDMA_REDIRECT;
> >  
> > -	if (ctrl & (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC))
> > -		return 1;
> > +	if (tlp == PCI_ACS_P2PDMA_TLP_COMPLETION)
> > +		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
> > +					   PCI_ACS_P2PDMA_DIRECT;
> 
> [Severity: High]
> According to PCIe Base Specification 6.12.4, ACS Egress Control applies to
> all TLPs, including both Requests and Completions.

No, it is wrong.
"PCIe 7.0 explicitly states in §6.12.1.1 and §6.12.1.2: “Completions are never affected
by ACS P2P Egress Control.” Section 6.12.3 says Completion routing is determined exclusively
by Completion Redirect. The EC Control bit description in §7.7.12.3 also refers only
to peer-to-peer Requests."



> 
> Does this logic incorrectly bypass Egress Control (PCI_ACS_EC) for Completion
> TLPs by only evaluating Completion Redirect (PCI_ACS_CR)?
> 
> If a PCIe switch has ACS Egress Control configured to isolate P2P traffic,
> will the hardware drop P2P Read Completions as ACS violations while the
> kernel incorrectly maps the path as direct? This could lead to Completion
> Timeouts and potential runtime failures when drivers attempt P2P DMA reads.
> 
> > -	return 0;
> > +	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?
> > +		PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com?part=11
> 
