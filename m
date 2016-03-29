Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57203 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcC2TkP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 15:40:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr =?utf-8?B?xaB0ZXRpYXI=?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
Date: Tue, 29 Mar 2016 21:39:20 +0200
Message-ID: <3601512.SumN6MaWDe@wuerfel>
In-Reply-To: <CAJ+vNU01JFRXSzF-0OhvyLds03mbbeBbw0by0dwuCotdxpDuog@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <3827347.i8fIQs6jUv@wuerfel> <CAJ+vNU01JFRXSzF-0OhvyLds03mbbeBbw0by0dwuCotdxpDuog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 March 2016 10:38:16 Tim Harvey wrote:
> On Tue, Mar 29, 2016 at 8:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 29 March 2016 08:10:08 Tim Harvey wrote:
> >> Arnd,
> >>
> >> Right, on the IMX the MSI interrupt is GIC-120 which is also the
> >> legacy INTD and I do see that if I happen to put a radio in a slot
> >> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
> >> does fire and the device works. Any other slot using GIC-123 (INTA),
> >> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
> >> that something in the designware core is masking out the legacy irqs.
> >
> > Interesting. I was actually expecting the opposite here, having the
> > IRQs only work if they are not IntD.
> >
> >
> >> I typically advise our users to 'not' enable MSI because
> >> architecturally you can spread 4 distinct legacy irq's across CPU's
> >> better than a single shared irq.
> >
> > That is a very good point, I never understood why we want to enable
> > MSI support on any PCI host bridge that just forwards all MSIs
> > to a single IRQ line. Originally MSI was meant as a performance
> > feature, but there is nothing in this setup that makes things go
> > faster, and several things that make it go slower.
> 
> I had a conversation once with Lucas about implementing the shared MSI
> interrupt in such a way that its smp affinity could be set to other
> CPU's to gain a performance benefit in certain multi-device cases.
> 
> While this is technically possible it would involve creating a softirq
> glue between the different handlers but that would add overhead of a
> softirq plus potentially waking up another CPU to every IRQ which
> would end up adding some overhead to even the simple single-device
> case.
> 
> Without any hard data it wasn't clear if this was worth it or if there
> was a clean way to provide this as build-time or run-time option.

I think it's pretty clear that this would take things from 'somewhat silly'
to 'completely bonkers' ;-)

	Arnd
