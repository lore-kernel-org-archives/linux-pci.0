Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42831 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbbCKEYB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 00:24:01 -0400
Received: by padfa1 with SMTP id fa1so7951510pad.9
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 21:24:01 -0700 (PDT)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: phil.edworthy@renesas.com, linux-pci@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] PCI: rcar: Add PCIE_CONF_REGNO macro for PCIECAR register
Date: Wed, 11 Mar 2015 13:23:50 +0900
Message-Id: <1426047830-26410-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The reg variable used when setting PCIECAR register need to be masked by 0xFC
by restriction of the corresponding register.
This adds PCIE_CONF_REGNO are macros for masking changes that PCIE_CONF_REGNO
is used when setting PCIECAR register.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c57bd0a..1f493ef 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -104,6 +104,7 @@
 #define  PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
 #define  PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
 #define  PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
+#define  PCIE_CONF_REGNO(r)	(r & 0xfc)
 
 #define RCAR_PCI_MAX_RESOURCES 4
 #define MAX_NR_INBOUND_MAPS 6
@@ -227,7 +228,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 
 	/* Set the PIO address */
 	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
+		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) |
+		PCIE_CONF_REGNO(reg), PCIECAR);
 
 	/* Enable the configuration access */
 	if (bus->parent->number == pcie->root_bus_nr)
-- 
2.1.3

