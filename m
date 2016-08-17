Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45286 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbcHQUAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 16:00:10 -0400
Subject: [PATCH v6 2/4] PCI: designware: Move link wait definitions to .c
 file
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 17 Aug 2016 14:59:58 -0500
Message-ID: <20160817195958.10418.30303.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Move the link wait sleep definitions to the .c file as suggested by
Jisheng Zhang in a previous patch.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c |    5 +++++
 drivers/pci/host/pcie-designware.h |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f6bd6d..e99f56e 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -26,6 +26,11 @@
 
 #include "pcie-designware.h"
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_USLEEP_MIN		90000
+#define LINK_WAIT_USLEEP_MAX		100000
+
 /* Synopsis specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 74a8fc6..285e1ed 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,11 +22,6 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
-
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;

