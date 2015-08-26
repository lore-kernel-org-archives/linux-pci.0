Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:41393 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbHZDKz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 23:10:55 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<gabriele.paoloni@huawei.com>
CC: <linux-pci@vger.kernel.org>, <qiuzhenfa@hisilicon.com>,
	<zhangjukuo@huawei.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v2] PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
Date: Wed, 26 Aug 2015 11:17:34 +0800
Message-ID: <1440559054-231033-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The value under PORT_LOGIC_LINK_WIDTH_MASK is 0x1, 0x2, 0x4, 0x8. Here change
this mask to proper value.

In IP v4.2, bits [16:8] are defined for NUM_OF_LANES. But in IP v4.4, bits[12:8]
are defined for NUM_OF_LANES, bits [16:13] are for other usages(bit 16 is
AUTO_LANE_FLIP_CTRL_EN, bits [15:13] are PRE_DET_LANE).

As there is no conflict about NUM_OF_LANES between v4.2 and v4.4, this patch
change above mask value to avoid future problem.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..eb549b9 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -35,7 +35,7 @@
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
+#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
 #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-- 
1.9.1

