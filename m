Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbcAFK7c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2016 05:59:32 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 0/2] dra72: add support for PCIE 2 lane mode
Date: Wed, 6 Jan 2016 16:29:06 +0530
Message-ID: <1452077948-26232-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dra72 reuse the USB PHY for the PCIe 2n lane. So in order for PCIe x2 mode
to work in dra72, certain special configuration has to be made in
USB PHY. This patch series adds those configurations.

In order to enable PCIe x2 mode in DRA72, USB should be disabled.

Certain board modifications has to be done in order to test
x2 mode in dra72-evm.

Patch series is rebased on top of linux-phy next

Kishon Vijay Abraham I (2):
  phy: ti-pipe3: get tx and rx MEM resource
  phy: ti-pipe3: configure usb3 phy to be used as pcie phy

 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 +
 drivers/phy/phy-ti-pipe3.c                       |   57 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

-- 
1.7.9.5

