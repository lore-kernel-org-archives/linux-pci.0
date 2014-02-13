Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:42724 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaBMWhj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 17:37:39 -0500
Received: by mail-oa0-f52.google.com with SMTP id i4so13523274oah.39
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2014 14:37:39 -0800 (PST)
Date: Thu, 13 Feb 2014 15:37:36 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org
Subject: Re: [Bug 68591] Regression: Asrock M3A UCC does not boot without
 acpi=off or pci=noacpi
Message-ID: <20140213223736.GA13837@google.com>
References: <bug-68591-41252@https.bugzilla.kernel.org/>
 <bug-68591-41252-XeC6UtTUD6@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <bug-68591-41252-XeC6UtTUD6@https.bugzilla.kernel.org/>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc linux-pci to make this more discoverable]

> https://bugzilla.kernel.org/show_bug.cgi?id=68591

  ACPI: HPET id: 0x43538301 base: 0xfed00000
  pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xdfffffff]
  pci_root PNP0A03:00: host bridge window [mem 0xf0000000-0xfebfffff]
  pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
  pci 0000:00:14.0: reg 14: [mem 0xfed00000-0xfed003ff]
  hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
  pnp 00:06: Plug and Play ACPI device, IDs PNP0103 (active)
  pnp 00:06: [mem 0xfed00000-0xfed003ff]

The 00:14.0 MEM BAR is outside all the host bridge windows, so unless you
boot with "pci=nocrs", Linux will try to move it.  Moving it is not a good
idea because that's the HPET timer, and the rest of the kernel still
thinks it lives at 0xfed00000 because we learned that from the ACPI HPET
table.  It's also not a good thing that we have that resource reported for
both the PCI 00:14.0 device and the ACPI/PNP 00:06 device.

It looks like d7451fca18e2 ("x86, hpet: SB600 - remove HPET resources from
PCI device") is intended to fix this very problem by hiding BAR 1 of the
00:14.0 device, and I don't know why it isn't working on your system.  It
is interesting that the description of the bit toggled by the quirk (the
HideHpetBar bit in the SoftPciRst register at PM_Reg:55h, in the AMD SB600
Register Reference Manual, P/N 46155_sb600_rrg_pub_3.03) says "can not
write and always read 0".

Any chance you can try the attached patch?  It won't fix anything, so
you'll still have to boot with "pci=nocrs".

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sb600-patch

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index bca9e85daaa5..8e65dbdd61c6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -512,14 +512,22 @@ static void sb600_disable_hpet_bar(struct pci_dev *dev)
 	 */
 
 	pci_read_config_byte(dev, 0x08, &val);
+	dev_info(&dev->dev, "cfg 0x08: %#02x\n", val);
 
 	if (val < 0x2F) {
+		dev_info(&dev->dev, "disabling BAR 1 (HPET address)\n");
 		outb(0x55, 0xCD6);
 		val = inb(0xCD7);
+		dev_info(&dev->dev, "PM  0x55: %#02x\n", val);
 
 		/* Set bit 7 in PM register 0x55 */
 		outb(0x55, 0xCD6);
 		outb(val | 0x80, 0xCD7);
+		dev_info(&dev->dev, "PM  0x55: wrote %#02x\n", val | 0x80);
+
+		outb(0x55, 0xCD6);
+		val = inb(0xCD7);
+		dev_info(&dev->dev, "PM  0x55: %#02x\n", val);
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x4385, sb600_disable_hpet_bar);

--YiEDa0DAkWCtVeE4--
