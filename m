Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35627 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaB1Rao (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 12:30:44 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernel@pengutronix.de
Subject: [PATCH 0/3] i.MX6 MSI support
Date: Fri, 28 Feb 2014 18:30:30 +0100
Message-Id: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds MSI support to the i.MX6 PCIe host
controller driver. We keep MSI optional in order
to not break any existing DTs.

This series depends on the previous sent series
"PCI irq mapping fixes and cleanups".

Lucas Stach (3):
  ARM: dts: imx6: extend PCIe interrupt list for MSI
  PCI: designware: make MSI isr shared irq aware
  PCI: imx6: add support for MSI

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  9 +++++++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +++-
 drivers/pci/host/pci-exynos.c                      |  4 +---
 drivers/pci/host/pci-imx6.c                        | 26 ++++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |  6 ++++-
 drivers/pci/host/pcie-designware.h                 |  2 +-
 6 files changed, 44 insertions(+), 7 deletions(-)

-- 
1.8.5.3

