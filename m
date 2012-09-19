Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab2ISBIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Sep 2012 21:08:50 -0400
From: Dave Airlie <airlied@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] pci: don't touch card regs after runtime suspend D3
Date: Wed, 19 Sep 2012 11:07:04 +1000
Message-Id: <1348016824-1895-1-git-send-email-airlied@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the driver takes care of state saving, don't touch any registers on it.

Optimus (dual-gpu) laptops seem to have their own form of D3cold, but
unfortunately enter it on normal D3 transitions via the ACPI callback.

So when we use runtime PM to transition to D3, the card disappears off
the PCI bus, however we then try to access registers on it in the 
runtime suspend finish, which really doesn't work.

This patch check is the pci state is saved and doesn't attempt to hit
any registers after that point if it is.

(Looks okay to Rafael)

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/pci/pci-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 5270f1a..214a40b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1057,10 +1057,11 @@ static int pci_pm_runtime_suspend(struct device *dev)
 		return 0;
 	}
 
-	if (!pci_dev->state_saved)
+	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
 
-	pci_finish_runtime_suspend(pci_dev);
+		pci_finish_runtime_suspend(pci_dev);
+	}
 
 	return 0;
 }
-- 
1.7.12

