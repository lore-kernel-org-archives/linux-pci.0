Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17258318BBC
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825293; cv=none; b=q6yOXCiteaZE49RfmJcw1CKRUOazPeZMZUz42fs0rUjsZOrhJYazA3Peke7Q020Vuo5V/nfmDohdn/koes+p+66HOU/NOkaGoT7ICh5tEVvfXKu5yfejwwH0dyijMRhrX6s4iiAEhn6yylTm/1sAd6VRhCD86UpuNG1vvVz80v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825293; c=relaxed/simple;
	bh=Rtl2aRXU0OI6aLaQilSSkNT2RoHf2tWAPfQ4OtTBc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF5PnG98ICL+2L+wvgMOEQOxbHEM+Wa07km6s15zLwZlP41NczGrudck34fjSM/34WtiEwBGSYgmCpo1JHDdAE7TagVeaBgbfhmlhqlaW7jQbS7c3HyFmYnC1qqvGAknnjUaEv6aczM3FFK4ogDRDbRxudbf4AAxSTF9dJThvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv4SEQqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv4SEQqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5441AC4CEF7;
	Wed, 11 Feb 2026 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770825292;
	bh=Rtl2aRXU0OI6aLaQilSSkNT2RoHf2tWAPfQ4OtTBc2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kv4SEQqxd34tHkZ7EAE9VqgLJo47xPUExoH5NPofddbOTDWM2d3hAV62hglNgEYC9
	 1fw4ESfPlrxdcAxpVUaxmzBW9rR1nIcTJZ15lJzCctL5r/GCntOFIkdl4Ferdk1Jz0
	 TUX0tfZteFCHDqbQuyBRpD2cuMtspufcBzist11gmpl9V8G+xcgqa0TLxKP9MeLNLa
	 tRx/qSIB8w4Kk8antjbmYwE7ItURIoj+4zIIsJNp3YxWdvAf23wDYRdXBhGs7g4DpE
	 itOa9FPCRDdK2WiWEOSbdqKpUZyGnuiaW8ntQIojPyGVALK9r1W+edhvQWFTJBu7h8
	 jsEg4MwoifNKw==
Date: Wed, 11 Feb 2026 08:54:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, lukas@wunner.de, dan.j.williams@intel.com,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <aYymSgmgSTI2D3vR@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-4-kbusch@meta.com>
 <20260210164623.74d38699@shazbot.org>
 <aYvJXRGnsIYVdVUm@kbusch-mbp>
 <20260211082229.4e746e32@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211082229.4e746e32@shazbot.org>

On Wed, Feb 11, 2026 at 08:22:29AM -0700, Alex Williamson wrote:
> On Tue, 10 Feb 2026 17:12:13 -0700
> Keith Busch <kbusch@kernel.org> wrote:
> > No, this still calls the slot's specific reset callback via
> > pci_reset_hotplug_slot. The only thing this does is add locking, config
> > state save/restore, and driver reset prepare/complete calls for the
> > entire bus rather than matching "slots" on that bus. In the worst case
> > scenario, this patch has the kernel do a little more work than it needed
> > to.
> 
> But with this change, when vfio-pci calls pci_probe_reset_slot() we
> test pci_bus_resettable() rather than pci_slot_resettable().  The
> former is a superset of the latter.  Another slot on the same bus might
> have a bridge card or quirked device that previously wouldn't have
> affected the ability to reset a separate physical, conventional slot.
> The risk is small, but the semantics are different.

Thanks, good point.
 
> > > I've always
> > > understood these to be a subset of the bus, where we find the devices
> > > sharing the same physical PCI slot by comparing the pci_dev.slot across
> > > the bus, as done in all the code removed here.  pci_create_slot()
> > > certainly is not simply a reflection of PCI_SLOT().    
> > 
> > pci_create_slot assigns devices that match PCI_SLOT() of the bus's
> > devices, so it certainly is a reflection of that, no? The problem is
> > that PCI_SLOT() macro doesn't actually reflect the true nature of what
> > devices belong in the slot: the devices in a particular "slot" does not
> > define the actual blast radius of resetting that "slot".
> 
> struct pci_slot, the thing created by pci_create_slot(), represents a
> physical slot.  PCI_SLOT() is the bus addressing.  Not all pci_devs
> have a struct pci_slot, not all pci_devs within the same physical slot
> share the same B:D.F slot number (with ARI).
> 
> The vfio code does assume that 'slot' defines the blast radius of a
> pci_slot_reset() and I'm confused how it should operate if we're now
> going to conflate slot and bus reset scopes.

Yes, the "struct pci_slot" is that represetation. The problem is that
its current form is missing semantics to bind to functions that don't
match PCI_SLOT(). I don't know why PCI_SLOT is that criteria, but it's
clearly the wrong criteria for pciehp, probably others too if they
support ARI devices. The previous patch in this series creates entirely
new semantics specifically for pciehp and fixes that issue. It also
makes this patch unnecessary, but *only* for pciehp.

> > > Is the error below
> > > really a reflection that pci_dev.slot isn't carried over to the full
> > > set of functions?  
> > 
> > Correct, the pci slot today in a pciehp hotplug slot is not getting
> > assigned to all the functions in that slot, so slot resets completely
> > miss handling those functions, which inevitably break them.
> 
> Isn't this then a pciehp hotplug issue that all children of the bus
> should be linked via the struct pci_slot regardless of PCI_SLOT()?

It's not really a pciehp issue because pci_slot doesn't make it possible
to do anything else. See [PATCH 2/4] from this series.

In light of these concerns, I think the safest way forward is to drop
this patch and just enable something like what patch 2 provides.
