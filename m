Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38495 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbdGTAq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 20:46:56 -0400
Received: by mail-pg0-f44.google.com with SMTP id s4so7054831pgr.5
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2017 17:46:56 -0700 (PDT)
From: Feng Kan <fkan@apm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com
Cc: Feng Kan <fkan@apm.com>
Subject: [PATCH V2] pci: quirk: Apply APM ACS quirk to XGene devices
Date: Wed, 19 Jul 2017 17:46:51 -0700
Message-Id: <1500511611-2019-1-git-send-email-fkan@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The APM X-Gene PCIe root port does not support ACS at this point.
However, the hw provides isolation and source validation through
the SMMU. Turn on ACS but disable all the peer to peer features.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb78..0f8f1cd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4120,6 +4120,19 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 	return acs_flags ? 0 : 1;
 }
 
+static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * XGene root matching this quirk do not allow peer-to-peer
+	 * transactions with others, allowing masking out these bits as if they
+	 * were unimplemented in the ACS capability.
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
@@ -4368,6 +4381,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
 	/* Cavium ThunderX */
 	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
+	/* APM XGene */
+	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
 	{ 0 }
 };
 
-- 
1.8.3.1
