Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48051 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbcBWArY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:24 -0500
Subject: [PATCH v4 08/11] PCI: Remove struct pci_vpd_ops.release function
 pointer
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:21 -0600
Message-ID: <20160223004721.10635.89434.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct pci_vpd_ops.release function pointer is always
pci_vpd_pci22_release(), so there's no need for the flexibility of a
function pointer.

Inline the pci_vpd_pci22_release() body into pci_vpd_release() and remove
pci_vpd_pci22_release() and the struct pci_vpd_ops.release function
pointer.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    9 +--------
 drivers/pci/pci.h    |    1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ca42a33..68ed22a 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -508,15 +508,9 @@ out:
 	return ret ? ret : count;
 }
 
-static void pci_vpd_pci22_release(struct pci_dev *dev)
-{
-	kfree(container_of(dev->vpd, struct pci_vpd_pci22, base));
-}
-
 static const struct pci_vpd_ops pci_vpd_pci22_ops = {
 	.read = pci_vpd_pci22_read,
 	.write = pci_vpd_pci22_write,
-	.release = pci_vpd_pci22_release,
 };
 
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
@@ -552,7 +546,6 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.read = pci_vpd_f0_read,
 	.write = pci_vpd_f0_write,
-	.release = pci_vpd_pci22_release,
 };
 
 int pci_vpd_pci22_init(struct pci_dev *dev)
@@ -584,7 +577,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 void pci_vpd_release(struct pci_dev *dev)
 {
 	if (dev->vpd)
-		dev->vpd->ops->release(dev);
+		kfree(container_of(dev->vpd, struct pci_vpd_pci22, base));
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 52e86b0..b3e9daa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,7 +97,6 @@ static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-	void (*release)(struct pci_dev *dev);
 };
 
 struct pci_vpd {

