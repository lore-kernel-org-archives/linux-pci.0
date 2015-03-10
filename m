Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:55232
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751911AbbCJC3C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 22:29:02 -0400
From: "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>
To: Tord Andersson <tord.andersson@endian.se>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>
Subject: RE: iMX6 PCIe gen 2 card compatibility
Date: Tue, 10 Mar 2015 01:54:39 +0000
Message-ID: <DM2PR0301MB086247D8F9781E7BE3A1C0A2F7180@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <8B884B45-776A-4C9E-B539-B973D6A46128@endian.se>
In-Reply-To: <8B884B45-776A-4C9E-B539-B973D6A46128@endian.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No, it's not common for all gen2 cards.
I used the xhci(one, pcie2usb3.0) ep device, this device works well on gen2 speed.

Best Regards
Richard Zhu
Linux BSP team

> -----Original Message-----
> From: Tord Andersson [mailto:tord.andersson@endian.se]
> Sent: Tuesday, March 10, 2015 12:25 AM
> To: linux-pci@vger.kernel.org
> Cc: Zhu Richard-R65037; l.stach@pengutronix.de; bhelgaas@google.com;
> Estevam Fabio-R49496
> Subject: iMX6 PCIe gen 2 card compatibility
> 
> I have done some tests on a PCIe gen 2 based USB3380 card on an IMX6Q-
> based reference board using the latest mainline kernel with the
> associated net2280 driver.
> The only way, at the moment to make it work is to force gen 1 link
> speed.
> Is this common for all gen 2 cards?
> Are there fixes or patches available that will make it possible to
> reenable gen 2?
> I wonder if this problem might be caused by iMX6 errata ERR005184 -
> "PCIe: Clock pointers can lose sync during clock rate changes"?
> 
> BR,
> 
> Tord
