Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:53668 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933863AbcCNIpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2016 04:45:08 -0400
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Fabio Estevam <festevam@gmail.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56E679FE.20409@tekno-soft.it>
Date: Mon, 14 Mar 2016 09:44:46 +0100
MIME-Version: 1.0
In-Reply-To: <56E1B04A.9010206@tekno-soft.it>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/10/2016 06:35 PM, Roberto Fichera wrote:
> On 03/08/2016 03:53 PM, Lucas Stach wrote:
>> Am Dienstag, den 08.03.2016, 15:39 +0100 schrieb Roberto Fichera:
>>>> On 03/03/2016 07:34 PM, Roberto Fichera wrote:
>>>>>> On 03/03/2016 03:34 PM, Roberto Fichera wrote:
>>>>>>
>>>>>> I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
>>>>>> and exactly equal to uboot settings.
>>>>>>
>>>>>> However I'm investigating a possible HW issue in the LDVS pad wiring against
>>>>>> the bridge XIO2001. Let's see once this is also clarified.
>>>> Our HW engineer has applied a fix to LVDS vs XIO2001 clock wiring. However I'm still getting the same problem.
>>>>
>>>> I've tried to boot a kernel with uboot not setting up the PCIe subsys and below there is the resulting kernel log.
>>>> Note that the CCGR5 doesn't set the CG2 field associated to sata_clk_enable. I think this field should be set all 1 to
>>>> enable the SATA ref at 100MHz, right?
>>>>
>> No, the reference manual is a bit confusing about this, but the LVDS1
>> clock output is driven by sata_ref_100mhz, not the sata_clk gate.
>>
>> So the only thing that needs to be enabled for LVDS clock output is the
>> 100MHz clock output from PLL ENET. (Register CCM_ANALOG_PLL_ENETn bit
>> 20).
> Guys! No more idea where to look at! Still getting PCIe link reaching L0 state under
> uboot but doesn't progress more than POLL_ACTIVE or POLL_COMPLIANCE states
> under kernel.
>
> Any idea what to do?

Good progress! Once kernel booted, I'm still getting the usual PCIe link not coming up:


[    0.236946] PCI host bridge /soc/pcie@0x01000000 ranges:
[    0.236969]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
[    0.237018]   err 0x01f00000..0x01f7ffff -> 0x01f00000
[    0.237056]    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.237140]   MEM 0x01000000..0x01efffff -> 0x01000000
[    3.339021] imx6q-pcie 1ffc000.pcie: phy link never came up
[    3.339599] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    3.339622] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.339642] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
[    3.339659] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    3.339672] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]

but when I trigger a pcie bus rescan with an "echo 1 > /sys/bus/pci/rescan" then I finally get:

root@voneus-janas-imx6q:/sys/bus/pci# echo 1 > rescan
[  12.306722] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[  12.321690] PCI: bus2: Fast back to back transfers disabled
[  12.327421] pci_bus 0000:02: [bus 02] partially hidden behind bridge 0000:01 [bus 01]
[  12.335377] pcieport 0000:00:00.0: bridge has subordinate 01 but max busn 02
[  12.342691] pcieport 0000:00:00.0: BAR 8: assigned [mem 0x01200000-0x012fffff]
[  12.350041] pcieport 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[  12.356754] pci 0000:01:00.0: BAR 8: assigned [mem 0x01200000-0x012fffff]
[  12.363650] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[  12.369858] pci 0000:02:04.0: BAR 1: assigned [mem 0x01200000-0x01200fff]
[  12.376715] pci 0000:02:04.0: BAR 0: assigned [io  0x1000-0x1007]
[  12.382939] pci 0000:01:00.0: PCI bridge to [bus 02]
[  12.387960] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[  12.394182] pci 0000:01:00.0:   bridge window [mem 0x01200000-0x012fffff]

root@voneus-janas-imx6q:/sys/bus/pci# lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 290
        Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
        Capabilities: [70] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Kernel driver in use: pcieport
lspci: Unable to load libkmod resources: error -12

01:00.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge (prog-if 00 [Normal decode])
        Flags: fast devsel
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01200000-012fffff
        Capabilities: [40] Subsystem: Device 0000:0000
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/16 Maskable- 64bit+
        Capabilities: [70] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
        Capabilities: [100] Advanced Error Reporting

02:04.0 ISDN controller: Cologne Chip Designs GmbH ISDN network Controller [HFC-4S] (rev 01)
        Subsystem: Cologne Chip Designs GmbH HFC-4S [OpenVox B200P / B400P]
        Flags: medium devsel, IRQ 255
        I/O ports at 1000 [disabled] [size=8]
        Memory at 01200000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [40] Power Management version 2

I've also tried to increase the polling loop timeout, but doesn't change anything.

Any suggestion?

>
> Cheers,
> Roberto Fichera.


