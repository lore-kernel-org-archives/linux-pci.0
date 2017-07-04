Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:8423 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdGDCPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2017 22:15:32 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <guodong.xu@linaro.org>, <bhelgaas@google.com>
CC: <songxiaowei@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS:add maintainer for kirin pcie
Date: Tue, 4 Jul 2017 10:15:16 +0800
Message-ID: <20170704021516.96575-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Kirin PCIe Driver does not have a maintainer at present,

Add maintainers for kirin pcie driver and Doc, the two fellowing files.
Documentation/devicetree/bindings/pci/pcie-kirin.txt
drivers/pci/dwc/pcie-kirin.c

Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ee3125f8341..c64ff79587c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9851,6 +9851,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/dwc/pcie-hisi.c
 
+PCIE DRIVER FOR Kirin
+M:	Xiaowei Song <songxiaowei@hisilicon.com>
+M:	Binghui Wang <wangbinghui@hisilicon.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
+F:	drivers/pci/dwc/pcie-kirin.c
+
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
 M:	Wenrui Li <wenrui.li@rock-chips.com>
-- 
2.11.GIT
