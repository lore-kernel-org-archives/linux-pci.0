Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:47207 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbaLVIcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Dec 2014 03:32:47 -0500
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
Subject: [PATCH v2 0/4] Add support for kosagi novena
Date: Mon, 22 Dec 2014 16:32:03 +0800
Message-Id: <1419237127-21763-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kosagi Novena mainboard contains an i.MX6, along with a PCI Express slot.
This patchset adds regulator support to the PCI Express slot, and adds
device tree support for the Novena mainboard.

Changes since v1:
    - Add 'kosagi' to vendor prefixes
    - Add LCD panel to simple-panel
    - Renamed power-supply to bus-supply
    - Replaced devm_regulator_get() with devm_regulator_get_optional()
    - Moved regulator_enable to imx6_add_pcie_port()
    - Removed fpga@1 from spi definition in dts -- will use overlays instead

Sean Cross (4):
  drm/panel: simple: Add Innolux N133HSE panel support
  devicetree: bindings: Add vendor prefix for Kosagi
  PCI: imx6: Add power-supply support
  ARM: dts: imx6q: add Novena board

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   3 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-novena.dts                 | 856 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  26 +
 drivers/pci/host/pci-imx6.c                        |  27 +
 6 files changed, 914 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts

-- 
2.1.3

