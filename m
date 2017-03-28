Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:48387 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbdC1MRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Mar 2017 08:17:08 -0400
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Date: Tue, 28 Mar 2017 14:16:44 +0200
Message-Id: <1490703404-4944-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

ATS is broken on these devices. Under invalidation load, the
GPU does not reply to invalidations anymore, causing
Completion-wait loop timeouts on the AMD IOMMU driver side.
Fix it by not enabling ATS on these devices.

Note that below mentioned commit is not broken, it just
triggers the issue because it might cause invalidation
storms on devices.

Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
Reported-by: Daniel Drake <drake@endlessm.com>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index eeb9fb2..711bdb2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -17,10 +17,18 @@
 
 #include "pci.h"
 
+static const struct pci_device_id broken_ats_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x98e4) }, /* AMD Stoney GPU part */
+	{ 0 }
+};
+
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
 
+	if (pci_match_id(broken_ats_tbl, dev))
+		return;
+
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
-- 
1.9.1
