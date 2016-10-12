Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754864AbcJLNms (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:42:48 -0400
Subject: [PATCH v2 2/8] PCI: hisi: Remove unused platform data
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:42:44 -0500
Message-ID: <20161012134244.28562.45315.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The hisi driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 1c08028..d4a5812 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -210,8 +210,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, hisi_pcie);
-
 	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
 
 	return 0;

