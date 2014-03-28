Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59000 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaC1QxH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:53:07 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
Date: Fri, 28 Mar 2014 17:52:51 +0100
Message-Id: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While working on MSI support for the i.MX6 PCIe host driver
it has been discovered that the binding for this host controller
is broken in many ways (refer to the patch descriptions for more
info) and was introduced without proper discussion about what
should/should not be in the binding.

This series fixes this and minimizes the difference of the
i.MX6 binding to the common designware PCIe binding. I'm aware
that this is a quite radical change, but I think it's justified
to do this as long as there aren't many user of the old binding
(most of the optional properties in the binding aren't even
implemented).

Looking forward to your feedback.

Lucas Stach (8):
  ARM: imx6q-clk: parent lvds_gate from lvds_sel
  PCI: designware: split Exynos and i.MX bindings
  ARM: dts: imx6: update pcie to bring in line with new binding
  PCI: imx6: use new clock names
  PCI: imx6: drop old irq mapping
  PCI: imx6: rip out optional (and unused) irqs
  PCI: designware: make MSI isr shared irq aware
  PCI: imx6: add support for MSI

 .../devicetree/bindings/pci/designware-pcie.txt    |  74 +----------
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  38 ++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt       |  65 +++++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   7 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   4 +-
 drivers/pci/host/pci-exynos.c                      |   4 +-
 drivers/pci/host/pci-imx6.c                        | 145 ++++++++-------------
 drivers/pci/host/pcie-designware.c                 |   6 +-
 drivers/pci/host/pcie-designware.h                 |   2 +-
 9 files changed, 176 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

-- 
1.9.0

