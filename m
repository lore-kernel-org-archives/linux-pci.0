Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:37027 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965305AbbI2Nus (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 09:50:48 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v5 3/3] PCI: designware: add sanity checks on the header offset in dw_pcie_cfg_read and dw_pcie_cfg_write
Date: Tue, 29 Sep 2015 21:57:22 +0800
Message-ID: <1443535042-242400-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch adds sanity checks on "where" input parameter in
dw_pcie_cfg_read and dw_pcie_cfg_write. These checks make sure
that offset passed in by the caller is not in conflict with
the size of the PCI header field that is being read/written

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index d771fa5..719d2cd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -82,11 +82,15 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
-	if (size == 4)
+	if (size == 4) {
+		if ((uintptr_t)addr & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 		*val = readl(addr);
-	else if (size == 2)
+	} else if (size == 2) {
+		if ((uintptr_t)addr & 1)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 		*val = readw(addr);
-	else if (size == 1)
+	} else if (size == 1)
 		*val = readb(addr);
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -96,11 +100,15 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 {
-	if (size == 4)
+	if (size == 4) {
+		if ((uintptr_t)addr & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 		writel(val, addr);
-	else if (size == 2)
+	} else if (size == 2) {
+		if ((uintptr_t)addr & 1)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 		writew(val, addr);
-	else if (size == 1)
+	} else if (size == 1)
 		writeb(val, addr);
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-- 
1.9.1

