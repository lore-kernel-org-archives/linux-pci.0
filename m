Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320B3BF303;
	Wed, 21 Jan 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000172; cv=none; b=fZcCxHV4COcuo8aK67o/Ymx7QTSvyX/QrN68R8jglW0NQ3nuRu90FAHhTr0eiDI8UGW5DWLFEAf1Vp1PZGVEo+LcYnPU2DQj3cPAqjjJvTTZ7sIWdNycWWodlV9FqyrvDUlxzBdpGCdnARcrR3UOSZfTEtn6WxgE+pNBjltX3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000172; c=relaxed/simple;
	bh=56UVyqPWLJemWzhcDurculBaLPi8noDT7EpZ0GoyH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlevSfuUgVwDNE4DjIYrW+Q7e8+Ini1JFUaLJDo8obgvUrlVZx/TaFdwwqanTTPa6TJ6Io+FpsmFpXFKV5KTYtZfDZPI5J9k9sXaMBPTgNJ+Gg9vr8WU8MA1DQT0Nw32aThIJM+1zs+aNDY1k6hgdm2tR5w28ophr+0Gb0SLBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5twf1DK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5twf1DK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DC9C19421;
	Wed, 21 Jan 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769000171;
	bh=56UVyqPWLJemWzhcDurculBaLPi8noDT7EpZ0GoyH6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5twf1DKCwjMY6KBLErakNGtNa4SFiAsM8bAlz4Te3tbB572/BLe/C51jPWTtMWHe
	 /5TKCx2eNX+swo6+EGAZtHN4a/Il4+dqb3aiCWYFr39l853YRra8HCfpuNYdMs6AlV
	 8FOWOPAKDACLz9GflLu9JuQwt7wu6HtNmUadaPc13CVFY3gusQBlQFYBKQNaz5cuB/
	 Uapkj0vcscBjDjeSIX5WEilm3mITSzpmgJPRzproWnR34/jNgJcKVSxDBDuKRWm2q2
	 +Cu77aU2kjB4Uy/gjG+XOpg+4u5iaEL7kprL1qjCpuJ9xK5RSrJHHpSPNRyKSgYCSf
	 /j9bUkNTrdAGg==
Date: Wed, 21 Jan 2026 13:56:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] PCI: dwc: ep: Add per-PF BAR and iATU
 mapping support
Message-ID: <aXDM5qpREE9FKrW6@ryzen>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-3-a-garg7@ti.com>
 <aXCaba4I0woHJCza@ryzen>
 <c7d4e9cf-8b0b-4f87-a354-d4f443da0964@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d4e9cf-8b0b-4f87-a354-d4f443da0964@ti.com>

On Wed, Jan 21, 2026 at 05:05:50PM +0530, Aksh Garg wrote:
> 
> 
> > On Wed, Jan 21, 2026 at 11:12:14AM +0530, Aksh Garg wrote:
> > > The commit 47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP
> > > way of finding") adds support for each physical function to have its
> > > own MSI and MSI-X capability structures by introducing struct
> > > dw_pcie_ep_func. However, BAR configuration and iATU mappings are still
> > > being managed globally in struct dw_pcie_ep, meaning all PFs shared the
> > > same BAR-to-iATU mapping table.
> > 
> > You are mentioning commit 47a062609a30 ("PCI: designware-ep: Modify MSI and
> > MSIX CAP way of finding"), but you should probably also mention commit
> > 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> > which added support for PFs in the DWC driver.
> > 
> > That is the commit that is incorrect IMO. You cannot add support for PFs
> > and then have a different EPFs over overwriting address translation for
> > other EPFs. The design was simply broken from the start.
> > 
> 
> Yes, the commit 24ede430fa49 is indeed the culprit for this issue. Maybe the
> way I wrote this commit message confused you. I was just referring to the
> commit 47a062609a30 saying that as this commit added the feature for each PF
> to have its own MSI and MSI-X capability, I wanted to move bar_to_atu and
> epf_bar per-PF as well, such that each PF should have its own epf_bar[] and
> bar_to_atu[]. The index passed to these fields should be unique across
> PF+BAR combinations while the current implementation is only keeping it
> unique across BARs but not PFs. This results in overwriting address
> translation regions across the PFs.
> I will rephrase the commit message and add fixes tag for 24ede430fa49.
> 
> Please provide your input whether the above explaination is sufficient.
> Should I refer to commit 47a062609a30 as an example in the commit message,
> or that would not be required given the above explaination is added?

As long as you mention both commits, I think it is sufficient.


Perhaps something like:
Commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
added support for multiple PFs in the DWC driver.

However, this commit was incomplete, and did not properly support MSI/MSI-X
for multiple PFs, which was fixed in commit 47a062609a30 ("PCI: designware-ep:
Modify MSI and MSIX CAP way of finding").

Even with both these commits, the multiple PF support in the DWC driver is
severely broken, because one EPF for one PF will currently overwrite the address
translation done by another EPF for a completely different PF. To fix this,
just as commit 47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP way of
finding") did when it moved things to a per PF struct dw_pcie_ep_func, moving the
data structures needed for address translation to struct dw_pcie_ep_func.



Kind regards,
Niklas
