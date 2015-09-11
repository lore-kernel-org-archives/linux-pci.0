Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:5328 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbIKJby (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 05:31:54 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>,
	Pratyush Anand <panand@redhat.com>
Subject: [PATCH v3 1/3] PCIe: SPEAr13xx: fix dw_pcie_cfg_read/write() usage
Date: Fri, 11 Sep 2015 17:38:25 +0800
Message-ID: <1441964307-126942-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

w_pcie_cfg_read/write() expects 1st argument 'addr' as a 32 bit word
aligned address, 2nd argument 'where' as the offset within that word(0, 1,
2 or 3) and 3rd argument 'size' is the number of bytes need to be read at
the offset(could be 1, 2 ,4).

SPEAr13xx is using dw_pcie_cfg_read() and dw_pcie_cfg_write() incorrectly.
Without this fix, SPEAr13xx host will never work with  few buggy gen1 card
which connects with only gen1 host and also with any endpoint which would
generate a read request of more than 128 bytes.

Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Pratyush Anand <panand@redhat.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 98d2683..0754ea3 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -163,34 +163,36 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
+				0, 2, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
+				0, 2, val);
 
-	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 0, 2, 0x104A);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 2, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
-				 &val);
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+					0, 4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCAP, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+						PCI_EXP_LNKCAP, 0, 4, val);
 		}
 
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
-				 &val);
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+					0, 2, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCTL2, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+						PCI_EXP_LNKCTL2, 0, 2, val);
 		}
 	}
 
-- 
1.9.1

