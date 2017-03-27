Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbdC0JuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 05:50:01 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Tony Luck <tony.luck@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Mason <jonmason@broadcom.com>,
        Ingo Molnar <mingo@redhat.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 00/22] PCI: fix config and I/O Address space memory mappings
Date: Mon, 27 Mar 2017 10:49:28 +0100
Message-Id: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series[1] is a v2 of a previous version:

v1 -> v2:
	- Changed pci_remap_cfgspace() to more generic ioremap_nopost()
	  interface
	- Added pgprot_nonposted
	- Fixed build errors on arches not relying on asm-generic headers
	- Added PCI versatile host controller driver patch
	- Added missing config space remapping to hisilicon host controller
	- Rebased against v4.11-rc4

v1: https://lkml.org/lkml/2017/2/27/228

PCI local bus specifications (Rev3.0, 3.2.5 "Transaction Ordering
and Posting") strictly require PCI configuration and I/O Address space
write transactions to be non-posted.

Current crop of DT/ACPI PCI host controllers drivers relies on
the ioremap interface to map ECAM and ECAM-derivative PCI config
regions and pci_remap_iospace() to create a VMA for mapping
PCI host bridge I/O Address space transactions to CPU virtual address
space.

On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
configuration non-posted write transactions requirement, because it
provides a memory mapping that issues "bufferable" or, in PCI terms
"posted" write transactions. Likewise, the current pci_remap_iospace()
implementation maps the physical address range that the PCI translates
to I/O space cycles to virtual address space through pgprot_device()
attributes that on eg ARM64 provides a memory mapping issuing
posted writes transactions, which is not PCI specifications compliant.

This patch series[1] addresses both issues in one go:

- It updates the pci_remap_iospace() function to use a page mapping
  that guarantees non-posted write transactions for I/O space addresses
- It adds a kernel API to remap PCI config space resources, so that
  architecture can override it with a mapping implementation that
  guarantees PCI specifications compliancy wrt non-posted write
  configuration transactions
- It updates all PCI host controller implementations (and the generic
  ECAM layer) to use the newly introduced mapping interface

Tested on Juno ECAM based interface (DT/ACPI).

Non-ECAM PCI host controller drivers patches need checking to make
sure that:

- I patched the correct resource region mapping for config space
- There are not any other ways to ensure posted-write completion
  in the respective pci_ops that make the relevant patch unnecessary

[1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git
pci/config-io-mappings-fix-v2

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>

Lorenzo Pieralisi (22):
  PCI: remove __weak tag from pci_remap_iospace()
  asm-generic/io.h: add ioremap_nopost remap interface
  asm-generic/pgtable.h: introduce pgprot_nonposted remap attribute
  PCI: fix pci_remap_iospace() remap attribute
  ARM64: implement ioremap_nopost() interface
  ARM: implement ioremap_nopost() interface
  PCI: ECAM: use ioremap_nopost() to map config region
  lib: implement Devres ioremap_nopost() interface
  PCI: xilinx: update PCI config space remap function
  PCI: xilinx-nwl: update PCI config space remap function
  PCI: spear13xx: update PCI config space remap function
  PCI: rockchip: update PCI config space remap function
  PCI: qcom: update PCI config space remap function
  PCI: iproc-platform: update PCI config space remap function
  PCI: hisi: update PCI config space remap function
  PCI: designware: update PCI config space remap function
  PCI: armada8k: update PCI config space remap function
  PCI: xgene: update PCI config space remap function
  PCI: tegra: update PCI config space remap function
  PCI: layerscape: update PCI config space remap function
  PCI: keystone-dw: update PCI config space remap function
  PCI: versatile: update PCI config space remap function

 Documentation/driver-model/devres.txt  |  3 ++
 arch/alpha/include/asm/io.h            |  1 +
 arch/arm/include/asm/io.h              | 10 +++++
 arch/arm/mm/ioremap.c                  |  7 +++
 arch/arm/mm/nommu.c                    |  9 ++++
 arch/arm64/include/asm/io.h            | 12 ++++++
 arch/avr32/include/asm/io.h            |  1 +
 arch/frv/include/asm/io.h              |  1 +
 arch/ia64/include/asm/io.h             |  1 +
 arch/x86/include/asm/io.h              |  1 +
 drivers/pci/dwc/pci-keystone-dw.c      |  2 +-
 drivers/pci/dwc/pci-layerscape.c       |  2 +-
 drivers/pci/dwc/pcie-armada8k.c        |  2 +-
 drivers/pci/dwc/pcie-designware-host.c | 12 +++---
 drivers/pci/dwc/pcie-hisi.c            |  7 ++-
 drivers/pci/dwc/pcie-qcom.c            |  2 +-
 drivers/pci/dwc/pcie-spear13xx.c       |  2 +-
 drivers/pci/ecam.c                     |  5 ++-
 drivers/pci/host/pci-tegra.c           |  4 +-
 drivers/pci/host/pci-versatile.c       |  3 +-
 drivers/pci/host/pci-xgene.c           |  4 +-
 drivers/pci/host/pcie-iproc-platform.c |  3 +-
 drivers/pci/host/pcie-rockchip.c       |  2 +-
 drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
 drivers/pci/host/pcie-xilinx.c         |  2 +-
 drivers/pci/pci.c                      |  4 +-
 include/asm-generic/io.h               |  4 ++
 include/asm-generic/pgtable.h          |  4 ++
 include/linux/device.h                 |  2 +
 include/linux/io.h                     |  2 +
 lib/devres.c                           | 78 ++++++++++++++++++++++++++++++++++
 31 files changed, 166 insertions(+), 28 deletions(-)

-- 
2.10.0
