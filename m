Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556D512E.9020209@huawei.com>
Date: Tue, 2 Jun 2015 14:46:06 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v4 0/8] Consolidate ACPI PCI root common code into ACPI
 core
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/2 14:12, Jiang Liu wrote:
> This patch set consolidates common code to support ACPI PCI root on x86
> and IA64 platforms into ACPI core, to reproduce duplicated code and
> simplify maintenance. And a patch set based on this to support ACPI based
> PCIe host bridge on ARM64 has been posted at:

https://lkml.org/lkml/2015/5/26/207

And yes, it works on ARM64 too with legacy interrupts (INT#A/B/C/D) with ACPI _PRT
method (MSI is in developing).

Thanks
Hanjun

>
> It's based on latest mainstream kernel. It passes Fengguang's 0day test
> suite and has been tested on two IA64 platforms and one x86 platform.
>
> V3->V4:
> 1) Add patch[05/08] support solve building issue on ARM64
> 2) Solve an implicitly pointer cast issue.
> 3) Rebase to latest mainstream kernel
>
> V2->V3:
> 1. Move memory allocation/free from ACPI core into arch
> 2. Kill the field 'segment' in struct pci_root_info on x86
>
> Thanks!
> Gerry
>
> Hanjun Guo (1):
>   ARM64 / PCI: introduce struct pci_controller for ACPI
>
> Jiang Liu (7):
>   ACPI/PCI: Enhance ACPI core to support sparse IO space
>   ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
>     bridge
>   ia64/PCI: Use common struct resource_entry to replace struct
>     iospace_resource
>   x86/PCI: Rename struct pci_sysdata as struct pci_controller
>   PCI/ACPI: Consolidate common PCI host bridge code into ACPI core
>   x86/PCI/ACPI: Use common interface to support PCI host bridge
>   ia64/PCI/ACPI: Use common interface to support PCI host bridge
>
>  arch/arm64/include/asm/pci.h  |   10 ++
>  arch/ia64/include/asm/pci.h   |    5 -
>  arch/ia64/pci/pci.c           |  364 +++++++++++------------------------------
>  arch/x86/include/asm/pci.h    |   13 +-
>  arch/x86/include/asm/pci_64.h |    4 +-
>  arch/x86/pci/acpi.c           |  295 ++++++++++-----------------------
>  arch/x86/pci/common.c         |    2 +-
>  drivers/acpi/pci_root.c       |  200 ++++++++++++++++++++++
>  drivers/acpi/resource.c       |    9 +-
>  include/linux/ioport.h        |    1 +
>  include/linux/pci-acpi.h      |   23 +++
>  11 files changed, 432 insertions(+), 494 deletions(-)
>


