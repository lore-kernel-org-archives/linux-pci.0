Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:41247 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbaGIPde (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 11:33:34 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so2000224igq.9
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 08:33:33 -0700 (PDT)
Received: from localhost ([172.16.48.225])
        by mx.google.com with ESMTPSA id t1sm16346471igh.9.2014.07.09.08.33.32
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 08:33:33 -0700 (PDT)
Subject: [PATCH 3/3] PCI: Tidy resource assignment messages
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 09 Jul 2014 09:33:31 -0600
Message-ID: <20140709153331.1004.51135.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Print messages about failures in pci_assign_resource().  We can drop the
"by-hand" message from _pci_assign_resource() because %pR now prints the
size rather than the address if the resource hasn't been assigned.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 74eb6febdf87..6a9e4ec37af0 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -251,7 +251,6 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 	struct resource *res = dev->resource + resno;
 	struct pci_bus *bus;
 	int ret;
-	char *type;
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
@@ -260,21 +259,6 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 		bus = bus->parent;
 	}
 
-	if (ret) {
-		if (res->flags & IORESOURCE_MEM)
-			if (res->flags & IORESOURCE_PREFETCH)
-				type = "mem pref";
-			else
-				type = "mem";
-		else if (res->flags & IORESOURCE_IO)
-			type = "io";
-		else
-			type = "unknown";
-		dev_info(&dev->dev,
-			 "BAR %d: can't assign %s (size %#llx)\n",
-			 resno, type, (unsigned long long) resource_size(res));
-	}
-
 	return ret;
 }
 
@@ -300,11 +284,16 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	 * where firmware left it.  That at least has a chance of
 	 * working, which is better than just leaving it disabled.
 	 */
-	if (ret < 0)
+	if (ret < 0) {
+		dev_info(&dev->dev, "BAR %d: no space for %pR\n", resno, res);
 		ret = pci_revert_fw_address(res, dev, resno, size);
+	}
 
-	if (ret < 0)
+	if (ret < 0) {
+		dev_info(&dev->dev, "BAR %d: failed to assign %pR\n", resno,
+			 res);
 		return ret;
+	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
@@ -344,7 +333,8 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
+	dev_info(&dev->dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
+		 resno, res, (unsigned long long) addsize);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 

