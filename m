Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 00/18] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
Date: Wed, 26 Apr 2017 12:17:51 +0100
Message-Id: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Current pci_fixup_irqs() usage on ARM/ARM64 host controller drivers is
flawed in that pci_fixup_irqs() allocates IRQs for all PCI devices present
in a system; those PCI devices possibly belong to different PCI bus trees
(and possibly rooted at different host bridges) and may well be enabled
(ie probed and bound to a driver) by the time pci_fixup_irqs() is called
when probing a given host bridge driver.

Furthermore, current kernel code relying on pci_fixup_irqs() to
assign legacy PCI IRQs to devices does not work at all for
hotplugged devices in that the code carrying out the IRQ fixup
is called at host bridge driver probe time, which just cannot take
into account devices hotplugged after system has booted.

By leveraging Matthew Minter's patch series (and its purpose):

http://lkml.kernel.org/r/1445576642-29624-2-git-send-email-matt@masarand.com

this series[1] adds IRQs mapping and swizzling primitives to
the struct pci_host_bridge which allows IRQs to be allocated for
for a device at probe time with host bridge specific functions,
fixing the aforementioned limitations.

Current series remove pci_fixup_irqs() usage on ARM/ARM64; removal
can be extended to other architectures provided the IRQs map/swizzle
functions are set-up properly in the respective host bridges
set-up/probe paths.

Tested on kvmtool with PCI host generic.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms@verge.net.au>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Matthew Minter <matt@masarand.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>

Lorenzo Pieralisi (13):
  PCI: Initialize bridge release function at bridge allocation
  PCI: Add pci_free_host_bridge interface
  PCI: Introduce pci_scan_root_bus_bridge()
  ARM: PCI: bios32: Convert PCI scan API to pci_scan_root_bus_bridge()
  ARM: PCI: dove: Convert PCI scan API to pci_scan_root_bus_bridge()
  ARM: PCI: iop13xx: Convert PCI scan API to pci_scan_root_bus_bridge()
  ARM: PCI: orion5x: Convert PCI scan API to pci_scan_root_bus_bridge()
  PCI: designware: Convert PCI scan API to pci_scan_root_bus_bridge()
  PCI: aardvark: Convert PCI scan API to pci_scan_root_bus_bridge()
  PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()
  PCI: Remove pci_scan_root_bus_msi()
  ARM: PCI: Remove pci_fixup_irqs() call for bios32 host controllers
  ARM/ARM64: PCI: Drop pci_fixup_irqs() usage for DT based host
    controllers

Matthew Minter (5):
  PCI: Build setup-irq.o on all arches
  PCI: Add IRQ mapping function pointers to pci_host_bridge struct
  PCI: Add pci_assign_irq() function and have pci_fixup_irqs() use it
  OF/PCI: Update of_irq_parse_and_map_pci() comment
  PCI: Add a call to pci_assign_irq() in pci_device_probe()

 arch/arm/kernel/bios32.c               | 63 ++++++++++++++++++++++-----
 arch/arm/mach-dove/pcie.c              | 36 ++++++++++++----
 arch/arm/mach-iop13xx/pci.c            | 36 +++++++++++++---
 arch/arm/mach-orion5x/pci.c            | 47 ++++++++++++++------
 arch/arm64/kernel/pci.c                | 32 +++++++++++---
 drivers/of/of_pci_irq.c                |  3 +-
 drivers/pci/Makefile                   | 17 +-------
 drivers/pci/dwc/pcie-designware-host.c | 41 +++++++++---------
 drivers/pci/host/pci-aardvark.c        | 33 +++++++++++---
 drivers/pci/host/pci-host-common.c     |  4 --
 drivers/pci/host/pci-tegra.c           |  3 +-
 drivers/pci/host/pci-versatile.c       |  1 -
 drivers/pci/host/pcie-altera.c         |  1 -
 drivers/pci/host/pcie-iproc.c          | 43 ++++++++++++-------
 drivers/pci/host/pcie-rcar.c           | 28 +++++++-----
 drivers/pci/host/pcie-xilinx.c         |  3 --
 drivers/pci/pci-driver.c               |  2 +
 drivers/pci/probe.c                    | 78 ++++++++++++++++++++++------------
 drivers/pci/setup-irq.c                | 45 +++++++++++++++-----
 include/linux/pci.h                    |  9 ++--
 20 files changed, 363 insertions(+), 162 deletions(-)

-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
