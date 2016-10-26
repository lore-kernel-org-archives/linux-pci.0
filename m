Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbcJZSBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 14:01:40 -0400
Subject: [PATCH 4/5] iommu: Move REQ_ACS_FLAGS out to header and rename
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 12:01:34 -0600
Message-ID: <20161026180134.23495.27520.stgit@gimli.home>
In-Reply-To: <20161026175156.23495.12980.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow other parts of the kernel to see which PCI ACS flags the IOMMU
layer considers necessary for isolation.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/iommu.c |   18 +++++-------------
 include/linux/iommu.h |   11 +++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b06d935..f73e6f4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -610,16 +610,6 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 					       unsigned long *devfns);
 
 /*
- * To consider a PCI device isolated, we require ACS to support Source
- * Validation, Request Redirection, Completer Redirection, and Upstream
- * Forwarding.  This effectively means that devices cannot spoof their
- * requester ID, requests and completions cannot be redirected, and all
- * transactions are forwarded upstream, even as it passes through a
- * bridge where the target device is downstream.
- */
-#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
-/*
  * For multifunction devices which are not isolated from each other, find
  * all the other non-isolated functions and look for existing groups.  For
  * each function, we also need to look for aliases to or from other devices
@@ -631,13 +621,14 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	if (!pdev->multifunction ||
+	    pci_acs_enabled(pdev, IOMMU_REQ_PCI_ACS_FLAGS))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
 		if (tmp == pdev || tmp->bus != pdev->bus ||
 		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
-		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
+		    pci_acs_enabled(tmp, IOMMU_REQ_PCI_ACS_FLAGS))
 			continue;
 
 		group = get_pci_alias_group(tmp, devfns);
@@ -765,7 +756,8 @@ struct iommu_group *pci_device_group(struct device *dev)
 		if (!bus->self)
 			continue;
 
-		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
+		if (pci_acs_path_enabled(bus->self, NULL,
+					 IOMMU_REQ_PCI_ACS_FLAGS))
 			break;
 
 		pdev = bus->self;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a35fb8b..23f4d1d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -131,6 +131,17 @@ struct iommu_dm_region {
 	int			prot;
 };
 
+/*
+ * To consider a PCI device isolated, we require ACS to support Source
+ * Validation, Request Redirection, Completer Redirection, and Upstream
+ * Forwarding.  This effectively means that devices cannot spoof their
+ * requester ID, requests and completions cannot be redirected, and all
+ * transactions are forwarded upstream, even as it passes through a
+ * bridge where the target device is downstream.
+ */
+#define IOMMU_REQ_PCI_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | \
+				   PCI_ACS_CR | PCI_ACS_UF)
+
 #ifdef CONFIG_IOMMU_API
 
 /**

