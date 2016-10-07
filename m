Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938941AbcJGQ0y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:26:54 -0400
Subject: [PATCH 5/5] PCI: tegra: Remove unused platform data
To: Alexandre Courbot <gnurou@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:26:50 -0500
Message-ID: <20161007162650.23718.2297.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The tegra driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index f5b112c..8f5cda7 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2262,7 +2262,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to setup debugfs: %d\n", err);
 	}
 
-	platform_set_drvdata(pdev, pcie);
 	return 0;
 
 disable_msi:

