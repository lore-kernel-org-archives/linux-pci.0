Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0119.outbound.protection.outlook.com ([65.55.169.119]:37472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751481AbaI2FdW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Sep 2014 01:33:22 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>
Subject: [PATCH v3]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Mon, 29 Sep 2014 13:03:08 +0800
Message-ID: <1411966997-27118-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the v2:
1. the async reset input need ref clock to sync internally, add one
10us delay between clks enable and the set of the pcie_ref_clk_en.
2. reformat imx6sx pcie dts, and split the dts changes into three part,
imx6sx pcie,imx6sx-sdb board, gpc dts.
3. add the pcie_phy-supply for imx6sx in dts and binding document.
4. figure out that display_axi clock is required by imx6sx pcie inbount
axi port. Add one more clk for imx6sx pcie.
5. Regarding to Lucas' suggestion, move "program correct class for RC"
from dw_pcie_host_init(), to dw_pcie_setup_rc().
6. add one re-store msi data function. Because that pcie controller
maybe powered off during system suspend, and the msi data configuration
would be lost. this functions can be used to restore the msi data
during the resume callback.
7. fix one possible dead lock during imx6sx pcie suspend resume
stress tests.

[PATCH v3 1/9] PCI: imx6: wait the clocks to stabilize after ref_en
[PATCH v3 2/9] PCI: imx6: enable pcie on imx6qdl sabreauto
[PATCH v3 3/9] PCI: imx6: update dts and binding for imx6sx pcie
[PATCH v3 4/9] PCI: imx6: add syscon into gpc dts
[PATCH v3 5/9] PCI: imx6: add imx6sx pcie related gpr bits
[PATCH v3 6/9] PCI: imx6: enable pcie on imx6sx sdb board
[PATCH v3 7/9] PCI: imx6: add imx6sx pcie support
[PATCH v3 8/9] PCI: designware: refine setup_rc and add msi data
[PATCH v3 9/9] PCI: imx6: Fix possible dead lock
