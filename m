Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38552 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeFYVGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 17:06:23 -0400
Received: by mail-qt0-f193.google.com with SMTP id c5-v6so2523000qth.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 14:06:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width
Date: Mon, 25 Jun 2018 16:06:06 -0500
Message-Id: <20180625210606.2736-6-alexander.deucher@amd.com>
In-Reply-To: <20180625210606.2736-1-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These functions duplicated functionality which was ultimately added
to the pci core.

All users of these functions have been ported to using the newly
exposed pci functionality.  These functions are no longer used,
so drop them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/drm_pci.c | 58 -----------------------------------------------
 include/drm/drm_pci.h     |  7 ------
 2 files changed, 65 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 4db9c515b74f..896e42a34895 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -326,64 +326,6 @@ int drm_legacy_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
 }
 EXPORT_SYMBOL(drm_legacy_pci_init);
 
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
-int drm_pcie_get_max_link_width(struct drm_device *dev, u32 *mlw)
-{
-	struct pci_dev *root;
-	u32 lnkcap;
-
-	*mlw = 0;
-	if (!dev->pdev)
-		return -EINVAL;
-
-	root = dev->pdev->bus->self;
-
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
-
-	*mlw = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
-
-	DRM_INFO("probing mlw for device %x:%x = %x\n", root->vendor, root->device, lnkcap);
-	return 0;
-}
-EXPORT_SYMBOL(drm_pcie_get_max_link_width);
-
 #else
 
 void drm_pci_agp_destroy(struct drm_device *dev) {}
diff --git a/include/drm/drm_pci.h b/include/drm/drm_pci.h
index 674599025d7d..8181e9e7cf1d 100644
--- a/include/drm/drm_pci.h
+++ b/include/drm/drm_pci.h
@@ -58,11 +58,4 @@ static inline int drm_get_pci_dev(struct pci_dev *pdev,
 }
 #endif
 
-#define DRM_PCIE_SPEED_25 1
-#define DRM_PCIE_SPEED_50 2
-#define DRM_PCIE_SPEED_80 4
-
-int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *speed_mask);
-int drm_pcie_get_max_link_width(struct drm_device *dev, u32 *mlw);
-
 #endif /* _DRM_PCI_H_ */
-- 
2.13.6
