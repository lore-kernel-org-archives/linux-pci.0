Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42004 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeFYVGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 17:06:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so13304020qty.9
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 14:06:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] pci: export pcie_get_speed_cap and pcie_get_width_cap
Date: Mon, 25 Jun 2018 16:06:02 -0500
Message-Id: <20180625210606.2736-2-alexander.deucher@amd.com>
In-Reply-To: <20180625210606.2736-1-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So drivers can use them.  This can be used to replace
duplicate code in the drm subsystem.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/pci.c   | 2 ++
 include/linux/pci.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba712e4e..22adaf35b136 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5222,6 +5222,7 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 
 	return PCI_SPEED_UNKNOWN;
 }
+EXPORT_SYMBOL(pcie_get_speed_cap);
 
 /**
  * pcie_get_width_cap - query for the PCI device's link width capability
@@ -5240,6 +5241,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
 }
+EXPORT_SYMBOL(pcie_get_width_cap);
 
 /**
  * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..6e0c0803b241 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -261,6 +261,9 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
+
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
-- 
2.13.6
