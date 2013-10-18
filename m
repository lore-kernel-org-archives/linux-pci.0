Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:1875 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072Ab3JRHpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Oct 2013 03:45:15 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>
CC: Sean Cross <xobs@kosagi.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-2?Q?Marek_Va=B9ut?= <marex@denx.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Subject: RE: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Fri, 18 Oct 2013 07:45:09 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
	<CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
	<0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
In-Reply-To: <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi


> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Tim Harvey
> Sent: Friday, October 18, 2013 3:28 PM
> To: Zhu Richard-R65037
> Cc: Sean Cross; devicetree@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; Sascha Hauer; Shawn Guo; Bjorn Helgaas; Marek
> Va¹ut; Jingoo Han; Pratyush Anand; Troy Kisky
> Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
> 
> On Thu, Oct 17, 2013 at 11:34 PM, Zhu Richard-R65037 <r65037@freescale.com>
> wrote:
> 
> [...]
> 
> > Hi Tim:
> > Regarding to my experience, the difference shouldn't be related with the bus
> hang.
> > Here are my DT region setup when I trying to bring up imx6 pcie on 3.1x
> kernel by my own driver.
> >                         clock-names = "pcie_axi", "pcie_ref", "pcie_bus_in",
> "pcie_bus_out";
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> >                         ranges = <0x00000800 0 0x01f00000 0x01f00000 0
> 0x00080000   /* configuration space */
> >                                   0x81000000 0 0          0x01f80000 0
> 0x00010000   /* downstream I/O */
> >                                   0x82000000 0 0x01000000 0x01000000 0
> 0x00f00000>; /* non-prefetchable memory */
> >                         num-lanes = <1>;
> >
> > It works sometimes, although that there is random kernel panic and
> > system hang(log is pasted below):( LOGS, when pericom's PI7C9X2G303EL and
> Intel e1000e network card is used.
> > ...
> > imx-pcie 1ffc000.pcie: legacy_irq 155
> > imx-pcie 1ffc000.pcie: map [mem 0x01ffc000-0x01ffffff] IMX PCIe port:
> > link up.
> > PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [io  0x1000-0x10000] pci_bus
> > 0000:00: root bus resource [mem 0x01000000-0x01efffff] pci_bus
> > 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> > PCI: bus0: Fast back to back transfers disabled
> > PCI: bus1: Fast back to back transfers disabled pci 0000:01:00.0:
> > bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus2: Fast back to back transfers disabled pci 0000:02:01.0:
> > bridge configuration invalid ([bus 00-00]), reconfiguring pci
> > 0000:02:02.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > PCI: bus3: Fast back to back transfers disabled
> > PCI: bus4: Fast back to back transfers enabled pci 0000:00:00.0: BAR
> > 0: assigned [mem 0x01000000-0x010fffff 64bit] pci 0000:00:00.0: BAR 8:
> > assigned [mem 0x01100000-0x012fffff] pci 0000:00:00.0: BAR 6: assigned
> > [mem 0x01300000-0x0130ffff pref] pci 0000:00:00.0: BAR 7: assigned [io
> > 0x1000-0x1fff] pci 0000:01:00.0: BAR 8: assigned [mem
> > 0x01100000-0x012fffff] pci 0000:01:00.0: BAR 7: assigned [io
> > 0x1000-0x1fff] pci 0000:02:01.0: BAR 8: assigned [mem
> > 0x01100000-0x012fffff] pci 0000:02:01.0: BAR 7: assigned [io
> > 0x1000-0x1fff] pci 0000:03:00.0: BAR 1: assigned [mem
> > 0x01100000-0x011fffff] pci 0000:03:00.0: BAR 0: assigned [mem
> > 0x01200000-0x0121ffff] pci 0000:03:00.0: BAR 3: assigned [mem
> > 0x01220000-0x01223fff] pci 0000:03:00.0: BAR 2: assigned [io
> > 0x1000-0x101f] pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> > pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
> > pci 0000:02:02.0: PCI bridge to [bus 04] pci 0000:01:00.0: PCI bridge
> > to [bus 02-04]
> > pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
> > pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff]
> > pci 0000:00:00.0: PCI bridge to [bus 01-04]
> > pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> > pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
> > PCI: enabling device 0000:01:00.0 (0140 -> 0143)
> > PCI: enabling device 0000:02:01.0 (0140 -> 0143)
> > PCI: enabling device 0000:02:02.0 (0140 -> 0143) ...
> > e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
> > e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
> > e1000e 0000:03:00.0: Disabling ASPM L0s L1
> > PCI: enabling device 0000:03:00.0 (0140 -> 0142) e1000e 0000:03:00.0:
> > Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> > e1000e 0000:03:00.0 eth1: registered PHC clock e1000e 0000:03:00.0
> > eth1: (PCI Express:2.5GT/s:Width x1) 00:1b:21:3a:18:8b e1000e
> > 0000:03:00.0 eth1: Intel(R) PRO/1000 Network Connection e1000e
> > 0000:03:00.0 eth1: MAC: 3, PHY: 8, PBA No: E42641-005
> > igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.3-k
> > igb: Copyright (c) 2007-2013 Intel Corporation.
> > ...
> >
> > ALSA device list:
> >   #0: wm8962-audio
> > VFS: Mounted root (nfs filesystem) on device 0:11.
> > devtmpfs: mounted
> > Freeing unused kernel memory: 324K (8082d000 - 8087e000) Kernel panic
> > - not syncing: Attempted to kill init! exitcode=0x0000000b  <-- Kernel panic
> here randomly. Same phenomena when the root-fs is located in SD.
> 
> Richard,
> 
> I would suspect this is the imprecise abort issue.  Please see my patch
> (http://thread.gmane.org/gmane.linux.kernel.pci/26159) resolves that for you
> and reply to that thread if so.
> 
> I believe that the imprecise abort's only occurs if you have a PCIe switch on
> the bus - is this your topology and if so are you experiencing any issues with
> devices behind the bus that use io regions?  If you do have a switch, perhaps
> you can provide me with an 'lspci -v' for comparison.
> 
Hi Tim:
Oh, It's great. Your patch can fix my problem. 
My own patch-set of pcie driver works well when my Pericom's switch is used.
Thanks a lot.

Yes, it is.
E1000e network card request about 32 bytes IO regions during the bus enumeration procedure, 
and it works well behind the my Pericom's switch.

Based on my own pcie driver(not the one up-streamed by Sean),
Here are the log and the lspci -v results I got just now:

imx-pcie 1ffc000.pcie: legacy_irq 155
imx-pcie 1ffc000.pcie: map [mem 0x01ffc000-0x01ffffff]
imx-pcie 1ffc000.pcie: starting to link pcie port.
imx-pcie 1ffc000.pcie: Link up
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus3: Fast back to back transfers disabled
PCI: bus4: Fast back to back transfers enabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:01:00.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:02:01.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:03:00.0: BAR 1: assigned [mem 0x01100000-0x0117ffff]
pci 0000:03:00.0: BAR 6: assigned [mem 0x01200000-0x0123ffff pref]
pci 0000:03:00.0: BAR 0: assigned [mem 0x01180000-0x0119ffff]
pci 0000:03:00.0: BAR 3: assigned [mem 0x011a0000-0x011a3fff]
pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:02:01.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:02:01.0:   bridge window [mem 0x01200000-0x012fffff pref]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:01:00.0: PCI bridge to [bus 02-04]
pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:01:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:00:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
PCI: enabling device 0000:02:01.0 (0140 -> 0143)
PCI: enabling device 0000:02:02.0 (0140 -> 0143)
...
root@freescale ~$ lspci -v
00:00.0 PCI bridge: Unknown device 16c3:abcd (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01100000-011fffff
        Prefetchable memory behind bridge: 01200000-012fffff
        [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel

01:00.0 PCI bridge: Pericom Semiconductor Unknown device 2303 (rev 05) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01100000-011fffff
        Prefetchable memory behind bridge: 0000000001200000-00000000012fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [5c] Vital Product Data
        Capabilities: [64] Vendor Specific Information
        Capabilities: [b0] Subsystem: Gammagraphx, Inc. Unknown device 0000
        Capabilities: [c0] Express Upstream Port IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [20c] Power Budgeting
        Capabilities: [230] Unknown (24)

02:01.0 PCI bridge: Pericom Semiconductor Unknown device 2303 (rev 05) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01100000-011fffff
        Prefetchable memory behind bridge: 0000000001200000-00000000012fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [4c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [64] Vendor Specific Information
        Capabilities: [b0] Subsystem: Gammagraphx, Inc. Unknown device 0000
        Capabilities: [c0] Express Downstream Port (Slot+) IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [20c] Power Budgeting
        Capabilities: [220] Unknown (13)

02:02.0 PCI bridge: Pericom Semiconductor Unknown device 2303 (rev 05) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        Capabilities: [40] Power Management version 3
        Capabilities: [4c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [64] Vendor Specific Information
        Capabilities: [b0] Subsystem: Gammagraphx, Inc. Unknown device 0000
        Capabilities: [c0] Express Downstream Port (Slot+) IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [20c] Power Budgeting
        Capabilities: [220] Unknown (13)

03:00.0 Ethernet controller: Intel Corporation Unknown device 10d3
        Subsystem: Intel Corporation Unknown device a01f
        Flags: bus master, fast devsel, latency 0, IRQ 154
        Memory at 01180000 (32-bit, non-prefetchable) [size=128K]
        Memory at 01100000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1000 [disabled] [size=32]
        Memory at 011a0000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at 01200000 [disabled] [size=256K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [e0] Express Endpoint IRQ 0
        Capabilities: [a0] MSI-X: Enable- Mask- TabSize=5
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 8b-18-3a-ff-ff-21-1b-00


> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

Best Regards
Richard

