Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0099.outbound.protection.outlook.com ([207.46.100.99]:3709
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751116AbcAKL4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 06:56:18 -0500
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: designware: Remove unused variable
Date: Mon, 11 Jan 2016 09:41:10 -0200
Message-ID: <1452512470-20890-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 50a1a3b06dddaa5b ("PCI: designware: Simplify control flow")
causes the following build warning:

drivers/pci/host/pcie-designware.c:683:6: warning: unused variable 'ret' [-Wunused-variable]

Remove the unused 'ret' varaible.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9a666db..2171682 100644
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
1.9.1

