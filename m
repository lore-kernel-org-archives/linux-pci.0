Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Thierry Reding" <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 07/10] PCI: mvebu: Save MSI controller in pci_sys_data
Date: Mon, 27 Oct 2014 15:48:44 +0800
Message-ID: <1414396127-30023-8-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Save MSI controller in pci_sys_data instead of
assigning MSI controller pointer to every pci bus
in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pci-mvebu.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 5ab7d16..e2db57e 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -774,12 +774,6 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bus;
 }
 
-static void mvebu_pcie_add_bus(struct pci_bus *bus)
-{
-	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
-	bus->msi = pcie->msi;
-}
-
 static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 						 const struct resource *res,
 						 resource_size_t start,
@@ -816,6 +810,9 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 
 	memset(&hw, 0, sizeof(hw));
 
+#ifdef CONFIG_PCI_MSI
+	hw.msi_ctrl = pcie->msi;
+#endif
 	hw.nr_controllers = 1;
 	hw.private_data   = (void **)&pcie;
 	hw.setup          = mvebu_pcie_setup;
@@ -823,7 +820,6 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.map_irq        = of_irq_parse_and_map_pci;
 	hw.ops            = &mvebu_pcie_ops;
 	hw.align_resource = mvebu_pcie_align_resource;
-	hw.add_bus        = mvebu_pcie_add_bus;
 
 	pci_common_init(&hw);
 }
-- 
1.7.1

