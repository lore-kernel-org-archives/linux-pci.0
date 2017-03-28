Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35859 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754188AbdC1Aqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2017 20:46:51 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so55568830pge.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2017 17:46:50 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
        linux-pci@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: [TRIVIAL PATCH] PCI: fix typo in doc for pci_cfg_access_lock()
Date: Mon, 27 Mar 2017 17:46:14 -0700
Message-Id: <20170328004614.12889-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no pci_cfg_access_unlocked(). I think the author meant
pci_cfg_access_unlock().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pci/access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 8b7382705bf2..20ec96c4239e 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -629,7 +629,7 @@ void pci_vpd_release(struct pci_dev *dev)
  *
  * When access is locked, any userspace reads or writes to config
  * space and concurrent lock requests will sleep until access is
- * allowed via pci_cfg_access_unlocked again.
+ * allowed via pci_cfg_access_unlock again.
  */
 void pci_cfg_access_lock(struct pci_dev *dev)
 {
-- 
2.12.2.564
