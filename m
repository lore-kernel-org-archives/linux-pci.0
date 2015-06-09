Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55771B27.1060509@linux.intel.com>
Date: Wed, 10 Jun 2015 00:58:15 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v5 4/6] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com> <1433780448-18636-5-git-send-email-jiang.liu@linux.intel.com> <20150609161230.GC8591@red-moon>
In-Reply-To: <20150609161230.GC8591@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/10 0:12, Lorenzo Pieralisi wrote:
> On Mon, Jun 08, 2015 at 05:20:46PM +0100, Jiang Liu wrote:
> 
> [...]
> 
>> +static int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>> +{
>> +	int ret;
>> +	struct list_head *list = &info->resources;
>> +	struct acpi_device *device = info->bridge;
>> +	struct resource_entry *entry, *tmp;
>> +	unsigned long flags;
>> +
>> +	flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT;
> 
> Is IORESOURCE_MEM_8AND16BIT required because of some pending patches
> that will change ACPI resource filtering ? It does not seem to make
> a difference in the mainline code, AFAICT.
Hi Lorenzo,
	Sorry, the 'IORESOURCE_MEM_8AND16BIT' is leaked into this patch
from another bugfix patch. It should be removed.

>> +static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
>> +{
>> +	struct resource *res;
>> +	struct resource_entry *entry;
>> +
>> +	resource_list_for_each_entry(entry, &bridge->windows) {
>> +		res = entry->res;
>> +		if (res->parent &&
>> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> +			release_resource(res);
>> +	}
> 
> It is a question: is this loop necessary given that we are already
> releasing resources in __acpi_pci_root_release_info() ?
Function pci_create_root_bus() moves resources from info->resources list
onto bridge->windows list, so an ACPI resource will be either on
info->resources or bridge->windows. Thus we need to deal with both
info->resources and bridge->windows.

> 
>> +	__acpi_pci_root_release_info(bridge->release_data);
>> +}
>> +
>> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>> +				     struct acpi_pci_root_ops *ops,
>> +				     struct acpi_pci_root_info *info,
>> +				     void *sysdata, int segment, int node)
> 
> I do not think you need to pass segment and node, they clutter the
> function signature when you can retrieve them from root, I would
> make them local variables and use root->segment and acpi_get_node
> in the function body to retrieve them.
On x86, node and segment may be overridden under certain conditions.
For example, segment will always be 0 if 'pci_ignore_seg' is set.

>> +{
>> +	int ret, busnum = root->secondary.start;
>> +	struct acpi_device *device = root->device;
>> +	struct pci_bus *bus;
>> +
>> +	info->root = root;
>> +	info->bridge = device;
>> +	info->ops = ops;
>> +	INIT_LIST_HEAD(&info->resources);
>> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
>> +		 segment, busnum);
>> +
>> +	if (ops->init_info && ops->init_info(info))
>> +		goto out_release_info;
>> +	ret = acpi_pci_probe_root_resources(info);
>> +	if (ops->prepare_resources)
>> +		ret = ops->prepare_resources(info, ret);
> 
> You go through this ret passing song and dance because we may want to
> call prepare_resources even if acpi_pci_probe_root_resource failed (on
> x86), correct ? I will have a further look at x86 and ia64 if we
> can consolidate these ops function hooks even further.
Yes. X86 uses flag 'pci_use_crs' to choose ACPI parsed resources or
other method parsed resources. This provides user a way to work
around some bios issues.
Thanks!
Gerry

