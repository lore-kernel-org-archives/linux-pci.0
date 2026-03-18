Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7393CD8C4;
	Wed, 18 Mar 2026 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835458; cv=none; b=Y50RsOroDDJajc2s/h52iI/IqDcWRONU/NiCITVIQx15WKJc/5YnWl3c3FRSbozS3V3hQzDqHEd6GTOrBzMEFkg+yzOLVY6/Qgb14+50jcOG+X14x3KxXEmZePyyvEaop7/U4TdHrl6hx+nJajoXgjP9r9dGscK4bnw2hzLYTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835458; c=relaxed/simple;
	bh=Xc1j0xbckMquE+7Oq8YBPSx/m+/CmsUtSO9wmdNglrk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eEybsk1kcCpsb2wffW1X9o3i9FmQKjhXVkTgCTtV1OBeXOIvuk/CLqVXoUrdbGARWwd+dIMYTY1jS6D7vMms6x7u647KwEFpSVXAggsxzBAQWf2yJo6cqn0UyEIypyHWrnPyCZCHge4um+1OWxXMATGAUUQ9/rqfZAjD+jY/PjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e05Xubgv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e05Xubgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773835457; x=1805371457;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xc1j0xbckMquE+7Oq8YBPSx/m+/CmsUtSO9wmdNglrk=;
  b=e05Xubgv+8yknuXNW0AdNEtvLhGuo6hd4K+kPcxfcnf2RBtmKc6O7rwv
   061Vi84+Oo4c7AGVSDRaqo6VFn1k3Oot2HmKSYlhgr/Gx+uVhNpoyd297
   WTyP4TAYxRf+E5ItRp9oMaVO4rQoQrchN0G358BN1yujzPXLQwjOWctp/
   tzd59CH2h7dCusnaD8VmHEvAvROC2x/EaJGiUMrsQCmscg0IMqvp0CzsD
   7F1ZUzaP0LFd9F0bBVxjjxUfOJ1KTHUcWs73SvtAmrVVJylfsDCN4kswy
   gMJEAiwLN6UdBaUmOhfgutRq11oIAxZinjfHHVAhA3J3ge0AlkebJRaUh
   w==;
X-CSE-ConnectionGUID: EnUSF7zsR3iKG43dCYzRUg==
X-CSE-MsgGUID: xuZspob/TP6KBXGQ/4jXjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74772562"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74772562"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:04:16 -0700
X-CSE-ConnectionGUID: 0e+BTQM+QiOAM98/VBXl7w==
X-CSE-MsgGUID: Eyq3oyOITGu+yo1pzh9H9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="245630682"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:04:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Mar 2026 14:04:06 +0200 (EET)
To: Ahmed Naseef <naseefkm@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Caleb James DeLisle <cjd@cjdns.fr>, 
    linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
    ryder.lee@mediatek.com, bhelgaas@google.com, lpieralisi@kernel.org, 
    kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
    angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
    linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: Skip bridge window reads when window is not
 supported
In-Reply-To: <abpFjQJ5RNcbzbmz@DESKTOP-TIT0J8O.localdomain>
Message-ID: <fc927b7f-a820-d3c2-581c-ab6db562bcfb@linux.intel.com>
References: <20260316155157.679533-4-cjd@cjdns.fr> <20260317212908.GA109023@bhelgaas> <abpFjQJ5RNcbzbmz@DESKTOP-TIT0J8O.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Mar 2026, Ahmed Naseef wrote:

> On Tue, Mar 17, 2026 at 04:29:08PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 16, 2026 at 03:51:57PM +0000, Caleb James DeLisle wrote:
> > > pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> > > registers unconditionally. If the registers are hardwired to zero
> > > (not implemented), both base and limit will be 0. Since (0 <= 0) is
> > > true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> > > gets created.
> > > 
> > > pci_read_bridge_windows() already detects unsupported windows by
> > > testing register writability and sets io_window/pref_window flags
> > > accordingly. Check these flags at the start of pci_read_bridge_io()
> > > and pci_read_bridge_mmio_pref() to skip reading registers when the
> > > window is not supported.
> > 
> > The fundamental problem here is that assigned space to a bridge window
> > that isn't implemented.  I wish we understood the connection between
> > this "read window" path and the assignment path.
> > 
> > Maybe this patch fixes it because we enter pci_read_bridge_mmio_pref()
> > with res->flags being NULL, and we set IORESOURCE_MEM |
> > IORESOURCE_PREFETCH again, which makes it look like we can assign
> > space for it?
> 
> Yes, that's exactly right.
> 
> > 
> > If that's the case, I think it would improve the commit log to mention
> > the actual mechanism by which we avoid assigning space.
> > 
> 
> How about this:
> 
>   pci_read_bridge_io() and pci_read_bridge_mmio_pref() read
>   bridge window registers unconditionally. If the registers
>   are hardwired to zero (not implemented), both base and limit
>   will be 0. Since (0 <= 0) is true, these functions set
>   IORESOURCE_IO or IORESOURCE_MEM | IORESOURCE_PREFETCH on
>   the bridge resource. This causes the allocator to assign
>   space for the window even though the hardware can't
>   implement it.
> 
>   pci_read_bridge_windows() already detects unsupported windows
>   by testing register writability and sets io_window/pref_window
>   flags accordingly. Check these flags at the start of
>   pci_read_bridge_io() and pci_read_bridge_mmio_pref() to skip
>   reading registers when the window is not supported, so the
>   resource flags remain clear and the allocator does not assign
>   space for non-existent windows.

At least to me the proposed text reads much better than the original.
The original text required reading between the lines to connect the dots, 
whereas this new one clearly explains what causes what.

--
 i.

> Ahmed Naseef
> 
> > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Link: https://lore.kernel.org/all/20260113210259.GA715789@bhelgaas/
> > > Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> > > Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> > > ---
> > >  drivers/pci/probe.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index bccc7a4bdd79..4eacb741b4ec 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -395,6 +395,9 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
> > >  	unsigned long io_mask, io_granularity, base, limit;
> > >  	struct pci_bus_region region;
> > >  
> > > +	if (!dev->io_window)
> > > +		return;
> > > +
> > >  	io_mask = PCI_IO_RANGE_MASK;
> > >  	io_granularity = 0x1000;
> > >  	if (dev->io_window_1k) {
> > > @@ -465,6 +468,9 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
> > >  	pci_bus_addr_t base, limit;
> > >  	struct pci_bus_region region;
> > >  
> > > +	if (!dev->pref_window)
> > > +		return;
> > > +
> > >  	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
> > >  	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
> > >  	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> > > -- 
> > > 2.39.5
> > > 
> 
