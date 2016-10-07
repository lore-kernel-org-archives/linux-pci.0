Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756096AbcJGQ3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:20 -0400
Subject: [PATCH 5/5] PCI: xgene: Remove unused platform data
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:28:30 -0500
Message-ID: <20161007162830.24026.7748.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index ec55f12..bc6f93d 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -569,8 +569,6 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
-
-	platform_set_drvdata(pdev, xgene);
 	return 0;
 
 error:

