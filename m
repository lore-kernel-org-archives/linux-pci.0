Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:36288
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750965AbdG0Igg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jul 2017 04:36:36 -0400
From: Sandeep Singh <Sandeep.Singh@amd.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        bhelgaas@google.com, dheitmueller@kernellabs.com,
        stern@rowland.harvard.edu, samuel.thibault@ens-lyon.org,
        lukas@oxygene.sk
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        Sandeep Singh <sandeep.singh@amd.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH] usb: xhci: Add quirk for Certain failing HP keyboard on reset after resume
Date: Thu, 27 Jul 2017 14:05:09 +0530
Message-Id: <1501144509-19357-1-git-send-email-Sandeep.Singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Sandeep Singh <sandeep.singh@amd.com>

Certain HP keyboards would keep inputting a character automatically which
is the wake-up key after S3 resume

On some AMD platforms USB host fails to respond (by holding resume-K) to
USB device (an HP keyboard) resume request within 1ms (TURSM) and ensures
that resume is signaled for at least 20 ms (TDRSMDN), which is defined in
USB 2.0 spec. The result is that the keyboard is out of function.

In SNPS USB design, the host responds to the resume request only after
system gets back to S0 and the host gets to functional after the internal
HW restore operation that is more than 1 second after the initial resume
request from the USB device.

As a workaround for specific keyboard ID(HP Keyboards), applying port reset
after resume when the keyboard is plugged in.

Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
---
 drivers/usb/core/quirks.c     |  1 +
 drivers/usb/host/pci-quirks.c | 17 ++++++++++++-----
 include/linux/pci_ids.h       |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 3116edf..2e9cde0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -249,6 +249,7 @@ static const struct usb_device_id usb_amd_resume_quirk_list[] = {
 	{ USB_DEVICE(0x093a, 0x2500), .driver_info = USB_QUIRK_RESET_RESUME },
 	{ USB_DEVICE(0x093a, 0x2510), .driver_info = USB_QUIRK_RESET_RESUME },
 	{ USB_DEVICE(0x093a, 0x2521), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x03f0, 0x2b4a), .driver_info = USB_QUIRK_RESET_RESUME },
 
 	/* Logitech Optical Mouse M90/M100 */
 	{ USB_DEVICE(0x046d, 0xc05a), .driver_info = USB_QUIRK_RESET_RESUME },
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index c8989c6..292d684 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -98,6 +98,7 @@ enum amd_chipset_gen {
 	AMD_CHIPSET_HUDSON2,
 	AMD_CHIPSET_BOLTON,
 	AMD_CHIPSET_YANGTZE,
+	AMD_CHIPSET_TAISHAN,
 	AMD_CHIPSET_UNKNOWN,
 };
 
@@ -143,6 +144,11 @@ static int amd_chipset_sb_type_init(struct amd_chipset_info *pinfo)
 			pinfo->sb_type.gen = AMD_CHIPSET_SB800;
 	} else {
 		pinfo->smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
+				PCI_DEVICE_ID_AMD_TAISHAN, NULL);
+		if (pinfo->smbus_dev)
+			pinfo->sb_type.gen = AMD_CHIPSET_TAISHAN;
+
+		pinfo->smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
 				PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
 
 		if (!pinfo->smbus_dev) {
@@ -260,11 +266,12 @@ int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev)
 {
 	/* Make sure amd chipset type has already been initialized */
 	usb_amd_find_chipset_info();
-	if (amd_chipset.sb_type.gen != AMD_CHIPSET_YANGTZE)
-		return 0;
-
-	dev_dbg(&pdev->dev, "QUIRK: Enable AMD remote wakeup fix\n");
-	return 1;
+	if (amd_chipset.sb_type.gen == AMD_CHIPSET_YANGTZE ||
+	    AMD_CHIPSET_TAISHAN) {
+		dev_dbg(&pdev->dev, "QUIRK: Enable AMD remote wakeup fix\n");
+		return 1;
+	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_hcd_amd_remote_wakeup_quirk);
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c71e532..d3f2296 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -583,6 +583,7 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
+#define PCI_DEVICE_ID_AMD_TAISHAN	0x145c
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
2.7.4
