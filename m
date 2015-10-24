Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <562B378D.10903@huawei.com>
Date: Sat, 24 Oct 2015 15:47:25 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH V4 8/8] PCI: ACPI: Add support for PCI device DMA coherency
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1445442731-28819-9-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1445442731-28819-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/21 23:52, Suravee Suthikulpanit wrote:
> This patch adds support for setting up PCI device DMA coherency from
> ACPI _CCA object that should normally be specified in the DSDT node
> of its PCI host bridge.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/probe.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 09264f8..6e9f7e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1642,17 +1642,26 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>   * @dev: ptr to pci_dev struct of the PCI device
>   *
>   * Function to update PCI devices's DMA configuration using the same
> - * info from the OF node of host bridge's parent (if any).
> + * info from the OF node or ACPI node of host bridge's parent (if any).
>   */
>  static void pci_dma_configure(struct pci_dev *dev)
>  {
>  	struct device *bridge = pci_get_host_bridge_device(dev);
>  
>  	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -		if (!bridge->parent)
> -			return;
> -
> -		of_dma_configure(&dev->dev, bridge->parent->of_node);
> +		if (bridge->parent)
> +			of_dma_configure(&dev->dev,
> +					 bridge->parent->of_node);
> +	} else if (has_acpi_companion(bridge)) {
> +		struct acpi_device *adev = to_acpi_node(bridge->fwnode);

It's to_acpi_device_node() now in Rafael's tree.

Thanks
Hanjun

