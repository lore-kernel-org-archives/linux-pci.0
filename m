Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574735AC05;
	Wed, 22 Jul 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732193; cv=none; b=ATG+7v8OhRgvXmogW7p2S8MVGnvG2cgyB7b4tlSbT2hKcmdtxD5AzwQjuoFG6buD3Gzy6y0hmQu+0xLRIveUJN2RwShNZNbGMM6wa6gK7io6p5J+QYPCecZEvpc24LF33zi3duiu8HX/Pv2B3CgSncNBsUGOq+hgyPEFrrUyq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732193; c=relaxed/simple;
	bh=CgSzGmAS+QRkLE0LdoH5pWM/VAz+zCNRzPQbraP67jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS4kUaCUKf2oL+GJeRGmMp1ENZFHrIUPxVKejNqXDvsAvZXdyLS1cuZEnCIZ+9FNAflJUJ0dQjoSzfW9O8+YG/8oWAXnbjtFaN4Ag1GH06XEAPVRl8AlMF7/cqmOY4nv+a/psRXNFuoF5rZnm/Qqa9jnL3WCSyPhtDA3XrdUivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBUeYIi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBUeYIi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FFA1F000E9;
	Wed, 22 Jul 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732191;
	bh=v3WvHmJHIPHHvilRXLurOwmXE4QbZCzmkt98mJHIKGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MBUeYIi+xsKWeCJ5Siiz8Rog7qRh2ySH/mPwhQphhpn8M998p9D3EeGnn1QCF8M2B
	 JhfMTsvKfumE7v+urYqAdjiXRWabQX3GeE2uHGhDcSA4LPVd/tM+xwhjhdKH5OXeUt
	 +uNM6Io8k5RI/465E45x/gGemcq13buJ271BYuN+9/cyU0iaBa8XLp8MfOSxO4Lsku
	 11i7Bd3Lz7YxsB7gPwM3oJXFKag3jIZcpvESvXLuiQi0KGIxCGA3O9rjDQOYZSRF+k
	 3GolkA/7hiZzkA5bPMNZjVAwJpFYWStvIiI0ECjDko9+vyqEgtIXioUs/hJhc8reBf
	 v7I4abrySspHA==
Date: Wed, 22 Jul 2026 09:56:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260722145630.GA729605@bhelgaas>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
 <20260621071242.B20F31F000E9@smtp.kernel.org>
 <29e347a8ed29e7fdc52ddba72c8ce9da80239993.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29e347a8ed29e7fdc52ddba72c8ce9da80239993.camel@intel.com>

On Sun, Jun 21, 2026 at 07:30:25AM +0000, Grumbach, Emmanuel wrote:
> On Sun, 2026-06-21 at 07:12 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > - [High] Missing suspend/resume fixup hook for Intel BE200 PCIe
> > erratum workaround
> > --
> > 
> > commit ebcdab6d68a92d23aa6cf1713e8e72d87f0e6279
> > Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > 
> > PCI: Disable NoSnoop and Relaxed ordering for Intel wireless BE200
> > 
> > This commit disables NoSnoop and Relaxed ordering on the root port
> > for the
> > Intel wireless BE200 device because it fails to copy TLP Attributes
> > from a
> > Request to the Completion. 
> > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4674,6 +4674,13 @@ static void
> > > quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > >  			
> > > quirk_chelsio_T5_disable_root_port_attributes);
> > >  
> > > +/*
> > > + * The Intel wireless BE200 fails to copy TLP Attributes from a
> > > Request to the
> > > + * Completion it generates.
> > > + */
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x272b,
> > > +			 quirk_disable_root_port_attributes);
> > 
> > [Severity: High]
> > Will this workaround survive a system suspend and resume cycle?
> > 
> > When the Intel BE200 device is hotplugged, the upstream Root Port's
> > configuration state is saved at boot time by pcie_portdrv_probe(),
> > which calls pci_save_state(). The workaround modifies the Root Port's
> > current configuration to disable Relaxed Ordering and No Snoop, but it
> > does not update the Root Port's saved state array.
> 
> That's a good point, but I'm not sure we really test well hotplug...

It looks like BE200 is normally an M.2 form factor, and I don't think
M.2 is designed to support hotplug.  I guess it could be done with an
M.2-to-PCIe adapter, but that seems a bit esoteric.

> > Upon system suspend, the PCI core skips saving the Root Port's state
> > because its state_saved flag is already true. During resume,
> > pci_restore_state() restores the Root Port to its original boot-time
> > state, which would re-enable the problematic attributes.
> > 
> > Should there also be a DECLARE_PCI_FIXUP_RESUME_EARLY hook registered
> > here to ensure the workaround is re-applied when the device resumes?

I'm pretty sure the header quirks would be run before portdrv probes, so I
guess this is part of the same theoretical scenario, where portdrv probes
before a BE200 is hot-added.

Can we include any relevant dmesg output, e.g., AER errors or whatever
motivated this quirk in the first place?

c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5
Completion erratum") mentions Malformed TLP or Unexpected Completion
errors, so I suppose this is similar?

