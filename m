Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f202.google.com ([209.85.160.202]:48884 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3ADTKd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:10:33 -0500
Received: by mail-gh0-f202.google.com with SMTP id z10so1474000ghb.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:10:32 -0800 (PST)
Subject: [PATCH 1/3] drm/pci: Use the standard #defines for PCIe Link
	Capability bits
To: David Airlie <airlied@linux.ie>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Betty Dall <betty.dall@hp.com>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 04 Jan 2013 12:10:32 -0700
Message-ID: <20130104191031.4586.63513.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
References: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the standard #defines rather than bare numbers for the PCIe Link
Capabilities speed bits.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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
 

