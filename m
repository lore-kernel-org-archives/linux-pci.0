Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbbCTS2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Mar 2015 14:28:01 -0400
Subject: [PATCH] PCI: Add ACS quirks for Intel 1G NICs
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: john.ronciak@intel.com, linux-kernel@vger.kernel.org
Date: Fri, 20 Mar 2015 12:27:57 -0600
Message-ID: <20150320182722.5362.75868.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel has verified that there is no peer-to-peer between functions for
the below selection of 82580, 82576, 82575, I350, and 82571 multi-port
devices.  This adds the necessary quirks to consider the functions
isolated from each other.  82571 quad-port devices are omitted due to
likely lack of ACS/isolation in the onboard switch, rendering quirks
for the downstream endpoints useless.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: John Ronciak <john.ronciak@intel.com>
---
 drivers/pci/quirks.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..1bde397 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3822,6 +3822,38 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, 0x154F, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x1551, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x1558, pci_quirk_mf_endpoint_acs },
+	/* 82580 */
+	{ PCI_VENDOR_ID_INTEL, 0x1509, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x150E, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x150F, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1510, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1511, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1516, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1527, pci_quirk_mf_endpoint_acs },
+	/* 82576 */
+	{ PCI_VENDOR_ID_INTEL, 0x10C9, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10E6, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10E7, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10E8, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x150A, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x150D, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1518, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1526, pci_quirk_mf_endpoint_acs },
+	/* 82575 */
+	{ PCI_VENDOR_ID_INTEL, 0x10A7, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10A9, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10D6, pci_quirk_mf_endpoint_acs },
+	/* I350 */
+	{ PCI_VENDOR_ID_INTEL, 0x1521, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1522, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1523, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1524, pci_quirk_mf_endpoint_acs },
+	/* 82571 (Quads omitted due to non-ACS switch) */
+	{ PCI_VENDOR_ID_INTEL, 0x105E, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x105F, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x1060, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x10D9, pci_quirk_mf_endpoint_acs },
+	/* Intel PCH root ports */
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */

