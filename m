Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59119 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423019AbbFEOLN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:13 -0400
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Cc: zhen-hual@hp.com, bhe@redhat.com, dwmw2@infradead.org,
	vgoyal@redhat.com, dyoung@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	indou.takao@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com,
	jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com,
	lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH 04/17] iommu/vt-d: Load old data structures only in kdump kernel
Date: Fri,  5 Jun 2015 16:10:50 +0200
Message-Id: <1433513463-19128-5-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

If we are not in a kdump kernel anybody could have left the
iommu enabled. We have no reason at all to trust the data
the data structures in this case, so don't even try to
preserve anything.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c         | 14 ++++++++++++++
 drivers/iommu/intel_irq_remapping.c | 12 +++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 982b8c8..d66bec6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -40,6 +40,7 @@
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
+#include <linux/crash_dump.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -2943,6 +2944,19 @@ static int __init init_dmars(void)
 			goto free_iommu;
 
 		iommu_check_pre_te_status(iommu);
+
+		/*
+		 * We don't even try to preserve anything when we are not in a
+		 * kdump kernel.
+		 */
+		if (!is_kdump_kernel() && iommu->pre_enabled_trans) {
+			iommu_disable_translation(iommu);
+			iommu->pre_enabled_trans = 0;
+			g_translation_pre_enabled = 0;
+			pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
+					iommu->name);
+		}
+
 		if (iommu->pre_enabled_trans) {
 			pr_info("IOMMU Copying translate tables from panicked kernel\n");
 			ret = intel_iommu_load_translation_tables(iommu);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 46d80ad..c3f0686 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/intel-iommu.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include <asm/io_apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
@@ -666,11 +667,12 @@ static int __init intel_enable_irq_remapping(void)
 
 		iommu_check_pre_ir_status(iommu);
 
-		/*
-		 * Here we do not disable intr remapping,
-		 * if already enabled prior to OS handover.
-		 */
-		/* iommu_disable_irq_remapping(iommu); */
+		if (!is_kdump_kernel() && iommu->pre_enabled_ir) {
+			iommu_disable_irq_remapping(iommu);
+			iommu->pre_enabled_ir = 0;
+			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
+				iommu->name);
+		}
 
 		dmar_disable_qi(iommu);
 	}
-- 
1.9.1

