Return-Path: <jacek.lawrynowicz@intel.com>
Return-Path: <jacek.lawrynowicz@intel.com>
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
To: helgaas@kernel.org
Cc: lukas@wunner.de,
	jroedel@suse.de,
	alex.williamson@redhat.com,
	linux-pci@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Subject: [PATCH] PCI: Fix merge conflict in amd_iommu.c
Date: Tue, 17 May 2016 11:55:35 +0200
Message-Id: <1463478935-7253-1-git-send-email-jacek.lawrynowicz@intel.com>
In-Reply-To: <20160516201000.GB20759@localhost>
References: <20160516201000.GB20759@localhost>
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
---
 drivers/iommu/amd_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5efadad..3839fd2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -263,8 +263,7 @@ static u16 get_alias(struct device *dev)
 	 */
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		pdev->dma_alias_devfn = ivrs_alias & 0xff;
+		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
 		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
-- 
1.8.3.1
