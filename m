Return-Path: <SRS0=ZHUD=CA=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=ZHUD=CA=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>
Subject: [PATCH] MAINTAINERS: Remove Gabriele Paoloni as HiSilicon PCI maintainer
Date: Thu, 2 Nov 2017 12:01:26 +0000
Message-ID: <1509624086-9076-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Gabriele is now moving to a different role, therefore remove him
as HiSilicon PCI maintainer

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af0cb69..6eb7141 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10471,7 +10471,6 @@ F:	drivers/pci/host/pci-thunder-*
 
 PCIE DRIVER FOR HISILICON
 M:	Zhou Wang <wangzhou1@hisilicon.com>
-M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
-- 
2.7.4
