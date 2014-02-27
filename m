Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:50960 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaB0I4X convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:3:1>);
	Thu, 27 Feb 2014 03:56:23 -0500
Message-Id: <530F0BD3020000780011FC25@nat28.tlf.novell.com>
Date: Thu, 27 Feb 2014 08:56:35 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI/MSI: simplify populate_msi_sysfs()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While originally this was a patch to fix the two memory leaks (which
got preempted by the two commits that went in the day before I wanted
to submit this fix), I think this can (and should) be done more
efficiently:
- swapping the order of the two allocations and storing the
  msi_dev_attr-derived pointer right after allocation, allowing the
  cleanup code to pick things up without extra effort
- using kasprintf() instead of the kmalloc()/sprintf() pair

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/msi.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- 3.14-rc4/drivers/pci/msi.c
+++ 3.14-rc4-pci-msi-sysfs-cleanup/drivers/pci/msi.c
@@ -544,22 +544,18 @@ static int populate_msi_sysfs(struct pci
 	if (!msi_attrs)
 		return -ENOMEM;
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		char *name = kmalloc(20, GFP_KERNEL);
-		if (!name)
-			goto error_attrs;
-
 		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-		if (!msi_dev_attr) {
-			kfree(name);
+		if (!msi_dev_attr)
 			goto error_attrs;
-		}
+		msi_attrs[count] = &msi_dev_attr->attr;
 
-		sprintf(name, "%d", entry->irq);
 		sysfs_attr_init(&msi_dev_attr->attr);
-		msi_dev_attr->attr.name = name;
+		msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
+						    entry->irq);
+		if (!msi_dev_attr->attr.name)
+			goto error_attrs;
 		msi_dev_attr->attr.mode = S_IRUGO;
 		msi_dev_attr->show = msi_mode_show;
-		msi_attrs[count] = &msi_dev_attr->attr;
 		++count;
 	}
 



