Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42307 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbbJMSGD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 14:06:03 -0400
From: WingMan Kwok <w-kwok2@ti.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <m-karicheri2@ti.com>,
	<bhelgaas@google.com>, <ssantosh@kernel.org>,
	<linux@arm.linux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>
Subject: [PATCH 0/3] Common SerDes driver for TI's Keystone Platforms
Date: Tue, 13 Oct 2015 14:04:21 -0400
Message-ID: <1444759464-32299-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On TI's Keystone platforms, several peripherals such as the
gbe ethernet switch, 10gbe ethether switch and PCIe controller
require the use of a SerDes for converting SoC parallel data into
serialized data that can be output over a high-speed electrical
interface, and also converting high-speed serial input data
into parallel data that can be processed by the SoC.  The
SerDeses used by those peripherals, though they may be different,
are largely similar in functionality and setup.

This patch series provides a SerDes phy driver implementation that can be
used by the above mentioned peripheral drivers to configure their
respective SerDeses.

As an example of the using the SerDes driver, this patch series also
updates the Keystone PCIe host driver to enable and use its SerDes block.

References:

[1] KeyStone II Architecture Serializer/Deserializer (SerDes) User's Guide
    (http://www.ti.com/lit/ug/spruho3a/spruho3a.pdf)

WingMan Kwok (3):
  phy: keystone: serdes driver for gbe 10gbe and pcie
  PCI: keystone: update to use generic keystone serdes driver
  ARM: keystone: dts: add PCI serdes driver bindings

 Documentation/devicetree/bindings/phy/ti-phy.txt |  256 +++
 arch/arm/boot/dts/k2e.dtsi                       |   24 +
 arch/arm/boot/dts/keystone.dtsi                  |   25 +
 drivers/pci/host/pci-keystone.c                  |   54 +-
 drivers/pci/host/pci-keystone.h                  |    2 +
 drivers/phy/Kconfig                              |    8 +
 drivers/phy/Makefile                             |    1 +
 drivers/phy/phy-keystone-serdes.c                | 2465 ++++++++++++++++++++++
 8 files changed, 2826 insertions(+), 9 deletions(-)
 create mode 100644 drivers/phy/phy-keystone-serdes.c

-- 
1.7.9.5

