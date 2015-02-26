Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:36605 "EHLO
	resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753005AbbBZBUh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 20:20:37 -0500
Date: Thu, 26 Feb 2015 01:12:25 +0000 (UTC)
From: Alnie <memobook80@comcast.net>
To: linux-pci@vger.kernel.org
Message-ID: <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net>
In-Reply-To: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net>
Subject: PCI Issues with ExpressCard/54 Audio Device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, I am seeking feedback in regards to issues with a ExpressCard/54 audio card (http://www.notebookreview.com/notebookreview/creative-soundblaster-x-fi-xtreme-audio-for-notebook-review/) under Linux (same card has been working fine in Win 7). After recently having a conversation on alsa-devel about it, it was decided it seems to be a PCI issue. The "devices" in question....

05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge (prog-if 00 [Normal decode])
     Physical Slot: 3
     Flags: bus master, fast devsel, latency 0
     Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
     Memory behind bridge: f4300000-f43fffff
     Capabilities: [50] Power Management version 3
     Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
     Capabilities: [80] Subsystem: Creative Labs Device 0040
     Capabilities: [90] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
     Capabilities: [100] Advanced Error Reporting

06:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
     Subsystem: Creative Labs SB1040
     Flags: bus master, fast Back2Back, medium devsel, latency 32, IRQ 19
     Memory at f4300000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [dc] Power Management version 3
     Kernel driver in use: snd_hda_intel



dmesg output... http://pastebin.com/66UE659K

and comments in regard to it... http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088237.html
> 
> [ 2619.199658] pciehp 0000:00:1c.3:pcie04: Card not present on Slot(3)
> [ 2619.199666] pciehp 0000:00:1c.3:pcie04: slot(3): Link Down event
> [ 2619.199674] pciehp 0000:00:1c.3:pcie04: Link Down event ignored on 
> slot(3): already powering off
> [ 2619.199911] pci_bus 0000:06: busn_res: [bus 06-0c] is released
> [ 2620.757928] pciehp 0000:00:1c.3:pcie04: Card present on Slot(3)
> [ 2620.767950] pciehp 0000:00:1c.3:pcie04: slot(3): Link Up event
> [ 2620.767985] pciehp 0000:00:1c.3:pcie04: Link Up event ignored on 
> slot(3): already powering on

pciehp reacted power off and on here, and...

> [ 2620.876160] pci 0000:05:00.0: [1102:7006] type 01 class 0x060400
> [ 2620.876426] pci 0000:05:00.0: supports D1 D2
> [ 2620.876719] pci 0000:05:00.0: bridge configuration invalid ([bus 
> 00-00]), reconfiguring
> [ 2620.876928] pci_bus 0000:06: busn_res: can not insert [bus 06-ff] 
> under [bus 05-0c] (conflicts with (null) [bus 05-0c])

.... and something failed here for the PCI bridge device.

> [ 2620.876967] pci 0000:06:00.0: [1102:0009] type 00 class 0x040300
> [ 2620.877013] pci 0000:06:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
> [ 2620.877203] pci 0000:06:00.0: supports D1 D2
> [ 2620.877443] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
> [ 2620.877462] pci 0000:05:00.0:   bridge window [io  0x0000-0x0fff]
> [ 2620.877474] pci 0000:05:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [ 2620.877492] pci 0000:05:00.0:   bridge window [mem 
> 0x00000000-0x000fffff 64bit pref]
> [ 2620.877500] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
> [ 2620.877559] pci 0000:05:00.0: BAR 14: assigned [mem 
> 0xf4300000-0xf43fffff]
> [ 2620.877568] pci 0000:05:00.0: BAR 15: assigned [mem 
> 0xf4000000-0xf40fffff 64bit pref]
> [ 2620.877574] pci 0000:05:00.0: BAR 13: assigned [io  0x2000-0x2fff]
> [ 2620.877582] pci 0000:06:00.0: BAR 0: assigned [mem 0xf4300000-0xf4303fff]
> [ 2620.877595] pci 0000:05:00.0: PCI bridge to [bus 06]
> [ 2620.877603] pci 0000:05:00.0:   bridge window [io  0x2000-0x2fff]
> [ 2620.877618] pci 0000:05:00.0:   bridge window [mem 0xf4300000-0xf43fffff]
> [ 2620.877630] pci 0000:05:00.0:   bridge window [mem 
> 0xf4000000-0xf40fffff 64bit pref]
> [ 2620.877647] pcieport 0000:00:1c.3: PCI bridge to [bus 05-0c]
> [ 2620.877655] pcieport 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> [ 2620.877667] pcieport 0000:00:1c.3:   bridge window [mem 
> 0xf4300000-0xf7efffff]
> [ 2620.877677] pcieport 0000:00:1c.3:   bridge window [mem 
> 0xf4000000-0xf40fffff 64bit pref]
> [ 2620.877990] pci 0000:05:00.0: enabling device (0000 -> 0003)
> [ 2620.878013] snd_hda_intel 0000:06:00.0: enabling device (0000 -> 0002)
> [ 2620.882747] azx_single_wait_for_response: 108 callbacks suppressed
> [ 2620.882753] snd_hda_intel 0000:06:00.0: Codec #1 probe error; 
> disabling it...
> [ 2620.887052] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
> [ 2620.887058] snd_hda_intel 0000:06:00.0: no codecs initialized



I've tried many kernels from 2.6 to 3.18 with similar results. Willing to retrieve more info. Thank you :)

-Alnie
