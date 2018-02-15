Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([12.32.117.8]:40678 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033082AbeBOOeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Feb 2018 09:34:46 -0500
From: Ganesh Goudar <ganeshgr@chelsio.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, hare@suse.de,
        nirranjan@chelsio.com, indranil@chelsio.com, venkatesh@chelsio.com,
        Casey Leedom <leedom@chelsio.com>, <stable@vger.kernel.org>,
        Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>
Subject: [PATCH] PCI/cxgb4: Extend T3 PCI quirk to T4+ devices
Date: Thu, 15 Feb 2018 20:03:18 +0530
Message-Id: <1518705198-15987-1-git-send-email-ganeshgr@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Casey Leedom <leedom@chelsio.com>

We've run into a problem where our device is attached
to a Virtual Machine and the use of the new pci_set_vpd_size()
API doesn't help.  The VM kernel has been informed that
the accesses are okay, but all of the actual VPD Capability
Accesses are trapped down into the KVM Hypervisor where it
goes ahead and imposes the silent denials.

The right idea is to follow the kernel.org
commit 1c7de2b4ff88 ("PCI: Enable access to non-standard VPD for
Chelsio devices (cxgb3)") which Alexey Kardashevskiy authored
to establish a PCI Quirk for our T3-based adapters. This commit
extends that PCI Quirk to cover Chelsio T4 devices and later.

The advantage of this approach is that the VPD Size gets set early
in the Base OS/Hypervisor Boot and doesn't require that the cxgb4
driver even be available in the Base OS/Hypervisor.  Thus PF4 can
be exported to a Virtual Machine and everything should work.

Fixes: 67e658794ca1 ("cxgb4: Set VPD size so we can read both VPD structures")
Cc: <stable@vger.kernel.org>  # v4.9+
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 10 --------
 drivers/pci/quirks.c                       | 39 ++++++++++++++++++------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 047609e..920bccd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -2637,7 +2637,6 @@ void t4_get_regs(struct adapter *adap, void *buf, size_t buf_size)
 }
 
 #define EEPROM_STAT_ADDR   0x7bfc
-#define VPD_SIZE           0x800
 #define VPD_BASE           0x400
 #define VPD_BASE_OLD       0
 #define VPD_LEN            1024
@@ -2704,15 +2703,6 @@ int t4_get_raw_vpd_params(struct adapter *adapter, struct vpd_params *p)
 	if (!vpd)
 		return -ENOMEM;
 
-	/* We have two VPD data structures stored in the adapter VPD area.
-	 * By default, Linux calculates the size of the VPD area by traversing
-	 * the first VPD area at offset 0x0, so we need to tell the OS what
-	 * our real VPD size is.
-	 */
-	ret = pci_set_vpd_size(adapter->pdev, VPD_SIZE);
-	if (ret < 0)
-		goto out;
-
 	/* Card information normally starts at VPD_BASE but early cards had
 	 * it at 0.
 	 */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fc73401..8b14bd3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3419,22 +3419,29 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
 
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
-	pci_set_vpd_size(dev, 8192);
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_extend_vpd);
+	int chip = (dev->device & 0xf000) >> 12;
+	int func = (dev->device & 0x0f00) >>  8;
+	int prod = (dev->device & 0x00ff) >>  0;
+
+	/*
+	 * If this is a T3-based adapter, there's a 1KB VPD area at offset
+	 * 0xc00 which contains the preferred VPD values.  If this is a T4 or
+	 * later based adapter, the special VPD is at offset 0x400 for the
+	 * Physical Functions (the SR-IOV Virtual Functions have no VPD
+	 * Capabilities).  The PCI VPD Access core routines will normally
+	 * compute the size of the VPD by parsing the VPD Data Structure at
+	 * offset 0x000.  This will result in silent failures when attempting
+	 * to accesses these other VPD areas which are beyond those computed
+	 * limits.
+	 */
+	if (chip == 0x0 && prod >= 0x20)
+		pci_set_vpd_size(dev, 8192);
+	else if (chip >= 0x4 && func < 0x8)
+		pci_set_vpd_size(dev, 2048);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			quirk_chelsio_extend_vpd);
 
 #ifdef CONFIG_ACPI
 /*
-- 
2.1.0
