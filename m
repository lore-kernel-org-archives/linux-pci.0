Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38983 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752547AbcC0JbT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 05:31:19 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Yehuda Yitschak <yehuday@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/2] pci: host: new driver for Marvell Armada 7K/8K PCIe controller
Date: Sun, 27 Mar 2016 11:30:56 +0200
Message-Id: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of two patches add support for the PCIe controller found in
the Marvell Armada 7K/8K ARM processors. The first patch adds the
Device Tree binding documentation, the second patch the driver itself.

The driver is really simple, since the PCIe controller is based on the
Designware design, and only a little bit of vendor-specific glue is
needed.

Thanks!

Thomas

Thomas Petazzoni (2):
  dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
    controller
  pci: host: new driver for Marvell Armada 7K/8K PCIe controller

 .../devicetree/bindings/pci/pci-armada8k.txt       |  41 ++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-armada8k.c                   | 261 +++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
 create mode 100644 drivers/pci/host/pcie-armada8k.c

-- 
2.6.4

