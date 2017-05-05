Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:50299 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbdEESis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 14:38:48 -0400
Message-Id: <771bc335fb5856792d086ae7db288dcf244cb4cd.1493964354.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 5 May 2017 20:38:38 +0200
Subject: [PATCH] efi/cper: Fix endianness of PCI class code
To: linux-efi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The CPER parser assumes that the class code is big endian, but at least
on this edk2-derived Intel Purley platform it's little endian:

    efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
    DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017

    {1}[Hardware Error]:   device_id: 0000:5d:00.0
    {1}[Hardware Error]:   slot: 0
    {1}[Hardware Error]:   secondary_bus: 0x5e
    {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
    {1}[Hardware Error]:   class_code: 000406
                                       ^^^^^^ (should be 060400)

Cc: Huang Ying <ying.huang@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---

@Ashok Raj: Could you test if this patch results in the correct
PCI class being logged? Thanks!

 drivers/firmware/efi/cper.c | 5 ++---
 include/linux/cper.h        | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index d42537425438..e360c8b77bd9 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -364,7 +364,6 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%s""command: 0x%04x, status: 0x%04x\n", pfx,
 		       pcie->command, pcie->status);
 	if (pcie->validation_bits & CPER_PCIE_VALID_DEVICE_ID) {
-		const __u8 *p;
 		printk("%s""device_id: %04x:%02x:%02x.%x\n", pfx,
 		       pcie->device_id.segment, pcie->device_id.bus,
 		       pcie->device_id.device, pcie->device_id.function);
@@ -374,8 +373,8 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		       pcie->device_id.secondary_bus);
 		printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
 		       pcie->device_id.vendor_id, pcie->device_id.device_id);
-		p = pcie->device_id.class_code;
-		printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
+		printk("%s""class_code: 0x%06x\n", pfx,
+		       pcie->device_id.class_code);
 	}
 	if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
 		printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,
diff --git a/include/linux/cper.h b/include/linux/cper.h
index dcacb1a72e26..fbfb50f52362 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -416,7 +416,7 @@ struct cper_sec_pcie {
 	struct {
 		__u16	vendor_id;
 		__u16	device_id;
-		__u8	class_code[3];
+		__u32	class_code:24;
 		__u8	function;
 		__u8	device;
 		__u16	segment;
-- 
2.11.0
