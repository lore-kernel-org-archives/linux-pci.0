Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:45042 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab3IPF5h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Sep 2013 01:57:37 -0400
Message-ID: <52369DCB.80101@kosagi.com>
Date: Mon, 16 Sep 2013 13:57:31 +0800
From: Sean Cross <xobs@kosagi.com>
MIME-Version: 1.0
To: Tim Harvey <tharvey@gateworks.com>
CC: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com> <1379065222-7275-4-git-send-email-xobs@kosagi.com> <CAJ+vNU2GGfW0SQV1NnROMBtN5V_ANrjLJw2_+tWCRDsYG8BEeQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU2GGfW0SQV1NnROMBtN5V_ANrjLJw2_+tWCRDsYG8BEeQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/9/13 7:50 AM, Tim Harvey wrote:
> Sean,
>
> Thanks for your work - I'm glad to see an i.MX6 PCIe host controller 
> driver finally getting some upstream attention!
>
> I've tested this under several scenarios and am running into some issues.
>
> I found that on an IMX6DL I had to enable the sata_ref_100m clock 
> additionally or a readl to the host address registers would hang (like 
> the core had no clock).  I've run into this before with the IMX6DL and 
> don't quite understand why the core would be clocked off the sata clock.
>
> When going through a switch (Gateworks GW5400-B has a PLX PEX8609 
> 8-port PCIe switch) I found that the CPU would randomly hang sometime 
> after bootup.  I found that installing an abort handler (from the 
> Freescale BSP) seemed to resolve this.  Additionally when going 
> through a switch, I could not read config space of the switch dev or 
> anything beyond it so it doesn't look like the driver supports 
> switches/bridges.
As Richard Zhu mentioned, all devices should have sata_ref_100m 
enabled.  I'll make this change in v5.

I don't have a PCIe switch handy, so I can't test your handler, but the 
reasoning does make sense.  I'll add the abort handler code into the 
driver.  I'd be curious to know if this is a Designware limitation, or 
if it's the sort of thing that this hardware is capable of supporting.

Freescale recommends using the SATA clock to drive the external bus.  I 
don't quite understand the reasoning, but it seems to have to do with a 
number of dividers and multipliers it goes through, some of which are 
fixed, and they all expect a 100 MHz clock.  They are starting to change 
the names of the clocks in the documentation from "SATA" and "PCIE" to 
"100Mhz" and "125Mhz" because of the ambiguity.

--
Sean Cross
