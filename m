Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755502AbcJLNLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:11:51 -0400
Subject: [PATCH v2 2/5] PCI: xilinx: Remove unused platform data
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:10:47 -0500
Message-ID: <20161012131047.25793.54060.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The xilinx driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2ef47af..8a0eb03 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -688,8 +688,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 #endif
 	pci_bus_add_devices(bus);
-	platform_set_drvdata(pdev, port);
-
 	return 0;
 
 error:

