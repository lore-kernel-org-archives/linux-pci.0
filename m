Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [65.55.169.138] ([65.55.169.138]:4086 "EHLO
	na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751569AbaJTCtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Oct 2014 22:49:53 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v7 03/13] PCI: dra7xx: Change the func type of host init
Date: Mon, 20 Oct 2014 10:19:06 +0800
Message-ID: <1413771556-32212-4-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
References: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to avoid compilation warning, change
the func type of host init from void to int.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pci-dra7xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 52b34fe..7b11968 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -141,13 +141,15 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 				   LEG_EP_INTERRUPTS);
 }
 
-static void dra7xx_pcie_host_init(struct pcie_port *pp)
+static int dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
 	dra7xx_pcie_establish_link(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
-- 
1.9.1

