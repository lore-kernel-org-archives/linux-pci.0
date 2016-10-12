Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933077AbcJLMxq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:46 -0400
Subject: [PATCH v2 4/5] PCI: iproc: Remove redundant null pointer checking
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Wed, 12 Oct 2016 07:53:42 -0500
Message-ID: <20161012125342.24076.88359.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The callers never pass a null "pcie" pointer (they check for kzalloc
failure), so we don't need to check here.  The bus driver should never call
the probe function with a null ->dev pointer, so we don't need to check
that either.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 12a5156..e9210f6 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -462,9 +462,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	void *sysdata;
 	struct pci_bus *bus;
 
-	if (!pcie || !pcie->dev)
-		return -EINVAL;
-
 	dev = pcie->dev;
 	ret = devm_request_pci_bus_resources(dev, res);
 	if (ret)

