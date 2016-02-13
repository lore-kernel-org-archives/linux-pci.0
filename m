Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:59662 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcBMWZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Feb 2016 17:25:42 -0500
Date: Sat, 13 Feb 2016 13:57:36 -0800
From: Marc MERLIN <marc@merlins.org>
To: linux-pci@vger.kernel.org
Message-ID: <20160213215736.GA1002@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: 4.4.x kernel (only) gives pcieport 0000:00:1c.4: AER: Corrected
 error received: id=00e4
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Howdy,

I just upgraded my laptop to a Lenovo thinkpad P70 (skylake), moved my linux
image (4.4.1 kernel), and I'm pseudo-randomly getting these:

pcieport 0000:00:1c.4: AER: Corrected error received: id=00e4
pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=00e4(Transmitter ID)
pcieport 0000:00:1c.4:   device [8086:a114] error status/mask=00001000/00002000
pcieport 0000:00:1c.4:    [12] Replay Timer Timeout
pcieport 0000:00:1c.4: AER: Corrected error received: id=00e4
pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=00e4(Transmitter ID)
pcieport 0000:00:1c.4:   device [8086:a114] error status/mask=00001000/00002000
pcieport 0000:00:1c.4:    [12] Replay Timer Timeout

pcieport 0000:00:1c.4: AER: Multiple Corrected error received: id=00e4
pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=00e4(Transmitter ID)
pcieport 0000:00:1c.4:   device [8086:a114] error status/mask=00001000/00002000
pcieport 0000:00:1c.4:    [12] Replay Timer Timeout
pcieport 0000:00:1c.4: AER: Multiple Corrected error received: id=00e4
pcieport 0000:00:1c.4: can't find device of ID00e4
pcieport 0000:00:1c.4: AER: Multiple Corrected error received: id=00e4
pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=00e4(Transmitter ID)

They did not seem to be happening with 4.3.3 kernel.
With 4.4.1, I've had a boot where I got so many of those that the machine was unusable.
Other times, it happens a bit, and stops.
My last boot, it didn't happen at all.

Sadly, I have no idea what they mean, what I should do about them, and
why they only seem to be happening with 4.4.1 and not older kernels.

Boot log: http://marc.merlins.org/tmp/4.1.4.boot.txt
config.gz: http://marc.merlins.org/tmp/4.1.4.config.gz

8086:a114 is this:
PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #5 (rev f1)
00:1c.4 0604: 8086:a114 (rev f1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 123
        Bus: primary=00, secondary=05, subordinate=6f, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: a4000000-ba0fffff
        Prefetchable memory behind bridge: 0000000080000000-00000000a1ffffff
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: 17aa:222d
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [220] #19
        Kernel driver in use: pcieport

Can someone offer some suggestions?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
