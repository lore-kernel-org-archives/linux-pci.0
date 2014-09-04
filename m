Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0240.outbound.protection.outlook.com ([207.46.163.240]:19095
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752812AbaIDLAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Sep 2014 07:00:44 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH 1/2] PCI: designware: change MSI-related pcie_host_ops
Date: Thu, 4 Sep 2014 18:45:37 +0000
Message-ID: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

1. Change original get_msi_data() to get_msi_addr(), since this
function returns MSI message address.
2. Add a new function get_msi_data() to return MSI message data.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 11 ++++++++---
 drivers/pci/host/pcie-designware.h |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52bd3a1..c84913e 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -373,12 +373,17 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	 */
 	desc->msi_attrib.multiple = msgvec;
 
-	if (pp->ops->get_msi_data)
-		msg.address_lo = pp->ops->get_msi_data(pp);
+	if (pp->ops->get_msi_addr)
+		msg.address_lo = pp->ops->get_msi_addr(pp);
 	else
 		msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
-	msg.data = pos;
+
+	if (pp->ops->get_msi_data)
+		msg.data = pp->ops->get_msi_data(pp, pos);
+	else
+		msg.data = pos;
+
 	write_msi_msg(irq, &msg);
 
 	return 0;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index daf81f9..7f08807 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -73,7 +73,8 @@ struct pcie_host_ops {
 	void (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	u32 (*get_msi_data)(struct pcie_port *pp);
+	u32 (*get_msi_addr)(struct pcie_port *pp);
+	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 };
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
-- 
1.9.1

