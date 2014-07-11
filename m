Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Liviu Dudau' <Liviu.Dudau@arm.com>
Cc: 'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'linaro-kernel' <linaro-kernel@lists.linaro.org>,
	'Tanmay Inamdar' <tinamdar@apm.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Sinan Kaya' <okaya@codeaurora.org>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Suravee Suthikulanit' <suravee.suthikulpanit@amd.com>,
	'LKML' <linux-kernel@vger.kernel.org>,
	'Device Tree ML' <devicetree@vger.kernel.org>,
	'LAKML' <linux-arm-kernel@lists.infradead.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-9-git-send-email-Liviu.Dudau@arm.com>
In-reply-to: <1404240214-9804-9-git-send-email-Liviu.Dudau@arm.com>
Subject: Re: [PATCH v8 8/9] pci: Add support for creating a generic host_bridge
 from device tree
Date: Fri, 11 Jul 2014 16:43:21 +0900
Message-id: <004601cf9cdb$ca08f7f0$5e1ae7d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 02, 2014 3:44 AM, Liviu Dudau wrote:
> 
> Several platforms use a rather generic version of parsing
> the device tree to find the host bridge ranges. Move the common code
> into the generic PCI code and use it to create a pci_host_bridge
> structure that can be used by arch code.
> 
> Based on early attempts by Andrew Murray to unify the code.
> Used powerpc and microblaze PCI code as starting point.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/of/of_pci.c       | 135 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host-bridge.c |  18 +++++++
>  include/linux/of_pci.h    |  10 ++++
>  include/linux/pci.h       |   8 +++
>  4 files changed, 171 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 8481996..55d8320 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c

[.....]

> +struct pci_host_bridge *
> +of_create_pci_host_bridge(struct device *parent, struct pci_ops *ops, void *host_data)
> +{
> +	int err, domain, busno;
> +	struct resource *bus_range;
> +	struct pci_bus *root_bus;
> +	struct pci_host_bridge *bridge;
> +	resource_size_t io_base;
> +	LIST_HEAD(res);
> +
> +	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
> +	if (!bus_range)
> +		return ERR_PTR(-ENOMEM);
> +
> +	domain = of_alias_get_id(parent->of_node, "pci-domain");
> +	if (domain == -ENODEV)
> +		domain = atomic_inc_return(&domain_nr);
> +
> +	err = of_pci_parse_bus_range(parent->of_node, bus_range);
> +	if (err) {
> +		dev_info(parent, "No bus range for %s, using default [0-255]\n",
> +			parent->of_node->full_name);
> +		bus_range->start = 0;
> +		bus_range->end = 255;
> +		bus_range->flags = IORESOURCE_BUS;
> +	}
> +	busno = bus_range->start;
> +	pci_add_resource(&res, bus_range);
> +
> +	/* now parse the rest of host bridge bus ranges */
> +	err = pci_host_bridge_of_get_ranges(parent->of_node, &res, &io_base);
> +	if (err)
> +		goto err_create;
> +
> +	/* then create the root bus */
> +	root_bus = pci_create_root_bus_in_domain(parent, domain, busno,
> +						ops, host_data, &res);
> +	if (IS_ERR(root_bus)) {
> +		err = PTR_ERR(root_bus);
> +		goto err_create;
> +	}
> +
> +	bridge = to_pci_host_bridge(root_bus->bridge);
> +	bridge->io_base = io_base;

Hi Liviu Dudau,

Would you fix the following warning?

drivers/of/of_pci.c: In function 'of_create_pci_host_bridge'
drivers/of/of_pci.c:218:18: warning: 'of_base' may be used uninitialized in this function [-Wmaybe-uninitialized]
  bridge->io_base = io_base;

Best regards,
Jingoo Han

[.....]

