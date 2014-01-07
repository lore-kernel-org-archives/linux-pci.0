Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:60726 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaAGJLr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 04:11:47 -0500
Received: by mail-lb0-f182.google.com with SMTP id l4so79528lbv.13
        for <linux-pci@vger.kernel.org>; Tue, 07 Jan 2014 01:11:46 -0800 (PST)
Received: from [10.0.0.100] ([87.245.166.81])
        by mx.google.com with ESMTPSA id bl6sm44525667lbb.5.2014.01.07.01.11.45
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Jan 2014 01:11:45 -0800 (PST)
Message-ID: <52CBC4D1.5080706@gmail.com>
Date: Tue, 07 Jan 2014 13:11:45 +0400
From: `VL <vl.homutov@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: pci->pcie bridge issue: kernel unable to find a free I/O port range.
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I'm having an issue with my M-Audio Delta 44 soundcard installed into
the PCI->PCIe adapter. When installed into PCI slot on my old computer,
it works perfectly, but the new one lacks PCI slots, so I installed it 
using
the adapter (http://www.espada-tech.ru/pr_-12351.shtml)

lspci shows the audio card:

07:00.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 
[Envy24] PCI Multi-Channel I/O Controller (rev 02)

but the driver won't load:

snd_ice1712 0000:07:00.0: Refused to change power state, currently in D3
ice1712: No matching model found for ID 0x6c6c6c6c
invalid EEPROM (size = 108)
snd_ice1712: probe of 0000:07:00.0 failed with error -5

Unknown ID and EEPROM size may differ from boot to boot.

Looking into message I see this:

[    0.384542] pci 0000:05:01.0: BAR 7: can't assign io (size 0x1000)
[    0.384714] pci 0000:06:00.0: BAR 7: can't assign io (size 0x1000)
[    0.384885] pci 0000:07:00.0: BAR 3: can't assign io (size 0x40)
[    0.385056] pci 0000:07:00.0: BAR 0: can't assign io (size 0x20)
[    0.385227] pci 0000:07:00.0: BAR 1: can't assign io (size 0x10)
[    0.385411] pci 0000:07:00.0: BAR 2: can't assign io (size 0x10)


The bridge is based on PLX PEX 8112(?) chip and lspci shows:

04:00.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:01.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:04.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:05.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:06.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:07.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:08.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
05:09.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba)
06:00.0 PCI bridge: PLX Technology, Inc. PEX 8111 PCI Express-to-PCI 
Bridge (rev 21)

my kernel is 3.11.10:

lspci -vvv: http://dpaste.com/1539094/
dmesg: http://dpaste.com/1539095/

I've tried to boot with pci=realloc, but the system hangs in this case 
(looks like during initialization
of sound card driver, but I'm not sure, since it hangs completely: no 
kernel panic, system just stopped
in the middle of usual boot message)

Feel free to ask for more information.
