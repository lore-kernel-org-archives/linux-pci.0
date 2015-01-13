Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge1.emulex.com ([138.239.224.99]:11317 "EHLO
	CMEXEDGE1.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbAMGTz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jan 2015 01:19:55 -0500
From: Sathya Perla <sathya.perla@emulex.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH] pci: Add ACS quirk for Emulex NICs
Date: Tue, 13 Jan 2015 01:22:23 -0500
Message-ID: <1421130143-4391-1-git-send-email-sathya.perla@emulex.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vasundhara Volam <vasundhara.volam@emulex.com>

As Skyhawk and BE3-R (both multi-function devices) don't advertise the
PCI-ACS capability, the vfio driver places all the functions of these
devices in a single IOMMU group. Attaching (via PCI-passthru)two different
Skyhawk/BE3-R partitions (nPAR, Flex etc PFs) using vfio, to different
guests doesn't work as vfio only allows functions in *different* IOMMU
groups to be assigned to different guests.

As peer-to-peer access between PFs in Skyhawk/BE3-R is not possible,
we can treat them as "fully isolated" even though the device doesn't
advertise ACS. So, this patch adds a PCI quirk for Skyhawk and BE3-R
chips to fix this problem.

Signed-off-by: Vasundhara Volam <vasundhara.volam@emulex.com>
Signed-off-by: Sathya Perla <sathya.perla@emulex.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ed6f89b..3d24629 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3713,6 +3713,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, 0x1551, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x1558, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
+	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
+	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
 	{ 0 }
 };
 
-- 
2.2.0

