Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbcJLM7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:59:11 -0400
Subject: [PATCH v2 4/5] PCI: rcar: Remove DRV_NAME macro
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:59:07 -0500
Message-ID: <20161012125907.24785.44288.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DRV_NAME macro is only used once, so there's no real advantage to
having the macro at all.  Remove it and use the "rcar-pcie" name directly
in the struct platform_driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 800a86d..62700d1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -31,8 +31,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-#define DRV_NAME "rcar-pcie"
-
 #define PCIECAR			0x000010
 #define PCIECCTLR		0x000018
 #define  CONFIG_SEND_ENABLE	(1 << 31)
@@ -1199,7 +1197,7 @@ err_pm_disable:
 
 static struct platform_driver rcar_pcie_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "rcar-pcie",
 		.of_match_table = rcar_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},

