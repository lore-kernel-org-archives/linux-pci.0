Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D023C4FF;
	Thu, 12 Feb 2026 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909228; cv=none; b=SVghWrhb3x0atRDAwKFW19jyA0V4122QGfRDE3hmA1Vpop5Xzi1zhj94dJfpNWsve7Z2KGq59G+UPSWTtCwoJFAcUafuLsw4oP967yLsNNbzgHOFspiT016DAtm8yLRA5lAe/Bz1u428U/iTyB45LAkF2NvVkZauWWvr1g04J7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909228; c=relaxed/simple;
	bh=ohJvhWi95ueYb6x1GbBTxS5DtEq+5LvFQGOq/3UaA80=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EIoy6OefYiK7OvOmhj0uZVIipTCnbW0wrx4vdYvZw32hAV/ZW61T20RngSwqBDByIthE3xpym7N7RLabjL99B8rS27mdtdJKdQFpGjBju28f0AwQsdAxQ0+anulQjgaugSqzl93PthFB9rdaQ7qaqGTiYuk7nqB35QXwrHL8EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q30QVXgi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q30QVXgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770909227; x=1802445227;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ohJvhWi95ueYb6x1GbBTxS5DtEq+5LvFQGOq/3UaA80=;
  b=Q30QVXgiZeHtZHTAycrskbXMjfFhy+d7NBZMs6Ti5lz9pjylUWavCTAC
   u2Cl8Cc3Jxlj+hspJIXnAFWyJIn6oLL7xHOTdOzWX5WvGmWDXXCBCvfDa
   NMGjj7XKodNe4mVkq7+nsKFFGk13HF1V7r9v5MKmNqLqdQIlI+NcyiEYV
   IE8pyQSpYXME35jzfxOFhVlrpxLDN7s0OFM8GLhr5/2Yh0JVfvQvxWcEz
   PrdPcMf+c/arMQCDJPKbBtDdUk+pDI11/jQktPhFpIHsgYxSssWsoOne2
   3T1pY1kp2fFga/oXTBpDvodx1v6aWSEVwkCCIT/WNsPb1DKpGdjCwxKnO
   w==;
X-CSE-ConnectionGUID: aDEJy1i5QsmGUoG+LCm8hQ==
X-CSE-MsgGUID: DgRDg2WaQP23Cg0c6kK9NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75925215"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="75925215"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 07:13:46 -0800
X-CSE-ConnectionGUID: DUSfwMClTZ6jenK7HAUjug==
X-CSE-MsgGUID: dmZ5WdFTR4minnHtglTWJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="217587509"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.159])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 07:13:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Feb 2026 17:13:40 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Kai-Heng Feng <kaihengf@nvidia.com>, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Validate window resource type in
 pbus_select_window_for_type()
In-Reply-To: <20260210172635.GA31498@bhelgaas>
Message-ID: <0c659d24-66ae-2bfa-08ce-ff4524d6d16d@linux.intel.com>
References: <20260210172635.GA31498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Feb 2026, Bjorn Helgaas wrote:

> On Tue, Feb 10, 2026 at 10:20:57PM +0800, Kai-Heng Feng wrote:
> > Afer commit ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during
> > IO window sizing") and commit ae88d0b9c57f ("PCI: Use
> > pbus_select_window_for_type() during mem window sizing"), many bridge
> > window can't get resource assigned:
> > pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> > pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> > pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> > pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> > pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> > pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> > pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> > pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> > 
> > Those commits replace find_bus_resource_of_type() with
> > pbus_select_window_for_type(), and the latter lacks resource type
> > validation.
> > 
> > This commit adds the resource type validation back to
> > pbus_select_window_for_type() to match the original behavior.
> > 
> > Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")
> 
> 74afce3dfcba, ebe091ad81e1, and ae88d0b9c57f all appeared in v6.18.
> Interesting that nobody else reported this since.  In any case, this
> looks like post-merge window v7.0 material after an ack from Ilpo,
> probably with a stable tag.

The change seemed fine to me.

> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221072
> > Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> 
> Thanks for bisecting and fixing this!  From the "dmesg with fix"
> attachment (https://bugzilla.kernel.org/attachment.cgi?id=309333):
> 
>   pci_bus 0006:00: root bus resource [mem 0x618040000000-0x6180bfffffff window] (bus address [0x40000000-0xbfffffff])
>   pci_bus 0006:00: root bus resource [mem 0x6180c0000000-0x627fffffffff window]
>   pci 0006:05:00.0: [15b3:197b] type 01 class 0x060400 PCIe Switch Downstream Port
>   pci 0006:05:00.0: PCI bridge to [bus 06]
>   pci 0006:05:00.0:   bridge window [mem 0x618040300000-0x6180403fffff]
> 
> Looks like the 32-bit (non-prefetchable) window was programmed by
> firmware but the 64-bit window was not programmed or maybe programmed
> incorrectly (a dmesg with "pci=earlydump" would show the raw state
> Linux received):
> 
>   pci 0006:05:00.0: bridge window [mem 0x00000000 64bit pref] to [bus 06] requires relaxed alignment rules
>   pci 0006:05:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
> 
> For hex_range() to print a resource with a single address like the
> "relaxed alignment" line, I think the resource must have
> start==end==0, which would mean a window at 0x0 that's one byte long.
>
> A memory window res.end should always have 0xfffff in the low 20 bits
> because these windows are a multiple of 1MB in size, so this suggests
> another bug somewhere.  

I tried to find places where the kernel could mess the end address up but 
unfortunately couldn't come up anything, the commit 8278c6914306 ("PCI: 
Preserve bridge window resource type flags") should take care 
initializing the window resource always (if the bridge window is read, 
obviously).

Perhaps the bridge window configuration was not read for that window, 
but feels odd given it has the type. One possibility would be that 
pci_bridge_check_ranges() set the type based on ->pref_window but 
pci_read_bridge_bases() never executed so the resource addresses were 
never filled (pci_read_bridge_windows() that fills ->pref_window only 
reads the window's addresses to a dummy resource). I'd prefer to kill 
pci_bridge_check_ranges() as it has chance of messing things up like this 
but that requires that one series to setup the bridge windows earlier we 
had to revert.


It's unclear to me if the commit 15c5867b0ae6 ("PCI: Don't print stale 
information about resource") is in the kernel these logs were taken from.
It does affect in what state the resource gets printed.

>   pci 0006:05:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 06] requires relaxed alignment rules
>   pci 0006:05:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 06] add_size 200000 add_align 100000
>   pci 0006:05:00.0: bridge window [mem 0x618040200000-0x6180404fffff]: assigned
> 
> I think these three lines all refer to the 32-bit window.  It's a bit
> confusing that the logging shows what looks like a
> IORESOURCE_STARTALIGN and size (same applies to the 64-bit window
> above).  I wonder if resource_string() should do something different
> when decoding this so it doesn't look like we actually programmed the
> window to this. 

> And maybe pci_resource_name() should explicitly say
> which window this is.

There was mention somewhere that it's not included because the resource 
bits should indicate that information.

I'd much prefer that info to be visible though, it's okay to not have it 
explicit when things work as expected but while troubleshooting the 
ambiguity is very annoying when those dreaded ??? appear.

> Also slightly interesting that we reassigned the 32-bit window,
> increasing its size from 1MB to 3MB.  Maybe this is because the bridge
> supports hotplug.

It has add_size so the expected size is resource size + add_size.

> Unrelated nit: I think we should add "0x" prefixes for add_size and
> add_align to match the addresses.
> 
>   pci 0006:05:00.0: bridge window [mem 0x6180c8800000-0x6180c89fffff 64bit pref]: assigned
> 
>   pci 0006:05:00.0: PCI bridge to [bus 06]
>   pci 0006:05:00.0:   bridge window [mem 0x618040200000-0x6180404fffff]
>   pci 0006:05:00.0:   bridge window [mem 0x6180c8800000-0x6180c89fffff 64bit pref]
> 
> > ---
> >  drivers/pci/setup-bus.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index e680f75a5b5e..1b5185697011 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -224,14 +224,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
> >  
> >  	switch (iores_type) {
> >  	case IORESOURCE_IO:
> > -		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> > +		win = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> > +		if (win && (win->flags & IORESOURCE_IO))
> > +			return win;
> > +		return NULL;
> >  
> >  	case IORESOURCE_MEM:
> >  		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
> >  		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
> >  
> > -		if (!(type & IORESOURCE_PREFETCH) ||
> > -		    !(mmio_pref->flags & IORESOURCE_MEM))
> > +		if (mmio && !(mmio->flags & IORESOURCE_MEM))
> > +			mmio = NULL;
> > +		if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
> > +			mmio_pref = NULL;
> > +
> > +		if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
> >  			return mmio;
> >  
> >  		if ((type & IORESOURCE_MEM_64) ||
> > -- 
> > 2.43.0
> > 
> 

-- 
 i.

