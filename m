Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7D364938
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815190; cv=none; b=FxXtEVkm5E0vNruOsf2/5d4Hl75KM7VQ3IdPG2M3Cik9ZuI+5E2mcjHjTf9lh+tlhjqAXw6Pakf6yNYboSERy3FCjk9emJzDmzGxH151rnKmt7GzpyT5O8FKKyiruAmGMDRE001qcpGZEv5fJ+TUh4/yOqM02B8I6+jomD9BF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815190; c=relaxed/simple;
	bh=V4TiM2oQbQvMxOOzG5GrS/DX9Cy+c9AJCjl2pkunZKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC8/rPAX6DIjQ29E3V0lgPCsxiQz/Z1S8I6vKj1Sxx1VMnHcst3xiln3l/Jc4cfEH8LKNUhnIUe1YvfnO9iTNAdcSzWvN5B3m96eNjZ1m/8HaNZc6MveGIlfnaZ9QCrad+d8d8MccoRiuN0vbD5XAQpZ1/3KA+yAbTrSfH7t/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL1TFZbI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL1TFZbI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so2249318a91.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815189; x=1774419989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpBW0wGm/rB3CXB45eRbxyqg2mwTYhAbVyKw2N1pJiY=;
        b=fL1TFZbIFtHG/nOvjZTiTJ6CnnVZsfl/hPnzvJIuKJE1Lspo1asmVSMkPh4WK2Wq6h
         Oo5/6/pZxjdqxEJ5r3Qjc8QOwq1E1ZknyncESJ4QcU5tMATg8T8734bf3n1Moj8Q4Swg
         dLuHiMz4x9whdHzEYwbeyTzhaMAiqwcvQ41G4xAvSpZ0ZuoOUFZ9V7+WCiCrGfq1avwb
         3Y2iTnYk/XVt+DPmTWrByWdfd7hjmikBRMDdt7N/++1xb4T5S4oZTu3d5n9Fkz2Ok0qp
         Pn6zBAlvUk54bkyDjBE6hkyN9k5Iz1AN6W5IVBjQma7XppmA1VbO7qEoT9kWBo1xNwKK
         SK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815189; x=1774419989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpBW0wGm/rB3CXB45eRbxyqg2mwTYhAbVyKw2N1pJiY=;
        b=oWSsEd0p+GEb04CchgBXKFNFH7Urn2OgeAUoFKFRSFdYF5ZriS8k5EroXJwQbU3xiI
         Q6+EgyjCACMGUsf/iSWNXFg4K1vPOAUNV4Uy7XOWsHPFZtgZvsLqCA1ZUtwo28zTCXJI
         hPt/gjD71p5QEC3mMG5BDNcML3rzb3tL/IQTA7iXb8DREtHMLqn8Wkg3DT0oESzmEb2k
         l8/x/0y0SL3H0F+jUzHDxfQ6VJAvtEzOfXcLR5y7Vzd5o+AS2jv3HtvuQiv15sBF0RzK
         OPPxlozhpN4l2lMzaekY7ykGwQ/puseo5+QHq1dtsMBcAZ71DVB5gX5qer8B7DQ0bEoV
         onRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshQg8ru3ektWR+zIKZbobN+kCk2xxdozl4yscC8tKR5UFv6ap3JIpS8veDTAMZzs7oGq2otIjNaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqLZ1C1k4bkQSUGoOvmP69QImLAm8kS6gLUh1TNfyrGGvQEzn
	cp5sYeG1UJRNUYADSRa5kMlxkjw9wznRp1qVFgCpqm7pTvoizFshJ+tm
X-Gm-Gg: ATEYQzz//KK4FjQ21w5TEubRO5w85ZmH6A3iBlUPJxRoqNvD26iJqk39RCelpuQVNmi
	th1lmvbG+epRvrATBq4r+bOuy+py+3KOPkO1mTGCMbSHY4aVqGdk0rO5po9wUxKuMvD2g2B0Fqr
	SahHSjKTNKIV7zFF54T+RMq8Jl4KqKZVki7swpYh8TsHtcV5buk4NJ8XrlMVc0myzhAsXRYmvWN
	nTo6NQajCRPcrJ0YnVeBP11tp38Tvf0V8/cTO4x0Dmgl2ga/Wnxo5hmMjRCxMxoAo+fBtGtKdQb
	Tse8d5nZZ6pYRzV4jXWa4bZkYgeTgyUyfVMoXfIenMYpv2mrj8RO1gz7ZDouicmHqUZvsQ0zOhH
	Mo30MDy/kj5MU/Ajvs35EgNoK2WScgczKmGxeAhsXzar9AghTy1HX03L4uHaUrFuQXJL0CrYtGE
	cn6LMXJ6hdGcEG72LZWigT7fdwOA0azCEae7BVnIE=
X-Received: by 2002:a17:90b:2d10:b0:359:ff8a:ee3c with SMTP id 98e67ed59e1d1-35bb9f11dcbmr1891248a91.23.1773815188966;
        Tue, 17 Mar 2026 23:26:28 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada2bc3esm6193566a91.1.2026.03.17.23.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:26:28 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:26:21 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Caleb James DeLisle <cjd@cjdns.fr>, linux-pci@vger.kernel.org,
	linux-mips@vger.kernel.org, ryder.lee@mediatek.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Skip bridge window reads when window is not
 supported
Message-ID: <abpFjQJ5RNcbzbmz@DESKTOP-TIT0J8O.localdomain>
References: <20260316155157.679533-4-cjd@cjdns.fr>
 <20260317212908.GA109023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317212908.GA109023@bhelgaas>

On Tue, Mar 17, 2026 at 04:29:08PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 16, 2026 at 03:51:57PM +0000, Caleb James DeLisle wrote:
> > pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> > registers unconditionally. If the registers are hardwired to zero
> > (not implemented), both base and limit will be 0. Since (0 <= 0) is
> > true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> > gets created.
> > 
> > pci_read_bridge_windows() already detects unsupported windows by
> > testing register writability and sets io_window/pref_window flags
> > accordingly. Check these flags at the start of pci_read_bridge_io()
> > and pci_read_bridge_mmio_pref() to skip reading registers when the
> > window is not supported.
> 
> The fundamental problem here is that assigned space to a bridge window
> that isn't implemented.  I wish we understood the connection between
> this "read window" path and the assignment path.
> 
> Maybe this patch fixes it because we enter pci_read_bridge_mmio_pref()
> with res->flags being NULL, and we set IORESOURCE_MEM |
> IORESOURCE_PREFETCH again, which makes it look like we can assign
> space for it?

Yes, that's exactly right.

> 
> If that's the case, I think it would improve the commit log to mention
> the actual mechanism by which we avoid assigning space.
> 

How about this:

  pci_read_bridge_io() and pci_read_bridge_mmio_pref() read
  bridge window registers unconditionally. If the registers
  are hardwired to zero (not implemented), both base and limit
  will be 0. Since (0 <= 0) is true, these functions set
  IORESOURCE_IO or IORESOURCE_MEM | IORESOURCE_PREFETCH on
  the bridge resource. This causes the allocator to assign
  space for the window even though the hardware can't
  implement it.

  pci_read_bridge_windows() already detects unsupported windows
  by testing register writability and sets io_window/pref_window
  flags accordingly. Check these flags at the start of
  pci_read_bridge_io() and pci_read_bridge_mmio_pref() to skip
  reading registers when the window is not supported, so the
  resource flags remain clear and the allocator does not assign
  space for non-existent windows.


Ahmed Naseef

> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Link: https://lore.kernel.org/all/20260113210259.GA715789@bhelgaas/
> > Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> > Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> > ---
> >  drivers/pci/probe.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index bccc7a4bdd79..4eacb741b4ec 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -395,6 +395,9 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
> >  	unsigned long io_mask, io_granularity, base, limit;
> >  	struct pci_bus_region region;
> >  
> > +	if (!dev->io_window)
> > +		return;
> > +
> >  	io_mask = PCI_IO_RANGE_MASK;
> >  	io_granularity = 0x1000;
> >  	if (dev->io_window_1k) {
> > @@ -465,6 +468,9 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
> >  	pci_bus_addr_t base, limit;
> >  	struct pci_bus_region region;
> >  
> > +	if (!dev->pref_window)
> > +		return;
> > +
> >  	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
> >  	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
> >  	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> > -- 
> > 2.39.5
> > 
