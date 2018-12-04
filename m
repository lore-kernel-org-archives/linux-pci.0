Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8216C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CC62081C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Z3VQ61Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CC62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeLDN1i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:27:38 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33624 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeLDN1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 08:27:38 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 841245C03A3;
        Tue,  4 Dec 2018 14:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543930056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=l/NqMlMJK6NCuID2vd75UkjcijsChz0PXtxpAkinb6A=;
        b=Z3VQ61CdqWFgxFzEkOjzTmIHpJ5Jv61kLXyp523WCTiAT2fVLCgnemUzqQIYMSf+Amqhfy
        7wEWsStTzS9y4ABLxwtVEPxzx8FobRfn6j0WjCGSbwERljOgkaPhpkmtMJMzBQeRmP3o2Z
        4QT3l+tHjscUfGZwK35zGspSrtLyZRE=
From:   Stefan Agner <stefan@agner.ch>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     robin.murphy@arm.com, tpiepho@impinj.com, linux@armlinux.org.uk,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        festevam@gmail.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        stefan@agner.ch, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pci: imx6: avoid dereferencing program counter from user mode
Date:   Tue,  4 Dec 2018 14:27:32 +0100
Message-Id: <20181204132733.14422-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The custom fault handler is currently only meant to handle kernel
mode bus faults. Exit in case the abort happened in user mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 69f86234f7c0..54a29e441303 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -270,8 +270,14 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
-	unsigned long instr = *(unsigned long *)pc;
-	int reg = (instr >> 12) & 15;
+	unsigned long instr;
+	int reg;
+
+	if (user_mode(regs))
+		return 1;
+
+	instr = *(unsigned long *)pc;
+	reg = (instr >> 12) & 15;
 
 	/*
 	 * If the instruction being executed was a read,
-- 
2.19.1

