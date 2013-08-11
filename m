Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:39750 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab3HKINr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2013 04:13:47 -0400
Received: by mail-bk0-f53.google.com with SMTP id d7so1791089bkh.26
        for <linux-pci@vger.kernel.org>; Sun, 11 Aug 2013 01:13:45 -0700 (PDT)
Message-ID: <520747B6.8010309@message-id.googlemail.com>
Date: Sun, 11 Aug 2013 10:13:42 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: Greg KH <gregkh@linux.com>, Oliver Neukum <oneukum@suse.de>
Subject: acpiphp and pciehp not working together on Thinkpad X200s
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

after openSUSE changed its kernel config to statically build in acpiphp
and pciehp, my ExpressCard slot does not work anymore. The workaround
is to disable acpiphp with acpiphp.disable=1

To be honest, I cannot say if it ever worked with both drivers loaded,
since I always had to load pciehp manually to get the slot working. I
don't think I ever tried acpiphp before. If necessary, I can either
build a kernel with both drivers modularized or just boot an old kernel
from before the config change.

I did diff both dmesg outputs and the only differences I can see are:

-kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
+kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5, disabled by user; please report a bug

@@ -401,7 +400,6 @@
 kernel: pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
 kernel: pci 0000:00:1c.1: PCI bridge to [bus 03]
 kernel: pci 0000:00:1c.1:   bridge window [mem 0xf2500000-0xf25fffff]
-kernel: acpiphp: Slot [1] registered
 kernel: pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
 kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
 kernel: pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]

@@ -585,8 +583,7 @@
 kernel: pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086 device_id 2942 ss_vid 17aa ss_did 20f3
 kernel: pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
 kernel: pciehp 0000:00:1c.3:pcie04: HPC vendor_id 8086 device_id 2946 ss_vid 17aa ss_did 20f3
-kernel: pciehp 0000:00:1c.3:pcie04: pci_hp_register failed with error -16
-kernel: pciehp 0000:00:1c.3:pcie04: Slot already registered by another hotplug driver
+kernel: pciehp 0000:00:1c.3:pcie04: service driver pciehp loaded
 kernel: pciehp: PCI Express Hot Plug Controller Driver version: 0.4
 kernel: intel_idle: does not run on family 6 model 23
 kernel: GHES: HEST is not enabled!

The other changes are
* kernel command line (obviously)
* timing related (small difference in cpu freq / jiffies)

Greg told me to report the issue here, so I'm doing that :-)

If you need more information (would a complete dmesg of both cases
be useful?), just let me know.

Best regards,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
