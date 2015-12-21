Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Tomasz Nowicki <tn@semihalf.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>
CC: "robert.richter@caviumnetworks.com"
	<robert.richter@caviumnetworks.com>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Wangyijing <wangyijing@huawei.com>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: RE: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Mon, 21 Dec 2015 11:47:48 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-23-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
> Sent: 16 December 2015 15:17
> To: bhelgaas@google.com; arnd@arndb.de; will.deacon@arm.com;
> catalin.marinas@arm.com; rjw@rjwysocki.net; hanjun.guo@linaro.org;
> Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
> jiang.liu@linux.intel.com; Stefano.Stabellini@eu.citrix.com
> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; tglx@linutronix.de;
> Wangyijing; Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org; jchandra@broadcom.com; jcm@redhat.com; Tomasz
> Nowicki
> Subject: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
> against platfrom specific quirks.
> 
> Some platforms may not be fully compliant with generic set of PCI
> config accessors. For these cases we implement the way to overwrite
> accessors set before PCI buses enumeration. Algorithm that overwrite
> accessors matches against platform ID (DMI), domain and bus number,
> hopefully enough for all cases. All quirks can be defined using:
> DECLARE_ACPI_MCFG_FIXUP() and keep self contained.

I've got a couple of comments/questions about this patch..

1) So according to this mechanism quirks would be supported only by 
   vendors whose BIOS are SMBIOS compliant. Now personally I am ok
   with this but I don't know if this is OK in general as it would 
   narrow down the number of platforms that would be able to define
   the quirks...
   Lorenzo, Arnd what is your opinion here?

2) In the quirk mechanism you proposed, I see that the callback function
   allows to do some preparation work for the host bridge. For example in
   Hisilicon hip05 case we would need to read some values from the ACPI 
   table (see acpi_pci_root_hisi_add() function in 
   https://lkml.org/lkml/2015/12/3/426). 
   I am quite new to ACPI and I wonder if it is OK to add such "Packages"
   to the  PCI host bridge ACPI device...or maybe we need to declare a new
   one...?

Many Thanks

Gab

> 
> example:
> 
> static const struct dmi_system_id yyy[] = {
> 	{
> 		.ident = "<Platform ident string>",
> 		.callback = <handler>,
> 		.matches = {
> 			DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> 			DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> 			DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> 		},
> 	},
> 	{ }
> };
> 
> static struct pci_ops ecam_pci_ops = {
> 	.map_bus = pci_mcfg_dev_base,
> 	.read = xxxx_ecam_config_read,
> 	.write = xxxx_ecam_config_write,
> };
> DECLARE_ACPI_MCFG_FIXUP(yyy, &ecam_pci_ops, <domain_nr>, <bus_nr>);
> 
> Note, that more custom actions can be done via DMI callback hook.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/mcfg.c               | 35
> +++++++++++++++++++++++++++++++++--
>  include/asm-generic/vmlinux.lds.h |  7 +++++++
>  include/linux/ecam.h              | 17 +++++++++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c index
> a9b2231..6d0194d 100644
> --- a/drivers/acpi/mcfg.c
> +++ b/drivers/acpi/mcfg.c
> @@ -8,6 +8,7 @@
>   */
> 
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/ecam.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -34,6 +35,31 @@ int __weak raw_pci_write(unsigned int domain,
> unsigned int bus,
>  	return PCIBIOS_DEVICE_NOT_FOUND;
>  }
> 
> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[]; extern struct
> +pci_mcfg_fixup __end_acpi_mcfg_fixups[];
> +
> +static struct pci_ops *pci_mcfg_check_quirks(int domain, int
> +bus_number) {
> +	struct pci_mcfg_fixup *fixup;
> +
> +	fixup = __start_acpi_mcfg_fixups;
> +	while (fixup < __end_acpi_mcfg_fixups) {
> +		if (dmi_check_system(fixup->system) &&
> +		    (fixup->domain == domain ||
> +		     fixup->domain == PCI_MCFG_DOMAIN_ANY) &&
> +		    (fixup->bus_number == bus_number ||
> +		     fixup->bus_number == PCI_MCFG_BUS_ANY)) {
> +			pr_info(PREFIX "Fixup applied: Platform [%s] domain
> [%d] bus number [%d]\n",
> +				fixup->system->ident, fixup->domain,
> +				fixup->bus_number);
> +			return fixup->ops;
> +		}
> +		++fixup;
> +	}
> +
> +	return NULL;
> +}
> +
>  void __iomem *
>  pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
> { @@ -56,10 +82,15 @@ static struct pci_ops default_pci_mcfg_ops = {
> 
>  struct pci_ops *pci_mcfg_get_ops(int domain, int bus)  {
> +	struct pci_ops *pci_mcfg_ops_quirk;
> +
>  	/*
> -	 * TODO: Match against platform specific quirks and return
> -	 * corresponding PCI config space accessor set.
> +	 * Match against platform specific quirks and return
> corresponding
> +	 * PCI config space accessor set.
>  	 */
> +	pci_mcfg_ops_quirk = pci_mcfg_check_quirks(domain, bus);
> +	if (pci_mcfg_ops_quirk)
> +		return pci_mcfg_ops_quirk;
> 
>  	return &default_pci_mcfg_ops;
>  }
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> generic/vmlinux.lds.h
> index c4bd0e2..c93fc97 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -298,6 +298,13 @@
>  		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
>  	}								\
>  									\
> +	/* ACPI MCFG quirks */						\
> +	.acpi_fixup        : AT(ADDR(.acpi_fixup) - LOAD_OFFSET) {	\
> +		VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) = .;		\
> +		*(.acpi_fixup_mcfg)					\
> +		VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) = .;		\
> +	}								\
> +									\
>  	/* Built-in firmware blobs */					\
>  	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
> diff --git a/include/linux/ecam.h b/include/linux/ecam.h index
> e0f322e..1319fa8 100644
> --- a/include/linux/ecam.h
> +++ b/include/linux/ecam.h
> @@ -20,6 +20,23 @@ struct pci_mmcfg_region {
>  	bool hot_added;
>  };
> 
> +struct pci_mcfg_fixup {
> +	const struct dmi_system_id *system;
> +	struct pci_ops *ops;
> +	int domain;
> +	int bus_number;
> +};
> +
> +#define PCI_MCFG_DOMAIN_ANY	-1
> +#define PCI_MCFG_BUS_ANY	-1
> +
> +/* Designate a routine to fix up buggy MCFG */
> +#define DECLARE_ACPI_MCFG_FIXUP(system, ops, dom, bus)
> 	\
> +	static const struct pci_mcfg_fixup
> __mcfg_fixup_##system##dom##bus\
> +	 __used	__attribute__((__section__(".acpi_fixup_mcfg"),
> 	\
> +				aligned((sizeof(void *))))) =		\
> +	{ system, ops, dom, bus };
> +
>  struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
> struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
>  						   int end, u64 addr);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
