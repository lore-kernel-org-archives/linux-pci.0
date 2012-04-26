Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li235-22.members.linode.com ([173.255.225.22]:60366 "EHLO
	erley.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab2DZTx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Apr 2012 15:53:28 -0400
Received: from [10.0.2.102] (adsl-99-122-21-65.dsl.klmzmi.sbcglobal.net [99.122.21.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pat)
	by erley.org (Postfix) with ESMTPSA id A8C0628DDB
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:46:02 +0000 (UTC)
Message-ID: <4F99A5E7.5090500@erley.org>
Date: Thu, 26 Apr 2012 15:45:43 -0400
From: Pat Erley <pat-lkml@erley.org>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Expresscard AHCI Controller not Detected at Hotplug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Apologies if I've chosen the wrong mailing list to start with.  I'm not certain
where this hickup is happening, so I'm not sure who to talk to.

I have a laptop (Lenovo w510) with an Expresscard/34 slot.  If I hotplug my
multi-i/o card, it works fine (well, it's detected and is enumerated):

  acpiphp_glue: _handle_hotplug_event_bridge: Bus check notify on \_SB_.PCI0.EXP4
  acpiphp_glue: _handle_hotplug_event_bridge: re-enumerating slots under \_SB_.PCI0.EXP4
  pci 0000:05:00.0: [9710:9912] type 0 class 0x000700
  pci 0000:05:00.0: reg 10: [io  0x0000-0x0007]
  pci 0000:05:00.0: reg 14: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.0: reg 24: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.0: PME# supported from D3hot D3cold
  pci 0000:05:00.1: [9710:9912] type 0 class 0x000700
  pci 0000:05:00.1: reg 10: [io  0x0000-0x0007]
  pci 0000:05:00.1: reg 14: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.1: reg 24: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.1: PME# supported from D3hot D3cold
  pci 0000:05:00.2: [9710:9912] type 0 class 0x000701
  pci 0000:05:00.2: reg 10: [io  0x0000-0x0007]
  pci 0000:05:00.2: reg 14: [io  0x0000-0x0007]
  pci 0000:05:00.2: reg 18: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.2: reg 24: [mem 0x00000000-0x00000fff]
  pci 0000:05:00.2: PME# supported from D3hot D3cold
  pci 0000:05:00.0: BAR 1: assigned [mem 0xf0000000-0xf0000fff]
  pci 0000:05:00.0: BAR 5: assigned [mem 0xf0001000-0xf0001fff]
  pci 0000:05:00.1: BAR 1: assigned [mem 0xf0002000-0xf0002fff]
  pci 0000:05:00.1: BAR 5: assigned [mem 0xf0003000-0xf0003fff]
  pci 0000:05:00.2: BAR 2: assigned [mem 0xf0004000-0xf0004fff]
  pci 0000:05:00.2: BAR 5: assigned [mem 0xf0005000-0xf0005fff]
  pci 0000:05:00.0: BAR 0: assigned [io  0x3000-0x3007]
  pci 0000:05:00.1: BAR 0: assigned [io  0x3008-0x300f]
  pci 0000:05:00.2: BAR 0: assigned [io  0x3010-0x3017]
  pci 0000:05:00.2: BAR 1: assigned [io  0x3018-0x301f]
  pci 0000:05:00.0: no hotplug settings from platform
  pci 0000:05:00.1: no hotplug settings from platform
  pci 0000:05:00.2: no hotplug settings from platform
  acpiphp_glue: acpiphp_check_bridge: 1 enabled, 0 disabled
  Serial: 8250/16550 driver, 0 ports, IRQ sharing enabled
  serial 0000:05:00.0: enabling device (0000 -> 0003)
  Couldn't register serial port 0000:05:00.0: -28
  serial 0000:05:00.1: enabling device (0000 -> 0003)
  Couldn't register serial port 0000:05:00.1: -28
  parport_serial 0000:05:00.2: enabling device (0000 -> 0003)
  parport0: PC-style at 0x3010 (0x3018), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]

If I eject my multi-i/o card and hotplug my esata card (Marvell 91xx based), nothing
is seen:

  acpiphp_glue: _handle_hotplug_event_bridge: Bus check notify on \_SB_.PCI0.EXP4
  acpiphp_glue: _handle_hotplug_event_bridge: re-enumerating slots under \_SB_.PCI0.EXP4
  acpiphp_glue: acpiphp_check_bridge: 0 enabled, 1 disabled
  acpiphp_glue: _handle_hotplug_event_bridge: Bus check notify on \_SB_.PCI0.EXP4
  acpiphp_glue: _handle_hotplug_event_bridge: re-enumerating slots under \_SB_.PCI0.EXP4
  acpiphp_glue: acpiphp_check_bridge: 0 enabled, 0 disabled

If I do:

echo 1 > /sys/bus/pci/rescan

  pci 0000:05:00.0: [1b4b:9123] type 0 class 0x000106
  pci 0000:05:00.0: reg 10: [io  0x8000-0x8007]
  pci 0000:05:00.0: reg 14: [io  0x8040-0x8043]
  pci 0000:05:00.0: reg 18: [io  0x8100-0x8107]
  pci 0000:05:00.0: reg 1c: [io  0x8140-0x8143]
  pci 0000:05:00.0: reg 20: [io  0x800000-0x80000f]
  pci 0000:05:00.0: reg 24: [mem 0x00900000-0x009007ff]
  pci 0000:05:00.0: reg 30: [mem 0xd0000000-0xd000ffff pref]
  pci 0000:05:00.0: PME# supported from D3hot
  pci 0000:05:00.0: BAR 6: assigned [mem 0xf2800000-0xf280ffff pref]
  pci 0000:05:00.0: BAR 5: assigned [mem 0xf0000000-0xf00007ff]
  pci 0000:05:00.0: BAR 4: assigned [io  0x3020-0x302f]
  pci 0000:05:00.0: BAR 0: assigned [io  0x3000-0x3007]
  pci 0000:05:00.0: BAR 2: assigned [io  0x3030-0x3037]
  pci 0000:05:00.0: BAR 1: assigned [io  0x3038-0x303b]
  pci 0000:05:00.0: BAR 3: assigned [io  0x303c-0x303f]
  ahci 0000:05:00.0: irq 46 for MSI/MSI-X
  ahci 0000:05:00.0: controller can do FBS, turning on CAP_FBS
  ahci 0000:05:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
  ahci 0000:05:00.0: flags: 64bit ncq fbs pio
  scsi28 : ahci
<snip x26>
  scsi 35:0:0:0: Processor         Marvell  91xx Config      1.01 PQ: 0 ANSI: 5
  scsi 35:0:0:0: Attached scsi generic sg5 type 3

It's detected and works fine.

Is this a PCI bug, an ACPI bug, a hardware issue, or working as designed?  Is there a
'better' way I should be handling this use case?
