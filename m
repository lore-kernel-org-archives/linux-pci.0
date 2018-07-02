Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:54219 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBQQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 12:16:20 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com, keith.busch@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date: Mon,  2 Jul 2018 11:16:01 -0500
Message-Id: <20180702161611.2048-1-mr.nuke.me@gmail.com>
In-Reply-To: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
References: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the documentation, "pcie_ports=native", linux should use
native AER and DPC services. While that is true for the _OSC method
parsing, this is not the only place that is checked. Should the HEST
table list PCIe ports as firmware-first, linux will not use native
services.

This happens because aer_acpi_firmware_first() doesn't take
'pcie_ports' into account. This is wrong. DPC uses the same logic when
it decides whether to load or not, so fixing this also fixes DPC not
loading.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..db2c01056dc7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -283,13 +283,14 @@ static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
 
 static void aer_set_firmware_first(struct pci_dev *pci_dev)
 {
-	int rc;
+	int rc = 0;
 	struct aer_hest_parse_info info = {
 		.pci_dev	= pci_dev,
 		.firmware_first	= 0,
 	};
 
-	rc = apei_hest_parse(aer_hest_parse, &info);
+	if (!pcie_ports_native)
+		rc = apei_hest_parse(aer_hest_parse, &info);
 
 	if (rc)
 		pci_dev->__aer_firmware_first = 0;
@@ -324,7 +325,9 @@ bool aer_acpi_firmware_first(void)
 	};
 
 	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
+		if (!pcie_ports_native)
+			apei_hest_parse(aer_hest_parse, &info);
+
 		aer_firmware_first = info.firmware_first;
 		parsed = true;
 	}
-- 
2.14.3
