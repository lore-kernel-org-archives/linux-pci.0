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
Subject: [RFC PATCH v2 25/32] PCI/iwl: use PCIe capabilities access functions to simplify implementation
Date: Wed, 25 Jul 2012 00:41:10 +0800
Message-Id: <1343148077-25941-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1343148077-25941-1-git-send-email-jiang.liu@huawei.com>
References: <1343148077-25941-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Use PCIe capabilities access functions to simplify Intel Wireless drivers'
implementation.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/net/wireless/iwlegacy/common.h        |    5 ++---
 drivers/net/wireless/iwlwifi/iwl-trans-pcie.c |    4 +---
 drivers/net/wireless/rtlwifi/pci.c            |    8 +++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/iwlegacy/common.h b/drivers/net/wireless/iwlegacy/common.h
index 5f50177..d119fa3 100644
--- a/drivers/net/wireless/iwlegacy/common.h
+++ b/drivers/net/wireless/iwlegacy/common.h
@@ -1832,10 +1832,9 @@ int il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd);
 static inline u16
 il_pcie_link_ctl(struct il_priv *il)
 {
-	int pos;
 	u16 pci_lnk_ctl;
-	pos = pci_pcie_cap(il->pci_dev);
-	pci_read_config_word(il->pci_dev, pos + PCI_EXP_LNKCTL, &pci_lnk_ctl);
+	pci_pcie_capability_read_word(il->pci_dev, PCI_EXP_LNKCTL,
+				      &pci_lnk_ctl);
 	return pci_lnk_ctl;
 }
 
diff --git a/drivers/net/wireless/iwlwifi/iwl-trans-pcie.c b/drivers/net/wireless/iwlwifi/iwl-trans-pcie.c
index ec6fb39..48b9561 100644
--- a/drivers/net/wireless/iwlwifi/iwl-trans-pcie.c
+++ b/drivers/net/wireless/iwlwifi/iwl-trans-pcie.c
@@ -643,15 +643,13 @@ static void iwl_set_pwr_vmain(struct iwl_trans *trans)
 
 static u16 iwl_pciexp_link_ctrl(struct iwl_trans *trans)
 {
-	int pos;
 	u16 pci_lnk_ctl;
 	struct iwl_trans_pcie *trans_pcie =
 		IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	struct pci_dev *pci_dev = trans_pcie->pci_dev;
 
-	pos = pci_pcie_cap(pci_dev);
-	pci_read_config_word(pci_dev, pos + PCI_EXP_LNKCTL, &pci_lnk_ctl);
+	pci_pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &pci_lnk_ctl);
 	return pci_lnk_ctl;
 }
 
diff --git a/drivers/net/wireless/rtlwifi/pci.c b/drivers/net/wireless/rtlwifi/pci.c
index 2062ea1..1018b5b 100644
--- a/drivers/net/wireless/rtlwifi/pci.c
+++ b/drivers/net/wireless/rtlwifi/pci.c
@@ -372,13 +372,11 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
 
 	u8 tmp;
-	int pos;
-	u8 linkctrl_reg;
+	u16 linkctrl_reg;
 
 	/*Link Control Register */
-	pos = pci_pcie_cap(pdev);
-	pci_read_config_byte(pdev, pos + PCI_EXP_LNKCTL, &linkctrl_reg);
-	pcipriv->ndis_adapter.linkctrl_reg = linkctrl_reg;
+	pci_pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctrl_reg);
+	pcipriv->ndis_adapter.linkctrl_reg = (u8)linkctrl_reg;
 
 	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
 		 pcipriv->ndis_adapter.linkctrl_reg);
-- 
1.7.9.5

