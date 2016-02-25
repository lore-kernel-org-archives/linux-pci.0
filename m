Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34482 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbcBYOsM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2016 09:48:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id b205so3898522wmb.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Feb 2016 06:48:12 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
Date: Thu, 25 Feb 2016 15:47:47 +0100
Message-Id: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v3:
 * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
v2:
 * leave out regulator handling from driver, will be done later
   in PM subsystem 
 * use BIT() macro for MFD

Christoph Fritz (2):
  MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
  PCI: imx6: add initial imx6sx support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
 3 files changed, 101 insertions(+), 40 deletions(-)

-- 
2.1.4

