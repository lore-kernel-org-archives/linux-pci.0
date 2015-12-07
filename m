Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 7 Dec 2015 14:31:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
Message-ID: <20151207203117.GB14429@localhost>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 05:38:31PM +0100, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into two logic parts:
> 1. Making MMCONFIG code arch-agnostic which allows all architectures to collect
>    PCI config regions and used when necessary.
> 2. Using generic MMCONFIG code and introducing ACPI based PCI hostbridge
>    initialization for ARM64
> 
> Patches has been built on top of:
> [Patch v7 0/7] Consolidate ACPI PCI root common code into ACPI core
> https://lkml.org/lkml/2015/10/14/31
> Git branch can be found here:
> https://git.linaro.org/leg/acpi/acpi.git/shortlog/refs/heads/pci-acpi-upstream
> 
> This has been tested on Cavium ThunderX 1 socket server.
> Any help in reviewing and testing is very appreciated.
> 
> Hanjun Guo (1):
>   XEN / PCI: Remove the dependence on arch x86 when PCI_MMCONFIG=y
> 
> Tomasz Nowicki (10):
>   x86, pci: Reorder logic of pci_mmconfig_insert() function
>   x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
>     out of arch/x86/ directory
>   pci, acpi, mcfg: Provide generic implementation of MCFG code
>     initialization.
>   x86, pci: mmconfig_{32,64}.c code refactoring - remove code
>     duplication.
>   x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
>     driver.
>   pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
>   pci, acpi, ecam: Add flag to indicate whether ECAM region was hot
>     added or not.
>   x86, pci: Use previously added ECAM hot_added flag to remove ECAM
>     regions.
>   pci, acpi: Provide generic way to assign bus domain number.
>   arm64, pci, acpi: Support for ACPI based PCI hostbridge init
> 
>  arch/arm64/Kconfig             |   6 +
>  arch/arm64/kernel/pci.c        | 208 ++++++++++++++++++++++++++++++++--
>  arch/x86/Kconfig               |   4 +
>  arch/x86/include/asm/pci_x86.h |  28 +----
>  arch/x86/pci/acpi.c            |  17 +--
>  arch/x86/pci/mmconfig-shared.c | 250 +++++++----------------------------------
>  arch/x86/pci/mmconfig_32.c     |  11 +-
>  arch/x86/pci/mmconfig_64.c     |  67 +----------
>  arch/x86/pci/numachip.c        |   1 +
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/mcfg.c            | 104 +++++++++++++++++
>  drivers/acpi/pci_root.c        |   2 +-
>  drivers/pci/Kconfig            |  10 ++
>  drivers/pci/Makefile           |   5 +
>  drivers/pci/ecam.c             | 234 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c              |  30 ++++-
>  drivers/xen/pci.c              |   7 +-
>  include/linux/acpi.h           |   2 +
>  include/linux/ecam.h           |  44 ++++++++
>  19 files changed, 691 insertions(+), 340 deletions(-)
>  create mode 100644 drivers/acpi/mcfg.c
>  create mode 100644 drivers/pci/ecam.c
>  create mode 100644 include/linux/ecam.h

Waiting for an updated version after all the discussion.

Bjorn
