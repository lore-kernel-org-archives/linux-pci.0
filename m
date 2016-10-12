Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932959AbcJLOEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:04:49 -0400
Subject: [PATCH v2 3/4] PCI: spear: Reorder struct spear13xx_pcie
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:04:44 -0500
Message-ID: <20161012140444.30368.62006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 26e905d..ecfb49e 100644
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
 

