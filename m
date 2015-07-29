Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55B8C46F.4090109@linaro.org>
Date: Wed, 29 Jul 2015 20:17:51 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v5 0/6] Consolidate ACPI PCI root common code into ACPI
 core
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Rafael,

Just kindly ping for this patchset, it has been reviewed and tested,
can it be merged in 4.3?

ARM64 ACPI PCI patches is based on this one, if this patchset is merged,
there will be less dependence for ARM64 ACPI PCI.

Thanks
Hanjun

On 06/09/2015 12:20 AM, Jiang Liu wrote:
> This patch set consolidates common code to support ACPI PCI root on x86
> and IA64 platforms into ACPI core, to reproduce duplicated code and
> simplify maintenance. And a patch set based on previous version to support
> ACPI based PCIe host bridge on ARM64 has been posted at:
> https://lkml.org/lkml/2015/5/26/207
>
> It's based on latest mainstream kernel. It passes Fengguang's 0day test
> suite and has been tested on two IA64 platforms and one x86 platform.
>
> V4-V5:
> 1) As suggested by Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, do not
>     introduce "struct pci_controller" into generic drivers/acpi/pci_root.c,
>     so ARM64 doesn't need to define a useless structure. And it simplifies
>     code a little too.
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
> Jiang Liu (6):
>    ACPI/PCI: Enhance ACPI core to support sparse IO space
>    ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
>      bridge
>    ia64/PCI: Use common struct resource_entry to replace struct
>      iospace_resource
>    PCI/ACPI: Consolidate common PCI host bridge code into ACPI core
>    x86/PCI/ACPI: Use common interface to support PCI host bridge
>    ia64/PCI/ACPI: Use common interface to support PCI host bridge
>
>   arch/ia64/include/asm/pci.h |    5 -
>   arch/ia64/pci/pci.c         |  366 ++++++++++++-------------------------------
>   arch/x86/pci/acpi.c         |  294 ++++++++++------------------------
>   drivers/acpi/pci_root.c     |  198 +++++++++++++++++++++++
>   drivers/acpi/resource.c     |    9 +-
>   include/linux/ioport.h      |    1 +
>   include/linux/pci-acpi.h    |   23 +++
>   7 files changed, 415 insertions(+), 481 deletions(-)
>
