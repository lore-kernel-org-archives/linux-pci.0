Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 2 Jun 2015 10:35:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Patch v4 5/8] ARM64/PCI/ACPI: Introduce struct pci_controller
 for ACPI
Message-ID: <20150602093525.GA23543@red-moon>
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
 <1433225576-8215-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433225576-8215-6-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 02, 2015 at 07:12:53AM +0100, Jiang Liu wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> ARM64 ACPI based PCI host bridge init needs a arch dependent
> struct pci_controller to accommodate common PCI host bridge
> code which is introduced later, or it will lead to compile
> errors on ARM64.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm64/include/asm/pci.h |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72f8bc0..70884957f253 100644
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
> +	struct acpi_device *companion;	/* ACPI companion device */
> +#endif
> +	int		segment;	/* PCI domain */
> +	int		node;		/* NUMA node */
> +};

There is nothing ARM64 specific in this structure. The only
reason I see you want to keep it arch specific is the iommu
pointer on x86, but I think we should find a way to make
the common bits shared across archs (ie the struct above) and
add (maybe a void*) to the generic struct to cater for arch
specific data.

Thoughts ?

Lorenzo

> +
>  #define PCIBIOS_MIN_IO		0x1000
>  #define PCIBIOS_MIN_MEM		0
>  
> -- 
> 1.7.10.4
> 
