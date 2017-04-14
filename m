Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33583 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdDNUic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 16:38:32 -0400
Received: by mail-pf0-f172.google.com with SMTP id s16so44408344pfs.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2017 13:38:32 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Date: Fri, 14 Apr 2017 13:38:02 -0700
Message-Id: <20170414203802.119399-1-mka@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
This fixes a clang warning about "implicit conversion from 'unsigned
long' to 'u32'".

Also remove now unnecessary casts to u32 from __pci_read_base() and
pci_std_update_resource().

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- Remove unnecessary casts
- Updated commit message

Changes in v2:
- Define PCI_ROM_ADDRESS_MASK as a 32-bit constant instead of using a cast
- Updated commit message

 drivers/pci/probe.c           | 2 +-
 drivers/pci/setup-res.c       | 2 +-
 include/uapi/linux/pci_regs.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a2794141..7d5d4a56a186 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -231,7 +231,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_ROM_ENABLE;
 		l64 = l & PCI_ROM_ADDRESS_MASK;
 		sz64 = sz & PCI_ROM_ADDRESS_MASK;
-		mask64 = (u32)PCI_ROM_ADDRESS_MASK;
+		mask64 = PCI_ROM_ADDRESS_MASK;
 	}
 
 	if (res->flags & IORESOURCE_MEM_64) {
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 4bc589ee78d0..85774b7a316a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -63,7 +63,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
 		new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		mask = (u32)PCI_ROM_ADDRESS_MASK;
+		mask = PCI_ROM_ADDRESS_MASK;
 	} else {
 		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
 		new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 634c9c44ed6c..fff521c9458c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -114,7 +114,7 @@
 #define PCI_SUBSYSTEM_ID	0x2e
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
-#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
+#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
 
-- 
2.12.2.762.g0e3151a226-goog
