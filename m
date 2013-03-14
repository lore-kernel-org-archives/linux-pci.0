Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:43127 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3CNRqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 13:46:01 -0400
Received: from /spool/local
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Thu, 14 Mar 2013 14:45:59 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 284331DC006E
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 13:45:56 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2EHhoh72326598
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 14:43:50 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2EHjtdQ013436
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 14:45:55 -0300
From: lucaskt@linux.vnet.ibm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-pci@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, brking@linux.vnet.ibm.com,
	cascardo@linux.vnet.ibm.com,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: [PATCH 1/2] drm: Move drm_pcie_get_speed_cap_mask to PCI
Date: Thu, 14 Mar 2013 14:45:46 -0300
Message-Id: <1363283147-8852-2-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1363283147-8852-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363283147-8852-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>

This function was more architecture related than drm related, as such it was
moved to the PCI driver.

This patch also allows it to be overwritten by architecture-dependent
implementations, and fixes the radeon driver (only one that uses it).

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 drivers/gpu/drm/drm_pci.c          |   38 -------------------------------
 drivers/gpu/drm/radeon/evergreen.c |    5 ++-
 drivers/gpu/drm/radeon/r600.c      |    5 ++-
 drivers/gpu/drm/radeon/rv770.c     |    5 ++-
 drivers/pci/pci.c                  |   43 ++++++++++++++++++++++++++++++++++++
 include/drm/drmP.h                 |    6 -----
 include/linux/pci.h                |    6 +++++
 7 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index bd719e9..ba70844 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -439,44 +439,6 @@ int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
 	return 0;
 }
 
-int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
-{
-	struct pci_dev *root;
-	u32 lnkcap, lnkcap2;
-
-	*mask = 0;
-	if (!dev->pdev)
-		return -EINVAL;
-
-	root = dev->pdev->bus->self;
-
-	/* we've been informed via and serverworks don't make the cut */
-	if (root->vendor == PCI_VENDOR_ID_VIA ||
-	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
-		return -EINVAL;
-
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
-
-	if (lnkcap2) {	/* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			*mask |= DRM_PCIE_SPEED_50;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			*mask |= DRM_PCIE_SPEED_80;
-	} else {	/* pre-r3.0 */
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			*mask |= (DRM_PCIE_SPEED_25 | DRM_PCIE_SPEED_50);
-	}
-
-	DRM_INFO("probing gen 2 caps for device %x:%x = %x/%x\n", root->vendor, root->device, lnkcap, lnkcap2);
-	return 0;
-}
-EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
-
 #else
 
 int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 305a657..6ba204d 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include "radeon.h"
 #include "radeon_asic.h"
@@ -3871,11 +3872,11 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 0740db3..89a7387 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -30,6 +30,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
 #include "radeon.h"
@@ -4371,11 +4372,11 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
 	if (rdev->family <= CHIP_R600)
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index d63fe1d..81c7f1c 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -28,6 +28,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include "radeon.h"
 #include "radeon_asic.h"
@@ -1254,11 +1255,11 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b099e00..ebf130c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3931,6 +3931,49 @@ static int __init pci_setup(char *str)
 }
 early_param("pci", pci_setup);
 
+int __weak pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
+{
+	struct pci_dev *root;
+	u32 lnkcap, lnkcap2;
+
+	*mask = 0;
+	if (!dev)
+		return -EINVAL;
+
+	root = dev->bus->self;
+
+	/* we've been informed via and serverworks don't make the cut */
+	if (root->vendor == PCI_VENDOR_ID_VIA ||
+	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
+		return -EINVAL;
+
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
+
+	if (lnkcap2) {	/* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			*mask |= PCIE_SPEED_25;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			*mask |= PCIE_SPEED_50;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			*mask |= PCIE_SPEED_80;
+	} else {	/* pre-r3.0 */
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+			*mask |= PCIE_SPEED_25;
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+			*mask |= (PCIE_SPEED_25 | PCIE_SPEED_50);
+	}
+
+	dev_info(&dev->dev, "probing gen 2 caps for device %x:%x = %x/%x\n",
+		root->vendor, root->device, lnkcap, lnkcap2);
+	return 0;
+}
+
+int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *mask) {
+	return pcibios_get_speed_cap_mask(dev, mask);
+}
+EXPORT_SYMBOL(pcie_get_speed_cap_mask);
+
 EXPORT_SYMBOL(pci_reenable_device);
 EXPORT_SYMBOL(pci_enable_device_io);
 EXPORT_SYMBOL(pci_enable_device_mem);
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 2d94d74..39b2872 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1788,12 +1788,6 @@ extern int drm_get_pci_dev(struct pci_dev *pdev,
 			   const struct pci_device_id *ent,
 			   struct drm_driver *driver);
 
-#define DRM_PCIE_SPEED_25 1
-#define DRM_PCIE_SPEED_50 2
-#define DRM_PCIE_SPEED_80 4
-
-extern int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *speed_mask);
-
 /* platform section */
 extern int drm_platform_init(struct drm_driver *driver, struct platform_device *platform_device);
 extern void drm_platform_exit(struct drm_driver *driver, struct platform_device *platform_device);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..24a2f63 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1861,4 +1861,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
  */
 struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
 
+#define PCIE_SPEED_25 1
+#define PCIE_SPEED_50 2
+#define PCIE_SPEED_80 4
+
+extern int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *speed_mask);
+
 #endif /* LINUX_PCI_H */
-- 
1.7.4.4

