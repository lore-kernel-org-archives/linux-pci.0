Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] vmd: allocate irq lists with correct msix count
Date: Mon, 29 Aug 2016 11:19:01 -0600
Message-Id: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

To reduce the amount of memory required for irq lists, only allocate
their space after calling pci_msix_enable_range which may reduce the
number of msix vectors allocated.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 8d6bb8a..514b446 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -679,11 +679,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
-				 GFP_KERNEL);
-	if (!vmd->irqs)
-		return -ENOMEM;
-
 	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
 					 sizeof(*vmd->msix_entries),
 					 GFP_KERNEL);
@@ -697,6 +692,11 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
+	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
+				 GFP_KERNEL);
+	if (!vmd->irqs)
+		return -ENOMEM;
+
 	for (i = 0; i < vmd->msix_count; i++) {
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
 		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
-- 
1.8.3.1
