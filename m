Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555BFC72.3060703@linux.intel.com>
Date: Wed, 20 May 2015 11:16:02 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	"x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v3 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com> <1431593803-5213-6-git-send-email-jiang.liu@linux.intel.com> <5559E44B.2010702@linaro.org>
In-Reply-To: <5559E44B.2010702@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/18 21:08, Hanjun Guo wrote:
> Hi Jiang,
> 
> On 2015年05月14日 16:56, Jiang Liu wrote:
>> Introduce common interface acpi_pci_root_create() and related data
>> structures to create PCI root bus for ACPI PCI host bridges. It will
>> be used to kill duplicated arch specific code for IA64 and x86. It may
>> also help ARM64 in future.
> 
> As I commented in previous version, this patch will introduce
> compile error on ACPI enabled ARM64 kernel because struct
> pci_controller is not defined for ARM64, so how about adding
> the following patch before this patch, or squash to this one,
> does it make sense?
Hi Hanjun,
	Thanks for fixing this building issue for ARM64. The patch
is really what I want:). Will merge it into next version. With this
patch applied, are there any other issues from ARM64 side?
Thanks!
Gerry

> 
> From 11d0e98154e681e75936698208398cb4dcd73632 Mon Sep 17 00:00:00 2001
> From: Hanjun Guo <hanjun.guo@linaro.org>
> Date: Mon, 18 May 2015 19:41:56 +0800
> Subject: [PATCH] ARM64 / PCI: introduce struct pci_controller for ACPI
> 
> ARM64 ACPI based PCI host bridge init needs a arch dependent
> struct pci_controller to accommodate common PCI host bridge
> code which is introduced later, or it will lead to compile
> errors on ARM64.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/pci.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72..7088495 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -10,6 +10,16 @@
>  #include <asm-generic/pci-bridge.h>
>  #include <asm-generic/pci-dma-compat.h>
> 
> +struct acpi_device;
> +
> +struct pci_controller {
> +#ifdef CONFIG_ACPI
> +       struct acpi_device *companion;  /* ACPI companion device */
> +#endif
> +       int             segment;        /* PCI domain */
> +       int             node;           /* NUMA node */
> +};
> +
>  #define PCIBIOS_MIN_IO         0x1000
>  #define PCIBIOS_MIN_MEM                0
> 
> 
> Thanks
> Hanjun
