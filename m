Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48474 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3BFFSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 00:18:11 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHS003YL9E9PRO0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 06 Feb 2013 14:18:09 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHS00F1F9E8SAG0@mmp2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 06 Feb 2013 14:18:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'David Airlie' <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] drm/pci: use PCI_EXP_LNKCAP_SLS_2_5GB/5_0GB instead of
 hardcoded values
Date: Wed, 06 Feb 2013 14:18:08 +0900
Message-id: <002b01ce0429$59d7acc0$0d870640$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB instead
of hardcoded values for readability. These bit definitions were
added by commit 130f1b8 ("PCI: Add PCIe Link Capability link speed
and width names")

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/gpu/drm/drm_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 754bc96..11c8add 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -504,9 +504,9 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
 			*mask |= DRM_PCIE_SPEED_80;
 	} else {
-		if (lnkcap & 1)
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
 			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap & 2)
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
 			*mask |= DRM_PCIE_SPEED_50;
 	}
 
-- 
1.7.2.5


