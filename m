Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:58650 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab3KEWXj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 17:23:39 -0500
Received: by mail-wg0-f52.google.com with SMTP id k14so4190867wgh.7
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2013 14:23:37 -0800 (PST)
Date: Tue, 5 Nov 2013 23:31:35 +0100
From: Marta Rybczynska <rybczynska@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] drivers/pci/pci.c: fix comment typo
Message-ID: <20131105223135.GA10523@desktop.fbx.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bdd64b1..fb5090d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3339,7 +3339,7 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 	/*
 	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
-	 * this to 2ms to ensure that we meet the minium requirement.
+	 * this to 2ms to ensure that we meet the minimum requirement.
 	 */
 	msleep(2);
 
-- 
1.8.4.rc3

