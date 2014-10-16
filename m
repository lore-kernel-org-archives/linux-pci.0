Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0101.outbound.protection.outlook.com ([157.56.110.101]:53017
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750891AbaJPIXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Oct 2014 04:23:07 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v6 04/13] PCI: exynos: Change the func type of host init
Date: Thu, 16 Oct 2014 15:52:34 +0800
Message-ID: <1413445963-24706-5-git-send-email-richard.zhu@freescale.com>
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
 drivers/pci/host/pci-exynos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c5d0ca3..606d0a9 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -494,10 +494,12 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void exynos_pcie_host_init(struct pcie_port *pp)
+static int exynos_pcie_host_init(struct pcie_port *pp)
 {
 	exynos_pcie_establish_link(pp);
 	exynos_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
-- 
1.9.1

