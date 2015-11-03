Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 3 Nov 2015 16:10:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 10/11] pci, acpi: Provide generic way to assign bus
 domain number.
Message-ID: <20151103161059.GE3574@red-moon>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-11-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445963922-22711-11-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 05:38:41PM +0100, Tomasz Nowicki wrote:
> Architectures which support PCI_DOMAINS_GENERIC (like ARM64)
> cannot call pci_bus_assign_domain_nr along ACPI PCI host bridge
> initialization since this function needs valid parent device reference
> to be able to retrieve domain number (aka segment).
> 
> We can omit that blocker and pass down host bridge device via
> pci_create_root_bus parameter and then be able to evaluate _SEG method
> being in pci_bus_assign_domain_nr.
> 
> Note that _SEG method is optional, therefore _SEG absence means
> that all PCI buses belong to domain 0.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_root.c |  2 +-
>  drivers/pci/pci.c       | 32 +++++++++++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 850d7bf..e682dc6 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -839,7 +839,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  
>  	pci_acpi_root_add_resources(info);
>  	pci_add_resource(&info->resources, &root->secondary);
> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +	bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
>  				  sysdata, &info->resources);

If I read x86 code correctly, they rely on the first argument to be
NULL, I think you would break x86 by doing that, see:

arch/x86/pci/acpi.c (pcibios_root_bridge_prepare())

By the way, can't we move the code setting up the ACPI_COMPANION
to core PCI code and stop relying on sysdata for that ?

Thanks,
Lorenzo

>  	if (!bus)
>  		goto out_release_info;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6a9a111..17d1857 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/acpi.h>
>  #include <asm-generic/pci-bridge.h>
>  #include <asm/setup.h>
>  #include "pci.h"
> @@ -4501,7 +4502,7 @@ int pci_get_new_domain_nr(void)
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
>  	static int use_dt_domains = -1;
> -	int domain = of_get_pci_domain_nr(parent->of_node);
> +	int domain;
>  
>  	/*
>  	 * Check DT domain and use_dt_domains values.
> @@ -4523,14 +4524,35 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  	 * API and update the use_dt_domains value to keep track of method we
>  	 * are using to assign domain numbers (use_dt_domains = 0).
>  	 *
> +	 * IF ACPI, we expect non-DT method (use_dt_domains == -1)
> +	 * and call _SEG method for corresponding host bridge device.
> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
> +	 * all PCI buses belong to domain 0.
> +	 *
>  	 * All other combinations imply we have a platform that is trying
> -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> -	 * which is a recipe for domain mishandling and it is prevented by
> -	 * invalidating the domain value (domain = -1) and printing a
> -	 * corresponding error.
> +	 * to mix domain numbers obtained from DT, ACPI and
> +	 * pci_get_new_domain_nr(), which is a recipe for domain mishandling and
> +	 * it is prevented by invalidating the domain value (domain = -1) and
> +	 * printing a corresponding error.
>  	 */
> +
> +	domain = of_get_pci_domain_nr(parent->of_node);
>  	if (domain >= 0 && use_dt_domains) {
>  		use_dt_domains = 1;
> +#ifdef CONFIG_ACPI
> +	} else if (!acpi_disabled && use_dt_domains == -1) {
> +		struct acpi_device *acpi_dev = to_acpi_device(parent);
> +		unsigned long long segment = 0;
> +		acpi_status status;
> +
> +		status = acpi_evaluate_integer(acpi_dev->handle,
> +					       METHOD_NAME__SEG, NULL,
> +					       &segment);
> +		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> +			dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
> +
> +		domain = segment;
> +#endif
>  	} else if (domain < 0 && use_dt_domains != 1) {
>  		use_dt_domains = 0;
>  		domain = pci_get_new_domain_nr();
> -- 
> 1.9.1
> 
