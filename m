Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37176 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbbIWXcD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 19:32:03 -0400
Received: by wicfx3 with SMTP id fx3so90557739wic.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2015 16:32:01 -0700 (PDT)
From: Romain Bezut <rbezut@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Romain Bezut <rbezut@gmail.com>
Subject: [PATCH] PCI/MSI: Export all remapped MSIs to sysfs attributes
Date: Thu, 24 Sep 2015 01:31:16 +0200
Message-Id: <1443051076-27716-1-git-send-email-rbezut@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

irqbalance uses these attributes to populate its internal database, which is
then used to bind the irq on the appropriate NUMA node.

On a device accepting multiple MSIs and with interrupt remapping enabled,
only the first irq entry is exported to msi_irqs directory.
This results in irqbalance having no clue of the NUMA affinity for the extra
irqs and starting to bind them on random nodes.

This patch exports all MSI interrupts as sysfs attributes when relevant.

Signed-off-by: Romain Bezut <rbezut@gmail.com>
---
 drivers/pci/msi.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d449714..324a164 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -475,10 +475,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	int ret = -ENOMEM;
 	int num_msi = 0;
 	int count = 0;
+	int i;
 
 	/* Determine how many msi entries we have */
 	for_each_pci_msi_entry(entry, pdev)
-		++num_msi;
+		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return 0;
 
@@ -487,19 +488,21 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	if (!msi_attrs)
 		return -ENOMEM;
 	for_each_pci_msi_entry(entry, pdev) {
-		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-		if (!msi_dev_attr)
-			goto error_attrs;
-		msi_attrs[count] = &msi_dev_attr->attr;
-
-		sysfs_attr_init(&msi_dev_attr->attr);
-		msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
-						    entry->irq);
-		if (!msi_dev_attr->attr.name)
-			goto error_attrs;
-		msi_dev_attr->attr.mode = S_IRUGO;
-		msi_dev_attr->show = msi_mode_show;
-		++count;
+		for (i = 0; i < entry->nvec_used; i++) {
+			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
+			if (!msi_dev_attr)
+				goto error_attrs;
+			msi_attrs[count] = &msi_dev_attr->attr;
+
+			sysfs_attr_init(&msi_dev_attr->attr);
+			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
+							    entry->irq + i);
+			if (!msi_dev_attr->attr.name)
+				goto error_attrs;
+			msi_dev_attr->attr.mode = S_IRUGO;
+			msi_dev_attr->show = msi_mode_show;
+			++count;
+		}
 	}
 
 	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-- 
2.4.9

