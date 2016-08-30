Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55565 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758215AbcH3M5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2016 08:57:22 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Yehuda Yitschak <yehuday@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/3] pcie-designware: support for external MSI controller
Date: Tue, 30 Aug 2016 14:57:07 +0200
Message-Id: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This short patch series extends the pcie-designware code to support
using an external MSI controller, rather than the built-in MSI
controller. It does so by making the pcie-designware driver handle the
"msi-parent" DT property.

The first patch updates the Device Tree binding documentation, the
second patch makes the change to the Designware PCIe controller driver
itself, and finally the third patch updates the Marvell Armada 7K/8K
Device Tree to use the msi-parent property.

Thanks,

Thomas

Thomas Petazzoni (3):
  dt-bindings: designware-pcie: document optional msi-parent property
  pci: pcie-designware: add support for external MSI controller
  arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

 .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  3 +++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  3 +++
 drivers/pci/host/pcie-designware.c                 | 24 ++++++++++++++++------
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.7.4

