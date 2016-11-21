Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753937AbcKUVp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 16:45:56 -0500
Subject: [PATCH v2 5/9] PCI/AER: Log AER IRQ when claiming Root Port
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:48 -0600
Message-ID: <20161121214548.21036.23843.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a log message when we enable AER on a Root Port and the hierarchy below
it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 60e63d6..dea186a 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -312,8 +312,8 @@ static int aer_probe(struct pcie_device *dev)
 	rpc->isr = 1;
 
 	aer_enable_rootport(rpc);
-
-	return status;
+	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
+	return 0;
 }
 
 /**

