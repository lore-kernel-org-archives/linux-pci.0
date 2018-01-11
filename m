Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33941 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeAKNXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jan 2018 08:23:35 -0500
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: torvalds@linux-foundation.org, aaro.koskinen@iki.fi,
        andy.shevchenko@gmail.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, alexander.deucher@amd.com, airlied@linux.ie
Subject: [PATCH 1/2] x86/PCI: add kernel option and taint it when we add a 64bit window v2
Date: Thu, 11 Jan 2018 14:23:29 +0100
Message-Id: <20180111132330.2682-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only try to enable a 64bit window on AMD CPUs when pci=big_root_window is
specified and taint the kernel when we add the window.

v2: add documentation for the new option.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 arch/x86/include/asm/pci_x86.h                  | 1 +
 arch/x86/pci/common.c                           | 5 +++++
 arch/x86/pci/fixup.c                            | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6571fbfdb2a1..0cf9e3785840 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3094,6 +3094,10 @@
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
+		big_root_window	Try to add a big 64bit memory window to the PCIe
+				root complex on AMD CPUs. This is useful for GFX
+				hardware which can resize their PCIe BAR to
+				allow full CPU access to VRAM.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 7a5d6695abd3..eb66fa9cd0fc 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -38,6 +38,7 @@ do {						\
 #define PCI_NOASSIGN_ROMS	0x80000
 #define PCI_ROOT_NO_CRS		0x100000
 #define PCI_NOASSIGN_BARS	0x200000
+#define PCI_BIG_ROOT_WINDOW	0x400000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 7a5350d08cef..563049c483a1 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -594,6 +594,11 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "nocrs")) {
 		pci_probe |= PCI_ROOT_NO_CRS;
 		return NULL;
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	} else if (!strcmp(str, "big_root_window")) {
+		pci_probe |= PCI_BIG_ROOT_WINDOW;
+		return NULL;
+#endif
 	} else if (!strcmp(str, "earlydump")) {
 		pci_early_dump_regs = 1;
 		return NULL;
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e663d6bf1328..a91280da2ea1 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -667,6 +667,9 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	struct resource *res, *conflict;
 	struct pci_dev *other;
 
+	if (!(pci_probe & PCI_BIG_ROOT_WINDOW))
+		return;
+
 	/* Check that we are the only device of that type */
 	other = pci_get_device(dev->vendor, dev->device, NULL);
 	if (other != dev ||
@@ -715,6 +718,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	}
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 
 	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
 		AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
-- 
2.11.0
