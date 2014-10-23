Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41288 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbaJWCLh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 22:11:37 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDV00E1RKRBHP40@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 23 Oct 2014 11:11:36 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Simon Horman' <horms@verge.net.au>,
	'Phil Edworthy' <phil.edworthy@renesas.com>
Subject: [PATCH] PCI: rcar: make local symbol static
Date: Thu, 23 Oct 2014 11:11:47 +0900
Message-id: <000201cfee66$b319ef90$194dceb0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make local symbol static, because this is used only in this file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 61158e0..0df9b29 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -389,7 +389,7 @@ static void rcar_pcie_add_bus(struct pci_bus *bus)
 	}
 }
 
-struct hw_pci rcar_pci = {
+static struct hw_pci rcar_pci = {
 	.setup          = rcar_pcie_setup,
 	.map_irq        = of_irq_parse_and_map_pci,
 	.ops            = &rcar_pcie_ops,
-- 
1.7.9.5


