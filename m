Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:21504
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751272AbaIWEjj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 00:39:39 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>
Subject: [PATCH v2]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Tue, 23 Sep 2014 12:11:33 +0800
Message-ID: <1411445498-20250-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim:
After I changed the wait clocks stabilize delay after pcie_ref_en is set
in this patch-set.
Can you help to make a double check whether it's ok or not at your side?

Thanks in advanced.

Main changes since the v1:
1. Regarding to Lucas' comments, seperated the enalbe pcie on
imx6qdl sabreauto patch.
2. Add the description why the wait clock stabilize delay should
be run after pcie_ref_en is set.
3. Return 0 directly in suspend call back.

Main changes since the RFC:
Thanks for quick review from Lucas.
1. seperate the smashed patch-set.
2. remove the "power-on-gpio".
3. add/update the pcie-supply of the dts and binding.
4. 

[PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
[PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after ref_en
[PATCH v2 3/5] PCI: imx6: update dts and binding for imx6sx pcie
[PATCH v2 4/5] PCI: imx6: add imx6sx pcie related gpr bits
[PATCH v2 5/5] PCI: imx6: add imx6sx pcie support
