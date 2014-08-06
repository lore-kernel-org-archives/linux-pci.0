Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57071 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbaHFOy2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 10:54:28 -0400
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jon.mason@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	Gerhard Sittig <gsi@denx.de>
Subject: [PATCH RFC v1 1/4] ntb: split Intel specifics out of the "NTB hardware" interface
Date: Wed,  6 Aug 2014 16:53:52 +0200
Message-Id: <1407336835-30586-2-git-send-email-gsi@denx.de>
In-Reply-To: <1407336835-30586-1-git-send-email-gsi@denx.de>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename the ntb_hw.c compile unit and adjust the Makefile, to reflect
that this code drives Intel hardware.  Move Intel specific declarations
from ntb_hw.h to a separate ntb_hw_intel.h header file and rename the
Intel specific register set header file.

This leaves the ntb_hw.h header file with the declaration of the
interface between the 'data transport' and the 'hardware' aspects.

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/ntb/Makefile                         |    2 +-
 drivers/ntb/ntb_hw.h                         |   21 --------
 drivers/ntb/{ntb_hw.c => ntb_hw_intel.c}     |   11 ++--
 drivers/ntb/ntb_hw_intel.h                   |   73 ++++++++++++++++++++++++++
 drivers/ntb/{ntb_regs.h => ntb_regs_intel.h} |    0
 5 files changed, 80 insertions(+), 27 deletions(-)
 rename drivers/ntb/{ntb_hw.c => ntb_hw_intel.c} (99%)
 create mode 100644 drivers/ntb/ntb_hw_intel.h
 rename drivers/ntb/{ntb_regs.h => ntb_regs_intel.h} (100%)

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 15cb59fd354e..468ca8ea395e 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_NTB) += ntb.o
 
-ntb-objs := ntb_hw.o ntb_transport.o
+ntb-objs := ntb_hw_intel.o ntb_transport.o
diff --git a/drivers/ntb/ntb_hw.h b/drivers/ntb/ntb_hw.h
index 465517b7393e..9cb288c045db 100644
--- a/drivers/ntb/ntb_hw.h
+++ b/drivers/ntb/ntb_hw.h
@@ -47,19 +47,6 @@
  */
 #include <linux/ntb.h>
 
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF		0x3725
-#define PCI_DEVICE_ID_INTEL_NTB_PS_JSF		0x3726
-#define PCI_DEVICE_ID_INTEL_NTB_SS_JSF		0x3727
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_SNB		0x3C0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_SNB		0x3C0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_SNB		0x3C0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_IVT		0x0E0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_IVT		0x0E0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_IVT		0x0E0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX		0x2F0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX		0x2F0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX		0x2F0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD		0x0C4E
 
 #ifndef readq
 static inline u64 readq(void __iomem *addr)
@@ -76,14 +63,6 @@ static inline void writeq(u64 val, void __iomem *addr)
 }
 #endif
 
-#define NTB_BAR_MMIO		0
-#define NTB_BAR_23		2
-#define NTB_BAR_45		4
-#define NTB_BAR_MASK		((1 << NTB_BAR_MMIO) | (1 << NTB_BAR_23) |\
-				 (1 << NTB_BAR_45))
-
-#define NTB_HB_TIMEOUT		msecs_to_jiffies(1000)
-
 #define NTB_MAX_NUM_MW		2
 
 enum ntb_hw_event {
diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw_intel.c
similarity index 99%
rename from drivers/ntb/ntb_hw.c
rename to drivers/ntb/ntb_hw_intel.c
index 372e08c4ffef..699f05132a61 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw_intel.c
@@ -54,13 +54,14 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include "ntb_hw.h"
-#include "ntb_regs.h"
+#include "ntb_hw_intel.h"
+#include "ntb_regs_intel.h"
 
-#define NTB_NAME	"Intel(R) PCI-E Non-Transparent Bridge Driver"
-#define NTB_VER		"1.0"
+#define NTB_HW_INTEL_NAME	"Intel(R) PCI-E Non-Transparent Bridge Driver"
+#define NTB_HW_INTEL_VER	"1.0"
 
-MODULE_DESCRIPTION(NTB_NAME);
-MODULE_VERSION(NTB_VER);
+MODULE_DESCRIPTION(NTB_HW_INTEL_NAME);
+MODULE_VERSION(NTB_HW_INTEL_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
diff --git a/drivers/ntb/ntb_hw_intel.h b/drivers/ntb/ntb_hw_intel.h
new file mode 100644
index 000000000000..93e2c3977394
--- /dev/null
+++ b/drivers/ntb/ntb_hw_intel.h
@@ -0,0 +1,73 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ *   redistributing this file, you may do so under either license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of version 2 of the GNU General Public License as
+ *   published by the Free Software Foundation.
+ *
+ *   BSD LICENSE
+ *
+ *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *
+ *   Redistribution and use in source and binary forms, with or without
+ *   modification, are permitted provided that the following conditions
+ *   are met:
+ *
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copy
+ *       notice, this list of conditions and the following disclaimer in
+ *       the documentation and/or other materials provided with the
+ *       distribution.
+ *     * Neither the name of Intel Corporation nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Intel PCIe NTB Linux driver
+ *
+ * Contact Information:
+ * Jon Mason <jon.mason@intel.com>
+ */
+#ifndef NTB_HW_INTEL_H
+#define NTB_HW_INTEL_H
+
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF		0x3725
+#define PCI_DEVICE_ID_INTEL_NTB_PS_JSF		0x3726
+#define PCI_DEVICE_ID_INTEL_NTB_SS_JSF		0x3727
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_SNB		0x3C0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_SNB		0x3C0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_SNB		0x3C0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_IVT		0x0E0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_IVT		0x0E0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_IVT		0x0E0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX		0x2F0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX		0x2F0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX		0x2F0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD		0x0C4E
+
+#define NTB_BAR_MMIO		0
+#define NTB_BAR_23		2
+#define NTB_BAR_45		4
+#define NTB_BAR_MASK		((1 << NTB_BAR_MMIO) | (1 << NTB_BAR_23) |\
+				 (1 << NTB_BAR_45))
+
+#define NTB_HB_TIMEOUT		msecs_to_jiffies(1000)
+
+#endif /* NTB_HW_INTEL_H */
diff --git a/drivers/ntb/ntb_regs.h b/drivers/ntb/ntb_regs_intel.h
similarity index 100%
rename from drivers/ntb/ntb_regs.h
rename to drivers/ntb/ntb_regs_intel.h
-- 
1.7.10.4

