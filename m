Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12347C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22E2081C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Ci0lrkr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC22E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLDN1j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:27:39 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33648 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDN1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 08:27:39 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D19835C07AA;
        Tue,  4 Dec 2018 14:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543930057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZDGS75OY2CnEYwbJ8d7y7z0pz7Qa2SwVyeltfytdi8=;
        b=Ci0lrkr4aqCtef7L1CtxiosDjlYrUy0H51byEx/rOkxq1VwGHJ6bzhKWtOzUTXy6yHErtJ
        80oh/dKBlJ6xJJmX34bD3C7z4ygG3saA5susUUjyTF+KEks0lTDPWpjTUiX+NVeMXG7GtL
        tRVfNilHAztXOFC4ljlYOLjroUnzLbg=
From:   Stefan Agner <stefan@agner.ch>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     robin.murphy@arm.com, tpiepho@impinj.com, linux@armlinux.org.uk,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        festevam@gmail.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        stefan@agner.ch, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pci: imx6: support kernels built in Thumb-2 mode
Date:   Tue,  4 Dec 2018 14:27:33 +0100
Message-Id: <20181204132733.14422-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204132733.14422-1-stefan@agner.ch>
References: <20181204132733.14422-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a fault handler which handles immediate reads in Thumb-2
mode. Install the appropriate handler depending on which mode
the kernel has been built. This avoids an "Unhandled fault:
external abort on non-linefetch (0x1008) at 0xf0a80000"
during boot on a device with a PCIe switch connected.

Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Added Thumb-2 32-bit instruction support (tested by inserting .w
  instructions in arch/arm/include/asm/io.h)
- Avoid dereferencing if fault happened in user mode

 drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 54a29e441303..a9bbbf176c4a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/reset.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <asm/opcodes.h>
 
 #include "pcie-designware.h"
 
@@ -305,6 +306,59 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 1;
 }
 
+static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long instr;
+
+	if (user_mode(regs))
+		return 1;
+
+	instr = __mem_to_opcode_thumb32(*(unsigned long *)pc);
+
+	if (__opcode_is_thumb32(instr)) {
+		/* Load word/byte and halfword immediate offset */
+		if ((instr & 0xff100000UL) == 0xf8100000UL) {
+			int reg = (instr >> 12) & 0xf;
+			unsigned long val;
+
+			if ((instr & 0x00700000UL) == 0x00100000UL)
+				val = 0xff;
+			else if ((instr & 0x00700000UL) == 0x00300000UL)
+				val = 0xffff;
+			else
+				val = 0xffffffffUL;
+
+			regs->uregs[reg] = val;
+			regs->ARM_pc += 4;
+			return 0;
+		}
+	} else {
+		instr = __mem_to_opcode_thumb16(*(unsigned long *)pc);
+
+		/* Load word/byte and halfword immediate offset */
+		if (((instr & 0xe800) == 0x6800) ||
+		    ((instr & 0xf800) == 0x8800)) {
+			int reg = instr & 0x7;
+			unsigned long val;
+
+			if (instr & 0x1000)
+				val = 0xff;
+			else if (instr & 0x8000)
+				val = 0xffff;
+			else
+				val = 0xffffffffUL;
+
+			regs->uregs[reg] = val;
+			regs->ARM_pc += 2;
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 static int imx6_pcie_attach_pd(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1075,6 +1129,8 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1082,7 +1138,8 @@ static int __init imx6_pcie_init(void)
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

