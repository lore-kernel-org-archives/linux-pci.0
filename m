Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:56674 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbaLSISj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Dec 2014 03:18:39 -0500
From: Sean Cross <xobs@kosagi.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org
Cc: bunnie@kosagi.com, Sean Cross <xobs@kosagi.com>
Subject: [PATCH 0/2] Add support for kosagi novena
Date: Fri, 19 Dec 2014 16:10:15 +0800
Message-Id: <1418976617-833-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kosagi Novena mainboard contains an i.MX6, along with a PCI Express slot.
This patchset adds regulator support to the PCI Express slot, and adds
device tree support for the Novena mainboard.

Sean Cross (2):
  PCI: imx6: Add power-supply support
  ARM: dts: imx6q: add Novena board

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-novena.dts                 | 893 +++++++++++++++++++++
 drivers/pci/host/pci-imx6.c                        |  20 +-
 4 files changed, 916 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts

-- 
2.1.3

