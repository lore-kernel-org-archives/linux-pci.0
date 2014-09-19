Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0115.outbound.protection.outlook.com ([65.55.169.115]:15424
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754085AbaISPVe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Sep 2014 11:21:34 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <bhelgaas@google.com>
CC: <mohit.kumar@st.com>, <jg1.han@samsung.com>,
	<linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] PCI: designware: Use NULL instead of false
Date: Fri, 19 Sep 2014 10:47:30 -0300
Message-ID: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_get_address() expects pointers in the third and fourth parameters.

Pass NULL in order to fix the following sparse warnings:

drivers/pci/host/pcie-designware.c:433:51: warning: Using plain integer as NULL pointer
drivers/pci/host/pcie-designware.c:433:58: warning: Using plain integer as NULL pointer 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12c42fc..f1f0b7a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -430,7 +430,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 		/* Find the untranslated configuration space address */
 		index = of_property_match_string(np, "reg-names", "config");
-		addrp = of_get_address(np, index, false, false);
+		addrp = of_get_address(np, index, NULL, NULL);
 		pp->cfg0_mod_base = of_read_number(addrp, ns);
 		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->config.cfg0_size;
 	} else {
-- 
1.9.1

