Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51184 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758971Ab3JOQHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 12:07:00 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/6] PCI: imx6: Random fixes
Date: Tue, 15 Oct 2013 18:06:34 +0200
Message-Id: <1381853200-5534-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as expected.

NOTE: I'm sure this will start some discussion. There are quite a few patches
      that are more of a hacks. Shawn, I didn't ignore your remark about the
      clock patches, I will test it ASAP, I just want to have these fixes in
      the public so others can comment/test.

Marek Vasut (6):
  PCI: imx6: Make reset-gpio optional
  PCI: imx6: Fix the clock for PCIe
  ARM: dts: imx6qdl: Fix the clock for PCIe
  PCI: imx6: Probe the PCIe in fs_initcall()
  PCI: imx6: Force Gen1 operation
  PCI: designware: Fix DT resource retrieval

 .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +-
 drivers/pci/host/pci-imx6.c                        | 63 ++++++++++++++++------
 drivers/pci/host/pcie-designware.c                 | 17 +++---
 4 files changed, 55 insertions(+), 31 deletions(-)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>

-- 
1.8.4.rc3

