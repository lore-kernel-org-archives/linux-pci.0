Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47912 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379AbcBWAqs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:46:48 -0500
Subject: [PATCH v4 03/11] PCI: Use bitfield instead of bool for struct
 pci_vpd_pci22.busy
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:46:45 -0600
Message-ID: <20160223004645.10635.98577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make struct pci_vpd_pci22.busy a 1-bit field instead of a bool.  We intend
to add another flag, and two bitfields are cheaper than two bools.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 8c05b5c..a7f0069 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -283,8 +283,8 @@ struct pci_vpd_pci22 {
 	struct pci_vpd base;
 	struct mutex lock;
 	u16	flag;
-	bool	busy;
 	u8	cap;
+	u8	busy:1;
 };
 
 /*
@@ -313,7 +313,7 @@ static int pci_vpd_pci22_wait(struct pci_dev *dev)
 			return ret;
 
 		if ((status & PCI_VPD_ADDR_F) == vpd->flag) {
-			vpd->busy = false;
+			vpd->busy = 0;
 			return 0;
 		}
 
@@ -355,7 +355,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 						 pos & ~3);
 		if (ret < 0)
 			break;
-		vpd->busy = true;
+		vpd->busy = 1;
 		vpd->flag = PCI_VPD_ADDR_F;
 		ret = pci_vpd_pci22_wait(dev);
 		if (ret < 0)
@@ -415,7 +415,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 		if (ret < 0)
 			break;
 
-		vpd->busy = true;
+		vpd->busy = 1;
 		vpd->flag = 0;
 		ret = pci_vpd_pci22_wait(dev);
 		if (ret < 0)
@@ -495,7 +495,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 		vpd->base.ops = &pci_vpd_pci22_ops;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
-	vpd->busy = false;
+	vpd->busy = 0;
 	dev->vpd = &vpd->base;
 	return 0;
 }

