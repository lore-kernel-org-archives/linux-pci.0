Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:48187 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021AbaHEQMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:13 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so1266735wes.30
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:12 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 19/22] Added (untested) workaround to s390 architecture to accomodate new irq init code. Unfortunately adding runtime irq assignment will not work but avoided breaking the existing code
Date: Tue,  5 Aug 2014 17:11:20 +0100
Message-Id: <1407255083-9356-20-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/s390/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9ddc51e..be7d1fe 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -474,6 +474,13 @@ out:
 	return rc;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+	return 0;
+}
+
 void arch_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
-- 
2.0.4

