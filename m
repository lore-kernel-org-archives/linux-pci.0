Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:9352 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbIKJbt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 05:31:49 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v3 3/3] PCI: designware: add sanity checks on the header offset in dw_pcie_cfg_read and dw_pcie_cfg_write
Date: Fri, 11 Sep 2015 17:38:27 +0800
Message-ID: <1441964307-126942-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
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
 drivers/pci/host/pcie-designware.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index cb23e31..6812f69 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -88,9 +88,14 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 
 	if (size == 1)
 		*val = (*val >> (8 * where)) & 0xff;
-	else if (size == 2)
+	else if (size == 2) {
+		if (where & 1)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 		*val = (*val >> (8 * where)) & 0xffff;
-	else if (size != 4)
+	} else if (size == 4) {
+		if (where & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	return PCIBIOS_SUCCESSFUL;
@@ -100,11 +105,15 @@ int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
 {
 	addr += where;
 
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

