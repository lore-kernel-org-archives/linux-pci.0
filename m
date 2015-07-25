Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:42339 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbbGYDPd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 23:15:33 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <gabriele.paoloni@huawei.com>,
	<lorenzo.pieralisi@arm.com>, James Morse <james.morse@arm.com>,
	<Liviu.Dudau@arm.com>, <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <kangfenglong@huawei.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v5 5/5] MAINTAINERS: Add pcie-hisi maintainer
Date: Sat, 25 Jul 2015 11:21:26 +0800
Message-ID: <1437794486-21134-6-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..7cd8e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7854,6 +7854,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/host/pci-xgene-msi.c
 
+PCIE DRIVER FOR HISILICON
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+F:	drivers/pci/host/pcie-hisi.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.9.1

