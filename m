Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Subject: [PATCH V7 0/8] Introduce ACPI world to ITS irqchip
Date: Mon, 20 Jun 2016 13:02:13 +0200
Message-Id: <1466420541-20101-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The series builds the PCI/MSI domain stack based on initial IORT driver
which is added in first place. As a reference please see IORT spec:
http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf

Tested on Cavium ThunderX server. The patches can be found here:
https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v7)

v6 -> v7
- rebased against irq/irqchip-4.8
- improvements for IORT ID mapping
- call IORT init call from acpi_init() instead of arch_initcall()
- split IORT driver in to two parts: core and ITS/MSI

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

Tomasz Nowicki (8):
  ACPI: I/O Remapping Table (IORT) initial support
  ACPI: Add new IORT functions to support MSI domain handling
  PCI/MSI: Setup MSI domain on a per-device basis using IORT ACPI table
  irqchip/gicv3-its: Cleanup for ITS domain initialization
  irqchip/gicv3-its: Refactor ITS DT init code to prepare for ACPI
  irqchip/gicv3-its: Probe ITS in the ACPI way
  irqchip/gicv3-its: Factor out code that might be reused for ACPI
  irqchip/gicv3-its: Use MADT ITS subtable to do PCI/MSI domain
    initialization

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/bus.c                       |   2 +
 drivers/acpi/iort.c                      | 389 +++++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  88 +++++--
 drivers/irqchip/irq-gic-v3-its.c         | 169 ++++++++++----
 drivers/irqchip/irq-gic-v3.c             |   7 +-
 drivers/pci/msi.c                        |  11 +-
 include/linux/iort.h                     |  41 ++++
 include/linux/irqchip/arm-gic-v3.h       |   4 +-
 11 files changed, 646 insertions(+), 70 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
