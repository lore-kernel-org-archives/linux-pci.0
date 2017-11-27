Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbdK0Q64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 11:58:56 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 12/29] iommu/amd: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:57:49 -0500
Message-Id: <1511801886-6753-13-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-code the domain number as 0 for the AMD IOMMU driver.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/iommu/amd_iommu.c      | 3 ++-
 drivers/iommu/amd_iommu_init.c | 9 +++++----
 drivers/iommu/amd_iommu_v2.c   | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8e8874d..2c3452f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -528,7 +528,8 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
 
-	pdev = pci_get_bus_and_slot(PCI_BUS_NUM(devid), devid & 0xff);
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
 	if (pdev)
 		dev_data = get_dev_data(&pdev->dev);
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d03..4e4a615 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1697,8 +1697,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	u32 range, misc, low, high;
 	int ret;
 
-	iommu->dev = pci_get_bus_and_slot(PCI_BUS_NUM(iommu->devid),
-					  iommu->devid & 0xff);
+	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
+						 iommu->devid & 0xff);
 	if (!iommu->dev)
 		return -ENODEV;
 
@@ -1764,8 +1764,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
-		iommu->root_pdev = pci_get_bus_and_slot(iommu->dev->bus->number,
-				PCI_DEVFN(0, 0));
+		iommu->root_pdev =
+			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
+						    PCI_DEVFN(0, 0));
 
 		/*
 		 * Some rd890 systems may not be fully reconfigured by the
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 7d94e1d..8696382 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -564,7 +564,8 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	finish      = (iommu_fault->tag >> 9) & 1;
 
 	devid = iommu_fault->device_id;
-	pdev = pci_get_bus_and_slot(PCI_BUS_NUM(devid), devid & 0xff);
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
 	dev_data = get_dev_data(&pdev->dev);
-- 
1.9.1
