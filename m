Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0080.outbound.protection.outlook.com ([157.56.110.80]:42696
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753102AbcA2ViB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 16:38:01 -0500
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Tirumalesh Chalamarla <tchalamarla@cavium.com>,
	"Richter, Robert" <Robert.Richter@caviumnetworks.com>
From: Manish Jaggi <mjaggi@caviumnetworks.com>
Subject: [PATCH] PCI: Add cavium acs pci quirk
Message-ID: <56ABC5AE.1050209@caviumnetworks.com>
Date: Sat, 30 Jan 2016 01:33:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Cavium devices matching this quirk do not perform
peer-to-peer with other functions, allowing masking out
these bits as if they were unimplemented in the ACS capability.

Acked-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Signed-off-by: Manish Jaggi <mjaggi@caviumnetworks.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e32730..a300fa6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3814,6 +3814,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }

+static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Cavium devices matching this quirk do not perform
+	 * peer-to-peer with other functions, allowing masking out
+	 * these bits as if they were unimplemented in the ACS capability.
+	 */
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
+		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
+
+	return acs_flags ? 0 : 1;
+}
+
 /*
  * Many Intel PCH root ports do provide ACS-like features to disable peer
  * transactions and validate bus numbers in requests, but do not provide an
@@ -3966,6 +3979,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
+	/* Cavium ThunderX */
+	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 	{ 0 }
 };

-- 
1.9.1
