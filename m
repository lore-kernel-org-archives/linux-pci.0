Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938918AbcJGQYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:00 -0400
Subject: [PATCH 5/7] PCI: iproc: Remove redundant null pointer checking
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Fri, 07 Oct 2016 11:23:44 -0500
Message-ID: <20161007162344.23015.2449.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The callers never pass null pointers here, so remove redundant checking
here.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3de157a..950622d 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -457,9 +457,6 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 	void *sysdata;
 	struct pci_bus *bus;
 
-	if (!iproc || !iproc->dev)
-		return -EINVAL;
-
 	ret = devm_request_pci_bus_resources(iproc->dev, res);
 	if (ret)
 		return ret;

