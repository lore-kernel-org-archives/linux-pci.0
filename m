Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v6 4/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
 <1442218057-4355-5-git-send-email-jiang.liu@linux.intel.com>
 <20151006174725.GA29420@localhost>
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
Message-ID: <5615FFD4.3090202@linux.intel.com>
Date: Thu, 8 Oct 2015 13:32:04 +0800
MIME-Version: 1.0
In-Reply-To: <20151006174725.GA29420@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/7 1:47, Bjorn Helgaas wrote:
> Hi Jiang,
> 
> Strictly speaking, this patch by itself doesn't actually "consolidate"
> anything because it only adds acpi_pci_root_create() (which isn't called by
> anything yet), but doesn't remove the original x86 copy.
> 
<snit>
>> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>> +				     struct acpi_pci_root_ops *ops,
>> +				     struct acpi_pci_root_info *info,
>> +				     void *sysdata)
>> +{
>> +	int ret, busnum = root->secondary.start;
>> +	struct acpi_device *device = root->device;
>> +	int node = acpi_get_node(device->handle);
>> +	struct pci_bus *bus;
>> +
>> +	info->root = root;
>> +	info->bridge = device;
>> +	info->ops = ops;
>> +	INIT_LIST_HEAD(&info->resources);
>> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
>> +		 root->segment, busnum);
>> +
>> +	if (ops->init_info && ops->init_info(info))
>> +		goto out_release_info;
>> +	ret = acpi_pci_probe_root_resources(info);
>> +	if (ops->prepare_resources)
>> +		ret = ops->prepare_resources(info, ret);
>> +	if (ret < 0)
>> +		goto out_release_info;
>> +	else if (ret > 0)
>> +		pci_acpi_root_add_resources(info);
> 
> This is unnecessarily complicated: you set "ret", then overwrite it if
> ops->prepare_resources.  By the time you test "ret", it's messy to
> figure out what it means.
> 
> Both ops->prepare_resources() and pci_acpi_root_add_resources()
> should be able to deal with empty resource lists, so can you do the
> following instead?
> 
>     ret = acpi_pci_probe_root_resources(info);
>     if (ret < 0)
>         goto out_release_info;
Hi Bjorn,
	Thanks for review:)
	The original code is used to handle a special case for x86,
where acpi_pci_probe_root_resources() fails but ops->prepare_resources()
succeeds. For x86, PCI host bridge resources may probed by means
other than ACPI when pci_use_crs is true (AMD and Broadcom hostbridges).
So we can't return failure when acpi_pci_probe_root_resources() fails.
+	ret = acpi_pci_probe_root_resources(info);
+	if (ops->prepare_resources)
+		ret = ops->prepare_resources(info, ret);
+	if (ret < 0)
+		goto out_release_info;

>     if (ops->prepare_resources) {
>         ret = ops->prepare_resources(info, ret);
>         if (ret < 0)
>             goto out_release_info;
>     }
>     pci_acpi_root_add_resources(info);
I will remove the redundant check of (ret > 0) in:
+	else if (ret > 0)
+		pci_acpi_root_add_resources(info);

> 
>> +	pci_add_resource(&info->resources, &root->secondary);
>> +
>> +	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
>> +				  sysdata, &info->resources);
>> +	if (bus) {
> 
>     if (!bus)
>         goto out_release_info;
> 
> Then it looks like the other error paths above, and you can un-indent
> the following code, which is the normal path:
Will do this.
Thanks!
Gerry
