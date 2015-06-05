Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH 05/17] iommu/vt-d: Mark root-entry present in set_root_entry
Date: Fri,  5 Jun 2015 16:10:51 +0200
Message-Id: <1433513463-19128-6-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

When we do no memcpy from the old to the new kernel for the
root entry table, we have to set the present bit ourself.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d66bec6..cda0901 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -198,8 +198,7 @@ static inline bool root_present(struct root_entry *root)
 
 static inline void set_root_value(struct root_entry *root, unsigned long value)
 {
-	root->lo &= ~VTD_PAGE_MASK;
-	root->lo |= value & VTD_PAGE_MASK;
+	root->lo = (value & VTD_PAGE_MASK) | 1;
 }
 
 static inline struct context_entry *
-- 
1.9.1

