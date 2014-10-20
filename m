Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.100.106] ([207.46.100.106]:8224 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752031AbaJTCvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Oct 2014 22:51:32 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v7 02/13] PCI: designware: Set func type of host init to int
Date: Mon, 20 Oct 2014 10:19:05 +0800
Message-ID: <1413771556-32212-3-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
References: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

host init maybe failed, change the func type of host_init
defined in struct pci_host_ops from void to int.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 7 +++++--
 drivers/pci/host/pcie-designware.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index b1f82ff..1a2b477 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -578,8 +578,11 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
+	if (pp->ops->host_init) {
+		ret = pp->ops->host_init(pp);
+		if (ret < 0)
+			return ret;
+	}
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index b0bfed0..57ab11d 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -72,7 +72,7 @@ struct pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val);
 	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
+	int (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	u32 (*get_msi_data)(struct pcie_port *pp);
-- 
1.9.1

