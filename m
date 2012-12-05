Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:57412 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810Ab2LEU5m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:57:42 -0500
Received: by mail-we0-f202.google.com with SMTP id t57so395514wey.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 12:57:41 -0800 (PST)
Subject: [PATCH 04/12] [SCSI] qla2xxx: Use standard PCIe Capability Link
	register field names
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-driver@qlogic.com,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	linux-scsi@vger.kernel.org
Date: Wed, 05 Dec 2012 13:57:40 -0700
Message-ID: <20121205205740.13851.43284.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the standard #defines for PCIe Link Capability register fields
rather than bare numbers.  This also uses the new PCI Express Capability
accessor rather than reading the capability directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Andrew Vasquez <andrew.vasquez@qlogic.com>
CC: linux-driver@qlogic.com
CC: "James E.J. Bottomley" <JBottomley@parallels.com>
CC: linux-scsi@vger.kernel.org
---
 drivers/scsi/qla2xxx/qla_os.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d501bf5..b5d070f 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -480,18 +480,14 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str)
 	static char *pci_bus_modes[] = { "33", "66", "100", "133", };
 	struct qla_hw_data *ha = vha->hw;
 	uint32_t pci_bus;
-	int pcie_reg;
 
-	pcie_reg = pci_pcie_cap(ha->pdev);
-	if (pcie_reg) {
+	if (pci_is_pcie(ha->pdev)) {
 		char lwstr[6];
-		uint16_t pcie_lstat, lspeed, lwidth;
+		uint32_t lstat, lspeed, lwidth;
 
-		pcie_reg += PCI_EXP_LNKCAP;
-		pci_read_config_word(ha->pdev, pcie_reg, &pcie_lstat);
-		lspeed = pcie_lstat & (BIT_0 | BIT_1 | BIT_2 | BIT_3);
-		lwidth = (pcie_lstat &
-		    (BIT_4 | BIT_5 | BIT_6 | BIT_7 | BIT_8 | BIT_9)) >> 4;
+		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
+		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
+		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
 
 		strcpy(str, "PCIe (");
 		if (lspeed == 1)

