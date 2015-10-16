Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:22592
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751082AbbJPHSh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 03:18:37 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Yoder Stuart-B08248" <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH v4 1/6] PCI: layerscape: remove ls_pcie_establish_link()
Date: Fri, 16 Oct 2015 15:19:15 +0800
Message-ID: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ls_pcie_establish_link() does not do any real operation, except
to wait for the linkup establishment. In fact, this is not
necessary. Moreover, each PCIe controller not inserted device
will increase the Linux startup time about 200ms.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index b2328ea1..6dd44a0 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_pci.h>
@@ -62,27 +61,12 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static int ls_pcie_establish_link(struct pcie_port *pp)
-{
-	unsigned int retries;
-
-	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(100, 1000);
-	}
-
-	dev_err(pp->dev, "phy link never came up\n");
-	return -EINVAL;
-}
-
 static void ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 	u32 val;
 
 	dw_pcie_setup_rc(pp);
-	ls_pcie_establish_link(pp);
 
 	/*
 	 * LS1021A Workaround for internal TKT228622
-- 
1.9.1

