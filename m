Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8638C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A430021916
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbeLUNNv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:13:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44124 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387590AbeLUNNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 08:13:51 -0500
X-UUID: 1e3c602add0a4690a97d4c6255b9464f-20181221
X-UUID: 1e3c602add0a4690a97d4c6255b9464f-20181221
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1063640725; Fri, 21 Dec 2018 21:13:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 21:13:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 21:13:31 +0800
Message-ID: <1545398011.25199.43.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <ryder.lee@mediatek.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <youlin.pei@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <honghui.zhang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 21 Dec 2018 21:13:31 +0800
In-Reply-To: <20181218153232.GA6715@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
         <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
         <20181213145517.GB4701@google.com> <1545034779.8528.8.camel@mhfsdcap03>
         <20181217143247.GK20725@google.com>
         <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
         <1545124764.25199.3.camel@mhfsdcap03>
         <20181218153232.GA6715@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-12-18 at 15:32 +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 18, 2018 at 05:19:24PM +0800, Jianjun Wang wrote:
> > On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > > > > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > > > > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > > > > > guarantee the pcie devices will be enabled correctly.
> > > > > > 
> > > > > > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > > > > > to 0, and an IO BAR has bit 1 hardwired to 0.
> > > > > 
> > > > > Yes, it only works properly on 64bit platform.
> > > > 
> > > > I don't understand.  BARs are supposed to work the same regardless of
> > > > whether it's a 32- or 64-bit platform.  If this is a workaround for a
> > > > hardware defect, please just say that explicitly.
> > > 
> > > I do not understand this either. First thing to do is to describe the
> > > problem properly so that we can actually find a solution to it.
> > > 
> > > Lorenzo
> > 
> > This BAR0 is a 64-bit memory BAR, the HW default values for this BAR is
> > 0xffff_ffff_0000_0000 and it could not be changed except by config write
> > operation.
> > 
> > The calculated BAR size will be 0 in 32-bit platform since the
> > phys_addr_t is a 32bit value in 32-bit platform.
> > 
> > Actually MediaTek's HW does not using this BAR0, just omit it when
> > assign resource is totally fine.
> > 
> > When assign the resource for each device, software will check the
> > resource alignment first, and the resource of length zero will be
> > regarded as a bogus alignment resource, it will be ignored and won't
> > claim a resource parent for it.
> > 
> > When drivers try to enable the PCIe devices, the software will enable
> > it's resources, but it will return an error number when found a
> > unclaimed resource, in that case, the flow of enable devices will be
> > interrupted and PCIe devices won't work properly.
> 
> As a starting point, please provide kernel logs for both 64-bit and
> 32-bit platforms (without this patch applied) and also a:
> 
> cat /proc/iomem
> 
> and
> 
> lspci
> 
> output for both configurations.
> 
> Thanks,
> Lorenzo

I compared with the mt2712 platform, which is an arm64 platform, and the
EP deivce is an Intel e1000e NIC. Compiled these drivers to modules
(without this patch applied both), and insert them separately after
system startup.

After insert these modules, there will be an Ethernet device on both
platform, and the 64-bit platform works properly, but the 32-bit
platform doesn't.

1.The following logs is from the 64-bit platform (mt2712):

1.1. insmod pcie-mediatek.ko:
mtk-pcie 11700000.pcie: host bridge /pcie@11700000 ranges:
mtk-pcie 11700000.pcie:   MEM 0x20000000..0x2fffffff -> 0x20000000
mtk-pcie 11700000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x20000000-0x2fffffff]
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
reconfiguring
pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8 GT/s x1
link)
pci 0000:00:00.0: BAR 0: no space for [mem size 0x100000000 64bit pref]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x100000000 64bit
pref]
pci 0000:00:00.0: BAR 8: assigned [mem 0x20000000-0x200fffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
pci 0000:01:00.0: BAR 2: no space for [io  size 0x0020]
pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0020]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x20000000-0x200fffff]

1.2. insmod e1000e.ko:
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
pci 0000:00:00.0: enabling device (0000 -> 0002)
e1000e 0000:01:00.0: enabling device (0000 -> 0002)
e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic
conservative mode
e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1)
2c:53:4a:03:89:e9
e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF

1.3. lspci -xxx
00:00.0 Class 0604: Device 14c3:2712
00: c3 14 12 27 06 00 10 00 00 01 04 06 00 00 01 00
10: 0c 00 00 00 00 00 00 00 00 01 01 40 00 00 20 04
20: 00 20 00 20 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 60 61 12 02 00 00 00 00 00 00 00 00
50: 05 78 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 11 78 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 c3 01 08 00 00 00
80: 10 00 42 01 41 83 00 00 10 28 20 00 12 8c 60 01
90: 08 00 11 10 00 00 04 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 Class 0200: Device 8086:10d3
00: 86 80 d3 10 06 04 18 00 00 00 00 02 10 00 00 00
10: 00 00 0c 20 00 00 00 20 01 00 00 00 00 00 0e 20
20: 00 00 00 00 00 00 00 00 00 00 00 00 1a 1d 00 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 f3 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 11 00 04 80 03 00 00 00 03 20 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 14
d0: 05 e0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 a0 01 00 c1 8c 00 00 10 28 10 00 11 1c 03 01
f0: 00 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00

1.4 lspci -v
00:00.0 Class 0604: Device 14c3:2712 (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Memory at <unassigned> (64-bit, prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: 20000000-200fffff [size=1M]
	Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Root Port (Slot+), MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [400] L1 PM Substates
	Capabilities: [600] Latency Tolerance Reporting

01:00.0 Class 0200: Device 8086:10d3
	Subsystem: Device 1d1a:0000
	Flags: bus master, fast devsel, latency 0, IRQ 243
	Memory at 200c0000 (32-bit, non-prefetchable) [size=128K]
	Memory at 20000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at <unassigned> [disabled]
	Memory at 200e0000 (32-bit, non-prefetchable) [size=16K]
	[virtual] Expansion ROM at 20080000 [disabled] [size=256K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [e0] Express Endpoint, MSI 00
	Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 2c-53-4a-ff-ff-03-89-e9
	Kernel driver in use: e1000e

1.5. cat /proc/iomem
20000000-2fffffff : pcie@11700000
  20000000-200fffff : PCI Bus 0000:01
    20000000-2007ffff : 0000:01:00.0
      20000000-2007ffff : e1000e
    20080000-200bffff : 0000:01:00.0
    200c0000-200dffff : 0000:01:00.0
      200c0000-200dffff : e1000e
    200e0000-200e3fff : 0000:01:00.0
      200e0000-200e3fff : e1000e

2. The following logs is from the 32-bit platform (mt7629):

2.1. insmod pcie-mediatek.ko
mtk-pcie 1a140000.pcie: host bridge /pcie@1a140000 ranges:
mtk-pcie 1a140000.pcie:   MEM 0x20000000..0x2fffffff -> 0x20000000
mtk-pcie 1a140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x20000000-0x2fffffff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),
reconfiguring
pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s x1 link at 0000:00:01.0 (capable of 7.876 Gb/s with 8 GT/s x1
link)
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 0: [mem 0x00000000-0xffffffff 64bit pref] has
bogus alignment
pci 0000:00:01.0: BAR 8: assigned [mem 0x20000000-0x200fffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
pci 0000:01:00.0: BAR 2: no space for [io  size 0x0020]
pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0020]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0x20000000-0x200fffff]

2.2. insmod e1000e.ko
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0xffffffff
64bit pref] not claimed
pci 0000:00:01.0: Error enabling bridge (-22), continuing
e1000e 0000:01:00.0: enabling device (0140 -> 0142)
e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic
conservative mode
e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1)
2c:53:4a:03:89:e9
e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF

2.3. lspci -xxx
00:01.0 Class 0604: Device 14c3:7629
00: c3 14 29 76 40 01 10 00 00 01 04 06 10 00 01 00
10: 0c 00 00 00 00 00 00 00 00 01 01 40 00 00 20 04
20: 00 20 00 20 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 01 00
40: 00 00 00 00 60 61 12 02 00 00 00 00 00 00 00 00
50: 05 78 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 11 78 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 c3 01 08 00 00 00
80: 10 00 42 01 41 83 00 00 10 28 20 00 22 8c 60 01
90: 08 00 11 10 00 00 04 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 Class 0200: Device 8086:10d3
00: 86 80 d3 10 40 01 10 00 00 00 00 02 10 00 00 00
10: 00 00 0c 20 00 00 00 20 01 00 00 00 00 00 0e 20
20: 00 00 00 00 00 00 00 00 00 00 00 00 1a 1d 00 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 11 00 04 00 03 00 00 00 03 20 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 14
d0: 05 e0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 a0 01 00 c1 8c 00 00 10 28 10 00 11 1c 03 01
f0: 00 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00

2.4. lspci -v
00:01.0 Class 0604: Device 14c3:7629 (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Memory at <unassigned> (64-bit, prefetchable) [disabled] [size=4G]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: 20000000-200fffff [size=1M]
	Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Root Port (Slot+), MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [400] L1 PM Substates
	Capabilities: [600] Latency Tolerance Reporting

01:00.0 Class 0200: Device 8086:10d3
	Subsystem: Device 1d1a:0000
	Flags: bus master, fast devsel, latency 0, IRQ 110
	Memory at 200c0000 (32-bit, non-prefetchable) [size=128K]
	Memory at 20000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at <unassigned> [disabled]
	Memory at 200e0000 (32-bit, non-prefetchable) [size=16K]
	[virtual] Expansion ROM at 20080000 [disabled] [size=256K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [e0] Express Endpoint, MSI 00
	Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 2c-53-4a-ff-ff-03-89-e9
	Kernel driver in use: e1000e

2.5. cat /proc/iomem
20000000-2fffffff : pcie@1a140000
  20000000-200fffff : PCI Bus 0000:01
    20000000-2007ffff : 0000:01:00.0
      20000000-2007ffff : e1000e
    20080000-200bffff : 0000:01:00.0
    200c0000-200dffff : 0000:01:00.0
      200c0000-200dffff : e1000e
    200e0000-200e3fff : 0000:01:00.0
      200e0000-200e3fff : e1000e

Thanks.

