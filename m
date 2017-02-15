Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52462 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdBOHwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 02:52:25 -0500
From: songxiaowei <songxiaowei@huawei.com>
To: <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>
Subject: [PATCH] PCI-DW: ARM64: check the result of hos_init
Date: Wed, 15 Feb 2017 15:52:04 +0800
Message-ID: <20170215075204.114925-1-songxiaowei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enumeration should be prevented 
when Host initialization fails.
Only one device link with Host escpecially, 
if host initialization fails or
establishling link-up is not successful,
there may no need for the Enumeration.

Signed-off-by: songxiaowei <songxiaowei@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 7 +++++--
 drivers/pci/host/pcie-designware.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index bed19994c1e9..561a2edaf06f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -637,8 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
+	if (pp->ops->host_init) {
+		ret = pp->ops->host_init(pp);
+		if (ret)
+			return ret;
+	}
 
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index a567ea288ee2..eacf18f9fc79 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -63,7 +63,7 @@ struct pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val);
 	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
+	int (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
-- 
2.11.GIT
