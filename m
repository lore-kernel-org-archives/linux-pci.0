Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36070 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbDGJvo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 05:51:44 -0400
Received: by igblo3 with SMTP id lo3so7131627igb.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2015 02:51:43 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Apr 2015 11:51:43 +0200
Message-ID: <CACna6ryiajzYAW+SJkJ-9ETpUe1+VDt99yKw9C39u_Na2q2kTQ@mail.gmail.com>
Subject: Preventing PCI from assigning mem (for MMIO) to bridge device
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Cc: Felix Fietkau <nbd@openwrt.org>,
	=?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
	Larry Finger <larry.finger@lwfinger.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I own a home router Linksys WRT300N v1.0 with CardBus slot on PCB and
wireless card attached.

This is MIPS SoC BCM4704 using following code for PCI controller:
1) register_pci_controller
http://lxr.free-electrons.com/source/arch/mips/pci/pci.c?v=3.18#L167
2) ssb_pcicore_init_hostmode
http://lxr.free-electrons.com/source/drivers/ssb/driver_pcicore.c?v=3.18#L317

There are two PCI devices discoverable:
1) 0000:00:00.0 (bridge)
14e4:472d / class 0x068000 / hdr_type 0
2) 0000:00:01.0 (wireless device)
14e4:4329 / class 0x028000 / hdr_type 0

My problem is that PCI subsystem assigns memory to the bridge device:
pci 0000:00:00.0: BAR 1: assigned [mem 0x40000000-0x47ffffff pref]
pci 0000:00:01.0: BAR 0: assigned [mem 0x48000000-0x48003fff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x48004000-0x48005fff]

This ancient & simple PCI controller allows assigning resources to the
wireless device only (slot 1). Trying to assign resources to the
bridge device (writing to slot 0 to registers PCI_BASE_ADDRESS_[0-5])
results in overwriting wireless device (slot 0) configuration!
As you can guess from the above log, the last assignment (targeting
slot 0) will break (overwrite) wireless device (slot 1) configuration.
Trying to access any MMIO register of wireless device will cause "Data
bus error".
For more details please see my comment in OpenWrt Trac:
https://dev.openwrt.org/ticket/12682#comment:11 (there is a nice
configuration dump after every assignment).

So I'm looking for a way to stop PCI subsystem from assigning any
memory to the bridge device (slot 0). I still need it to assign memory
for wireless device (slot 1) as its driver requires MMIO access.

I'm wondering what is the best way to achieve that?

MIPS arch code seems to respect PCI_PROBE_ONLY but this will stop
assigning memory to wireless device (slot 1) too.

I was considering modifying my "struct pci_ops" write callback to
include something like this:
if (extpci_core->cardbusmode && dev == 0 &&
    off >= PCI_BASE_ADDRESS_0 &&
    off <= PCI_BASE_ADDRESS_5)
        return -ENOTSUPP;
It seems to be working fine, all I get with above change is:
pci 0000:00:01.0: BAR 0: assigned [mem 0x40000000-0x40003fff]
, but I need an opinion if this is a correct solution.

-- 
Rafał
