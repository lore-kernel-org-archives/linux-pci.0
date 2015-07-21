Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38814 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbbGUVvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 17:51:08 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: keystone: fix the boot noise for missing *config* reg space
Date: Tue, 21 Jul 2015 17:51:05 -0400
Message-ID: <1437515465-20739-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently on Keystone SoCs, boot up log shows an unnecessary boot
noise as follows:-

[    0.365823] keystone-pcie 21021000.pcie: missing *config* reg space

Keystone uses older version of designware h/w that doesn't have ATU
support. So va_cfg0_base and va_cfg1_base are already set up in
ks_dw_pcie_host_init() before calling dw_pcie_host_init() and
they point to the remote config space address va (both same for Keystone).
So add a check to avoid this boot noise on Keystone.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..b48b8a2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -388,7 +388,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		addrp = of_get_address(np, index, NULL, NULL);
 		pp->cfg0_mod_base = of_read_number(addrp, ns);
 		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
-	} else {
+	} else if (!pp->va_cfg0_base) {
 		dev_err(pp->dev, "missing *config* reg space\n");
 	}
 
-- 
1.9.1

