Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 22/36] iommu/io-pgtable-arm: Factor out ARM LPAE register defines
Date: Fri,  6 Oct 2017 14:31:49 +0100
Message-Id: <20171006133203.22803-23-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For SVM, we'll need to extract CPU page table information and mirror it in
the substream setup. Move relevant defines to a common header.

Fix TCR_SZ_MASK while we're at it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 MAINTAINERS                    |  1 +
 drivers/iommu/io-pgtable-arm.c | 48 +-----------------------------
 drivers/iommu/io-pgtable-arm.h | 67 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 47 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 65b0c88d5ee0..cff90315c2ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1089,6 +1089,7 @@ S:	Maintained
 F:	drivers/iommu/arm-smmu.c
 F:	drivers/iommu/arm-smmu-v3.c
 F:	drivers/iommu/io-pgtable-arm.c
+F:	drivers/iommu/io-pgtable-arm.h
 F:	drivers/iommu/io-pgtable-arm-v7s.c
 
 ARM SUB-ARCHITECTURES
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a308868..443234a564a6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -31,6 +31,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		48
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -118,53 +119,6 @@
 #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
 
 /* Register bits */
-#define ARM_32_LPAE_TCR_EAE		(1 << 31)
-#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
-
-#define ARM_LPAE_TCR_EPD1		(1 << 23)
-
-#define ARM_LPAE_TCR_TG0_4K		(0 << 14)
-#define ARM_LPAE_TCR_TG0_64K		(1 << 14)
-#define ARM_LPAE_TCR_TG0_16K		(2 << 14)
-
-#define ARM_LPAE_TCR_SH0_SHIFT		12
-#define ARM_LPAE_TCR_SH0_MASK		0x3
-#define ARM_LPAE_TCR_SH_NS		0
-#define ARM_LPAE_TCR_SH_OS		2
-#define ARM_LPAE_TCR_SH_IS		3
-
-#define ARM_LPAE_TCR_ORGN0_SHIFT	10
-#define ARM_LPAE_TCR_IRGN0_SHIFT	8
-#define ARM_LPAE_TCR_RGN_MASK		0x3
-#define ARM_LPAE_TCR_RGN_NC		0
-#define ARM_LPAE_TCR_RGN_WBWA		1
-#define ARM_LPAE_TCR_RGN_WT		2
-#define ARM_LPAE_TCR_RGN_WB		3
-
-#define ARM_LPAE_TCR_SL0_SHIFT		6
-#define ARM_LPAE_TCR_SL0_MASK		0x3
-
-#define ARM_LPAE_TCR_T0SZ_SHIFT		0
-#define ARM_LPAE_TCR_SZ_MASK		0xf
-
-#define ARM_LPAE_TCR_PS_SHIFT		16
-#define ARM_LPAE_TCR_PS_MASK		0x7
-
-#define ARM_LPAE_TCR_IPS_SHIFT		32
-#define ARM_LPAE_TCR_IPS_MASK		0x7
-
-#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
-#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
-#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
-#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
-#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
-#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
-
-#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
-#define ARM_LPAE_MAIR_ATTR_MASK		0xff
-#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
-#define ARM_LPAE_MAIR_ATTR_NC		0x44
-#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
 #define ARM_LPAE_MAIR_ATTR_IDX_NC	0
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
new file mode 100644
index 000000000000..cb31314971ac
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -0,0 +1,67 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2017 ARM Limited
+ */
+#ifndef __IO_PGTABLE_ARM_H
+#define __IO_PGTABLE_ARM_H
+
+#define ARM_32_LPAE_TCR_EAE		(1 << 31)
+#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
+
+#define ARM_LPAE_TCR_EPD1		(1 << 23)
+
+#define ARM_LPAE_TCR_TG0_4K		(0 << 14)
+#define ARM_LPAE_TCR_TG0_64K		(1 << 14)
+#define ARM_LPAE_TCR_TG0_16K		(2 << 14)
+
+#define ARM_LPAE_TCR_SH0_SHIFT		12
+#define ARM_LPAE_TCR_SH0_MASK		0x3
+#define ARM_LPAE_TCR_SH_NS		0
+#define ARM_LPAE_TCR_SH_OS		2
+#define ARM_LPAE_TCR_SH_IS		3
+
+#define ARM_LPAE_TCR_ORGN0_SHIFT	10
+#define ARM_LPAE_TCR_IRGN0_SHIFT	8
+#define ARM_LPAE_TCR_RGN_MASK		0x3
+#define ARM_LPAE_TCR_RGN_NC		0
+#define ARM_LPAE_TCR_RGN_WBWA		1
+#define ARM_LPAE_TCR_RGN_WT		2
+#define ARM_LPAE_TCR_RGN_WB		3
+
+#define ARM_LPAE_TCR_SL0_SHIFT		6
+#define ARM_LPAE_TCR_SL0_MASK		0x3
+
+#define ARM_LPAE_TCR_T0SZ_SHIFT		0
+#define ARM_LPAE_TCR_SZ_MASK		0x3f
+
+#define ARM_LPAE_TCR_PS_SHIFT		16
+#define ARM_LPAE_TCR_PS_MASK		0x7
+
+#define ARM_LPAE_TCR_IPS_SHIFT		32
+#define ARM_LPAE_TCR_IPS_MASK		0x7
+
+#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
+#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
+#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
+#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
+#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
+#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+
+#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
+#define ARM_LPAE_MAIR_ATTR_MASK		0xff
+#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
+#define ARM_LPAE_MAIR_ATTR_NC		0x44
+#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
+
+#endif /* __IO_PGTABLE_ARM_H */
-- 
2.13.3

