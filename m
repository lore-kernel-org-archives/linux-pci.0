Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:45252
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbdILLzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Sep 2017 07:55:33 -0400
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: David.Daney@cavium.com, jcm@redhat.com, Robert.Richter@cavium.com,
        Wilson.Snyder@cavium.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: [PATCH] PCI: quirks: update cavium ACS quirk implementation
Date: Tue, 12 Sep 2017 04:55:16 -0700
Message-Id: <1505217316-15702-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit makes PIC ACS quirk applicable only to Cavium PCIE devices
and Cavium PCIE Root Ports which has limited PCI capabilities in terms
of no ACS support. Match function checks for ACS support and exact ACS
bits set at the device capabilities.
Also by this commit we get rid off device ID range values checkings.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
---
 drivers/pci/quirks.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d3361..11ca951 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4211,6 +4211,29 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+#define CAVIUM_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | \
+			  PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT)
+
+static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
+{
+	int pos = 0;
+	u32 caps = 0;
+
+	/* Filter out a few obvious non-matches first */
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	/* Get the ACS caps offset */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (pos) {
+		pci_read_config_dword(dev, pos + PCI_ACS_CAP, &caps);
+		/* If we have no such bits set, then we will need a quirk */
+		return ((caps & CAVIUM_ACS_FLAGS) != CAVIUM_ACS_FLAGS);
+	}
+
+	return true;
+}
+
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
@@ -4218,13 +4241,10 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 	 * with other functions, allowing masking out these bits as if they
 	 * were unimplemented in the ACS capability.
 	 */
-	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
-		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
-
-	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
+	if (!pci_quirk_cavium_acs_match(dev))
 		return -ENOTTY;
 
-	return acs_flags ? 0 : 1;
+	return acs_flags & ~(CAVIUM_ACS_FLAGS) ? 0 : 1;
 }
 
 static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
-- 
2.9.5
