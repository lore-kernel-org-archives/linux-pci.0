Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48524 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136AbcC2Izs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 04:55:48 -0400
Message-ID: <1459241739.2565.9.camel@pengutronix.de>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 29 Mar 2016 10:55:39 +0200
In-Reply-To: <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	 <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	 <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 28.03.2016, 15:06 -0700 schrieb Tim Harvey:
> On Mon, Mar 28, 2016 at 2:30 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Mar 28, 2016 at 5:42 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> >> Fabio,
> >>
> >> ok - I'll respond there as I agree with the patch but not the wording
> >> of the commit (It's Gateworks 'Ventana' using IMX6 not Laguna and we
> >> do define the polarity properly as active-low in Ventana dt's). It is
> >> the fact that the gpio polarity has the wrong logic level that breaks
> >> Ventana.
> >
> > Ok, I will change the wording in v2.
> >
> >>
> >> However, there seems to be another regression in 4.5 that's keeping
> >> PCI working for me and I'm still bisecting that (using 802.11n access
> >> points to test). Can you confirm that PCI works in v4.5 on IMX6 boards
> >> with only 5c5fb40de8f14391a1238db05cef88754faf9229 reverted?
> >
> > On imx6qdl-sabresd.dtsi the PCI reset gpio polarity is set to high,
> > which is not correct, so the Wifi card could be detected even with
> > 5c5fb40de8f. So two errors in sequence and PCI still works on this
> > board :-)
> 
> ouch - two wrongs did make a right!
> 
> It's not too easy to tell how many IMX6 boards incorrectly specify
> their reset-gpio polarity. I don't know what the best way to determine
> what boards use the IMX6 pcie host controller. Is there a dtc usage
> that will display the compiled dtb's then we grep out 'compatible =
> "fsl,imx6q-pcie"' to at least get the list of boards to inspect? I'm
> curious if its just one or two boards that incorrectly specify the
> polarity of their PCI reset.
> 
I would suspect that most boards specify the reset polarity the wrong
way around. Fixing this without breaking DT stability is hard. OTOH we
could just argue that the system description in DT is wrong and needs to
be fixed.

> >
> > I don't have access to the board at the moment, but the only test I
> > did was to see that the Wifi card got detected. I haven't really tried
> > to communicate via Wifi.
> 
> I figured out it was the change to enable CONFIG_PCI_MSI in v4.5 that
> is causing interrupts to fail for me.
> 
Is this working with v4.4 and PCI_MSI enabled? I'm sure I've tested MSI
IRQs before enabling them in the defconfig and they have been working
for me for a long time before that. Tested with i210 on Gateworks
Ventana.

> Lucas, the case that is failing for me is when I have 4 miniPCI radios
> behind a PCIe->PCI bridge. In this case the radios get legacy
> INTA/B/C/D mapped to them correctly from what I can tell (GIC
> 123/122/121/120 swizzled appropriately), but those interrupts never
> fire. I don't think this case is necessarily a regression, I'm not
> clear that it has ever worked. In fact I can't seem to come up with a
> scenario where the MSI irq is firing either: IMX6->ath9k radio (no
> bridge) with MSI doesn't fire the PCI-MSI interrupt or the GPC 123
> interrupt that gets mapped to it via the driver. Any ideas what can be
> going on here?
> 
Please test if MSI IRQs work with v4.4. I'll take a look at this later
today.

Regards,
Lucas

