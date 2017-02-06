Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdBFPeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 10:34:25 -0500
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH] pci: Don't duplicate fix up for positive error code
Date: Mon,  6 Feb 2017 13:34:14 -0200
Message-Id: <20170206153414.23854-1-krisman@collabora.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function __pci_device_probe tries to be careful about a PCI driver
probe() hook returning a positive value, but this is not really
necessary, since the same fix up is already done in
local_pci_probe (preceded by a noisy warning), which renders this
instance dead code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1ccce1cd6aca..3e0516ee9eab 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -381,8 +381,6 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 		id = pci_match_device(drv, pci_dev);
 		if (id)
 			error = pci_call_probe(drv, pci_dev, id);
-		if (error >= 0)
-			error = 0;
 	}
 	return error;
 }
-- 
2.11.0
