Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57285 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEIIqN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 04:46:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] of/irq: provide int of_irq_parse_and_map_pci wrapper
Date: Fri, 09 May 2014 10:45:53 +0200
Message-ID: <4975430.zMeeu7d2Xc@wuerfel>
In-Reply-To: <1399624119.4833.3.camel@weser.hi.pengutronix.de>
References: <4527717.yJh2gX3xCP@wuerfel> <1399624119.4833.3.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 09 May 2014 10:28:39 Lucas Stach wrote:
> Am Freitag, den 09.05.2014, 08:58 +0200 schrieb Arnd Bergmann:
> > The pci-rcar driver is enabled for compile tests, and this has
> > now shown that the driver cannot build without CONFIG_OF,
> > following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> > interrupt mapping when possible":
> > 
> > drivers/built-in.o: In function `rcar_pci_map_irq':
> > :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> > 
> > As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
> > supposed to build fine, which we can achieve if we make the
> > declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
> > and provide an empty inline function otherwise, as we do for
> > a lot of other of interfaces.
> > 
> > This lets us build the rcar_pci driver again without CONFIG_OF,
> > which won't work but give us compile time coverage.
> > 
> This part of the commit message is confusing. The driver is explicitly
> written to fall back to a platform irq when OF interrupt mapping doesn't
> work (return 0 or error), to keep non DT enabled boards working.
> 
> I hadn't thought of the compile time dependency, so thanks for fixing
> this up.

I thought it was meant to keep old DTBs working. AFAIK, there is no
legacy board file support for rcar-gen2, so we don't actually have to
worry about that.

	Arnd
