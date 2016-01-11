Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33095 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbcAKMP4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2016 07:15:56 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-next@vger.kernel.org
Subject: [PATCH] PCI: designware: Remove unused variable
Date: Mon, 11 Jan 2016 13:15:53 +0100
Message-Id: <1452514553-16287-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Commit 50a1a3b06ddd ("PCI: designware: Simplify control flow") removed
all uses of the "ret" variable in the dw_pcie_wr_conf() function but not
the variable itself. Do so now to get rid of an unused variable warning.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9a666dbff127..21716827847a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -680,7 +680,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
 	struct pcie_port *pp = bus->sysdata;
-	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.5.0

