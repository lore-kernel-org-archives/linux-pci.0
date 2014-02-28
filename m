Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53755 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaB1KUN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 05:20:13 -0500
Message-ID: <1393582776.5219.2.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v3 2/3] ARM: dts: imx6: extend PCIe interrupt list for
 MSI
From: Lucas Stach <l.stach@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de
Date: Fri, 28 Feb 2014 11:19:36 +0100
In-Reply-To: <6495086.OFxrshKaiu@wuerfel>
References: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
	 <1393519305-15128-2-git-send-email-l.stach@pengutronix.de>
	 <6495086.OFxrshKaiu@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Am Donnerstag, den 27.02.2014, 17:44 +0100 schrieb Arnd Bergmann:
> On Thursday 27 February 2014 17:41:44 Lucas Stach wrote:
> >                         num-lanes = <1>;
> > -                       interrupts = <0 123 0x04>;
> > +                       interrupt-names = "inta", "intb", "intc", "intd/msi";
> > +                       interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
> >                         clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
> > 
> 
> The standard PCI interrupts should not be listed here, you need to
> put them into the "interrupt-map" property so the of_irq_parse_and_map_pci()
> function can translate them.
> 
> 	Arnd

So as INTA is already listed and implemented in the driver this way,
this means the binding is totally bogus (taking into account that it
didn't match the documented designware binding in more places).

I wonder if we should just break the binding to sort things out, given
that there are not that many users of imx-pcie yet.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

