Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95A3909B4
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611720; cv=none; b=fRA9RywHV0Dli0tVkUHqjblrNbPO/2l5LH9+uwENinU2b9Lq015Tl03BxKqEix4JtLtnhSXmApSf2IvwiMFz/mU3Jt0BCIoGy6fM3gDDxa4mYJBgVB0MSbYJW1E2xJ9IZSxqpbfT+w39O7DZJx56f3EoJ1wvopi7rulqZpLMjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611720; c=relaxed/simple;
	bh=SCl11TbcKKgrDpz8AOKo3E9AzwfTwHh0/Z5vfzDPinw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/ObAUCX8ECFr+zKXqicOF6eF/Jl9ur51odrWY3n+a2wpChP8NHXA04vetmlqLGGLLayTvz1lp1Se4GlHepA4WQKEXQvHUts8OG9d3owAVLlCtlyQqPVWaaU4ReaD792pWgJOpmIGpHZ/fxgIUzvP4ZWJBDHC+yXPGCl2E7ArA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgMJc9/v; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgMJc9/v"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3598e7155bbso2002806a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772611715; x=1773216515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6V4ZABAoBYAEDoOVQvmIQ76oRldfMwh5wzfjWSFa+/U=;
        b=KgMJc9/v7e8TyF0l45KxWaYpiGQiHHdHaHh99F+sQOVf7pnj0jMqVkxoryAXv4vup4
         XQJheuqy6Bxicnv+xPE75cY/aZ5VIUGTBYLsN1yQwwimsf0Pa6A4bFkAy5bPdTvpUoMo
         qssc5eEPe6UlxisuAkkqhdbFA5RRP11tMk5dw6pFiyS+mOg4Dqxsaq9t7SXFgio+jYmX
         qGbcWQ+qNAicdFeo9FE6D3S97FcwyfH2x2VRTAa+F/Kxooe3FWp4A9cp47WLmDPdoGLl
         oPOxqY98YA42YhCUFlG6EDYiJBQTpHuwVjCs2A9vjNo9BeakWAoQ75r/m4a1BovurIJf
         jDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611715; x=1773216515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V4ZABAoBYAEDoOVQvmIQ76oRldfMwh5wzfjWSFa+/U=;
        b=omymz9FH4wzQ9PnYU1wyhTLrEIVgoyOYrjiifH8EhMk5+QIEeiFQZBlyJgVeL05cFM
         JWC/BXHVIiAbdmRSIrNxLnHg3AqQUpGi/sEOo8coEgf4GM/4LlQlCH5l1EplbVdNGDWs
         yv+TTEwF1sNk9oPMJGGHvIcGYW7o7MNtAIH1twcm+CRckQLAx95NA8nQiQTdEn8mAd9z
         VfTM/HSdAo29rCzTIlvhinY7l4JHTevUGnGjg7xrrnsJFgfjv5OxOwYSb5b0xyIAnrEz
         XVTPeDHsBhZbq6g6XT68Mz2th8zKvtEzyKab9+M/ch244U2TFkWvh4LpBblQDg/ZbhN/
         dJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGq3kJHdUh6mpfp9wa6Jp+jwx3LhPMHNgTZxq7B6qIZjMI3JcmP+pbYCZpsSXDY4ktUOH+z1xMYuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMLOL8qdiOChooVP2ZGNCp7gVdHKmVbSzW5AAB6Hr99IRavc2
	w4+APQWd02BfaVXwWprvr+OdBKDUbZcn8iSpRD1YryweMD25toB8gYMM
X-Gm-Gg: ATEYQzzxKXKOKGrG+9BQoJUm1Mkpa8L3l6IoOIYrJmDUq7AAJB6RXYDXGNNdfyRU342
	eh0RhV6vtPXY1cLNWP4Sl0VkHUr3BCudgDIL2l7JNNjySg2GvOrW5ftrLLp4ftnJ99p8NuL/0Fi
	OfNH3KzjO+e4X+gQe6vbBRwzObHz2xmu4muZbHXxKBjhQFouUUx5BvPSc5c1/Y5rsESfst/Q8Sz
	kvpr+wnF+d2V6sYCCXhyfEm2JLW4onedmbbXH/V/8gT1z+DcZ6KIDII0F3Cz023YbI0pYw38wbE
	1bniM+kMkLb1H+GF6d2WWZfJicCYOX6HPyaxtbPYBeQDZ5pBnbw02FZStwE+N6tfsvvUS4wAnsl
	stA4uBIArlNKJZi6C39RL/ty49+Fn5Pm+hVU3BWpbp819JzGNPxw+ea0qf13Fm0Ygwlkq5rS+TA
	6bfHA/7d2RcpOPmTyw3842Gj2ciTGKM8A4gRj9ZXI=
X-Received: by 2002:a17:90b:2fc8:b0:359:8e1c:542 with SMTP id 98e67ed59e1d1-359a6a3c1ddmr1261053a91.18.1772611715477;
        Wed, 04 Mar 2026 00:08:35 -0800 (PST)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3acea3sm4504552a91.16.2026.03.04.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:08:35 -0800 (PST)
Date: Wed, 4 Mar 2026 12:08:25 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Caleb James DeLisle <cjd@cjdns.fr>, linux-mips@vger.kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, tsbogend@alpha.franken.de,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, vkoul@kernel.org, neil.armstrong@linaro.org,
	p.zabel@pengutronix.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, nbd@nbd.name,
	ansuelsmth@gmail.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] PCI: Skip bridge window reads when window is not
 supported
Message-ID: <aafoedMHhKNuEwFE@DESKTOP-TIT0J8O.localdomain>
References: <20260303190948.694783-8-cjd@cjdns.fr>
 <20260303213723.GA4075286@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303213723.GA4075286@bhelgaas>

On Tue, Mar 03, 2026 at 03:37:23PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 03, 2026 at 07:09:47PM +0000, Caleb James DeLisle wrote:
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
> BTW, I'm still interested in the details of how we got here.  It
> shouldn't be too unusual to have a bridge without an I/O window or
> maybe even without a prefetchable (64-bit) memory window.
> 
Hi Bjorn,

I'm fairly new to the PCI subsystem, so please correct me if
any of my understanding below is wrong.

Regarding the I/O window check: I only hit the issue with the
prefetchable window. The I/O window check was added per your
suggestion in our earlier discussion, since the same logic
applies. Neither downstream device (MT7603, MT7663) has I/O
BARs, so I haven't been able to test that path.

The EN7528 SoC's PCIe bridge does not implement the optional
prefetchable memory window , the registers are hardwired to
zero. The downstream device (MT7663 WiFi) has 64-bit
prefetchable BARs.

The problem is that pci_read_bridge_bases() reads these
registers without checking pref_window. With both base and
limit hardwired to zero, base(0) <= limit(0) evaluates true,
creating a bogus [mem 0x00000000-0x000fffff pref] window.
This makes the allocator believe the bridge has a prefetch
window and route the prefetchable BARs through it. But since
the hardware can't actually forward through this non-existent
window, the device becomes unreachable.

This patch skips the register read when pref_window is not
set, so no bogus resource is created, and the allocator
correctly falls back to the non-prefetchable MMIO window.

As to why this hasn't surfaced before , I'm not sure. It may
depend on whether pci_read_bridge_bases() gets called on a
given platform and whether the downstream devices have
prefetchable BARs. But I don't have enough experience with
other platforms to say for certain.

Reagrds,
Ahmed Naseef

> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
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
