Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:37087 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab3LNEoX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2013 23:44:23 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so1682546bkz.11
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2013 20:44:22 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 14 Dec 2013 12:44:22 +0800
Message-ID: <CAPgLHd_kw4PNiJOCmiDBG2R86UPpD0DJRBtcD4WRVpzVdmjG1Q@mail.gmail.com>
Subject: [PATCH -next] PCI: msi: fix sparse non static symbol warning
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, zhenzhong.duan@oracle.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/pci/msi.c:119:6: warning:
 symbol 'default_restore_msi_irq' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pci/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c0baa3d..3fcc1e6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -116,7 +116,7 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	return default_teardown_msi_irqs(dev);
 }
 
-void default_restore_msi_irq(struct pci_dev *dev, int irq)
+static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
 	struct msi_desc *entry;
 

