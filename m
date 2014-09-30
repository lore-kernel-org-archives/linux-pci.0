Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0134.outbound.protection.outlook.com ([207.46.100.134]:23611
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751497AbaI3KHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 06:07:06 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>
Subject: [PATCH v4]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
Date: Tue, 30 Sep 2014 17:36:34 +0800
Message-ID: <1412069804-17162-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The 10th patch is not sent out properly, re-send the patch-set again.

Main changes since the v3:
1. fix one potential assignment error of cfg start in designware driver when
IORESOURCE_MEM "config" is represented as cfg space resource.
2. Use "config" cfg space in imx6sx pcie dts.
3. Add more descriptive in the imx6sx pcie binding.
4. Sort the pre-fix of the patch-set, then it would be easier
for Bjorn and Shawn to merge them, after the patch-set is accepted.
5. rename the disp_axi clcok to pcie_inbound_axi.

[PATCH v4 01/10] PCI: imx6: wait the clocks to stabilize after ref_en
[PATCH v4 02/10] PCI: imx6: add imx6sx pcie support
[PATCH v4 03/10] PCI: imx6: Fix possible dead lock
[PATCH v4 04/10] PCI: designware: refine setup_rc and add msi data
[PATCH v4 05/10] PCI: designware: fix one potential assignment error
[PATCH v4 06/10] ARM: imx6qdl: enable pcie on imx6qdl sabreauto
[PATCH v4 07/10] ARM: imx6: update dts and binding for imx6sx pcie
[PATCH v4 08/10] ARM: imx6sx: add syscon into gpc dts
[PATCH v4 09/10] ARM: imx6sx: add imx6sx pcie related gpr bits
[PATCH v4 10/10] ARM: imx6sx: enable pcie on imx6sx sdb board
