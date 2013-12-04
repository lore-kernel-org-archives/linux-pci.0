Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50668 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab3LDWBX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 17:01:23 -0500
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 2/7] [RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Wed, 4 Dec 2013 23:01:11 +0100
Cc: Pratyush Anand <pratyush.anand@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1385500248-6551-1-git-send-email-marex@denx.de> <20131204103307.GB2285@pratyush-vbox> <CAJ+vNU2Kz11AGAKDqi0Q=OgpOm9bVuvhDPSQgufhoemRfm7Xcw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2Kz11AGAKDqi0Q=OgpOm9bVuvhDPSQgufhoemRfm7Xcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312042301.11823.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 04, 2013 at 07:51:22 PM, Tim Harvey wrote:
> On Wed, Dec 4, 2013 at 2:33 AM, Pratyush Anand <pratyush.anand@st.com> wrote:
> > Hi Tim,
> > 
> >> In my configuration I have a PLX switch off the IMX root complex with
> >> several devices behind it.  I find that the devices enumerate
> >> correctly but as soon as data is transferred to or from (not sure
> >> which) the device the system hangs (INFO: rcu_sched detected stalls on
> >> CPUs/tasks: { 0} (detected by 3, t=2135 jiffies, g=20, c=19, q=66)).
> >> My current test case is a GigE ethernet device and when I connect a
> >> network to the device I hange when a packet is responded to.
> >> 
> >> I can't claim to fully understand PCI resource mappings or the iATU
> >> and I don't understand why dw_pcie_rd_other_conf/dw_pcie_wr_other_conf
> >> need to change the viewport then change it back instead of using
> >> multiple viewports (perhaps because some hardware may not have more
> >> than the 2 viewports currently being used?).  The current driver uses
> > 
> > Yes, driver has been written keeping in mind that there exist minimum
> > of two programmable outbound viewport.
> > 
> >> viewport0 for cfg0 and mem and viewport1 for cfg1 and io.  If I remove
> >> the call to dw_pcie_prog_viewport_io_outbound to reconfigure viewport1
> >> for io after its altered for type1 cfg cycles, devices behind the
> > 
> >> bridge work for me:
> > This is strange !!!
> > When you say it does not work, what exactly happens? What does kernel
> > crash log says? Which register access forces CPU to hang? Is it
> > possible to capture traffic with PCIe analyzer?
> 
> Pratyush,
> 
> The device behind the switch is a Marvell Yukon 2 GigE 88E8057:
> 
> $ lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0604: 10b5:8609 (rev ba)
> 01:00.1 0880: 10b5:8609 (rev ba)
> 02:01.0 0604: 10b5:8609 (rev ba)
> 02:04.0 0604: 10b5:8609 (rev ba)
> 02:05.0 0604: 10b5:8609 (rev ba)
> 02:06.0 0604: 10b5:8609 (rev ba)
> 02:07.0 0604: 10b5:8609 (rev ba)
> 02:08.0 0604: 10b5:8609 (rev ba)
> 02:09.0 0604: 10b5:8609 (rev ba)
> 07:00.0 0280: 168c:002b (rev 01)
> 08:00.0 0200: 11ab:4380
> $ lspci -s 08:00.0 -v
> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057
> PCI-E Gigabit Ethernet Controller
>         Subsystem: Marvell Technology Group Ltd. 88E8057 PCI-E Gigabit
> Ethernet Controller
>         Flags: bus master, fast devsel, latency 0, IRQ 155
>         Memory at 01200000 (64-bit, non-prefetchable) [size=16K]
>         I/O ports at 1000 [size=256]
>         Capabilities: [48] Power Management version 3
>         Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [c0] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [130] Device Serial Number 00-00-00-00-00-00-00-00
>         Kernel driver in use: sky2
> 
> $ ifconfig eth1
> eth1      Link encap:Ethernet  HWaddr 00:D0:12:9D:EF:E7
>           BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>           Interrupt:155
> 
> $ ifconfig eth1 up
> [   70.207493] sky2 0000:08:00.0 eth1: enabling interface
> [   70.212855] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> [   72.703741] sky2 0000:08:00.0 eth1: Link is up at 1000 Mbps, full
> duplex, flow control both
> [   72.712392] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> 
> board hangs here for several minutes then an rcu_sched stall is
> detected minutes later (I can't explain why the printk time below is
> wrong... it seems to within several minutes after the hang)
> 
> [   63.559915] INFO: rcu_sched detected stalls on CPUs/tasks: { 0}
> (detected by 1, t=2102 jiffies, g=4294967231, c=4294967230, q=10)
> 
> I do not have an anaylzer that can get on the PCIe bus.

I wonder, if you remove all IO space accesses from your Yukon driver, will the 
system hang as well? That way, we can be sure that the IO accesses are what 
kills the system.
