Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:58478 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbGAJhs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2015 05:37:48 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <gabriele.paoloni@huawei.com>,
	James Morse <james.morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v3 5/5] MAINTAINERS: Add pcie-hisi maintainer
Date: Wed, 1 Jul 2015 17:43:37 +0800
Message-ID: <1435743817-19083-6-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd29..3f083d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7594,6 +7594,13 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
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

