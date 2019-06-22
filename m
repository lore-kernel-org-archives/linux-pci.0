Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D09C43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E1E206B6
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFUX5Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:57:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:48780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfFUX5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:57:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 16:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; 
   d="scan'208";a="359022891"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2019 16:57:21 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, megha.dey@intel.com,
        Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 RESEND 4/6] PCI/MSI: Introduce new structure to manage MSI-x entries
Date:   Fri, 21 Jun 2019 17:19:36 -0700
Message-Id: <1561162778-12669-5-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a preparatory patch to introduce disabling of MSI-X vectors
belonging to a particular group. In this patch, we introduce a new
structure msix_sysfs, which manages sysfs entries for dynamically
allocated MSI-X vectors belonging to a particular group.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 12 +++++++++++-
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  9 +++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fd7fa6e..e947243 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -479,10 +479,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	struct device_attribute *msi_dev_attr;
 	struct attribute_group *msi_irq_group;
 	const struct attribute_group **msi_irq_groups;
+	struct msix_sysfs *msix_sysfs_entry;
 	struct msi_desc *entry;
 	int ret = -ENOMEM;
 	int num_msi = 0;
-	int count = 0;
+	int count = 0, group = -1;
 	int i;
 
 	/* Determine how many msi entries we have */
@@ -509,6 +510,8 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 				goto error_attrs;
 			msi_dev_attr->attr.mode = S_IRUGO;
 			msi_dev_attr->show = msi_mode_show;
+			if (!i)
+				group = entry->group_id;
 			++count;
 		}
 	}
@@ -524,6 +527,13 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		goto error_irq_group;
 	msi_irq_groups[0] = msi_irq_group;
 
+	msix_sysfs_entry = kzalloc(sizeof(*msix_sysfs_entry) * 2, GFP_KERNEL);
+	msix_sysfs_entry->msi_irq_group = msi_irq_group;
+	msix_sysfs_entry->group_id = group;
+	msix_sysfs_entry->vecs_in_grp = count;
+	INIT_LIST_HEAD(&msix_sysfs_entry->list);
+	list_add_tail(&msix_sysfs_entry->list, &pdev->msix_sysfs);
+
 	if (!pdev->msix_enabled)
 		ret = sysfs_create_group(&pdev->dev.kobj, msi_irq_group);
 	else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 491c1cf..bb20ef6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2435,6 +2435,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	idr_init(dev->grp_idr);
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->msix_sysfs);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c56462c..73385c0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -471,6 +471,7 @@ struct pci_dev {
 	struct idr	*grp_idr;       /* IDR to assign group to MSI-X vecs */
 	unsigned long	*entry;         /* Bitmap to represent MSI-X entries */
 	bool		one_shot;	/* If true, oneshot MSI-X allocation */
+	struct list_head	msix_sysfs; /* sysfs entries for MSI-X group */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -1390,6 +1391,14 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
+/* Manage sysfs entries for dynamically allocated MSI-X vectors */
+struct msix_sysfs {
+	struct	attribute_group *msi_irq_group;
+	struct	list_head list;
+	int	group_id;
+	int	vecs_in_grp;
+};
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
-- 
2.7.4

