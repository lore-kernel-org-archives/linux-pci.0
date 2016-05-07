Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35461 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758696AbcEGAiz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2016 20:38:55 -0400
Received: by mail-vk0-f41.google.com with SMTP id f66so9193569vkh.2
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2016 17:38:54 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 6 May 2016 19:38:53 -0500
Message-ID: <CA+M2ft_nPCCLnqpN6nz9w8YU=hxrkPZJ+b=aiWj1kQ9xOAg9Vg@mail.gmail.com>
Subject: Follow up to
From: John Hendy <jw.hendy@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greetings,


I've been getting hot-add errors for a device on suspend/resume cycles
and the closest I've found to a resolution was a patch submitted to
this list:
- http://thread.gmane.org/gmane.linux.kernel/1834517

There's a kernel bug here where I've been trying to make headway but
thought I'd ping this list as it seemed relevant:
- https://bugzilla.kernel.org/show_bug.cgi?id=74471

The closest other reports I can find are here:
- https://bugs.archlinux.org/task/38486
- https://bbs.archlinux.org/viewtopic.php?pid=1314282#p1314282

This is on Arch linux.

$ uname -a
Linux 4.5.0-1-ARCH #1 SMP PREEMPT Tue Mar 15 09:41:03 CET 2016 x86_64 GNU/Linux


Example dmesg output:

$ dmesg |grep hot-add
[   43.105083] pciehp 0000:3d:03.0:pcie24: Device 0000:60:00.0 already
exists at 0000:60:00, cannot hot-add
[   43.208376] pciehp 0000:3d:03.0:pcie24: Device 0000:60:00.0 already
exists at 0000:60:00, cannot hot-add
[ 2223.875613] pciehp 0000:3d:03.0:pcie24: Device 0000:60:00.0 already
exists at 0000:60:00, cannot hot-add
[ 2223.982274] pciehp 0000:3d:03.0:pcie24: Device 0000:60:00.0 already
exists at 0000:60:00, cannot hot-add


Device info (let me know if -vv or -vvv is preferred)

$ sudo lspci -v
60:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5249 PCI Express Card Reader (rev 01)
Subsystem: Hewlett-Packard Company Device 2253
Physical Slot: 0-2
Flags: bus master, fast devsel, latency 0, IRQ 10
Memory at cc000000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Capabilities: [70] Express Endpoint, MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [148] Device Serial Number 00-00-00-01-00-4c-e0-00
Capabilities: [158] Latency Tolerance Reporting
Capabilities: [160] L1 PM Substates
Kernel modules: rtsx_pci

I noticed that on Arch the patch referenced above isn't applied, so
I'm not sure if it was ever integrated or not. I made the changes
contained in v2 manually, and am still experiencing the errors. That
said, they don't seem to affect anything noticeable other than showing
up when I move the mouse to disable xscreensaver (though that's gone
away recently).

If it's nothing to be concerned with, at the least I can add a comment
to kernel bug so that others who find it won't be worried. It'd be
nice to have an official resolution somewhere on the internet.


Thanks fo for taking a look,

John
