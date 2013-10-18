Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58170 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab3JRA1c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2013 20:27:32 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3668860pde.37
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2013 17:27:32 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH] PCI: imx6: fix imprecise abort handler
Date: Thu, 17 Oct 2013 17:27:22 -0700
Message-Id: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An imprecise abort is triggered when a port behind a switch is accessed
and no device is present.  At enumeration, imprecise aborts are not enabled
thus this ends up getting deferred until the kernel has completed init.  At
that point we must not adjust PC - the handler must do nothing, but a handler
must exist.

This fixes random crashes that occur right after freeing init.
This is against linux-pci/host-imx6.

Acked-by: Marek Vasut <marex@denx.de>
Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/host/pci-imx6.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 966bac6..90fce05 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -200,12 +200,6 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
-	/*
-	 * If it was an imprecise abort, then we need to correct the
-	 * return address to be _after_ the instruction.
-	 */
-	if (fsr & (1 << 10))
-		regs->ARM_pc += 4;
 	return 0;
 }
 
-- 
1.7.9.5

