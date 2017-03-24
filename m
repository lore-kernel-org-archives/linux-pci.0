Return-Path: <SRS0=9oiv=3B=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=9oiv=3B=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH 2/2] PCI: Add legacy firmware support for Cavium ThunderX
 host controller
To: helgaas@kernel.org, Lorenzo.Pieralisi@arm.com,
 robert.richter@caviumnetworks.com, ddaney@caviumnetworks.com,
 Vadim.Lomovtsev@caviumnetworks.com, rafael@kernel.org
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <1489564155-3881-3-git-send-email-tn@semihalf.com>
Cc: Sunil.Goutham@cavium.com, geethasowjanya.akula@gmail.com,
 linu.cherian@cavium.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <bc7b66de-9070-1561-440e-ac12124fc268@semihalf.com>
Date: Fri, 24 Mar 2017 16:55:20 +0100
MIME-Version: 1.0
In-Reply-To: <1489564155-3881-3-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 15.03.2017 08:49, Tomasz Nowicki wrote:
> During early days of PCI quirks support ThunderX firmware did not provide
> PNP0c02 node with PCI configuration space and PEM-specific register ranges.
> This means that for legacy FW we are not reserving these resources and
> cannot gather PEM-specific resources for further PEM initialization.
>
> In order to support already deployed legacy FW calculate PEM-specific ranges
> and provide resources reservation as fallback scenario into PEM driver when
> we could not gather PEM reg base from ACPI tables.
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> ---
>  drivers/pci/host/pci-thunder-pem.c | 56 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index e354010..e0aa194 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -14,6 +14,7 @@
>   * Copyright (C) 2015 - 2016 Cavium, Inc.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of_address.h>
> @@ -319,6 +320,50 @@ static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg,
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>
> +#define PEM_RES_BASE		0x87e0c0000000UL
> +#define PEM_NODE_MASK		GENMASK(45, 44)
> +#define PEM_INDX_MASK		GENMASK(26, 24)
> +#define PEM_MIN_DOM_IN_NODE	4
> +#define PEM_MAX_DOM_IN_NODE	10
> +
> +static void thunder_pem_reserve_range(struct device *dev, int seg,
> +				      struct resource *r)
> +{
> +	resource_size_t start = r->start, end = r->end;
> +	struct resource *res;
> +	const char *regionid;
> +
> +	regionid = kasprintf(GFP_KERNEL, "PEM RC:%d", seg);
> +	if (!regionid)
> +		return;
> +
> +	res = request_mem_region(start, end - start + 1, regionid);
> +	if (res)
> +		res->flags &= ~IORESOURCE_BUSY;
> +	else
> +		kfree(regionid);
> +
> +	dev_info(dev, "%pR %s reserved\n", r,
> +		 res ? "has been" : "could not be");
> +}
> +
> +static void thunder_pem_legacy_fw(struct acpi_pci_root *root,
> +				 struct resource *res_pem)
> +{
> +	int node = acpi_get_node(root->device->handle);
> +	int index;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = 0;
> +
> +	index = root->segment - PEM_MIN_DOM_IN_NODE;
> +	index -= node * PEM_MAX_DOM_IN_NODE;
> +	res_pem->start = PEM_RES_BASE | FIELD_PREP(PEM_NODE_MASK, node) |
> +					FIELD_PREP(PEM_INDX_MASK, index);
> +	res_pem->end = res_pem->start + SZ_16M - 1;
> +	res_pem->flags = IORESOURCE_MEM;
> +}
> +
>  static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -332,9 +377,16 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>  		return -ENOMEM;
>
>  	ret = acpi_get_rc_resources(dev, "CAVA02B", root->segment, res_pem);
> +
> +	/*
> +	 * If we fail to gather resources it means that we run with old
> +	 * FW where we need to calculate PEM-specific resources manually.
> +	 */
>  	if (ret) {
> -		dev_err(dev, "can't get rc base address\n");
> -		return ret;
> +		thunder_pem_legacy_fw(root, res_pem);
> +		/* Reserve PEM specific resources and PCI configuration space */
> +		thunder_pem_reserve_range(dev, root->segment, res_pem);


Looks like I screwed up PEM resource size for reservation. We cannot 
reserve full 16M here since devices will not able to request their 
resources later on:
pcieport 0004:1f:00.0: can't enable device: BAR 0 [mem 
0x87e0c0f00000-0x87e0c0ffffff 64bit] not claimed

SZ_64K is what we need to reserve.

Bjorn can you please apply below fix:

@@ -327,21 +327,20 @@ static void thunder_pem_legacy_fw(struct 
acpi_pci_root *root,
  	int node = acpi_get_node(root->device->handle);
  	int index;

  	if (node == NUMA_NO_NODE)
  		node = 0;

  	index = root->segment - PEM_MIN_DOM_IN_NODE;
  	index -= node * PEM_MAX_DOM_IN_NODE;
  	res_pem->start = PEM_RES_BASE | FIELD_PREP(PEM_NODE_MASK, node) |
  					FIELD_PREP(PEM_INDX_MASK, index);
-	res_pem->end = res_pem->start + SZ_16M - 1;
  	res_pem->flags = IORESOURCE_MEM;
  }

  static int thunder_pem_acpi_init(struct pci_config_window *cfg)
  {
  	struct device *dev = cfg->parent;
  	struct acpi_device *adev = to_acpi_device(dev);
  	struct acpi_pci_root *root = acpi_driver_data(adev);
  	struct resource *res_pem;
  	int ret;
@@ -351,22 +350,29 @@ static int thunder_pem_acpi_init(struct 
pci_config_window *cfg)
  		return -ENOMEM;

  	ret = acpi_get_rc_resources(dev, "CAVA02B", root->segment, res_pem);

  	/*
  	 * If we fail to gather resources it means that we run with old
  	 * FW where we need to calculate PEM-specific resources manually.
  	 */
  	if (ret) {
  		thunder_pem_legacy_fw(root, res_pem);
-		/* Reserve PEM specific resources and PCI configuration space */
+		/*
+		 * Reserve 64K size PEM specific resources. The full 16M range
+		 * size is required for thunder_pem_init() call.
+		 */
+		res_pem->end = res_pem->start + SZ_64K - 1;
  		thunder_pem_reserve_range(dev, root->segment, res_pem);
+		res_pem->end = res_pem->start + SZ_16M - 1;
+
+		/* and PCI configuration space */
  		thunder_pem_reserve_range(dev, root->segment, &cfg->res);
  	}

  	return thunder_pem_init(dev, cfg, res_pem);
  }

My apology for not paying attention.

Thanks,
Tomasz
