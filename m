Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v3 0/4] Add Broadcom North Star 2 support
Date: Wed, 15 Jul 2015 21:39:19 -0700
Message-ID: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds Broadcom North Star 2 (NS2) SoC support. NS2 is an ARMv8
based SoC and under the Broadcom iProc family.

Sorry for tying this with the Broadcom iProc PCIe driver fixes for ARM64. I
have to tie them together because iProc PCIe support is enabled by default
when ARCH_BCM_IPROC is enabled. Without the fixes in the iProc PCIe driver,
enabling CONFIG_ARCH_BCM_IPROC would break the build for arm64 defconfig. Let
me know if there's a better way to handle this.

This patch series is generated based on v4.2-rc2 and tested on Broadcom NS2 SVK

Code available on GITHUB: https://github.com/Broadcom/arm64-linux.git
branch is ns2-core-v3

Changes from V2:
- Drop hardcoded earlycon kernel command line paramter in NS2 SVK dts file
because 1) earlycon is a debugging feature that can be enabled in the
bootloader and should not be enabled by default in the board dts file and 2)
of_earlycon should be used and support should be added to 8250 DW driver

Changes from V1:
- Took Arnd's advice to tweak the location of struct pci_sys_data within
struct iproc_pcie. This helps to get rid of most of the CONFIG_ARM wrap in
iProc PCIe core driver
- Use stdout-path and alias for serial console in NS2 SVK dts
- Add all 4 CPU descriptions in NS2 dtsi
- Remove "clock-frequency" property in the armv8 timer node so timer frequency
can be determined based on readings from CNTFRQ_EL0
- Remove config flag ARCH_BCM_NS2. Leave only ARCH_BCM_IPROC for all Broadcom
arm64 SoCs as advised

Ray Jui (4):
  PCI: iproc: enable arm64 support for iProc PCIe
  PCI: iproc: Fix ARM64 dependency in Kconfig
  arm64: Add Broadcom iProc family support
  arm64: dts: Add Broadcom North Star 2 support

 Documentation/devicetree/bindings/arm/bcm/ns2.txt |    9 ++
 arch/arm64/Kconfig                                |    5 +
 arch/arm64/boot/dts/Makefile                      |    1 +
 arch/arm64/boot/dts/broadcom/Makefile             |    5 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts          |   59 +++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi             |  118 +++++++++++++++++++++
 arch/arm64/configs/defconfig                      |    2 +
 drivers/pci/host/Kconfig                          |    2 +-
 drivers/pci/host/pcie-iproc.c                     |   15 +--
 drivers/pci/host/pcie-iproc.h                     |    8 +-
 10 files changed, 210 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/ns2.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-svk.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2.dtsi

-- 
1.7.9.5

