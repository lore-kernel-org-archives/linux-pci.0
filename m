Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:7010
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751070AbaIVL2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 07:28:13 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>
Subject: [PATCH v1]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Mon, 22 Sep 2014 18:45:01 +0800
Message-ID: <1411382705-15301-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the RFC:
Thanks for quick review from Lucas.
1. seperate the smashed patch-set.
2. remove the "power-on-gpio".
3. add/update the pcie-supply of the dts and binding.
4. 

[PATCH v1 1/4] PCI: imx6: enable pcie on imx6qdl sabreauto
[PATCH v1 2/4] PCI: imx6: update dts and binding for imx6sx pcie
[PATCH v1 3/4] PCI: imx6: add imx6sx pcie related gpr bits
[PATCH v1 4/4] PCI: imx6: add imx6sx pcie support
