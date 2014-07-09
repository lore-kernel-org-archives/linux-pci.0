Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52773 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbaGIPd1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 11:33:27 -0400
Received: by mail-ie0-f180.google.com with SMTP id tr6so4439934ieb.39
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 08:33:26 -0700 (PDT)
Received: from localhost ([172.16.48.225])
        by mx.google.com with ESMTPSA id b2sm16376241igg.1.2014.07.09.08.33.25
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 08:33:26 -0700 (PDT)
Subject: [PATCH 2/3] PCI: Return conventional error values from
 pci_revert_fw_address()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 09 Jul 2014 09:33:25 -0600
Message-ID: <20140709153325.1004.93124.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we returned zero for success or 1 for failure.  This changes
that so we return zero for success or a negative errno for failure.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 532dc540dc5d..74eb6febdf87 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -166,11 +166,10 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 {
 	struct resource *root, *conflict;
 	resource_size_t fw_addr, start, end;
-	int ret = 0;
 
 	fw_addr = pcibios_retrieve_fw_addr(dev, resno);
 	if (!fw_addr)
-		return 1;
+		return -ENOMEM;
 
 	start = res->start;
 	end = res->end;
@@ -189,14 +188,13 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 		 resno, res);
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
-		dev_info(&dev->dev,
-			 "BAR %d: %pR conflicts with %s %pR\n", resno,
-			 res, conflict->name, conflict);
+		dev_info(&dev->dev, "BAR %d: %pR conflicts with %s %pR\n",
+			 resno, res, conflict->name, conflict);
 		res->start = start;
 		res->end = end;
-		ret = 1;
+		return -EBUSY;
 	}
-	return ret;
+	return 0;
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
@@ -305,7 +303,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	if (ret < 0)
 		ret = pci_revert_fw_address(res, dev, resno, size);
 
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	res->flags &= ~IORESOURCE_UNSET;

