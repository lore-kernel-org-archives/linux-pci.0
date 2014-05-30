Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:40591 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaE3Ra4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 13:30:56 -0400
Received: by mail-ig0-f170.google.com with SMTP id uy17so1055785igb.5
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 10:30:56 -0700 (PDT)
Date: Fri, 30 May 2014 11:30:53 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Richard Zhu <r65037@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
	Mark Rutland <mark.rutland@arm.com>,
	Sean Cross <xobs@kosagi.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
Message-ID: <20140530173053.GF4607@google.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <20140424175844.GD29593@google.com>
 <1398421265.4657.25.camel@weser.hi.pengutronix.de>
 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
 <1398774686.4677.12.camel@weser.hi.pengutronix.de>
 <1399885183.5016.4.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399885183.5016.4.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 12, 2014 at 10:59:43AM +0200, Lucas Stach wrote:
> Hi Bjorn,
> 
> just a friendly reminder. It would be nice if you could pull those in.
> 
> Shawn already pulled the DT change and as it is a binding change this
> means PCIe on i.MX6 is broken in -next, as long as the remaining patches
> are missing.

I applied these to pci/host-imx6 for v3.16.

Sorry I didn't do this sooner; I get a lot of email and it's easy to
overlook things.  I mostly work from patchwork
(http://patchwork.ozlabs.org/project/linux-pci/list/?order=date), and I had
dropped this series from there because there was enough discussion that I
expected a re-post, so it wasn't on my radar screen anymore.

Bjorn

> Am Dienstag, den 29.04.2014, 14:31 +0200 schrieb Lucas Stach:
> > Hi Bjorn,
> > 
> > Am Freitag, den 25.04.2014, 08:39 -0600 schrieb Bjorn Helgaas:
> > [...]
> > > >> >   PCI: designware: split Exynos and i.MX bindings
> > > >> >   ARM: dts: imx6: update pcie to bring in line with new binding
> > > >> >   PCI: imx6: use new clock names
> > > >> >   PCI: imx6: drop old irq mapping
> > > >> >   PCI: imx6: rip out optional (and unused) irqs
> > > >> >   PCI: designware: make MSI isr shared irq aware
> > > >> >   PCI: imx6: add support for MSI
> > > >>
> > > >> What's the status of all these?  I would normally apply patches 4-8 of this
> > > >> series through my tree, given the appropriate acks, but I haven't seen
> > > >> those yet.  And I'm not sure what dependencies there are between the
> > > >> non-PCI patches and the PCI ones.
> > > >>
> > > > It's a complete binding change, so applying one part without the other
> > > > is going to horribly break things.
> > > >
> > > > So I would at least want to see an ack for the binding change on the
> > > > i.MX side from Shawn and Richard. This will need some follow on patches,
> > > > as some boards adding PCIe using the old binding have cropped up in
> > > > linux-next, but I can do the patches on short notice if everyone agrees
> > > > to merge this patchset.
> > > >
> > > > The designware part is pretty simple and doesn't change anything for
> > > > other users than i.MX. Though I would like to see an ack from Jingoo for
> > > > those.
> > > >
> > > > I have some more stuff in the pipes regarding multiple MSI irqs, that
> > > > depend on this series and also the Keystone people are waiting for this
> > > > to be applied in order to consolidate the clock handling of the
> > > > designware core driver, so it would be nice to get this moving again.
> > > 
> > > OK, just poke me again when you're ready for me to do something with these.
> > > 
> > 
> > As both Richard and Jingoo gave their ack for the respective patches I
> > think this is good to go in and I would expect all the PCI patches to go
> > through your tree for 3.16.
> > 
> > Shawn, if you are not okay with this change, please speak up now.
> > Otherwise please pick the dts change for 3.16. I'll go over linux-next
> > and prepare the patches to fix up the boards there.
> > 
> 
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
