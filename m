Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0133.outbound.protection.outlook.com ([157.56.110.133]:14944
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751317AbaJJGLp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 02:11:45 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>
Subject: [PATCH v5]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Fri, 10 Oct 2014 13:41:07 +0800
Message-ID: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the v4:
1. add gpio controlled regulator for pcie on imx6sx sdb board.
2. in order to not break compilation, move designware modifications, before
imx6 pcie changes.
3. remove "PCI: imx6: Fix possible dead lock" from this series.
4. rename the pcie phy regulator from "pcie_regulator" to "pcie_phy_regulator".

[PATCH v5 1/9] PCI: designware: refine setup_rc and add msi data
[PATCH v5 2/9] PCI: designware: fix one potential assignment error of
[PATCH v5 3/9] PCI: imx6: wait the clocks to stabilize after ref_en
[PATCH v5 4/9] PCI: imx6: add imx6sx pcie support
[PATCH v5 5/9] ARM: imx6qdl: enable pcie on imx6qdl sabreauto
[PATCH v5 6/9] ARM: imx6: update dts and binding for imx6sx pcie
[PATCH v5 7/9] ARM: imx6sx: add syscon into gpc dts
[PATCH v5 8/9] ARM: imx6sx: add imx6sx pcie related gpr bits
[PATCH v5 9/9] ARM: imx6sx: enable pcie on imx6sx sdb board
