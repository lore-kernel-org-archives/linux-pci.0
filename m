Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B4378D87;
	Fri,  7 Aug 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118858; cv=none; b=AAcFz5UL8p7d/34PHlAyH304taP+tvHbGWLTwN3PsA+E1xH+bcQQcQZyCzlquwMDPFVrE9jifQeR4M+o4m8rrk+aPaP69quNcjns8ZmyKVEpn107dNmfCEwJvzuCbIfRfVRdzI08zUJmjGIH2PsWdrX97Rs0WN8CKdH4IbjUxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118858; c=relaxed/simple;
	bh=9EXYGZmVfl/OnCKMPexgog6XjIdKGkUGTzum5HKfq44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNPdan2cCIVM+pELfTm9VaS3G6Rieqrwz0Qzxb681JgqY5krCo1EeyMvINJsVhfYVlEbYQSPuajgpfHZ7E16/Dwx4kzCDQEVnDMu7fEWS01duLgkj3pcyjLyv3on/154kOeYUuk/L7Fnaruh2I6p+SWnVrL4I6IkUPi8vlU7aFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoCcFHZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoCcFHZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809461F000E9;
	Fri,  7 Aug 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118856;
	bh=DvUeGHyUTmYJWre1Tk8lxns7a2cTnDkmc8l4u025Rl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoCcFHZAep/SDFSOeYmWDjGlbpBTtZRx+01CW1BREFsUxiZAH5lNxad6vlpiQd6Q6
	 mKksL93Xrl17hoKiJ1boIec7RtzEZMBUiNmdLg8OwOK0az/s6IURa790M/Q+YvfTVK
	 ikmr6W04SjwlLranZsNIw/4e+xUBP5P0+bH0a4CHS1Kne3FgtKWPc1VGQ4Zo8kt/mP
	 8JbXCt1rt4X9m9RMTs55lPm86ExQlkqVEoW8OhQOVVOETMuGtqaeKoQVd3wCdelbcq
	 rkBSbXWvlIj3B5IKLh4/LfADQRbvJTH2ufu6wGH8Wo4g7brotJs3utngdKPe5c0WCF
	 XoyZjbo31RBsA==
Date: Fri, 7 Aug 2026 19:07:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 06/13] PCI: Account for ACS egress control in
 isolation checks
Message-ID: <20260807160730.GA445892@unreal>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-6-0cec14812965@nvidia.com>
 <20260806114055.DB5951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806114055.DB5951F00A3A@smtp.kernel.org>

On Thu, Aug 06, 2026 at 11:40:55AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unchecked PCI configuration reads in Intel SPT PCH ACS quirks lead to hardware state corruption on read failures.
> --
> 
> --- Patch [6]: [PATCH v2 06/13] PCI: Account for ACS egress control in isolation checks ---
> commit 99c1da7ad98e7bc62ca4515768fee9a8109e4739
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI: Account for ACS egress control in isolation checks
> 
> This commit modifies ACS isolation checks to ensure peer requests cannot
> bypass the IOMMU when Egress Control overrides Request Redirect. It also
> updates the Intel SPT PCH quirk to gracefully handle configuration read
> failures and properly enforce isolation rules.
> 
> [ ... ]
> 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index bb4c09cbbd10d..ebfe902b01182 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4990,15 +4990,21 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
> >  		return -ENOTTY;
> >  
> >  	/* see pci_acs_flags_enabled() */
> > -	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
> > +	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap))
> > +		return 0;
> >  	acs_flags &= (cap | PCI_ACS_EC);
> >  
> > -	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
> > +	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl))
> > +		return 0;
> 
> [Severity: High]
> This is a pre-existing issue, but since this patch adds return checks for
> pci_read_config_dword() here, should similar checks be added to
> pci_quirk_enable_intel_spt_pch_acs() and
> pci_quirk_disable_intel_spt_pch_acs_redir() in the same file?
> 
> If pci_read_config_dword() fails in those functions, cap and ctrl are
> populated with 0xFFFFFFFF by PCI_SET_ERROR_RESPONSE(). The subsequent
> bitwise operations and write-back will write 0xFFFFFFFF (or 0xFFFFFFFF
> masked in the disable function) to the INTEL_SPT_ACS_CTRL register,
> setting all other writable bits.
> 
> For example, in pci_quirk_enable_intel_spt_pch_acs():
> 
>     pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
>     pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
> 
>     ctrl |= (cap & PCI_ACS_SV);
>     ctrl |= (cap & PCI_ACS_RR);
>     ctrl |= (cap & PCI_ACS_CR);
>     ctrl |= (cap & PCI_ACS_UF);
> 
>     if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>         ctrl |= (cap & PCI_ACS_TB);
> 
>     pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> 
> Could these unchecked reads lead to hardware state corruption on transient
> read failures?

A failed read is always followed by a failed write, so the register is not
changed. pci_generic_config_read() and pci_generic_config_write() both use
bus->ops->map_bus(), and on x86 pci_conf1_read/write and pci_mmcfg_read/write
have the same checks. If the read fails, the write to the same offset fails
too, so INTEL_SPT_ACS_CTRL never gets 0xFFFFFFFF.

The check function is different. It returns an isolation answer. On a failed
read, the old code passed ~0 to pci_acs_ctrl_enabled(), where
(req & 0xffff) == req is always true, so it reported full isolation from
garbage data. The enable and disable helpers return no such answer, and they
already write nothing when the read fails.

It is false alarm.

Thanks

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com?part=6
> 
