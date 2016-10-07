Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:23:10 -0400
Subject: [PATCH 10/10] PCI: altera: Remove unused platform data
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:23:06 -0500
Message-ID: <20161007162306.22796.57510.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The altera driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 92749e9..638becdad 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -627,7 +627,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	pci_bus_add_devices(bus);
 
-	platform_set_drvdata(pdev, altera);
 	return ret;
 }
 

