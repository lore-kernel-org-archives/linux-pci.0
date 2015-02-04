Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33587 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437AbbBDJDI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 04:03:08 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so963789pad.10
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2015 01:03:07 -0800 (PST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] PCI: rcar: Change macro name of PCIEPARL and PCIEPARH
Date: Wed,  4 Feb 2015 18:02:55 +0900
Message-Id: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIEPARL and PCIEPARH are macro that calculates address of the register.
However, register name is incorrect, PCIEPALR and PCIEPAUR is correct.
This change macro name to PCIEPALR and PCIEPAUR.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index eb12659..183c32d 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -64,8 +64,8 @@
 #define  LAR_ENABLE		(1 << 1)
 
 /* PCIe address reg & mask */
-#define PCIEPARL(x)		(0x03400 + ((x) * 0x20))
-#define PCIEPARH(x)		(0x03404 + ((x) * 0x20))
+#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
+#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
 #define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
 #define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
 #define  PAR_ENABLE		(1 << 31)
@@ -341,9 +341,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
 	else
 		res_start = res->start;
 
-	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
+	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
 	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
-			   PCIEPARL(win));
+			   PCIEPALR(win));
 
 	/* First resource is for IO */
 	mask = PAR_ENABLE;
-- 
2.1.3

