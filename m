Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:1872
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752957AbaIWOot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 10:44:49 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH v3 1/3] PCI: designware: Rename get_msi_data to get_msi_addr
Date: Tue, 23 Sep 2014 22:28:58 +0800
Message-ID: <1411482540-31297-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function get_msi_data is used to return MSI message address.
In order to accurately express function purpose the patch rename
it to get_msi_addr.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log:
v3: no change
v2: no change just derived from v1

 drivers/pci/host/pcie-designware.c | 4 ++--
 drivers/pci/host/pcie-designware.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 5d720c2..1c09f814 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -361,8 +361,8 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	 */
 	desc->msi_attrib.multiple = msgvec;
 
-	if (pp->ops->get_msi_data)
-		msg.address_lo = pp->ops->get_msi_data(pp);
+	if (pp->ops->get_msi_addr)
+		msg.address_lo = pp->ops->get_msi_addr(pp);
 	else
 		msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 48f8670..904e40a 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -70,7 +70,7 @@ struct pcie_host_ops {
 	void (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	u32 (*get_msi_data)(struct pcie_port *pp);
+	u32 (*get_msi_addr)(struct pcie_port *pp);
 	void (*scan_bus)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
 };
-- 
1.9.1

