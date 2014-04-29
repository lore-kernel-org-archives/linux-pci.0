Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44356 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933607AbaD2Mcv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 08:32:51 -0400
Message-ID: <1398774686.4677.12.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marek Vasut <marex@denx.de>, linux-samsung-soc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	Sean Cross <xobs@kosagi.com>,
	Tim Harvey <tharvey@gateworks.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Date: Tue, 29 Apr 2014 14:31:26 +0200
In-Reply-To: <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
	 <20140424175844.GD29593@google.com>
	 <1398421265.4657.25.camel@weser.hi.pengutronix.de>
	 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Freitag, den 25.04.2014, 08:39 -0600 schrieb Bjorn Helgaas:
[...]
> >> >   PCI: designware: split Exynos and i.MX bindings
> >> >   ARM: dts: imx6: update pcie to bring in line with new binding
> >> >   PCI: imx6: use new clock names
> >> >   PCI: imx6: drop old irq mapping
> >> >   PCI: imx6: rip out optional (and unused) irqs
> >> >   PCI: designware: make MSI isr shared irq aware
> >> >   PCI: imx6: add support for MSI
> >>
> >> What's the status of all these?  I would normally apply patches 4-8 of this
> >> series through my tree, given the appropriate acks, but I haven't seen
> >> those yet.  And I'm not sure what dependencies there are between the
> >> non-PCI patches and the PCI ones.
> >>
> > It's a complete binding change, so applying one part without the other
> > is going to horribly break things.
> >
> > So I would at least want to see an ack for the binding change on the
> > i.MX side from Shawn and Richard. This will need some follow on patches,
> > as some boards adding PCIe using the old binding have cropped up in
> > linux-next, but I can do the patches on short notice if everyone agrees
> > to merge this patchset.
> >
> > The designware part is pretty simple and doesn't change anything for
> > other users than i.MX. Though I would like to see an ack from Jingoo for
> > those.
> >
> > I have some more stuff in the pipes regarding multiple MSI irqs, that
> > depend on this series and also the Keystone people are waiting for this
> > to be applied in order to consolidate the clock handling of the
> > designware core driver, so it would be nice to get this moving again.
> 
> OK, just poke me again when you're ready for me to do something with these.
> 

As both Richard and Jingoo gave their ack for the respective patches I
think this is good to go in and I would expect all the PCI patches to go
through your tree for 3.16.

Shawn, if you are not okay with this change, please speak up now.
Otherwise please pick the dts change for 3.16. I'll go over linux-next
and prepare the patches to fix up the boards there.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

