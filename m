Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbbG1NkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:40:05 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <tony@atomide.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<bcousson@baylibre.com>, <linux@arm.linux.org.uk>, <kishon@ti.com>,
	<nsekhar@ti.com>
Subject: [PATCH 0/2] pci: am57xx-evm: Fix PCIe card enumeration issue
Date: Tue, 28 Jul 2015 19:09:08 +0530
Message-ID: <1438090750-11604-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes PCIe card enumeration issue in am57xx-evm.

In the case of am57xx-evm, the PERST# line is connected to a gpio line
and this has to be driven low in order to perform a fundamental reset
of the card. If the gpio line is driven high, there is no way the card
can come out of reset.

Add support in the pcie-dra7xx driver to make gpio drive PERST# line.

The PERST# line can be used to perform reset not during the power on
sequence too (warm reset) but we are not adding support for this as the
PCIe express base sepcification doesn't explain how to perform warm
reset

"In some cases, it may be possible for the Fundamental Reset mechanism
to be triggered by hardware without the removal and re-application of
power to the component. This is called a warm reset. This document does
not specify a means for generating a warm reset."

Kishon Vijay Abraham I (2):
  pci: host: pci-dra7xx: Add support to make gpio drive PERST# line
  ARM: dts: am57xx-evm: Add 'gpios' property with gpio2_8

 Documentation/devicetree/bindings/pci/ti-pci.txt |    3 +++
 arch/arm/boot/dts/am57xx-beagle-x15.dts          |    5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |    2 +-
 drivers/pci/host/pci-dra7xx.c                    |   24 ++++++++++++++++++++--
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
1.7.9.5

