Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:24329 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754286AbbJPPWt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 11:22:49 -0400
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
Subject: [PATCH v4 0/3] arm64: Juno: Add support for PCIe on R1 board
Date: Fri, 16 Oct 2015 16:22:06 +0100
Message-Id: <1445008929-32267-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes in v4 vs v3:
 - Dropped the quirks patches as the fixup can be done in firmware.
Changes in v3 vs v2:
 - Add Documentation files describing the DT bindings for plda,xpressrich3-axi
   and arm,juno-r1-pcie properties.
 - Cosmetic changes in the .dts to bracket range and interrupt-map entries
   individually.
Changes in v2 vs v1:
 - Add plda as OF vendor prefix
 - Add more specific compatible values to the Juno R1 DT
 

Juno R1 board has a working PCIe host bridge that can be enabled and
configured by the firmware and made use of by Linux. For UEFI, the
Linaro releases contain firmware that configure the XpressRICH3 host
bridge correctly. For U-Boot based setups, one needs the patchset
posted here[1].

This patchset adds a quirk for setting the correct class to the host
bridge device and the device tree changes that enable PCIe on Juno R1.
We also update the defconfig to enable the generic PCI host bridge driver.

The changes can also available in the git repository at:

  git://linux-arm.org/linux-ld.git for-upstream/juno-pcie

They are based on v4.3-rc5.

Catalin, Will: This series has got Mark's ACKs for the DT changes and
now with the quirks dropped it can be pulled into whatever arm64 -next
branch you want to prepare. Do you want a formal pull request for this?

Best regards,
Liviu

1. http://lists.denx.de/pipermail/u-boot/2015-October/229669.html

Liviu Dudau (3):
  Documentation: of: Document the bindings used by Juno R1 PCIe host bridge
  arm64: Juno: Add support for the PCIe host bridge on Juno R1
  arm64: defconfig: Enable PCI generic host bridge by default

 .../devicetree/bindings/pci/arm,juno-r1-pcie.txt     | 10 ++++++++++
 .../devicetree/bindings/pci/plda,xpressrich3-axi.txt | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt          |  1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                  | 20 ++++++++++++++++++++
 arch/arm64/configs/defconfig                         |  1 +
 5 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

-- 
2.6.0

