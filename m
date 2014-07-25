Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:51927 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759774AbaGYIgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Jul 2014 04:36:20 -0400
From: Tobias Klauser <tklauser@distanz.ch>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Remove unnecessary variable in pci_add_dynid()
Date: Fri, 25 Jul 2014 10:36:14 +0200
Message-Id: <1406277374-559-1-git-send-email-tklauser@distanz.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The variable retval in pci_add_dynid() is only used to store the return
value of driver_attach() and is then directly returned. Remove the
variable and directly pass on driver_attach()'s return value.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/pci/pci-driver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d04c5ad..2b3c894 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -55,7 +55,6 @@ int pci_add_dynid(struct pci_driver *drv,
 		  unsigned long driver_data)
 {
 	struct pci_dynid *dynid;
-	int retval;
 
 	dynid = kzalloc(sizeof(*dynid), GFP_KERNEL);
 	if (!dynid)
@@ -73,9 +72,7 @@ int pci_add_dynid(struct pci_driver *drv,
 	list_add_tail(&dynid->node, &drv->dynids.list);
 	spin_unlock(&drv->dynids.lock);
 
-	retval = driver_attach(&drv->driver);
-
-	return retval;
+	return driver_attach(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(pci_add_dynid);
 
-- 
2.0.1


