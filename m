Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965223AbcJGQoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:44:14 -0400
Subject: [PATCH 4/5] PCI: spear: Reorder struct spear13xx_pcie
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:44:05 -0500
Message-ID: <20161007164405.26585.40728.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct spear13xx_pcie to put generic fields first.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 2585fca..61bb8d7 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -25,10 +25,10 @@
 #include "pcie-designware.h"
 
 struct spear13xx_pcie {
+	struct pcie_port	pp;		/* DT dbi is pp.dbi_base */
 	void __iomem		*app_base;
 	struct phy		*phy;
 	struct clk		*clk;
-	struct pcie_port	pp;
 	bool			is_gen1;
 };
 

