Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:39738 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeAUVQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Jan 2018 16:16:06 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992521AbeAUVQFPNoFG (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:16:05 +0100
Date: Sun, 21 Jan 2018 22:16:04 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/5] devres: Make devm_ioremap_release() static
Message-ID: <20180121211604.GD15151@lenoch>
References: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211432.GA15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_ioremap_release() is an implementation detail and shouldn't
be public.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 include/linux/device.h | 1 -
 lib/devres.c           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 91f508edb266..e99d41a6190b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -734,7 +734,6 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
 void devm_iounmap(struct device *dev, void __iomem *addr);
-void devm_ioremap_release(struct device *dev, void *res);
 
 void *devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
diff --git a/lib/devres.c b/lib/devres.c
index f2f80c233aa4..e9aad136f667 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -5,7 +5,7 @@
 #include <linux/gfp.h>
 #include <linux/export.h>
 
-void devm_ioremap_release(struct device *dev, void *res)
+static void devm_ioremap_release(struct device *dev, void *res)
 {
 	iounmap(*(void __iomem **)res);
 }
-- 
2.15.1
