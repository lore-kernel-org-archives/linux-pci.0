Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58562 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021AbbBKKcn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 05:32:43 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id CF12020C3
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2015 05:23:12 -0500 (EST)
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
Subject: [PATCH v3 0/3] Add support for kosagi novena
Date: Wed, 11 Feb 2015 18:22:59 +0800
Message-Id: <1423650182-16865-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kosagi Novena mainboard contains an i.MX6, along with a PCI Express slot.
This patchset adds device tree support for the Novena mainboard.

Changes since v2:
 - Updated stmpe_touchscreen bindings to match documentation
 - Removed bindings for eepromoops, it6251, senoko
 - Removed simple-bus and moved regulators into the parent node
 - Removed "Peek array power" from hog
 - Removed lonely "wakeup" from kpp
 - Dropped "add power-supply support" patch

Changes since v1:
 - Add 'kosagi' to vendor prefixes
 - Add LCD panel to simple-panel
 - Renamed power-supply to bus-supply
 - Replaced devm_regulator_get() with devm_regulator_get_optional()
 - Moved regulator_enable to imx6_add_pcie_port()
 - Removed fpga@1 from spi definition in dts -- will use overlays instead


Sean Cross (3):
  drm/panel: simple: Add Innolux N133HSE panel support
  devicetree: bindings: Add vendor prefix for Kosagi
  ARM: dts: imx6q: add Novena board

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-novena.dts                 | 818 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  26 +
 4 files changed, 846 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts

-- 
2.1.3

