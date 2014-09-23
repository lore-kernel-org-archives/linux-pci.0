Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0141.outbound.protection.outlook.com ([157.56.111.141]:41189
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755932AbaIWO3F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 10:29:05 -0400
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
Subject: [PATCH] PCI: designware: Fix IO resource end address calculation
Date: Tue, 23 Sep 2014 22:28:57 +0800
Message-ID: <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

End address should be equal to start_addr + size - 1.
The patch fixes PCI IO resource end address calculation.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 0f3cb2a..c19184f7 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -459,7 +459,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 			pp->io.end = min_t(resource_size_t,
 					   IO_SPACE_LIMIT,
 					   range.pci_addr + range.size
-					   + global_io_offset);
+					   + global_io_offset - 1);
 			pp->io_size = resource_size(&pp->io);
 			pp->io_bus_addr = range.pci_addr;
 			pp->io_base = range.cpu_addr;
-- 
1.9.1

