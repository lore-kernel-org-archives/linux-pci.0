Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756788AbcJGQb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:58 -0400
Subject: [PATCH 5/8] PCI: armada: Reorder struct armada8k_pcie
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:54 -0500
Message-ID: <20161007163153.24582.18919.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder the device-specific struct to put the DesignWare generic struct
pcie_port first.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 16fcb43..276125f 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -29,8 +29,8 @@
 #include "pcie-designware.h"
 
 struct armada8k_pcie {
+	struct pcie_port pp;		/* pp.dbi_base is DT ctrl */
 	struct clk *clk;
-	struct pcie_port pp;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000

