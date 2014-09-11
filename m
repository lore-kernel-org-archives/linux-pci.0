Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:39060
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755934AbaIKNIo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Sep 2014 09:08:44 -0400
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
Subject: [PATCH v2 2/3] PCI: designware: Add get_msi_data to pcie_host_ops
Date: Thu, 11 Sep 2014 21:09:00 +0000
Message-ID: <1410469741-11634-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1410469741-11634-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1410469741-11634-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch adds get_msi_data for some platforms to return their
special MSI message data.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log:
v2: no change just derived from v1

 drivers/pci/host/pcie-designware.c | 6 +++++-
 drivers/pci/host/pcie-designware.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1d37bed..eae4917 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -366,7 +366,11 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	else
 		msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
-	msg.data = pos;
+
+	if (pp->ops->get_msi_data)
+		msg.data = pp->ops->get_msi_data(pp, pos);
+	else
+		msg.data = pos;
 
 	write_msi_msg(irq, &msg);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 8be2b33..c8ec879 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -75,6 +75,7 @@ struct pcie_host_ops {
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	u32 (*get_msi_addr)(struct pcie_port *pp);
+	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
 };
-- 
1.9.1

