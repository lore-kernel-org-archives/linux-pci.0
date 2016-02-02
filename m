Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56458 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932932AbcBBTip (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 14:38:45 -0500
Subject: [PATCH 2/5] PCI: Remove includes of empty asm-generic/pci-bridge.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Feb 2016 13:38:42 -0600
Message-ID: <20160202193841.9258.9882.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

include/asm-generic/pci-bridge.h is now empty, so remove every #include of
it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/include/asm/pci.h          |    1 -
 arch/arm/include/asm/pci.h            |    3 ---
 arch/arm64/include/asm/pci.h          |    1 -
 arch/mips/include/asm/pci.h           |    1 -
 arch/powerpc/include/asm/pci-bridge.h |    1 -
 arch/unicore32/include/asm/pci.h      |    2 --
 arch/x86/pci/common.c                 |    1 -
 drivers/of/of_pci.c                   |    1 -
 drivers/pci/pci.c                     |    1 -
 drivers/pci/probe.c                   |    1 -
 drivers/pci/setup-bus.c               |    1 -
 11 files changed, 14 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 98f2eee..75d8865 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -7,7 +7,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <asm/machvec.h>
-#include <asm-generic/pci-bridge.h>
 
 /*
  * The following structure is used to manage multiple PCI busses.
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index a563544..d7de19a 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -3,8 +3,6 @@
 
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
-#include <asm-generic/pci-bridge.h>
-
 #include <asm/mach/pci.h> /* for pci_sys_data */
 
 extern unsigned long pcibios_min_io;
@@ -41,5 +39,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 
 #endif /* __KERNEL__ */
- 
 #endif
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b008a72..f75b04e 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -7,7 +7,6 @@
 #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
-#include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci-dma-compat.h>
 
 #define PCIBIOS_MIN_IO		0x1000
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 98c31e5..108d193 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -102,7 +102,6 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
-#include <asm-generic/pci-bridge.h>
 
 struct pci_dev;
 
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 54843ca..78968c1 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -10,7 +10,6 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
-#include <asm-generic/pci-bridge.h>
 
 struct device_node;
 
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index 38b3f37..eb9dcce 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -14,7 +14,6 @@
 
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
-#include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
@@ -23,5 +22,4 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	enum pci_mmap_state mmap_state, int write_combine);
 
 #endif /* __KERNEL__ */
-
 #endif
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 2879efc..b4a9f23 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -12,7 +12,6 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 
-#include <asm-generic/pci-bridge.h>
 #include <asm/acpi.h>
 #include <asm/segment.h>
 #include <asm/io.h>
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index b1449f7..13f4fed 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -5,7 +5,6 @@
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
-#include <asm-generic/pci-bridge.h>
 
 static inline int __of_pci_pci_compare(struct device_node *node,
 				       unsigned int data)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..64c0a12 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,7 +25,6 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
-#include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
 #include <linux/aer.h>
 #include "pci.h"
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ead1ac1..5eb378f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,7 +15,6 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
-#include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..55641a3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -25,7 +25,6 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
-#include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
 unsigned int pci_flags;

