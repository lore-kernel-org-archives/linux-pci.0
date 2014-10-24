Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0135.outbound.protection.outlook.com ([157.56.111.135]:62304
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752098AbaJXDBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 23:01:13 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>
Subject: [PATCH V1]PCI: imx6: Wait the clocks to stabilize after ref_en
Date: Fri, 24 Oct 2014 10:30:51 +0800
Message-ID: <1414117852-31657-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fabio suggested to resend this patch only, because that he notice that
the kernel does not boot anymore since commit  3fce0e882f61
(PCI: imx6: Delay enabling reference clock for SS until it stabilizes)
on a system that does not pass the PCI gpio reset in the dtb. This causes
a regression on mx6 nitrogen boards.

[PATCH V1] PCI: imx6: Wait the clocks to stabilize after ref_en
---
 drivers/pci/host/pci-imx6.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

