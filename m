Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45387 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbaGCDUw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jul 2014 23:20:52 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so13328381oag.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2014 20:20:52 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Jul 2014 23:20:52 -0400
Message-ID: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>
Subject: How to check for proper MSI support?
From: Ilia Mirkin <imirkin@alum.mit.edu>
To: linux-pci@vger.kernel.org
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	brian.johnathan.b@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

A user (cc'd) reported that nouveau's enabling of MSI causes the card
to not work on his setup [1]. I think the situation is that MSI is
just not supported by the underlying motherboard, even though the
card, and probably bridge, support it just fine. It's a very old
board. The nouveau code does:

pmc->use_msi = pci_enable_msi(device->pdev) == 0;

Does it need to do more checking than that before trying to enable MSI
on the device? Could it be that the linux pci subsystem is missing on
inheriting MSI capabilities somewhere?

Thanks,

  -ilia

[1]

00:00.0 Host bridge [0600]: Intel Corporation 430FX - 82437FX TSC
[Triton I] [8086:122d] (rev 01)
        Flags: bus master, medium devsel, latency 64

00:0e.0 PCI bridge [0604]: PLX Technology, Inc. PEX8112 x1 Lane PCI
Express-to-PCI Bridge [10b5:8112] (rev aa) (prog-if 00 [Normal
decode])
        Flags: bus master, 66MHz, medium devsel, latency 66
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-0000ffff
        Memory behind bridge: f5e00000-fbffffff
        Prefetchable memory behind bridge: d5d00000-f5dfffff
        Capabilities: [40] Power Management version 2
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [60] Express PCI/PCI-X to PCI-Express Bridge, MSI 00

01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G96
[GeForce 9400 GT] [10de:0641] (rev a1) (prog-if 00 [VGA controller])
        Subsystem: Jaton Corp Device [1b13:0641]
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Memory at f8000000 (64-bit, non-prefetchable) [size=32M]
        I/O ports at fc80 [size=128]
        [virtual] Expansion ROM at d5d00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Express Endpoint, MSI 00
        Capabilities: [b4] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: nouveau
