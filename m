Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37875 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933671AbaFCUEe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Jun 2014 16:04:34 -0400
Date: Tue, 3 Jun 2014 14:04:32 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org
cc: bhelgaas@google.com
Subject: Debugging incorrect mps settings detected
Message-ID: <alpine.LRH.2.03.1406031308200.11244@AMR>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Hot adding a pci device results in improper MPS settings detected,
reading 128 even though the upstream port is 256. This causes a warning
print to be logged suggesting I should report a bug. :)

Here's the dmesg of the hot plug event:

[ 2105.051941] pciehp 0000:05:07.0:pcie24: Card present on Slot(27)
[ 2107.012811] pci 0000:09:00.0: [8086:0953] type 00 class 0x010802
[ 2107.012838] pci 0000:09:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[ 2107.012873] pci 0000:09:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[ 2107.014986] pcieport 0000:05:07.0: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[ 2107.014996] pcieport 0000:05:07.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[ 2107.015001] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
[ 2107.015006] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
[ 2107.015013] pci 0000:09:00.0: BAR 6: assigned [mem 0xd5200000-0xd520ffff pref]
[ 2107.015018] pci 0000:09:00.0: BAR 0: assigned [mem 0xdb600000-0xdb603fff 64bit]
[ 2107.015030] pcieport 0000:05:07.0: PCI bridge to [bus 09]
[ 2107.015037] pcieport 0000:05:07.0:   bridge window [mem 0xdb600000-0xdb7fffff]
[ 2107.015042] pcieport 0000:05:07.0:   bridge window [mem 0xd5200000-0xd52fffff 64bit pref]
[ 2107.015060] pci 0000:09:00.0: Max Payload Size 128, but upstream 0000:05:07.0 set to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
[ 2107.015079] pci 0000:09:00.0: no hotplug settings from platform

The commit message that added the warning indicates it may be a BIOS
issue that incorrectly configures this, but BIOS isn't involved with
setting the MPS on a device hot add, am I right? Or is that wrong?
This is a Dell R620 server, if that matters, though we see this on other
platforms as well.

Using pci=pcie_bus_perf works around the issue, but that seems a bit
odd to suggest to users. Is setting MPS on hot-add something the PCI
driver layer ought to be doing, or should I be looking into the platform
BIOS instead?

Thanks!
Keith
