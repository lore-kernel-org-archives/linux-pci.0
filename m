Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:44929 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3ADTKo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:10:44 -0500
Received: by mail-ee0-f74.google.com with SMTP id t10so1049343eei.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:10:43 -0800 (PST)
Subject: [PATCH 3/3] drm/pci: Use PCI Express Capability accessors
To: David Airlie <airlied@linux.ie>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Betty Dall <betty.dall@hp.com>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 04 Jan 2013 12:10:42 -0700
Message-ID: <20130104191042.4586.39304.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
References: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI Express Capability access functions to simplify this code a bit.
For non-PCIe devices or pre-PCIe 3.0 devices that don't implement the Link
Capabilities 2 register, pcie_capability_read_dword() reads a zero.

Since we're only testing whether the bits we care about are set, there's no
need to mask out the other bits we *don't* care about.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/drm_pci.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 50e26f2..86102a0 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -469,41 +469,30 @@ EXPORT_SYMBOL(drm_pci_exit);
 int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 {
 	struct pci_dev *root;
-	int pos;
-	u32 lnkcap = 0, lnkcap2 = 0;
+	u32 lnkcap, lnkcap2;
 
 	*mask = 0;
 	if (!dev->pdev)
 		return -EINVAL;
 
-	if (!pci_is_pcie(dev->pdev))
-		return -EINVAL;
-
 	root = dev->pdev->bus->self;
 
-	pos = pci_pcie_cap(root);
-	if (!pos)
-		return -EINVAL;
-
 	/* we've been informed via and serverworks don't make the cut */
 	if (root->vendor == PCI_VENDOR_ID_VIA ||
 	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
 		return -EINVAL;
 
-	pci_read_config_dword(root, pos + PCI_EXP_LNKCAP, &lnkcap);
-	pci_read_config_dword(root, pos + PCI_EXP_LNKCAP2, &lnkcap2);
-
-	lnkcap &= PCI_EXP_LNKCAP_SLS;
-	lnkcap2 &= 0xfe;
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
 
-	if (lnkcap2) { /* PCIE GEN 3.0 */
+	if (lnkcap2) {	/* PCIe r3.0-compliant */
 		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
 			*mask |= DRM_PCIE_SPEED_25;
 		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
 			*mask |= DRM_PCIE_SPEED_50;
 		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
 			*mask |= DRM_PCIE_SPEED_80;
-	} else {
+	} else {	/* pre-r3.0 */
 		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
 			*mask |= DRM_PCIE_SPEED_25;
 		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)

