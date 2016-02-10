Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 10 Feb 2016 14:06:03 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V4 15/23] acpi, mcfg: Implement two calls that might be
 used to inject/remove MCFG region.
Message-ID: <20160210140602.GB25060@red-moon>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-16-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454606941-9523-16-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 06:28:53PM +0100, Tomasz Nowicki wrote:
> Lets abstract two calls which allow to inject and remove MCFG regions
> which may come from DSDT table. These calls will be used for x86 and ARM64
> PCI host bridge driver in the later patches.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/mcfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  9 +++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
> index 3e1e7be..dca4c4e 100644
> --- a/drivers/acpi/mcfg.c
> +++ b/drivers/acpi/mcfg.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/ecam.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
>  
>  #define	PREFIX	"MCFG: "
>  
> @@ -77,6 +78,43 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
>  	return 0;
>  }
>  
> +int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci)
> +{
> +	struct pci_mmcfg_region *cfg;
> +	struct acpi_pci_root *root;
> +	int seg, start, end, err;
> +
> +	root = ci->root;
> +	seg = root->segment;
> +	start = root->secondary.start;
> +	end = root->secondary.end;
> +
> +	cfg = pci_mmconfig_lookup(seg, start);
> +	if (cfg)
> +		return 0;
> +
> +	cfg = pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	err = pci_mmconfig_inject(cfg);
> +	return err;

When you integrate Jayachandran's patch this whole function will
become a pci_mmconfig_insert() and that's where hot_added should
be set.

> +}
> +
> +void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci)
> +{
> +	struct acpi_pci_root *root = ci->root;
> +	struct pci_mmcfg_region *cfg;
> +
> +	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
> +	if (!cfg)
> +		return;
> +
> +	if (cfg->hot_added)

Move the hot_added check in pci_mmconfig_delete() (that does the look
up again), we do not want to carry out pci_mmconfig_lookup only to
check that flag here (and we miss rcu locking for the look-up BTW).

Thanks,
Lorenzo

> +		pci_mmconfig_delete(root->segment, root->secondary.start,
> +				    root->secondary.end);
> +}
> +
>  int __init __weak acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
>  					struct acpi_mcfg_allocation *cfg)
>  {
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a72e22d..65b91f3 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -80,6 +80,15 @@ extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  void acpi_pci_add_bus(struct pci_bus *bus);
>  void acpi_pci_remove_bus(struct pci_bus *bus);
>  
> +#ifdef	CONFIG_PCI_MMCONFIG
> +int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci);
> +void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci);
> +#else
> +static inline int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci)
> +{ return 0; }
> +static inline void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci) { }
> +#endif
> +
>  #ifdef	CONFIG_ACPI_PCI_SLOT
>  void acpi_pci_slot_init(void);
>  void acpi_pci_slot_enumerate(struct pci_bus *bus);
> -- 
> 1.9.1
> 
