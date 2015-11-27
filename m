Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:51874 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbK0Ey0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 23:54:26 -0500
From: Dongdong Liu <liudongdong3@huawei.com>
To: <wangzhou1@hisilicon.com>, <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <gabriele.paoloni@huawei.com>,
	<qiujiang@huawei.com>, <zhangjukuo@huawei.com>,
	<haifeng.wei@huawei.com>, <yisen.zhuang@huawei.com>,
	<liudongdong3@huawei.com>
Subject: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
Date: Fri, 27 Nov 2015 12:58:00 +0800
Message-ID: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current hisi_pcie_cfg_read code read the RC configuration space,
this has a problem that the output parameter "*val" have not been
assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/host/pcie-hisi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 35457ec..da677b1 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -61,7 +61,9 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 		*val = *(u8 __force *) walker;
 	else if (size == 2)
 		*val = *(u16 __force *) walker;
-	else if (size != 4)
+	else if (size == 4)
+		*val = reg_val;
+	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	return PCIBIOS_SUCCESSFUL;
-- 
1.9.1

