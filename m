Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:26510 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756211AbbJINqD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 09:46:03 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] arm64: Juno: Add support for PCIe on R1 board
Date: Fri,  9 Oct 2015 14:45:19 +0100
Message-Id: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Juno R1 board has a working PCIe host bridge that can be enabled and
configured by the firmware and made use of by Linux. For UEFI, the
Linaro releases contain firmware that configure the XpressRICH3 host
bridge correctly. For U-Boot based setups, one needs the patchset
posted here[1].

This patchset adds a quirk for setting the correct class to the host
bridge device and the device tree changes that enable PCIe on Juno R1.
We also update the defconfig to enable the generic PCI host bridge driver.

Best regards,
Liviu

1. http://lists.denx.de/pipermail/u-boot/2015-October/229669.html


Andrew Murray (1):
  pci: Add PLDA's XpressRICH3 PCIe host bridge PCI ID

Liviu Dudau (3):
  PCI: Add quirk for PLDA's XpressRICH3 host bridge class.
  arm64: Juno: Add support for the PCIe host bridge on Juno R1
  arm64: defconfig: Enable PCI generic host bridge by default

 arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
 arch/arm64/configs/defconfig        |  1 +
 drivers/pci/quirks.c                | 10 ++++++++++
 include/linux/pci_ids.h             |  3 +++
 4 files changed, 34 insertions(+)

-- 
2.6.0

