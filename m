Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:64519 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918AbaGHThy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 15:37:54 -0400
Received: by mail-ve0-f173.google.com with SMTP id db11so6164535veb.18
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2014 12:37:53 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Jul 2014 12:37:53 -0700
Message-ID: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
Subject: Error assigning BAR 0 to hotplugged device
From: Chuck Tuffli <ctuffli@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a system with a recent Fedora kernel (3.14.9-200.fc20.x86_64), a
hotplugged PCI device is unable to get memory mapped IO:
...
[  183.247377] pcieport 0000:9a:00.0: BAR 15: can't assign mem pref
(size 0x100000)
[  183.247384] pcieport 0000:9b:15.0: BAR 14: can't assign mem (size 0x100000)
[  183.247388] pcieport 0000:9b:15.0: BAR 15: can't assign mem pref
(size 0x100000)
[  183.247394] pci 0000:a5:00.0: BAR 6: can't assign mem pref (size 0x10000)
[  183.247397] pci 0000:a5:00.0: BAR 0: can't assign mem (size 0x4000)

The device is connected to a switch supporting hotplug (i.e. SltCap
includes HotPlug+) and I have added
pci=realloc,hpmemsize=16M
to the kernel boot parameters. This appears to have increased the
prefetchable memory but not the memory mapped IO:

99:00.0 PCI bridge: PLX Technology, Inc. Device 8733 (rev ca) (prog-if
00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=99, secondary=9a, subordinate=a5, sec-latency=0
    I/O behind bridge: 0000d000-0000ffff
    Memory behind bridge: fb100000-fbafffff
    Prefetchable memory behind bridge: 0000381000000000-0000381000ffffff

Should this work or am I missing a step somewhere? TIA.

Full dmesg http://pastebin.com/pZ1zzHS6
Full lspci -vv http://pastebin.com/n57UheAE

--chuck
