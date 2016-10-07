Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940957AbcJGQ35 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:57 -0400
Subject: [PATCH 9/9] PCI: xilinx-nwl: Remove unused platform data
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:29:53 -0500
Message-ID: <20161007162953.24137.29173.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 63b6174..ea0265e 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -864,7 +864,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
-	platform_set_drvdata(pdev, nwl);
 	return 0;
 
 error:

