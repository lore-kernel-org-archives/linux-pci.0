Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:52119 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaB1KWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 05:22:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/3] ARM: dts: imx6: extend PCIe interrupt list for MSI
Date: Fri, 28 Feb 2014 11:22:26 +0100
Message-ID: <59506012.lKQmfIR71j@wuerfel>
In-Reply-To: <1393582776.5219.2.camel@weser.hi.pengutronix.de>
References: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de> <6495086.OFxrshKaiu@wuerfel> <1393582776.5219.2.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 28 February 2014 11:19:36 Lucas Stach wrote:
> Am Donnerstag, den 27.02.2014, 17:44 +0100 schrieb Arnd Bergmann:
> > On Thursday 27 February 2014 17:41:44 Lucas Stach wrote:
> > >                         num-lanes = <1>;
> > > -                       interrupts = <0 123 0x04>;
> > > +                       interrupt-names = "inta", "intb", "intc", "intd/msi";
> > > +                       interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
> > >                         clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
> > > 
> > 
> > The standard PCI interrupts should not be listed here, you need to
> > put them into the "interrupt-map" property so the of_irq_parse_and_map_pci()
> > function can translate them.
> > 
> 
> So as INTA is already listed and implemented in the driver this way,
> this means the binding is totally bogus (taking into account that it
> didn't match the documented designware binding in more places).
> 
> I wonder if we should just break the binding to sort things out, given
> that there are not that many users of imx-pcie yet.

That may be best, yes. If we have to provide backwards compatibility,
the driver can have a fallback for the case where no interrupt-map
property is present, but it should not try to handle multiple
interrupt lines that way, only the trivial case where you have a single
IntA line for all devices.

	Arnd
