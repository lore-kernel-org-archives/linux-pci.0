Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5/7] amd_iommu: Make use of DMA quirks and ACS checks in IOMMU
 groups
To: joerg.roedel@amd.com, dwmw2@infradead.org,
	iommu@lists.linux-foundation.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, aik@ozlabs.ru,
	david@gibson.dropbear.id.au, konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, ddutile@redhat.com,
	alex.williamson@redhat.com
Date: Tue, 29 May 2012 23:10:34 -0600
Message-ID: <20120530051034.1543.46304.stgit@bling.home>
In-Reply-To: <20120530045150.1543.73660.stgit@bling.home>
References: <20120530045150.1543.73660.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Work around broken devices and adhere to ACS support when determining
IOMMU grouping.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

 drivers/iommu/amd_iommu.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c0385b3..9b2e2c9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -254,6 +254,8 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
+#define PCI_ACS_ENABLED	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+
 static int iommu_init_device(struct device *dev)
 {
 	struct pci_dev *dma_pdev, *pdev = to_pci_dev(dev);
@@ -291,6 +293,22 @@ static int iommu_init_device(struct device *dev)
 		dma_pdev = pci_get_slot(pdev->bus,
 					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
 
+	dma_pdev = pci_dma_source(dma_pdev);
+
+	if (dma_pdev->multifunction &&
+	    !pci_acs_enabled(dma_pdev, PCI_ACS_ENABLED))
+		dma_pdev = pci_get_slot(dma_pdev->bus,
+					PCI_DEVFN(PCI_SLOT(dma_pdev->devfn),
+					0));
+
+	while (!pci_is_root_bus(dma_pdev->bus)) {
+		if (pci_acs_path_enabled(dma_pdev->bus->self,
+					 NULL, PCI_ACS_ENABLED))
+			break;
+
+		dma_pdev = dma_pdev->bus->self;
+	}
+
 	group = iommu_group_get(&dma_pdev->dev);
 	if (!group) {
 		group = iommu_group_alloc();

