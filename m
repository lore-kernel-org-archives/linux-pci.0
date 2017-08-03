Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51430 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdHCCpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2017 22:45:03 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: endpoint: not need to free epf_test
Date: Thu,  3 Aug 2017 10:44:11 +0800
Message-Id: <1501728251-196637-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's from devm_kzalloc. so not need to free it when removing
the test driver.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Just compile only. Unless I missed something when
trying to support ep mode for pcie-rockchip and find this
issue.

 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 53fff80..4e3abbd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -455,9 +455,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 static int pci_epf_test_remove(struct pci_epf *epf)
 {
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-
-	kfree(epf_test);
 	return 0;
 }
 
-- 
1.9.1
