Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQlI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:41:08 -0400
Subject: [PATCH 5/6] PCI: keystone: Reorder struct keystone_pcie
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:41:04 -0500
Message-ID: <20161007164104.26090.20537.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct keystone_pcie to put generic fields first.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 2a81e05..be0ddc4 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -17,8 +17,8 @@
 #define MAX_LEGACY_HOST_IRQS		4
 
 struct keystone_pcie {
+	struct	pcie_port	pp;		/* pp.dbi_base is DT 0th res */
 	struct	clk		*clk;
-	struct	pcie_port	pp;
 	/* PCI Device ID */
 	u32			device_id;
 	int			num_legacy_host_irqs;
@@ -34,7 +34,7 @@ struct keystone_pcie {
 	int error_irq;
 
 	/* Application register space */
-	void __iomem		*va_app_base;
+	void __iomem		*va_app_base;	/* DT 1st resource */
 	struct resource		app;
 };
 

