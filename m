Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <562761A1.4020306@linaro.org>
Date: Wed, 21 Oct 2015 11:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14.10.2015 08:29, Jiang Liu wrote:
> Introduce common interface acpi_pci_root_create() and related data
> structures to create PCI root bus for ACPI PCI host bridges. It will
> be used to kill duplicated arch specific code for IA64 and x86. It may
> also help ARM64 in future.
>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
> ---
>   drivers/acpi/pci_root.c  |  204 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-acpi.h |   24 ++++++
>   2 files changed, 228 insertions(+)
>

[...]

> +
> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> +				     struct acpi_pci_root_ops *ops,
> +				     struct acpi_pci_root_info *info,
> +				     void *sysdata)
> +{
> +	int ret, busnum = root->secondary.start;
> +	struct acpi_device *device = root->device;
> +	int node = acpi_get_node(device->handle);
> +	struct pci_bus *bus;
> +
> +	info->root = root;
> +	info->bridge = device;
> +	info->ops = ops;
> +	INIT_LIST_HEAD(&info->resources);
> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> +		 root->segment, busnum);
> +
> +	if (ops->init_info && ops->init_info(info))
> +		goto out_release_info;
> +	if (ops->prepare_resources)
> +		ret = ops->prepare_resources(info);
> +	else
> +		ret = acpi_pci_probe_root_resources(info);
> +	if (ret < 0)
> +		goto out_release_info;
> +
> +	pci_acpi_root_add_resources(info);
> +	pci_add_resource(&info->resources, &root->secondary);
> +	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +				  sysdata, &info->resources);

Thank a lot for this cleanup!!

I recall you already considered passing segment (domain nr) to 
pci_create_root_bus, right? Can you please remind me why we gave up on this?

I am asking because currently I can not find the way to retrieve domain 
number from pci_bus_assign_domain_nr (for those platforms which choose 
PCI_DOMAINS_GENERIC and want to use segment nr from MCFG table) which is 
the part of pci_create_root_bus.

Regards,
Tomasz
