Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRkp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:40:45 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@freescale.com>, kernel@pengutronix.de
Subject: [PATCH 2/3] PCI: imx6: prevent driver unbind
Date: Wed, 23 Jul 2014 19:40:16 +0200
Message-Id: <1406137217-11294-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current code is not prepared for the driver to be
bound/unbound arbitrarily.

Prevent possible user visible issues by disabling the
bind sysfs attributes.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efaa331c..ceb1677884b2 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -600,6 +600,7 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.owner	= THIS_MODULE,
 		.of_match_table = imx6_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
-- 
2.0.1

