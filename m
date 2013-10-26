Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:63784 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab3JZRXV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 Oct 2013 13:23:21 -0400
Received: by mail-we0-f176.google.com with SMTP id w62so4966292wes.7
        for <linux-pci@vger.kernel.org>; Sat, 26 Oct 2013 10:23:20 -0700 (PDT)
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, m-karicheri2@ti.com,
	Andrew Murray <amurray@embedded-bits.co.uk>
Subject: [PATCH] pci: update pcie_ports 'auto' behavior for non-ACPI platforms
Date: Sat, 26 Oct 2013 18:23:25 +0100
Message-Id: <1382808205-843-1-git-send-email-amurray@embedded-bits.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcie_ports parameter, which defaults to 'auto', allows a user
to specify if PCIe port services are disabled ('compat'), always
enabled ('native'), or only used when allowed by the BIOS
('auto').

Where CONFIG_ACPI isn't enabled, as is often the case for non
x86/ia64 platforms, the 'auto' behavior results in that of
'compat'. Thus in order to use port services on these platforms
'pcie_ports=native' must be added to the kernel command line.

This patch results in the 'native' behavior being followed where
'auto' is selected and ACPI is not enabled.

Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
---
 drivers/pci/pcie/portdrv_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 31063ac..08d131f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -260,13 +260,14 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if (pcie_ports_disabled)
 		return 0;
 
-	err = pcie_port_platform_notify(dev, &cap_mask);
-	if (!pcie_ports_auto) {
-		cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
-				| PCIE_PORT_SERVICE_VC;
-		if (pci_aer_available())
-			cap_mask |= PCIE_PORT_SERVICE_AER;
-	} else if (err) {
+	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
+			| PCIE_PORT_SERVICE_VC;
+	if (pci_aer_available())
+		cap_mask |= PCIE_PORT_SERVICE_AER;
+
+	if (pcie_ports_auto) {
+		err = pcie_port_platform_notify(dev, &cap_mask);
+		if (err)
 			return 0;
 	}
 
-- 
1.8.1.2

