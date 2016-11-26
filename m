Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57790 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753204AbcKZSaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Nov 2016 13:30:01 -0500
From: Borislav Petkov <bp@alien8.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] drivers/pci/host/vmd: Fix suspend handlers unused warning
Date: Sat, 26 Nov 2016 19:29:57 +0100
Message-Id: <20161126182957.6144-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

Fix:

  drivers/pci/host/vmd.c:731:12: warning: ‘vmd_suspend’ defined but not used [-Wunused-function]
   static int vmd_suspend(struct device *dev)
              ^
  drivers/pci/host/vmd.c:739:12: warning: ‘vmd_resume’ defined but not used [-Wunused-function]
   static int vmd_resume(struct device *dev)
              ^

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 37e29b580be3..0e7f8f319fe3 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -727,7 +727,7 @@ static void vmd_remove(struct pci_dev *dev)
 	irq_domain_remove(vmd->irq_domain);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int vmd_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-- 
2.10.0

