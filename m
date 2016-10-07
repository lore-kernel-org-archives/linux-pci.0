Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938811AbcJGQYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:00 -0400
Subject: [PATCH 4/7] PCI: iproc: Validate CSR base in BCMA setup code
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Fri, 07 Oct 2016 11:23:36 -0500
Message-ID: <20161007162336.23015.7099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Validate iproc->base for BCMA devices just like we already do for platform
devices in iproc_pcie_pltfm_probe().  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-bcma.c |    5 +++++
 drivers/pci/host/pcie-iproc.c      |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 72273ff..5377328 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -55,6 +55,11 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	bcma_set_drvdata(bdev, iproc);
 
 	iproc->base = bdev->io_addr;
+	if (!iproc->base) {
+		dev_err(&bdev->dev, "no controller registers\n");
+		return -ENOMEM;
+	}
+
 	iproc->base_addr = bdev->addr;
 
 	res_mem.start = bdev->addr_s[0];
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 38f5ee0..3de157a 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -457,7 +457,7 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 	void *sysdata;
 	struct pci_bus *bus;
 
-	if (!iproc || !iproc->dev || !iproc->base)
+	if (!iproc || !iproc->dev)
 		return -EINVAL;
 
 	ret = devm_request_pci_bus_resources(iproc->dev, res);

