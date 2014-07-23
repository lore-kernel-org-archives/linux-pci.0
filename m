Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757741AbaGWRw5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:52:57 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 3/4] PCI: designware: remove pci_assign_unassigned_resources call
Date: Wed, 23 Jul 2014 19:52:40 +0200
Message-Id: <1406137961-14684-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_common_init_dev() call right before will already
handle the device resource allocation, so this call
was a no-op.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index b869e202367c..dde5e6d4afa2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -568,7 +568,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	dw_pci.private_data = (void **)&pp;
 
 	pci_common_init_dev(pp->dev, &dw_pci);
-	pci_assign_unassigned_resources();
 #ifdef CONFIG_PCI_DOMAINS
 	dw_pci.domain++;
 #endif
-- 
2.0.1

