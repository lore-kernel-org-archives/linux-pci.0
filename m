Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:38920 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbbIJOwK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 10:52:10 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v2 1/3] PCI: spear13xx: fix addresses in dw_pcie_cfg_read and dw_pcie_cfg_write
Date: Thu, 10 Sep 2015 22:58:56 +0800
Message-ID: <1441897138-23251-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently spear13xx passes the wrong "address" in many calls to
dw_pcie_cfg_read and dw_pcie_cfg_write: the passed address is
always pp->dbi_base, that is wrong as it does not consider
the offset to access the right register of the PCI header.
This patches fixes these function calls passing the address to
access the right register.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pcie-spear13xx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index c49fbdc..5f3513b 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -146,6 +146,7 @@ struct pcie_app_reg {
 static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 {
 	u32 val;
+	int where;
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
@@ -163,9 +164,10 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	where = exp_cap_off + PCI_EXP_DEVCTL;
+	dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+	dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where, 4, val);
 
 	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
 	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
@@ -175,22 +177,24 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
+		where = exp_cap_off + PCI_EXP_LNKCAP;
+		dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4,
 				 &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCAP, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
+					where, 4, val);
 		}
 
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
+		where = exp_cap_off + PCI_EXP_LNKCTL2;
+		dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4,
 				 &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCTL2, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
+					where, 4, val);
 		}
 	}
 
-- 
1.9.1

