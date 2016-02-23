Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48024 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbcBWArR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:17 -0500
Subject: [PATCH v4 07/11] PCI: Move pci_vpd_release() from header file to
 pci/access.c
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:14 -0600
Message-ID: <20160223004714.10635.28635.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move pci_vpd_release() so it's next to the other VPD functions.  This puts
it next to pci_vpd_pci22_init(), which allocates the space freed by
pci_vpd_release().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    6 ++++++
 drivers/pci/pci.h    |    6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 4c4c734..ca42a33 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -581,6 +581,12 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	return 0;
 }
 
+void pci_vpd_release(struct pci_dev *dev)
+{
+	if (dev->vpd)
+		dev->vpd->ops->release(dev);
+}
+
 /**
  * pci_cfg_access_lock - Lock PCI config reads/writes
  * @dev:	pci device struct
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1660f..52e86b0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -107,11 +107,7 @@ struct pci_vpd {
 };
 
 int pci_vpd_pci22_init(struct pci_dev *dev);
-static inline void pci_vpd_release(struct pci_dev *dev)
-{
-	if (dev->vpd)
-		dev->vpd->ops->release(dev);
-}
+void pci_vpd_release(struct pci_dev *dev);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS

