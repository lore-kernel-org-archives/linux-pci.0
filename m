Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 11/13] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>,
	<arnd@arndb.de>, <will.deacon@arm.com>, <catalin.marinas@arm.com>,
	<rafael@kernel.org>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <okaya@codeaurora.org>,
	<jiang.liu@linux.intel.com>, <jchandra@broadcom.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-12-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
	<msalter@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jcm@redhat.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
From: "liudongdong (C)" <liudongdong3@huawei.com>
Message-ID: <5714C6F6.8050600@huawei.com>
Date: Mon, 18 Apr 2016 19:37:26 +0800
MIME-Version: 1.0
In-Reply-To: <1460740008-19489-12-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

I merged my patchset to branch topci-acpi-v6.
The patchset is used for Hisilicon DO2 PCIe ACPI support.
I found some compile errors. The log as below.
drivers/pci/host/pcie-hisi-acpi.c: In function 'hisi_pcie_init':
drivers/pci/host/pcie-hisi-acpi.c:130:6: error: 'struct acpi_pci_root' has no member named 'sysdata'
   root->sysdata = reg_base;

In your PATCH V5, add "sysdata" for strcut acpi_pci_root, but PATCH V6 has not add it.
In my patch, I used root->sysdata which will be available along read/write accessor.
I want to know the reason this v6 patchset does not add "sysdata". I need this.

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 14362a8..0fc6f13 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -556,6 +556,7 @@ struct acpi_pci_root {
  	struct pci_bus *bus;
  	u16 segment;
  	struct resource secondary;	/* downstream bus range */
+	void *sysdata;

  	u32 osc_support_set;	/* _OSC state of support bits */
  	u32 osc_control_set;	/* _OSC state of control bits */

Thanks
Dongdong

ÔÚ 2016/4/16 1:06, Tomasz Nowicki Ð´µÀ:
> Some platforms may not be fully compliant with generic set of PCI config
> accessors. For these cases we implement the way to overwrite accessors
> set prior to PCI buses enumeration. Algorithm traverses available quirk
> list, matches against <DMI ID (optional), domain, bus number> tuple and
> an extra match call and returns corresponding PCI config ops.
> All quirks can be defined using:
> DECLARE_ACPI_MCFG_FIXUP() macro and kept self contained. Example:
>
> /* Additional DMI platform identification (optional) */
> static const struct dmi_system_id foo_dmi[] = {
>          {
>                  .ident = "<Platform ident string>",
>                  .matches = {
>                          DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
>                          DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
>                          DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
>                  },
>          },
>          { }
> };
>
> /* Custom PCI config ops */
> static struct pci_generic_ecam_ops foo_pci_ops = {
> 	.bus_shift	= 24,
> 	.pci_ops = {
> 		.map_bus = pci_mcfg_dev_base,
> 		.read = foo_ecam_config_read,
> 		.write = foo_ecam_config_write,
> 	}
> };
>
> static int foo_match(struct pci_mcfg_fixup *fixup, struct acpi_pci_root *root)
> {
> 	if (additional platform identification)
> 	        return true;
> 	return false;
> }
>
> DECLARE_ACPI_MCFG_FIXUP(foo_dmi, foo_init, &foo_root_ops, <domain_nr>, <bus_nr>);
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/acpi/pci_gen_host.c       | 30 +++++++++++++++++++++++++++++-
>   include/asm-generic/vmlinux.lds.h |  7 +++++++
>   include/linux/pci-acpi.h          | 18 ++++++++++++++++++
>   3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_gen_host.c b/drivers/acpi/pci_gen_host.c
> index fd360b5..e55dfca 100644
> --- a/drivers/acpi/pci_gen_host.c
> +++ b/drivers/acpi/pci_gen_host.c
> @@ -11,6 +11,8 @@
>    * You should have received a copy of the GNU General Public License
>    * version 2 (GPLv2) along with this source code.
>    */
> +
> +#include <linux/dmi.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
>   #include <linux/pci-acpi.h>
> @@ -54,6 +56,32 @@ static struct mcfg_entry *pci_mcfg_lookup(u16 seg, u8 bus_start)
>   	return NULL;
>   }
>
> +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
> +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
> +
> +static struct pci_generic_ecam_ops *pci_acpi_get_ops(struct acpi_pci_root *root)
> +{
> +	int bus_num = root->secondary.start;
> +	int domain = root->segment;
> +	struct pci_cfg_fixup *f;
> +
> +	/*
> +	 * Match against platform specific quirks and return corresponding
> +	 * CAM ops.
> +	 *
> +	 * First match against PCI topology <domain:bus> then use DMI or
> +	 * custom match handler.
> +	 */
> +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
> +		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
> +		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
> +		    (f->system ? dmi_check_system(f->system) : 1) &&
> +		    (f->match ? f->match(f, root) : 1))
> +			return f->ops;
> +	}
> +	/* No quirks, use ECAM */
> +	return &pci_generic_ecam_default_ops;
> +}
>
>   /*
>    * Lookup the bus range for the domain in MCFG, and set up config space
> @@ -95,7 +123,7 @@ static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
>   	}
>
>   	cfg = pci_generic_ecam_create(&root->device->dev, addr, bus_start,
> -				      bus_end, &pci_generic_ecam_default_ops);
> +				      bus_end, pci_acpi_get_ops(root));
>   	if (IS_ERR(cfg)) {
>   		err = PTR_ERR(cfg);
>   		pr_err("%04x:%02x-%02x error %d mapping CAM\n", seg,
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 339125b..c53b6b7 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -298,6 +298,13 @@
>   		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
>   	}								\
>   									\
> +	/* ACPI MCFG quirks */						\
> +	.acpi_fixup        : AT(ADDR(.acpi_fixup) - LOAD_OFFSET) {	\
> +		VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) = .;		\
> +		*(.acpi_fixup_mcfg)					\
> +		VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) = .;		\
> +	}								\
> +									\
>   	/* Built-in firmware blobs */					\
>   	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
>   		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a72e22d..9545988 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -71,6 +71,24 @@ struct acpi_pci_root_ops {
>   	int (*prepare_resources)(struct acpi_pci_root_info *info);
>   };
>
> +struct pci_cfg_fixup {
> +	const struct dmi_system_id *system;
> +	bool (*match)(struct pci_cfg_fixup *, struct acpi_pci_root *);
> +	struct pci_generic_ecam_ops *ops;
> +	int domain;
> +	int bus_num;
> +};
> +
> +#define PCI_MCFG_DOMAIN_ANY	-1
> +#define PCI_MCFG_BUS_ANY	-1
> +
> +/* Designate a routine to fix up buggy MCFG */
> +#define DECLARE_ACPI_MCFG_FIXUP(system, match, ops, dom, bus)		\
> +	static const struct pci_cfg_fixup __mcfg_fixup_##system##dom##bus\
> +	 __used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
> +				aligned((sizeof(void *))))) =		\
> +	{ system, match, ops, dom, bus };
> +
>   extern int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info);
>   extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>   					    struct acpi_pci_root_ops *ops,
>

