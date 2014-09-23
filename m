Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0141.outbound.protection.outlook.com ([65.55.169.141]:43032
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755744AbaIWO24 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 10:28:56 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH] PCI: designware: Fix configuration base address
Date: Tue, 23 Sep 2014 22:28:56 +0800
Message-ID: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The code has calculated cfg0_base and cfg1_base when parsing 'reg'
or 'ranges' property of PCI DTS node. so remove duplicate calculation.
And when using 'reg', resource cfg is not used, the removed code
will get incorrect configuration base.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index c28ca05..0f3cb2a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -515,7 +515,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	pp->mem_base = pp->mem.start;
 
 	if (!pp->va_cfg0_base) {
-		pp->cfg0_base = pp->cfg.start;
 		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
 						pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
@@ -525,7 +524,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (!pp->va_cfg1_base) {
-		pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
 		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
-- 
1.9.1

