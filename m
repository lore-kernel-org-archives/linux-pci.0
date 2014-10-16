Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0131.outbound.protection.outlook.com ([65.55.169.131]:19648
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750765AbaJPIXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Oct 2014 04:23:07 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>
Subject: [PATCH v6]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Thu, 16 Oct 2014 15:52:30 +0800
Message-ID: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the v5:
1.use noirq pm_ops instead of the syscore pm_ops
2.in order to not break compilation, move gpr bits modifications, before
imx6 pcie changes.
3.host init maybe failed, return negative value when there is a failure
in the host init. In responding, the host_init func type had been change from
void to init.

[PATCH v6 01/13] PCI: designware: Refine setup_rc and add msi data
[PATCH v6 02/13] PCI: designware: Set func type of host init to int
[PATCH v6 03/13] PCI: dra7xx: Change the func type of host init
[PATCH v6 04/13] PCI: exynos: Change the func type of host init
[PATCH v6 05/13] PCI: spear: Change the func type of host init
[PATCH v6 06/13] PCI: designware: Fix one potential assignment error
[PATCH v6 07/13] ARM: imx6sx: Add imx6sx pcie related gpr bits
[PATCH v6 08/13] PCI: imx6: Wait the clocks to stabilize after ref_en
[PATCH v6 09/13] PCI: imx6: Add imx6sx pcie support
[PATCH v6 10/13] ARM: imx6qdl: Enable pcie on imx6qdl sabreauto
[PATCH v6 11/13] ARM: imx6: Update dts and binding for imx6sx pcie
[PATCH v6 12/13] ARM: imx6sx: Add syscon into gpc dts
[PATCH v6 13/13] ARM: imx6sx: Enable pcie on imx6sx sdb board
