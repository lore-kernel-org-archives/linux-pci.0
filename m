Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:30312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752492AbaJTFzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 01:55:53 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>
Subject: [PATCH v8]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Mon, 20 Oct 2014 13:25:15 +0800
Message-ID: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the v6(v7 is ignored):
1. Regarding to Lucas' suggestion, assert per-reset in suspend,
and de-assert it in resume.
2. Use pp->ops->get_msi_data in dw_pcie_msi_cfg_restore()
if there is one get_msi_data pp ops callback, refer to Muali's comment.
3. In order to avoid the compilation, squash imx6 changes with patch2-5
of v6, since the prototype of the host_init is changed.


[PATCH v8 1/9] PCI: designware: Refine setup_rc and add msi data
[PATCH v8 2/9] PCI: designware: Fix one potential assignment error of
[PATCH v8 3/9] ARM: imx6sx: Add imx6sx pcie related gpr bits
[PATCH v8 4/9] PCI: imx6: Wait the clocks to stabilize after ref_en
[PATCH v8 5/9] PCI: imx6: Add imx6sx pcie support
[PATCH v8 6/9] ARM: imx6qdl: Enable pcie on imx6qdl sabreauto
[PATCH v8 7/9] ARM: imx6: Update dts and binding for imx6sx pcie
[PATCH v8 8/9] ARM: imx6sx: Add syscon into gpc dts
[PATCH v8 9/9] ARM: imx6sx: Enable pcie on imx6sx sdb board
