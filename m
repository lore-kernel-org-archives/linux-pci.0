Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55577 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbbBBFKJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 00:10:09 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so77687881pad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Feb 2015 21:10:08 -0800 (PST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] PCI: rcar: Add mask of data to be written to PCIEPARL
Date: Mon,  2 Feb 2015 14:09:58 +0900
Message-Id: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lower 7bit of PCIEPARL is reserved bit. When we write to this register,
these bits must be 0.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 748786c..bb36e27 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -342,7 +342,8 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
 		res_start = res->start;
 
 	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
-	rcar_pci_write_reg(pcie, lower_32_bits(res_start), PCIEPARL(win));
+	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
+			   PCIEPARL(win));
 
 	/* First resource is for IO */
 	mask = PAR_ENABLE;
-- 
2.1.3

