Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F81C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9F420660
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 13:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SSWaLxnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9F420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeK2A1h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:27:37 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:41852 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeK2A1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 19:27:37 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9BEFA5C0D8F;
        Wed, 28 Nov 2018 14:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543411556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kmrYbWTrsnLX4BVniuahhuRxXCpcWsRxae9zHzOhLKc=;
        b=SSWaLxnXQpBhGX96ZBuORbwQFgLcAsufpY+nbboGT0yGtRq1HDecRGy/TWrnGXpFU5EOAu
        rqAz9PnIHtXuw9/iojnpEaJQhSgxyVAcX5T+lIsvkdOSW8QwfucuvaKT/uiUHp7bTOTEMw
        9T6B3J1MBoJH7f5/HCO2QJy1xriV8oQ=
From:   Stefan Agner <stefan@agner.ch>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        festevam@gmail.com, lorenzo.pieralisi@arm.com, tpiepho@impinj.com,
        bhelgaas@google.com, stefan@agner.ch, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
Date:   Wed, 28 Nov 2018 14:25:54 +0100
Message-Id: <20181128132554.28139-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a fault handler which handles reads in Thumb-2 mode. Install
the appropriate handler depending on which mode the kernel has
been built. This avoids an "Unhandled fault: external abort on
non-linefetch (0x1008) at 0xf0a80000" during boot on a device
with a PCIe switch connected.

Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
FWIW, I found this manual helpful to write the code below:
http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66

--
Stefan

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 69f86234f7c0..683deb74d69f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/reset.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <asm/opcodes.h>
 
 #include "pcie-designware.h"
 
@@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 1;
 }
 
+static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long instr = *(unsigned long *)pc;
+	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
+	int reg = thumb2_instr & 7;
+
+	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
+		return 1;
+
+	/* Load word/byte and halfword immediate offset */
+	if (((thumb2_instr & 0xe800) == 0x6800) ||
+	    ((thumb2_instr & 0xf800) == 0x8800)) {
+		unsigned long val;
+
+		if (thumb2_instr & 0x1000)
+			val = 0xff;
+		else if (thumb2_instr & 0x8000)
+			val = 0xffff;
+		else
+			val = 0xffffffffUL;
+
+		regs->uregs[reg] = val;
+		regs->ARM_pc += 2;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int imx6_pcie_attach_pd(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1076,7 +1110,8 @@ static int __init imx6_pcie_init(void)
 	 * we can install the handler here without risking it
 	 * accessing some uninitialized driver state.
 	 */
-	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
+	hook_fault_code(8, thumb2 ? imx6q_pcie_abort_handler_thumb2 :
+			imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
 
 	return platform_driver_register(&imx6_pcie_driver);
-- 
2.19.1

