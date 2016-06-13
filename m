Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
	rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 0/7] Introduce ACPI world to ITS irqchip
Date: Mon, 13 Jun 2016 16:41:06 +0200
Message-Id: <1465828873-23498-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The series builds the PCI/MSI domain stack based on initial IORT driver
which is added in first place. As a reference please see IORT spec:
http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf

Patches were built on top of accepted ARM64 ACPI PCI support and can be found
all together here:
https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v6)

Tested on Cavium ThunderX server.

v5 -> v6
- added locking mechanism for IORT list with domain token
- IORT function name improvements
- extended IORT RID mapping helper
- reworked IORT to be more SMMU friendly
- IORT functions which map RID and find corresponding domain are not
  PCI specific any more (struct pci_dev -> struct device)
- bug fixes

v4 -> v5
- rebased against v4.7-rc1
- drop generic layer and call IORT functions directly
- improve resource abstraction and string formatting

v3 -> v4
- rebased against v4.5
- add ACPI support for IRQ domain handling on a per-device basis
- reorder domain setup step
- improve error handling
- code style improvements

v2 -> v3
- rebased on top of 4.4
- fixes and improvements for redistributor init via GICC structures
- fixes as per kbuild reports

v1 -> v2
- rebased on top of 4.4-rc4
- use pci_msi_domain_get_msi_rid for requester ID to device ID translation

Tomasz Nowicki (7):
  ACPI: I/O Remapping Table (IORT) initial support
  PCI/MSI: Setup MSI domain on a per-devices basis using IORT ACPI table
  irqchip/gicv3-its: Cleanup for ITS domain initialization
  irqchip/gicv3-its: Refator ITS DT init code to prepare for ACPI
  irqchip/gicv3-its: Probe ITS in the ACPI way
  irqchip/gicv3-its: Factor out code that might be reused for ACPI
  irqchip/gicv3-its: Use MADT ITS subtable to do PCI/MSI domain
    initialization

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/iort.c                      | 386 +++++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  88 +++++--
 drivers/irqchip/irq-gic-v3-its.c         | 185 ++++++++++-----
 drivers/irqchip/irq-gic-v3.c             |   7 +-
 drivers/pci/msi.c                        |  11 +-
 include/linux/iort.h                     |  38 +++
 include/linux/irqchip/arm-gic-v3.h       |   4 +-
 10 files changed, 646 insertions(+), 78 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1

