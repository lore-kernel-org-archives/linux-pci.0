Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754881AbcJLNxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:53:52 -0400
Subject: [PATCH v2 6/6] PCI: keystone: Reorder struct keystone_pcie
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:53:48 -0500
Message-ID: <20161012135348.29306.55245.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index fe2f741..bc54baf 100644
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
 

