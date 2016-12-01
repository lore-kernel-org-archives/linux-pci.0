Return-Path: <SRS0=xAw2=XQ=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=xAw2=XQ=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 1 Dec 2016 14:17:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 02/12] PCI: Search ACPI namespace to ensure ECAM
 space is reserved
Message-ID: <20161201141729.GA9974@red-moon>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201082939.12247.55077.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201082939.12247.55077.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you very much for putting this series together !

On Thu, Dec 01, 2016 at 02:29:39AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The static MCFG table tells us the base of ECAM space, but it does not
> reserve the space -- the reservation should be done via a device in the
> ACPI namespace whose _CRS includes the ECAM region.
> 
> Add pci_ecam_verify_reservation() to check whether the ECAM space is
> reserved by an ACPI namespace device.  If it is, emit a message showing
> which device reserves it.  If not, emit a "[Firmware Bug]" warning.

I have a question: do we want to carry out a search on a restricted set
of _HIDs here ? I am not sure we should consider an ECAM region matching
with a resource in a device _CRS whose _HID/_CID is not part of
{PNP0c02, PNP0A03, PNP0A08} as a success, actually I think that would be
a FW bug, right ?

Thanks,
Lorenzo

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ecam.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 43ed08d..3805122 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -14,6 +14,7 @@
>   * version 2 (GPLv2) along with this source code.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -29,6 +30,24 @@
>   */
>  static const bool per_bus_mapping = !IS_ENABLED(CONFIG_64BIT);
>  
> +static void pci_ecam_verify_reservation(struct device *dev,
> +					struct resource *ecam)
> +{
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev;
> +
> +	adev = acpi_resource_consumer(ecam);
> +	if (!adev) {
> +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> +			 ecam);
> +		return;
> +	}
> +
> +	dev_info(dev, "ECAM area %pR reserved by %s\n", ecam,
> +		 dev_name(&adev->dev));
> +#endif
> +}
> +
>  /*
>   * Create a PCI config space window
>   *  - reserve mem region
> @@ -51,6 +70,8 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  	if (!cfg)
>  		return ERR_PTR(-ENOMEM);
>  
> +	pci_ecam_verify_reservation(dev, cfgres);
> +
>  	cfg->parent = dev;
>  	cfg->ops = ops;
>  	cfg->busr.start = busr->start;
> 
