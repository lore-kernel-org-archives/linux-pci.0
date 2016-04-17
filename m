Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	jchandra@broadcom.com
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57130E92.1020600@codeaurora.org>
Date: Sun, 17 Apr 2016 00:18:26 -0400
MIME-Version: 1.0
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/15/2016 1:06 PM, Tomasz Nowicki wrote:
>>From the functionality point of view this series might be split into the
> following logic parts:
> 1. Necessary fixes as the preparation for using driver on ARM64.
> 2. New ECAM API and update for users of the pci-host-common API
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.6-rc2 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
> 
> v5 -> v6
> - dropped idea of x86 MMCONFIG code refactoring
> - integrated JC's patches which introduce new ECAM API:
>   https://lkml.org/lkml/2016/4/11/907
>   git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
> - added ACPI support for ThunderX ECAM and PEM drivers
> - rebased to 4.6-rc2
> 
> v4 -> v5
> - dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
>   https://patchwork.ozlabs.org/patch/575525/
> - rewrite PCI legacy IRQs allocation
> - squashed two patches 11 and 12 from series v4, fixed bisection issue
> - changelog improvements
> - rebased to 4.5-rc3
> 
> v3 -> v4
> - dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
> - added Lorenzo's fix patch 19/24
> - ACPI PCI bus domain number assigning cleanup
> - changed resource management, we now claim and reassign resources
> - improvements for applying quirks
> - dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
> - rebased to 4.5-rc1
> 
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
>   able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
>   Mathew's series:
>   https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4
> 
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code
> 
> v1 - https://lkml.org/lkml/2015/10/27/504
> v2 - https://lkml.org/lkml/2015/12/16/246
> v3 - http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04308.html
> v4 - https://lkml.org/lkml/2016/2/4/646
> v5 - https://lkml.org/lkml/2016/2/16/426
> 
> Jayachandran C (2):
>   PCI: Provide common functions for ECAM mapping
>   PCI: generic, thunder: update to use generic ECAM API
> 
> Tomasz Nowicki (11):
>   pci, acpi, x86, ia64: Move ACPI host bridge device companion
>     assignment to core code.
>   pci, acpi: Provide generic way to assign bus domain number.
>   x86, ia64: Include acpi_pci_{add|remove}_bus to the default
>     pcibios_{add|remove}_bus implementation.
>   pci, of: Move the PCI I/O space management to PCI core code.
>   acpi, pci: Support IO resources when parsing PCI host bridge
>     resources.
>   arm64, pci, acpi: ACPI support for legacy IRQs parsing and
>     consolidation with DT code.
>   pci, acpi: Support for ACPI based generic PCI host controller
>   arm64, pci, acpi: Start using ACPI based PCI host controller driver
>     for ARM64.
>   pci, acpi: Match PCI config space accessors against platfrom specific
>     quirks.
>   pci, pci-thunder-ecam: Add ACPI support for ThunderX ECAM.
>   pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
> 
>  arch/arm64/Kconfig                  |  15 +++
>  arch/arm64/include/asm/cpufeature.h |   3 +-
>  arch/arm64/kernel/cpu_errata.c      |   8 ++
>  arch/arm64/kernel/pci.c             |  35 ++---
>  arch/ia64/hp/common/sba_iommu.c     |   2 +-
>  arch/ia64/include/asm/pci.h         |   1 -
>  arch/ia64/pci/pci.c                 |  26 ----
>  arch/ia64/sn/kernel/io_acpi_init.c  |   4 +-
>  arch/x86/include/asm/pci.h          |   3 -
>  arch/x86/pci/acpi.c                 |  17 ---
>  arch/x86/pci/common.c               |  10 --
>  drivers/acpi/Kconfig                |   8 ++
>  drivers/acpi/Makefile               |   1 +
>  drivers/acpi/bus.c                  |   1 +
>  drivers/acpi/pci_gen_host.c         | 259 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/pci_root.c             |  58 +++++++-
>  drivers/of/address.c                | 116 +---------------
>  drivers/pci/Kconfig                 |   3 +
>  drivers/pci/Makefile                |   2 +
>  drivers/pci/ecam.c                  | 137 +++++++++++++++++++
>  drivers/pci/ecam.h                  |  66 +++++++++
>  drivers/pci/host/Kconfig            |   1 +
>  drivers/pci/host/pci-host-common.c  | 119 ++++++++---------
>  drivers/pci/host/pci-host-common.h  |  47 -------
>  drivers/pci/host/pci-host-generic.c |  52 ++------
>  drivers/pci/host/pci-thunder-ecam.c |  70 ++++++----
>  drivers/pci/host/pci-thunder-pem.c  | 215 ++++++++++++++++++++++--------
>  drivers/pci/pci.c                   | 150 ++++++++++++++++++++-
>  drivers/pci/probe.c                 |   5 +
>  include/asm-generic/vmlinux.lds.h   |   7 +
>  include/linux/of_address.h          |   9 --
>  include/linux/pci-acpi.h            |  20 +++
>  include/linux/pci.h                 |  12 ++
>  33 files changed, 1029 insertions(+), 453 deletions(-)
>  create mode 100644 drivers/acpi/pci_gen_host.c
>  create mode 100644 drivers/pci/ecam.c
>  create mode 100644 drivers/pci/ecam.h
>  delete mode 100644 drivers/pci/host/pci-host-common.h
> 

+tested by for the v6.

Tested-by: Sinan Kaya <okaya@codeaurora.org>

using the Qualcomm Technologies QDF2XXX server.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
