Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 06/32] PCI/hotplug: use PCIe capabilities access functions to simplify implementation
Date: Wed,  1 Aug 2012 23:54:11 +0800
Message-Id: <1343836477-7287-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Use PCIe capabilities access functions to simplify cpihp_slot.c.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/pci/hotplug/pcihp_slot.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pcihp_slot.c b/drivers/pci/hotplug/pcihp_slot.c
index 8c05a18..649dcc8 100644
--- a/drivers/pci/hotplug/pcihp_slot.c
+++ b/drivers/pci/hotplug/pcihp_slot.c
@@ -96,17 +96,11 @@ static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
 static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 {
 	int pos;
-	u16 reg16;
 	u32 reg32;
 
 	if (!hpp)
 		return;
 
-	/* Find PCI Express capability */
-	pos = pci_pcie_cap(dev);
-	if (!pos)
-		return;
-
 	if (hpp->revision > 1) {
 		dev_warn(&dev->dev, "PCIe settings rev %d not supported\n",
 			 hpp->revision);
@@ -114,17 +108,13 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	}
 
 	/* Initialize Device Control Register */
-	pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &reg16);
-	reg16 = (reg16 & hpp->pci_exp_devctl_and) | hpp->pci_exp_devctl_or;
-	pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, reg16);
+	pci_pcie_capability_change_word(dev, PCI_EXP_DEVCTL,
+			hpp->pci_exp_devctl_or, ~hpp->pci_exp_devctl_and);
 
 	/* Initialize Link Control Register */
-	if (dev->subordinate) {
-		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &reg16);
-		reg16 = (reg16 & hpp->pci_exp_lnkctl_and)
-			| hpp->pci_exp_lnkctl_or;
-		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, reg16);
-	}
+	if (dev->subordinate)
+		pci_pcie_capability_change_word(dev, PCI_EXP_LNKCTL,
+			hpp->pci_exp_lnkctl_or, ~hpp->pci_exp_lnkctl_and);
 
 	/* Find Advanced Error Reporting Enhanced Capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-- 
1.7.9.5

