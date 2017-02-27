Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/20] PCI: fix config and I/O Address space memory mappings
Date: Mon, 27 Feb 2017 15:14:11 +0000
Message-Id: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/config-io-mappings-fix

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>

Lorenzo Pieralisi (20):
  PCI: remove __weak tag from pci_remap_iospace()
  PCI: fix pci_remap_iospace() remap attribute
  asm-generic/io.h: add PCI config space remap interface
  ARM64: implement pci_remap_cfgspace() interface
  ARM: implement pci_remap_cfgspace() interface
  PCI: ECAM: use pci_remap_cfgspace() to map config region
  PCI: implement Devres interface to map PCI config space
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

 Documentation/driver-model/devres.txt  |  6 ++-
 arch/arm/include/asm/io.h              | 10 ++++
 arch/arm/mm/ioremap.c                  |  7 +++
 arch/arm64/include/asm/io.h            | 10 ++++
 drivers/pci/dwc/pci-keystone-dw.c      |  2 +-
 drivers/pci/dwc/pci-layerscape.c       |  2 +-
 drivers/pci/dwc/pcie-armada8k.c        |  2 +-
 drivers/pci/dwc/pcie-designware-host.c | 12 +++--
 drivers/pci/dwc/pcie-hisi.c            |  3 +-
 drivers/pci/dwc/pcie-qcom.c            |  2 +-
 drivers/pci/dwc/pcie-spear13xx.c       |  2 +-
 drivers/pci/ecam.c                     |  5 +-
 drivers/pci/host/pci-tegra.c           |  4 +-
 drivers/pci/host/pci-xgene.c           |  4 +-
 drivers/pci/host/pcie-iproc-platform.c |  3 +-
 drivers/pci/host/pcie-rockchip.c       |  2 +-
 drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
 drivers/pci/host/pcie-xilinx.c         |  2 +-
 drivers/pci/pci.c                      | 86 +++++++++++++++++++++++++++++++++-
 include/asm-generic/io.h               |  9 ++++
 include/linux/pci.h                    |  5 ++
 21 files changed, 154 insertions(+), 26 deletions(-)

-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
