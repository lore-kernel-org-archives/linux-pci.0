Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46991 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFGTdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jun 2018 15:33:50 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date: Thu,  7 Jun 2018 14:33:40 -0500
Message-Id: <20180607193341.18891-1-mr.nuke.me@gmail.com>
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
 drivers/pci/pcie/aer/aerdrv_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 08c87de13cb8..4b491851a781 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -101,7 +101,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
 
 	rc = apei_hest_parse(aer_hest_parse, &info);
 
-	if (rc)
+	if (rc || pcie_ports_native)
 		pci_dev->__aer_firmware_first = 0;
 	else
 		pci_dev->__aer_firmware_first = info.firmware_first;
@@ -135,6 +135,8 @@ bool aer_acpi_firmware_first(void)
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first = info.firmware_first;
 		parsed = true;
+		if (pcie_ports_native)
+			aer_firmware_first = 0;
 	}
 	return aer_firmware_first;
 }
-- 
2.14.3
