Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755201AbcJLNH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:07:56 -0400
Subject: [PATCH v2 2/4] PCI: xgene: Remove unused platform data
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:07:51 -0500
Message-ID: <20161012130751.25368.87882.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The xgene driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 03d24e7..7da3b09 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -563,8 +563,6 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
-
-	platform_set_drvdata(pdev, port);
 	return 0;
 
 error:

