Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:40869 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab3ADTSw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:18:52 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so1786732vbi.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:18:52 -0800 (PST)
Subject: [PATCH 2/3] drm/pci: Set all supported speeds in speed cap mask for
	pre-3.0 devices
To: David Airlie <airlied@linux.ie>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Betty Dall <betty.dall@hp.com>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 04 Jan 2013 12:10:37 -0700
Message-ID: <20130104191037.4586.96280.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
References: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For devices that conform to PCIe r3.0 and have a Link Capabilities 2
register, we test and report every bit in the Supported Link Speeds Vector
field.  For a device that supports both 2.5GT/s and 5.0GT/s, we set both
DRM_PCIE_SPEED_25 and DRM_PCIE_SPEED_50 in the returned mask.

For pre-r3.0 devices, the Link Capabilities 0010b encoding
(PCI_EXP_LNKCAP_SLS_5_0GB) means that both 5.0GT/s and 2.5GT/s are
supported, so set both DRM_PCIE_SPEED_25 and DRM_PCIE_SPEED_50 in this
case as well.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/drm_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 11c8add..50e26f2 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -507,7 +507,7 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
 			*mask |= DRM_PCIE_SPEED_25;
 		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			*mask |= DRM_PCIE_SPEED_50;
+			*mask |= (DRM_PCIE_SPEED_25 | DRM_PCIE_SPEED_50);
 	}
 
 	DRM_INFO("probing gen 2 caps for device %x:%x = %x/%x\n", root->vendor, root->device, lnkcap, lnkcap2);

