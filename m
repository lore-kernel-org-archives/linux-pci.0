Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:44204 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbcCOLIh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 07:08:37 -0400
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Lucas Stach <l.stach@pengutronix.de>
References: <56D5E3DF.9030906@tekno-soft.it> <56D71F27.7070708@tekno-soft.it>
 <20160302195634.GA19223@localhost>
 <DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D80435.90408@tekno-soft.it>
 <DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D8180A.1050708@tekno-soft.it> <56D84B6D.1050800@tekno-soft.it>
 <56D883AD.5060601@tekno-soft.it> <56DEE426.8030902@tekno-soft.it>
 <1457448829.3207.22.camel@pengutronix.de> <56E1B04A.9010206@tekno-soft.it>
 <56E679FE.20409@tekno-soft.it>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Fabio Estevam <festevam@gmail.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56E7ED1E.3070506@tekno-soft.it>
Date: Tue, 15 Mar 2016 12:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <56E679FE.20409@tekno-soft.it>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/14/2016 09:44 AM, Roberto Fichera wrote:
> On 03/10/2016 06:35 PM, Roberto Fichera wrote:
>> > On 03/08/2016 03:53 PM, Lucas Stach wrote:
>>> >> Am Dienstag, den 08.03.2016, 15:39 +0100 schrieb Roberto Fichera:
>>>>> >>>> On 03/03/2016 07:34 PM, Roberto Fichera wrote:
>>>>>>> >>>>>> On 03/03/2016 03:34 PM, Roberto Fichera wrote:
>>>>>>> >>>>>>
>>>>>>> >>>>>> I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
>>>>>>> >>>>>> and exactly equal to uboot settings.
>>>>>>> >>>>>>
>>>>>>> >>>>>> However I'm investigating a possible HW issue in the LDVS pad wiring against
>>>>>>> >>>>>> the bridge XIO2001. Let's see once this is also clarified.
>>>>> >>>> Our HW engineer has applied a fix to LVDS vs XIO2001 clock wiring. However I'm still getting the same problem.
>>>>> >>>>
>>>>> >>>> I've tried to boot a kernel with uboot not setting up the PCIe subsys and below there is the resulting kernel log.
>>>>> >>>> Note that the CCGR5 doesn't set the CG2 field associated to sata_clk_enable. I think this field should be set all 1 to
>>>>> >>>> enable the SATA ref at 100MHz, right?
>>>>> >>>>
>>> >> No, the reference manual is a bit confusing about this, but the LVDS1
>>> >> clock output is driven by sata_ref_100mhz, not the sata_clk gate.
>>> >>
>>> >> So the only thing that needs to be enabled for LVDS clock output is the
>>> >> 100MHz clock output from PLL ENET. (Register CCM_ANALOG_PLL_ENETn bit
>>> >> 20).
>> > Guys! No more idea where to look at! Still getting PCIe link reaching L0 state under
>> > uboot but doesn't progress more than POLL_ACTIVE or POLL_COMPLIANCE states
>> > under kernel.
>> >
>> > Any idea what to do?

Just to say that I've fixed the problem by asserting PERST before to drop PCIe refclk and enable
power down. PERST is finally released at the usual place.

[    0.237473] PCI host bridge /soc/pcie@0x01000000 ranges:
[    0.237494]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
[    0.237545]   err 0x01f00000..0x01f7ffff -> 0x01f00000
[    0.237585]    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.237671]   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.353847] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.353866] imx6q-pcie 1ffc000.pcie: Link up, Gen=1
[    0.354441] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.354465] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.354483] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
[    0.354499] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.354513] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.354640] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.354707] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.354745] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.354932] pci 0000:00:00.0: supports D1
[    0.354952] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.355713] PCI: bus0: Fast back to back transfers disabled
[    0.356139] pci 0000:01:00.0: [104c:8240] type 01 class 0x060400
[    0.356688] pci 0000:01:00.0: supports D1 D2
[    0.369318] PCI: bus1: Fast back to back transfers disabled
[    0.369347] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.369844] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
[    0.377975] pci 0000:02:04.0: [1397:08b4] type 00 class 0x020400
[    0.378120] pci 0000:02:04.0: reg 0x10: [io  0x0000-0x0007]
[    0.378174] pci 0000:02:04.0: reg 0x14: [mem 0x00000000-0x00000fff]
[    0.378536] pci 0000:02:04.0: supports D1 D2
[    0.378550] pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot
[    0.379453] PCI: bus2: Fast back to back transfers disabled
[    0.379474] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.379494] pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 01] (conflicts with (null) [bus 01])
[    0.379524] pci_bus 0000:02: [bus 02] partially hidden behind bridge 0000:01 [bus 01]
[    0.379548] pci 0000:00:00.0: bridge has subordinate 01 but max busn 02
[    0.379837] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.379865] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.379884] pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
[    0.379900] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.379927] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.379942] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.379963] pci 0000:02:04.0: BAR 1: assigned [mem 0x01100000-0x01100fff]
[    0.379998] pci 0000:02:04.0: BAR 0: assigned [io  0x1000-0x1007]
[    0.380030] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.380054] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    0.380091] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.380149] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.380164] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.380183] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.380950] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    0.380970] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.380983] pci 0000:02:04.0: Signaling PME through PCIe PME interrupt
[    0.381003] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
[    0.381407] aer 0000:00:00.0:pcie02: service driver aer loaded

