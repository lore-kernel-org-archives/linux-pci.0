Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43571 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755191AbbLVM23 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 07:28:29 -0500
Message-ID: <1450787306.2637.3.camel@pengutronix.de>
Subject: Re: IMX6 PCIe - use LVDS2 clock as input instead of LVDS1 as an
 ouput
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawn.guo@linaro.org>, Sean Cross <xobs@kosagi.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Tue, 22 Dec 2015 13:28:26 +0100
In-Reply-To: <CAJ+vNU1RhaJrrwznkfpPdmu8BSLifvRXt=5yK3C=WqqT-G1BoQ@mail.gmail.com>
References: <CAJ+vNU1RhaJrrwznkfpPdmu8BSLifvRXt=5yK3C=WqqT-G1BoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

Am Montag, den 21.12.2015, 13:05 -0800 schrieb Tim Harvey:
> Lucas / Shawn / Sean,
> 
> Do any of you know what should be done in order to use the LVDS2
> clock
> as an 'input' for IMX6 PCIe?
> 
> Due to the fact that Freescale's internal clock does not pass Gen2
> jitter tests, we have designed an IMX6 based board that follows
> Freescale's recommendation to use an external Gen2 compliant clockgen
> running to one of the LVDS clocks and now need to configure the
> kernel
> to use this as an input. I had this run to LVDS2 because LVDS1 is
> configured by the kernel as a clock output for all IMX6 (see
> 74b8031307c5d33d36742c26dd0921991bd5a255).
> 
> My understanding is that if nothing is changed the host controller
> would use its internal reference clock, and the PCIe socket would use
> the external clkgen and all would be well and fine for Gen1 because
> they don't need to have synchronized clocks, but if Gen2 is needed we
> must change the clock routing such that LVDS2 is an input and that it
> is routed to the PCIe host controller reference clock.
> 
> I know that I can use IMX6QDL_CLK_LVDS2_IN instead of
> IMX6QDL_CLK_LVDS1_GATE in the clocks property of the PCIe node in the
> device-tree to configure LVDS2 as an input instead of LVDS1 as an
> output, but I'm not sure what to do with the rest of the clock tree
> and how to handle this dynamically at runtime.
> 
> Any ideas would be greatly appreciated.
> 
What you would need to do is the following, I think:

1. Overwrite the PCIe node clocks property in your board as described
above.

2. Set up the right connections in the clock tree by using the
"assigned-clocks" property attached to the PCIe node. This might need
some additions to the imx6 clock controller so you can attach the
external clockgen (abstracted as fixed-clock) as a parent to
the IMX6QDL_CLK_LVDS2_IN.

Regards,
Lucas
