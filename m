Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0143.outbound.protection.outlook.com ([65.55.169.143]:56595
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752358AbaJ0Frs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Oct 2014 01:47:48 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, <m-karicheri2@ti.com>
Subject: [PATCH V3]PCI: imx6: Wait the clocks to stabilize after ref_en
Date: Mon, 27 Oct 2014 13:17:31 +0800
Message-ID: <1414387052-3582-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn:
Can you pick up this patch as the fix for v3.18?
Thanks in advanced.

Fabio suggested to resend this patch only, because that he notice that
the kernel does not boot anymore since commit  3fce0e882f61
(PCI: imx6: Delay enabling reference clock for SS until it stabilizes)
on a system that does not pass the PCI gpio reset in the dtb. This causes
a regression on mx6 nitrogen boards.

Add "Acked-by: Lucas Stach <l.stach@pengutronix.de>" into the patch.
Remove "Tested-by: Tim Harvey <tharvey@gateworks.com>" from this patch.

[PATCH V3] PCI: imx6: Wait the clocks to stabilize after ref_en
