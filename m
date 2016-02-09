Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 9 Feb 2016 18:02:27 +0000
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
Subject: Re: [PATCH V4 11/23] pci, acpi: Move ACPI host bridge device
 companion assignment to core code.
Message-ID: <20160209180227.GC22868@red-moon>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-12-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454606941-9523-12-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 06:28:49PM +0100, Tomasz Nowicki wrote:
> Currently we have two platforms (x86 & ia64) capable of PCI ACPI host
> bridge initialization. They both use sysdata to pass down parent
> device reference and both rely on NULL parent in pci_create_root_bus()
> to validate sysdata content.
> 
> It looks hacky and prevents us from getting some firmware specific
> info for PCI host controller e.g. PCI bus domain number.
> However, we overcome that blocker by passing down parent
> device via pci_create_root_bus parameter (as the ACPI device type)
> and using ACPI_COMPANION_SET in core code for ACPI boot method.
> ACPI_COMPANION_SET is safe to run for all cases DT, ACPI and DT&ACPI.
> 
> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_root.c | 5 ++++-
>  drivers/pci/probe.c     | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ae3fe4e..a65c8c2 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -846,7 +846,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  
>  	pci_acpi_root_add_resources(info);
>  	pci_add_resource(&info->resources, &root->secondary);
> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +
> +	/* Root bridge device needs to be sure of parent ACPI type */

You can improve the comment.

"pci_create_root_bus() needs to detect the parent device type,
so initialize its companion data accordingly".

> +	ACPI_COMPANION_SET(&device->dev, device);
> +	bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
>  				  sysdata, &info->resources);
>  	if (!bus)
>  		goto out_release_info;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..81dd3a2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2100,6 +2100,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	bridge->dev.parent = parent;
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
> +	ACPI_COMPANION_SET(&bridge->dev,
> +			   parent ? to_acpi_device_node(parent->fwnode) : NULL);
if (parent)
	ACPI_COMPANION_SET(&bridge->dev, ACPI_COMPANION(parent));

?

It seems fine to me, hopefully Rafael can have a look to countercheck.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  	error = pcibios_root_bridge_prepare(bridge);
>  	if (error) {
>  		kfree(bridge);
> -- 
> 1.9.1
> 
