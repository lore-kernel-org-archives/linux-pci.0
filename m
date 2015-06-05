Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59083 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423014AbbFEOLM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:12 -0400
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
Subject: [PATCH 01/17] iommu/vt-d: Fix compile error when CONFIG_INTEL_IOMMU=n
Date: Fri,  5 Jun 2015 16:10:47 +0200
Message-Id: <1433513463-19128-2-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The patches for the Intel IOMMU driver to fix issues with
kdump introduced a compile error with:

CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=n
CONFIG_IRQ_REMAP=y

The error manifests as:

drivers/iommu/intel_irq_remapping.c: In function ‘modify_irte’:
drivers/iommu/intel_irq_remapping.c:149:11: error: ‘struct
intel_iommu’ has no member named ‘pre_enabled_ir’
  if (iommu->pre_enabled_ir)

Fix this by moving the declaration of the pre_enabled_ir
under #ifdef CONFIG_IRQ_REMAPPING instead of
CONFIG_INTEL_IOMMU.

Reported-by: Jim Davis <jim.epost@gmail.com>
Cc: Zhen-Hua Li <zhen-hual@hp.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/intel-iommu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d7a0b5d..a81ceee 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -344,8 +344,6 @@ struct intel_iommu {
 
 	/* whether translation is enabled prior to OS*/
 	u8		pre_enabled_trans;
-	/* whether interrupt remapping is enabled prior to OS*/
-	u8		pre_enabled_ir;
 
 	void __iomem	*root_entry_old_virt; /* mapped from old root entry */
 	unsigned long	root_entry_old_phys; /* root entry in old kernel */
@@ -357,6 +355,9 @@ struct intel_iommu {
 
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
+
+	/* whether interrupt remapping is enabled prior to OS*/
+	u8		pre_enabled_ir;
 #endif
 	struct device	*iommu_dev; /* IOMMU-sysfs device */
 	int		node;
-- 
1.9.1

