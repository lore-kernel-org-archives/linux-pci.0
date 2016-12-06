Return-Path: <SRS0=feWU=XV=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=feWU=XV=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 6 Dec 2016 16:01:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v11 04/15] arm64: PCI: Search ACPI namespace to ensure
 ECAM space is reserved
Message-ID: <20161206160114.GC4601@red-moon>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161205232549.3957.25468.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161205232549.3957.25468.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 05, 2016 at 05:25:50PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The static MCFG table tells us the base of ECAM space, but it does not
> reserve the space -- the reservation should be done via a device in the
> ACPI namespace whose _CRS includes the ECAM region.
> 
> Use acpi_resource_consumer() to check whether the ECAM space is reserved by
> an ACPI namespace device.  If it is, emit a message showing which device
> reserves it.  If not, emit a "[Firmware Bug]" warning.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm64/kernel/pci.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 8183c98..7909f59 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -124,8 +124,9 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>  	struct device *dev = &root->device->dev;
>  	struct resource *bus_res = &root->secondary;
>  	u16 seg = root->segment;
> -	struct pci_config_window *cfg;
>  	struct resource cfgres;
> +	struct acpi_device *adev;
> +	struct pci_config_window *cfg;
>  	unsigned int bsz;
>  
>  	/* Use address from _CBA if present, otherwise lookup MCFG */
> @@ -141,6 +142,16 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>  	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>  	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>  	cfgres.flags = IORESOURCE_MEM;
> +
> +	adev = acpi_resource_consumer(&cfgres);
> +	if (adev)

I think that currently:

if (unlikely(adev))

would be more appropriate. Joking (not really ;-))

> +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> +			 dev_name(&adev->dev));
> +	else
> +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> +			 &cfgres);

This log is going to be rather popular.

> +
> +

Nit: One too many empty line.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  	cfg = pci_ecam_create(dev, &cfgres, bus_res, &pci_generic_ecam_ops);
>  	if (IS_ERR(cfg)) {
>  		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> 
