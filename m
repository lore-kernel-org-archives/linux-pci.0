Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755446AbcJLNM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:12:28 -0400
Subject: [PATCH v2 5/5] PCI: xilinx-nwl: Remove unused platform data
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:11:14 -0500
Message-ID: <20161012131114.25793.27216.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The xilinx-nwl driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 10d4517..43eaa4a 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -861,7 +861,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
-	platform_set_drvdata(pdev, pcie);
 	return 0;
 
 error:

