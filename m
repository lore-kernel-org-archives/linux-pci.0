Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CC416846;
	Wed, 22 Jul 2026 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739881; cv=none; b=J8z4iG5aBp2hqubNdB4tztCsCCiSUBVb5GS7KAaFUT3H9AOFYlEvnuERfrQkF2yfHSY2Ua2vg4QUv1mA/a5GzqZD572XqqJck7cXMeImh9NbQROh16w1X1g2Rtn0QK33mKCHSzHTddZkB8ByJttmpySCpG2fneaEhHyifKVs5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739881; c=relaxed/simple;
	bh=uTj2QQfWNusR3JlXJj651tj/5y6hpi6F2AcnD6bIY5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=erU/Wo7ofBSSNag/0SEdKh867ZuMhx1Aa+2GJNBqV2tw/65SZrq+5qss+F3seZfMFuvUKQj3yymTRMRzJwpvao1ec4Mg/7KD0XiD9XSkLGk3YrX4UX/9q25dZUytC35EIdxZHRRJ42qh1DrwIXHbepYwWijvOfju2cGUZh/672I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh69sPdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh69sPdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727DE1F000E9;
	Wed, 22 Jul 2026 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739879;
	bh=5H7RGVYFUCgVtozZu6kCxPn33DSBrxqND4YE//badh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Gh69sPdg+R0OKishp1oO6SiK16KmNtQvf6PqDVmRnFsTfMNjaIZzwg/co6BxGkl0G
	 dfiTKEDyyGqa30H79LhgyZdVoxLi/VpDnLAuAKa+xqLi9WoAOqsxcxTuEJKlgUAt+U
	 942VbRn/O6ozpaHqCAjY2UYiv32hYPm0TeNNDEgKCEjZ/lo8uYF5RrgR/6ZGOePEy7
	 fkADs7p5hkAOkChDrhMuGlesFTFNsyBDl1KVLlhQQUQKwomFl5Cw1iw0nj5O/aow47
	 D6CoUd8k9kpZoqPxTFsU/tK/q1Vx4/d7Qe+I/9xyAK3LkA7sOYqW4URVZNqJ6Gh31R
	 /WNawYOwVbr2g==
Date: Wed, 22 Jul 2026 12:04:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260722170438.GA735886@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62aee750dbabf3e10494e0e5b20f3ba30a7815a3.camel@intel.com>

[+to Thierry, Manikanta for Tegra264 questions; beginning of thread:
https://lore.kernel.org/all/20260621065451.21650-1-emmanuel.grumbach@intel.com,
+cc Miri, Lukas]

On Wed, Jul 22, 2026 at 03:14:47PM +0000, Grumbach, Emmanuel wrote:
> On Wed, 2026-07-22 at 09:56 -0500, Bjorn Helgaas wrote:
> > On Sun, Jun 21, 2026 at 07:30:25AM +0000, Grumbach, Emmanuel wrote:
> > > On Sun, 2026-06-21 at 07:12 +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1
> > > > potential
> > > > issue(s) to consider:
> > > > - [High] Missing suspend/resume fixup hook for Intel BE200 PCIe
> > > > erratum workaround
> > > > --
> > > > 
> > > > commit ebcdab6d68a92d23aa6cf1713e8e72d87f0e6279
> > > > Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > > > 
> > > > PCI: Disable NoSnoop and Relaxed ordering for Intel wireless
> > > > BE200
> > > > 
> > > > This commit disables NoSnoop and Relaxed ordering on the root
> > > > port for the Intel wireless BE200 device because it fails to
> > > > copy TLP Attributes from a Request to the Completion. 
> > > > 
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -4674,6 +4674,13 @@ static void
> > > > > quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev
> > > > > *pdev)
> > > > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > > > >  			
> > > > > quirk_chelsio_T5_disable_root_port_attributes);
> > > > >  
> > > > > +/*
> > > > > + * The Intel wireless BE200 fails to copy TLP Attributes from
> > > > > a
> > > > > Request to the
> > > > > + * Completion it generates.
> > > > > + */
> > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x272b,
> > > > > +			 quirk_disable_root_port_attributes);
> > > > 
> > > > [Severity: High]
> > > > Will this workaround survive a system suspend and resume cycle?
> > > > 
> > > > When the Intel BE200 device is hotplugged, the upstream Root
> > > > Port's configuration state is saved at boot time by
> > > > pcie_portdrv_probe(), which calls pci_save_state(). The
> > > > workaround modifies the Root Port's current configuration to
> > > > disable Relaxed Ordering and No Snoop, but it does not update
> > > > the Root Port's saved state array.
> > > 
> > > That's a good point, but I'm not sure we really test well
> > > hotplug...
> > 
> > It looks like BE200 is normally an M.2 form factor, and I don't
> > think M.2 is designed to support hotplug.  I guess it could be
> > done with an M.2-to-PCIe adapter, but that seems a bit esoteric.
> 
> Indeed. BE200 is an M.2 form factor.
> 
> > > > Upon system suspend, the PCI core skips saving the Root Port's
> > > > state because its state_saved flag is already true. During
> > > > resume, pci_restore_state() restores the Root Port to its
> > > > original boot- time state, which would re-enable the
> > > > problematic attributes.
> > > > 
> > > > Should there also be a DECLARE_PCI_FIXUP_RESUME_EARLY hook
> > > > registered here to ensure the workaround is re-applied when
> > > > the device resumes?
> > 
> > I'm pretty sure the header quirks would be run before portdrv
> > probes, so I guess this is part of the same theoretical scenario,
> > where portdrv probes before a BE200 is hot-added.
> > 
> > Can we include any relevant dmesg output, e.g., AER errors or
> > whatever motivated this quirk in the first place?
> 
> The problem was that we didn't show up at all in the enumeration. We
> send a malformed TLP. I'm not quite an expert at this, but our PCIe
> experts run a PCI analyzer on the enumeration on that specific
> platform and they saw that platform's PCI controller sets the
> NoSnoop and Relaxed ordering bit in the TLP. According to the spec
> (which I ignore), the BE200 is supposed to return the TLP as
> received, but we reply with 0 Attributes and the enumeration doesn't
> complete successfully.

I'm curious about the details of this enumeration failure.  Do you
know which TLPs had No Snoop and Relaxed Ordering set?  Per the PCIe
spec, they shouldn't be set for the config requests used for PCI core
enumeration.

At least *some* config reads to the BE200 must work; otherwise, we
wouldn't know the Vendor or Device ID, which we need to apply the
quirk.  So I think you should see something like this in dmesg, and
BE200 would probably appear in lspci output:

  pci 0000:04:00.0: [8086:272b] type 00 class ...

Is the failure that iwl_pci_probe() itself fails somehow?

You mentioned that this happens on Jetson Thor, but I'm not sure what
PCIe controller that is.  My guess is it might be Tegra264 [1], which
doesn't look like it's merged yet.

Thierry, Manikanta, do you have any insight into this?  Does this PCIe
controller set No Snoop and Relaxed Ordering for some reason?  I don't
think endpoint drivers are expecting that.

[1] https://lore.kernel.org/linux-pci/20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com/

> > c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio
> > T5 Completion erratum") mentions Malformed TLP or Unexpected
> > Completion errors, so I suppose this is similar?
> 
> Precisely.
