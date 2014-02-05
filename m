Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49133 "EHLO
	alan.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751274AbaBELyc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 06:54:32 -0500
Received: from alan.etchedpixels.co.uk (localhost [127.0.0.1])
	by alan.etchedpixels.co.uk (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id s15BsYfb014448
	for <linux-pci@vger.kernel.org>; Wed, 5 Feb 2014 11:54:35 GMT
Subject: [PATCH] pci: allocation check missing
To: linux-pci@vger.kernel.org
From: Alan <gnomes@lxorguk.ukuu.org.uk>
Date: Wed, 05 Feb 2014 11:54:34 +0000
Message-ID: <20140205115412.14423.23707.stgit@alan.etchedpixels.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we fail to allocate the name, just drop nicely into the fail path

(as a footnote someone who works on this code more might want to shuffle
 the allocations about so the name and attributes are allocated and freed
 as one. There seems to be no reason to keep them separate)

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/pci/msi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 18ca2497..9bdf290 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -544,9 +544,13 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		return -ENOMEM;
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		char *name = kmalloc(20, GFP_KERNEL);
+		if (!name)
+		        goto error_attrs;
 		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-		if (!msi_dev_attr)
+		if (!msi_dev_attr) {
+		        kfree(name);
 			goto error_attrs;
+                }
 		sprintf(name, "%d", entry->irq);
 		sysfs_attr_init(&msi_dev_attr->attr);
 		msi_dev_attr->attr.name = name;

