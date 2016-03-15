Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56691 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbcCOOEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 10:04:35 -0400
Date: Tue, 15 Mar 2016 09:04:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
Message-ID: <20160315140431.GE19974@localhost>
References: <56D80435.90408@tekno-soft.it>
 <DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D8180A.1050708@tekno-soft.it>
 <56D84B6D.1050800@tekno-soft.it>
 <56D883AD.5060601@tekno-soft.it>
 <56DEE426.8030902@tekno-soft.it>
 <1457448829.3207.22.camel@pengutronix.de>
 <56E1B04A.9010206@tekno-soft.it>
 <56E679FE.20409@tekno-soft.it>
 <56E7ED1E.3070506@tekno-soft.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E7ED1E.3070506@tekno-soft.it>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 12:08:14PM +0100, Roberto Fichera wrote:
> On 03/14/2016 09:44 AM, Roberto Fichera wrote:
> > On 03/10/2016 06:35 PM, Roberto Fichera wrote:
> >> > On 03/08/2016 03:53 PM, Lucas Stach wrote:
> >>> >> Am Dienstag, den 08.03.2016, 15:39 +0100 schrieb Roberto Fichera:
> >>>>> >>>> On 03/03/2016 07:34 PM, Roberto Fichera wrote:
> >>>>>>> >>>>>> On 03/03/2016 03:34 PM, Roberto Fichera wrote:
> >>>>>>> >>>>>>
> >>>>>>> >>>>>> I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
> >>>>>>> >>>>>> and exactly equal to uboot settings.
> >>>>>>> >>>>>>
> >>>>>>> >>>>>> However I'm investigating a possible HW issue in the LDVS pad wiring against
> >>>>>>> >>>>>> the bridge XIO2001. Let's see once this is also clarified.
> >>>>> >>>> Our HW engineer has applied a fix to LVDS vs XIO2001 clock wiring. However I'm still getting the same problem.
> >>>>> >>>>
> >>>>> >>>> I've tried to boot a kernel with uboot not setting up the PCIe subsys and below there is the resulting kernel log.
> >>>>> >>>> Note that the CCGR5 doesn't set the CG2 field associated to sata_clk_enable. I think this field should be set all 1 to
> >>>>> >>>> enable the SATA ref at 100MHz, right?
> >>>>> >>>>
> >>> >> No, the reference manual is a bit confusing about this, but the LVDS1
> >>> >> clock output is driven by sata_ref_100mhz, not the sata_clk gate.
> >>> >>
> >>> >> So the only thing that needs to be enabled for LVDS clock output is the
> >>> >> 100MHz clock output from PLL ENET. (Register CCM_ANALOG_PLL_ENETn bit
> >>> >> 20).
> >> > Guys! No more idea where to look at! Still getting PCIe link reaching L0 state under
> >> > uboot but doesn't progress more than POLL_ACTIVE or POLL_COMPLIANCE states
> >> > under kernel.
> >> >
> >> > Any idea what to do?
> 
> Just to say that I've fixed the problem by asserting PERST before to drop PCIe refclk and enable
> power down. PERST is finally released at the usual place.

Glad to hear that.

> [    0.237473] PCI host bridge /soc/pcie@0x01000000 ranges:
> [    0.237494]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> [    0.237545]   err 0x01f00000..0x01f7ffff -> 0x01f00000
> [    0.237585]    IO 0x01f80000..0x01f8ffff -> 0x00000000
> [    0.237671]   MEM 0x01000000..0x01efffff -> 0x01000000
> [    0.353847] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
> [    0.353866] imx6q-pcie 1ffc000.pcie: Link up, Gen=1
> [    0.354441] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.354465] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.354483] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]

Looks like some kind of bug here.

> [    0.354499] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.354513] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> [    0.354640] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    0.354707] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.354745] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    0.354932] pci 0000:00:00.0: supports D1
> [    0.354952] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.355713] PCI: bus0: Fast back to back transfers disabled
> [    0.356139] pci 0000:01:00.0: [104c:8240] type 01 class 0x060400
> [    0.356688] pci 0000:01:00.0: supports D1 D2
> [    0.369318] PCI: bus1: Fast back to back transfers disabled

What an anachronism to see these "Fast back to back transfers"
messages on a PCIe system where Fast Back-to-Back is meaningless.
That code in pcibios_fixup_bus() was always generic code that should
have been in the PCI core rather than in arch-specific code.  It'd be nice
if somebody would clean that up someday.

Bjorn
