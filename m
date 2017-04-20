Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 20 Apr 2017 08:25:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 00/21] PCI: fix config space memory mappings
Message-ID: <20170420132554.GA8377@bhelgaas-glaptop.roam.corp.google.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Jonathan Corbet <corbet@lwn.net>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org, "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 05:48:49PM +0100, Lorenzo Pieralisi wrote:
> This patch series[1] is a v4 of a previous version:

Applied to pci/ioremap for v4.12, thanks, Lorenzo!

> v3 -> v4:
> 	- Reverted back to pci_remap_cfgspace() interface for lack of
> 	  consensus on ioremap_nopost() semantics
> 	- Dropped pci_remap_iospace() rework (owing to lack of adequate
> 	  pgprot_* attribute description across arches)
> 	- Updated pci_remap_cfgspace() comments
> 
> v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/500838.html
> 
> v2 -> v3:
> 	- Created a default ioremap_nopost() implementation in a separate
> 	  asm-generic header and patched all arches to make use of it
> 	- Removed PCI drivers patches from the series to simplify the
> 	  review, they will be posted separately once the ioremap_nopost()
> 	  interface is settled
> 	- Fixed devm_ioremap_* BUS offset comments and implemented
> 	  nopost interface on top of it
> 	- Added collected tags
> 
> v2: https://lkml.org/lkml/2017/3/27/220
> 
> v2 -> v3:
> 	- Fixed devm_ioremap_* BUS offset comments and implemented
> 	  nopost interface on top of it
> 	- Added collected tags
> 
> v1: https://lkml.org/lkml/2017/2/27/228
> 
> v1 -> v2:
> 	- Changed pci_remap_cfgspace() to more generic ioremap_nopost()
> 	  interface
> 	- Added pgprot_nonposted
> 	- Fixed build errors on arches not relying on asm-generic headers
> 	- Added PCI versatile host controller driver patch
> 	- Added missing config space remapping to hisilicon host controller
> 
> PCI local bus specifications (Rev3.0, 3.2.5 "Transaction Ordering
> and Posting") strictly require PCI configuration and I/O Address space
> write transactions to be non-posted.
> 
> Current crop of DT/ACPI PCI host controllers drivers relies on
> the ioremap interface to map ECAM and ECAM-derivative PCI config
> regions and pci_remap_iospace() to create a VMA for mapping
> PCI host bridge I/O Address space transactions to CPU virtual address
> space.
> 
> On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> configuration non-posted write transactions requirement, because it
> provides a memory mapping that issues "bufferable" or, in PCI terms
> "posted" write transactions. Likewise, the current pci_remap_iospace()
> implementation maps the physical address range that the PCI translates
> to I/O space cycles to virtual address space through pgprot_device()
> attributes that on eg ARM64 provides a memory mapping issuing
> posted writes transactions, which is not PCI specifications compliant.
> 
> This patch series[1] addresses both issues in one go:
> 
> - It updates the pci_remap_iospace() function to use a page mapping
>   that guarantees non-posted write transactions for I/O space addresses
> - It adds a kernel API to remap PCI config space resources, so that
>   architecture can override it with a mapping implementation that
>   guarantees PCI specifications compliancy wrt non-posted write
>   configuration transactions
> - It updates all PCI host controller implementations (and the generic
>   ECAM layer) to use the newly introduced mapping interface
> 
> Tested on Juno ECAM based interface (DT/ACPI).
> 
> Non-ECAM PCI host controller drivers patches need checking to make
> sure that:
> 
> - I patched the correct resource region mapping for config space
> - There are not any other ways to ensure posted-write completion
>   in the respective pci_ops that make the relevant patch unnecessary
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/config-io-mappings-fix-v4
> 
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mingkai Hu <mingkai.hu@freescale.com>
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Wenrui Li <wenrui.li@rock-chips.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Minghuan Lian <minghuan.Lian@freescale.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> 
> Lorenzo Pieralisi (21):
>   PCI: remove __weak tag from pci_remap_iospace()
>   linux/io.h: add PCI config space remap interface
>   ARM64: implement pci_remap_cfgspace() interface
>   ARM: implement pci_remap_cfgspace() interface
>   lib: fix Devres devm_ioremap_* offset parameter kerneldoc description
>   PCI: implement Devres interface to map PCI config space
>   PCI: ECAM: use pci_remap_cfgspace() to map config region
>   PCI: xilinx: update PCI config space remap function
>   PCI: xilinx-nwl: update PCI config space remap function
>   PCI: spear13xx: update PCI config space remap function
>   PCI: rockchip: update PCI config space remap function
>   PCI: qcom: update PCI config space remap function
>   PCI: iproc-platform: update PCI config space remap function
>   PCI: designware: update PCI config space remap function
>   PCI: armada8k: update PCI config space remap function
>   PCI: xgene: update PCI config space remap function
>   PCI: tegra: update PCI config space remap function
>   PCI: hisi: update PCI config space remap function
>   PCI: layerscape: update PCI config space remap function
>   PCI: keystone-dw: update PCI config space remap function
>   PCI: versatile: update PCI config space remap function
> 
>  Documentation/driver-model/devres.txt  |  6 ++-
>  arch/arm/include/asm/io.h              | 10 ++++
>  arch/arm/mm/ioremap.c                  |  7 +++
>  arch/arm/mm/nommu.c                    | 12 +++++
>  arch/arm64/include/asm/io.h            | 10 ++++
>  drivers/pci/dwc/pci-keystone-dw.c      |  2 +-
>  drivers/pci/dwc/pci-layerscape.c       |  2 +-
>  drivers/pci/dwc/pcie-armada8k.c        |  2 +-
>  drivers/pci/dwc/pcie-designware-host.c | 12 +++--
>  drivers/pci/dwc/pcie-hisi.c            |  7 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  2 +-
>  drivers/pci/dwc/pcie-spear13xx.c       |  2 +-
>  drivers/pci/ecam.c                     |  6 ++-
>  drivers/pci/host/pci-tegra.c           |  4 +-
>  drivers/pci/host/pci-versatile.c       |  3 +-
>  drivers/pci/host/pci-xgene.c           |  4 +-
>  drivers/pci/host/pcie-iproc-platform.c |  3 +-
>  drivers/pci/host/pcie-rockchip.c       |  2 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
>  drivers/pci/host/pcie-xilinx.c         |  2 +-
>  drivers/pci/pci.c                      | 84 +++++++++++++++++++++++++++++++++-
>  include/linux/io.h                     | 19 ++++++++
>  include/linux/pci.h                    |  5 ++
>  lib/devres.c                           |  6 +--
>  24 files changed, 183 insertions(+), 31 deletions(-)
> 
> -- 
> 2.10.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
