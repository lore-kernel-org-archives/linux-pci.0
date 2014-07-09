Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:63332 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbaGIPdV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 11:33:21 -0400
Received: by mail-ig0-f176.google.com with SMTP id r10so2000439igi.9
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 08:33:20 -0700 (PDT)
Received: from localhost ([172.16.48.225])
        by mx.google.com with ESMTPSA id j10sm16335046igv.17.2014.07.09.08.33.19
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 08:33:19 -0700 (PDT)
Subject: [PATCH 1/3] PCI: Cleanup control flow
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 09 Jul 2014 09:33:18 -0600
Message-ID: <20140709153318.1004.88406.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return errors immediately so the straightline path is the normal,
no-error path.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 481c4e18693a..532dc540dc5d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -305,14 +305,16 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	if (ret < 0)
 		ret = pci_revert_fw_address(res, dev, resno, size);
 
-	if (!ret) {
-		res->flags &= ~IORESOURCE_UNSET;
-		res->flags &= ~IORESOURCE_STARTALIGN;
-		dev_info(&dev->dev, "BAR %d: assigned %pR\n", resno, res);
-		if (resno < PCI_BRIDGE_RESOURCES)
-			pci_update_resource(dev, resno);
-	}
-	return ret;
+	if (ret)
+		return ret;
+
+	res->flags &= ~IORESOURCE_UNSET;
+	res->flags &= ~IORESOURCE_STARTALIGN;
+	dev_info(&dev->dev, "BAR %d: assigned %pR\n", resno, res);
+	if (resno < PCI_BRIDGE_RESOURCES)
+		pci_update_resource(dev, resno);
+
+	return 0;
 }
 EXPORT_SYMBOL(pci_assign_resource);
 
@@ -335,19 +337,20 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	/* already aligned with min_align */
 	new_size = resource_size(res) + addsize;
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
-	if (!ret) {
-		res->flags &= ~IORESOURCE_UNSET;
-		res->flags &= ~IORESOURCE_STARTALIGN;
-		dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
-		if (resno < PCI_BRIDGE_RESOURCES)
-			pci_update_resource(dev, resno);
-	} else {
+	if (ret) {
 		res->flags = flags;
 		dev_info(&dev->dev, "BAR %d: %pR (failed to expand by %#llx)\n",
 			 resno, res, (unsigned long long) addsize);
+		return ret;
 	}
 
-	return ret;
+	res->flags &= ~IORESOURCE_UNSET;
+	res->flags &= ~IORESOURCE_STARTALIGN;
+	dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
+	if (resno < PCI_BRIDGE_RESOURCES)
+		pci_update_resource(dev, resno);
+
+	return 0;
 }
 
 int pci_enable_resources(struct pci_dev *dev, int mask)

