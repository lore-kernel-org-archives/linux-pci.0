Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:34281 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab3KYUFc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 15:05:32 -0500
Date: Mon, 25 Nov 2013 20:54:41 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Jones <pjones@redhat.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [RFC patch] PCI: Extend boot_vga sysfs attribute lookup to fix X on
 MBA+EFI
Message-ID: <20131125205441.5046e0cb@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a MacBookAir2,1, booting to Linux with EFI though having
no efifb built-in Xorg refuses to start with "no devices detected"
because for the only VGA device available (NVidia Geforce 9400M)
the sysfs attribute boot_vga is zero (instead of expected 1).

When CONFIG_FB_EFI is selected, efifb does provide its own
vga_default_device() to report the PCI device matching global
screen_info as determined during efifb setup.

Otherwise there is just a dummy or VGA_ARB's vga_default_device()
that does not provide the right information.

On the other hand, boot_vga_show() falls back to poking PCI
resources to flag a PCI device as boot_vga if vga_default_device()
returned no PCI device (NULL).

To complement this PCI resource poking, this patch copies the
validation code used to determine which PCI device to report as
default VGA device by efifb into boot_vga_show().

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---
Would it make sense to kill the corresponding code from efifb
as it covers only a single case?

The other EFI capable system I have (AMD Ilano based, Gigabyte
mainboard does report boot_vga=1, possibly through the resources
poking and there Xorg starts properly without efifb built in.

Selecting CONFIG_X86_SYSFB (combined with CONFIG_FB_SIMPLE) does
not help by itself, patching that one instead of PCI's boot_vga
attribute directly would still not cover the case when neither
of them is enabled.


 drivers/pci/pci-sysfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7128cfd..91cac71 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -28,6 +28,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
+#include <linux/screen_info.h>
 #include <linux/pm_runtime.h>
 #include "pci.h"
 
@@ -540,6 +541,26 @@ boot_vga_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (vga_dev)
 		return sprintf(buf, "%u\n", (pdev == vga_dev));
 
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
+		resource_size_t start, end;
+		int i;
+
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
+				continue;
+
+			start = pci_resource_start(pdev, i);
+			end  = pci_resource_end(pdev, i);
+
+			if (!start || !end)
+				continue;
+
+			if (screen_info.lfb_base >= start &&
+				(screen_info.lfb_base + screen_info.lfb_size) < end)
+				return sprintf(buf, "1\n");
+		}
+	}
+
 	return sprintf(buf, "%u\n",
 		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
 		   IORESOURCE_ROM_SHADOW));
