Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0132.outbound.protection.outlook.com ([207.46.100.132]:36224
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751106AbaJPIXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Oct 2014 04:23:09 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v6 05/13] PCI: spear: Change the func type of host init
Date: Thu, 16 Oct 2014 15:52:35 +0800
Message-ID: <1413445963-24706-6-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
References: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to avoid compilation warning, change
the func type of host init from void to int.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pcie-spear13xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 6dea9e4..b8fd76b 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -258,10 +258,12 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void spear13xx_pcie_host_init(struct pcie_port *pp)
+static int spear13xx_pcie_host_init(struct pcie_port *pp)
 {
 	spear13xx_pcie_establish_link(pp);
 	spear13xx_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops spear13xx_pcie_host_ops = {
-- 
1.9.1

