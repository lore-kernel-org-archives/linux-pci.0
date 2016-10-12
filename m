Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933073AbcJLMxo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:44 -0400
Subject: [PATCH v2 3/5] PCI: iproc: Validate CSR base in BCMA setup code
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Wed, 12 Oct 2016 07:53:34 -0500
Message-ID: <20161012125334.24076.31257.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Validate iproc_pcie->base for BCMA devices just like we already do for
platform devices in iproc_pcie_pltfm_probe().  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-bcma.c |    5 +++++
 drivers/pci/host/pcie-iproc.c      |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index ec6edaf..8ce0890 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -55,6 +55,11 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	pcie->dev = dev;
 
 	pcie->base = bdev->io_addr;
+	if (!pcie->base) {
+		dev_err(dev, "no controller registers\n");
+		return -ENOMEM;
+	}
+
 	pcie->base_addr = bdev->addr;
 
 	res_mem.start = bdev->addr_s[0];
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index c41d6bd..12a5156 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -462,7 +462,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	void *sysdata;
 	struct pci_bus *bus;
 
-	if (!pcie || !pcie->dev || !pcie->base)
+	if (!pcie || !pcie->dev)
 		return -EINVAL;
 
 	dev = pcie->dev;

