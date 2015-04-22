Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v6 0/4]PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Date: Tue, 21 Apr 2015 23:15:07 -0700
Message-Id: <cover.1429677787.git.dhdang@apm.com>
In-Reply-To: <553667FD.9090806@arm.com>
References: <553667FD.9090806@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2048 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports. As the version 5 of this patch, the total MSI
vectors this driver supports is reduced to 256 to maintain the correct set_affinity
behavior for each MSI.

v6 changes:
	1. Correctly allocate MSI with bitmap_find_next_zero_area
	2. Add notifier for CPU hotplug case
	3. Driver clean up
	4. Add more detailed information into device tree binding document
	   and move the device tree binding patch before the driver/dts patch

v5 changes:
        1. Implement set_affinity for each MSI by statically allocating 2 MSI GIC IRQs
        for each X-Gene CPU core and moving MSI vectors around these GIC IRQs to steer
        them to target CPU core. As a consequence, the total MSI vectors that X-Gene v1
        supports is reduced to 256.

v4 changes:
        1. Remove affinity setting for each MSI
        2. Add description about register layout, MSI termination address and data
        3. Correct total number of MSI vectors to 2048
        4. Clean up error messages
        5. Remove unused module code

v3 changes:
        1. Implement MSI support using PCI MSI IRQ domain
        2. Only use msi_controller to store IRQ domain
v2 changes:
        1. Use msi_controller structure
        2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
 
 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  68 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 504 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  21 +
 7 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1

