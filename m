Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [157.56.111.112] ([157.56.111.112]:34880 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751993AbaJTCvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Oct 2014 22:51:32 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>
Subject: [PATCH v7]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Mon, 20 Oct 2014 10:19:03 +0800
Message-ID: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Main changes since the v6:
1. Regarding to Lucas' suggestion, assert per-reset in suspend,
and de-assert it in resume. Thanks Lucas.

[PATCH v7 01/13] PCI: designware: Refine setup_rc and add msi data
[PATCH v7 02/13] PCI: designware: Set func type of host init to int
[PATCH v7 03/13] PCI: dra7xx: Change the func type of host init
[PATCH v7 04/13] PCI: exynos: Change the func type of host init
[PATCH v7 05/13] PCI: spear: Change the func type of host init
[PATCH v7 06/13] PCI: designware: Fix one potential assignment error
[PATCH v7 07/13] ARM: imx6sx: Add imx6sx pcie related gpr bits
[PATCH v7 08/13] PCI: imx6: Wait the clocks to stabilize after ref_en
[PATCH v7 09/13] PCI: imx6: Add imx6sx pcie support
[PATCH v7 10/13] ARM: imx6qdl: Enable pcie on imx6qdl sabreauto
[PATCH v7 11/13] ARM: imx6: Update dts and binding for imx6sx pcie
[PATCH v7 12/13] ARM: imx6sx: Add syscon into gpc dts
[PATCH v7 13/13] ARM: imx6sx: Enable pcie on imx6sx sdb board
