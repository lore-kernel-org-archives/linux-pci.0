Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Patch v6 4/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
 <1442218057-4355-5-git-send-email-jiang.liu@linux.intel.com>
 <20151006174725.GA29420@localhost> <5615FFD4.3090202@linux.intel.com>
 <20151008132010.GI27633@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <561778A1.6000408@linux.intel.com>
Date: Fri, 9 Oct 2015 16:19:45 +0800
MIME-Version: 1.0
In-Reply-To: <20151008132010.GI27633@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/8 21:20, Bjorn Helgaas wrote:
> On Thu, Oct 08, 2015 at 01:32:04PM +0800, Jiang Liu wrote:
>> On 2015/10/7 1:47, Bjorn Helgaas wrote:
>>>> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>>> +				     struct acpi_pci_root_ops *ops,
>>>> +				     struct acpi_pci_root_info *info,
>>>> +				     void *sysdata)
>>>> +{
>>>> +	int ret, busnum = root->secondary.start;
>>>> +	struct acpi_device *device = root->device;
>>>> +	int node = acpi_get_node(device->handle);
>>>> +	struct pci_bus *bus;
>>>> +
>>>> +	info->root = root;
>>>> +	info->bridge = device;
>>>> +	info->ops = ops;
>>>> +	INIT_LIST_HEAD(&info->resources);
>>>> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
>>>> +		 root->segment, busnum);
>>>> +
>>>> +	if (ops->init_info && ops->init_info(info))
>>>> +		goto out_release_info;
>>>> +	ret = acpi_pci_probe_root_resources(info);
>>>> +	if (ops->prepare_resources)
>>>> +		ret = ops->prepare_resources(info, ret);
>>>> +	if (ret < 0)
>>>> +		goto out_release_info;
>>>> +	else if (ret > 0)
>>>> +		pci_acpi_root_add_resources(info);
>>>
>>> This is unnecessarily complicated: you set "ret", then overwrite it if
>>> ops->prepare_resources.  By the time you test "ret", it's messy to
>>> figure out what it means.
>>>
>>> Both ops->prepare_resources() and pci_acpi_root_add_resources()
>>> should be able to deal with empty resource lists, so can you do the
>>> following instead?
>>>
>>>     ret = acpi_pci_probe_root_resources(info);
>>>     if (ret < 0)
>>>         goto out_release_info;
>>
>> 	The original code is used to handle a special case for x86,
>> where acpi_pci_probe_root_resources() fails but ops->prepare_resources()
>> succeeds. For x86, PCI host bridge resources may probed by means
>> other than ACPI when pci_use_crs is true (AMD and Broadcom hostbridges).
>> So we can't return failure when acpi_pci_probe_root_resources() fails.
> 
> That's even worse than I thought.  I take back my ack; I think this
> really needs to be restructured so it does the right thing *and* reads
> clearly.  Having convoluted generic code to deal with an arch-specific
> special case is a recipe for breakage in the future.
> 
> Maybe you can move the non-ACPI resource probing from
> prepare_resources() into acpi_pci_probe_root_resources() (you could
> rename it to something more generic if that helps).
Hi Bjorn,
	How about this solution?
1) export acpi_pci_probe_root_resources() as a helper to arch code
2) change ACPI core code as below
        if (ops->init_info && ops->init_info(info))
                goto out_release_info;
        if (ops->prepare_resources)
                ret = ops->prepare_resources(info);
        else
                ret = acpi_pci_probe_root_resources(info);
        if (ret < 0)
                goto out_release_info;

        pci_acpi_root_add_resources(info);
        pci_add_resource(&info->resources, &root->secondary);
        bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
                                  sysdata, &info->resources);
        if (!bus)
                goto out_release_info;

By this way, if arch has special requirement, it could implement
prepare_resources callback and make use of
acpi_pci_probe_root_resources() if needed.
Thanks!
Gerry
