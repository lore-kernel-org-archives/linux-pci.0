Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42152 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbcFBJKE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 05:10:04 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/3] PCIe controller driver for Marvell Armada 3700
Date: Thu,  2 Jun 2016 11:09:42 +0200
Message-Id: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This small patch series adds a new driver for the PCIe controller
found on Marvell Armada 3700 ARM64 SoCs. Like any other new driver
submission, this patch series includes: a Device Tree binding
documentation patch, a patch adding the driver itself, and a patch
adding the Device Tree description of the hardware.

Thanks in advance for your reviews!

Thomas

Thomas Petazzoni (3):
  dt-bindings: add DT binding for the Aardvark PCIe controller
  PCI: host: new PCI host controller driver for Marvell Armada 3700
  arm64: dts: marvell: PCIe support for Armada 3700

 .../devicetree/bindings/pci/aardvark-pci.txt       |   51 +
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    5 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   23 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-aardvark.c                    | 1029 ++++++++++++++++++++
 7 files changed, 1125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 drivers/pci/host/pci-aardvark.c

-- 
2.7.4

