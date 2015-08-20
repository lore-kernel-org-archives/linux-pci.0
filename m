Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:47887 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbHTNvr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 09:51:47 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <gabriele.paoloni@huawei.com>, <wangzhou1@hisilicon.com>,
	<jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liguozhu@hisilicon.com>
Subject: [PATCH] PCI: designware: fix dw_pcie_cfg_write
Date: Thu, 20 Aug 2015 21:58:33 +0800
Message-ID: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently in dw_pcie_cfg_write() if the input size is 2 bytes
the address offset is wrongly calculated as we mask also bit0
of "where" input parameter. Instead we should mask all bits of
"where" except bit0 and bit1.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..a27f536 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -99,7 +99,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
 	if (size == 4)
 		writel(val, addr);
 	else if (size == 2)
-		writew(val, addr + (where & 2));
+		writew(val, addr + (where & 3));
 	else if (size == 1)
 		writeb(val, addr + (where & 3));
 	else
-- 
1.9.1

