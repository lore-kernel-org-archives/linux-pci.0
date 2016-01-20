Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 11/21] pci, acpi: Move ACPI host bridge device
 companion assignment to core code.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-12-git-send-email-tn@semihalf.com>
 <20160119160224.GD5276@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <569F6D67.5000000@semihalf.com>
Date: Wed, 20 Jan 2016 12:20:07 +0100
MIME-Version: 1.0
In-Reply-To: <20160119160224.GD5276@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19.01.2016 17:02, Lorenzo Pieralisi wrote:
> On Wed, Jan 13, 2016 at 02:20:57PM +0100, Tomasz Nowicki wrote:
[...]
>> device via pci_create_root_bus parameter (as the ACPI device type)
>
> I do not understand what you mean by "as the ACPI device type".

See below.

>
>> and using ACPI_COMPANION_SET in core code for ACPI boot method.
>> ACPI_COMPANION_SET is safe to run for all cases DT, ACPI and DT&ACPI.
>>
>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/acpi/pci_root.c | 5 ++++-
>>   drivers/pci/probe.c     | 2 ++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ae3fe4e..a65c8c2 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -846,7 +846,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>
>>   	pci_acpi_root_add_resources(info);
>>   	pci_add_resource(&info->resources, &root->secondary);
>> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
>> +
>> +	/* Root bridge device needs to be sure of parent ACPI type */
>> +	ACPI_COMPANION_SET(&device->dev, device);
>
> I do not understand why the code above is needed, can you elaborate
> please ?
>

This makes sure that device->dev can be identified as ACPI device, so we 
can use to_acpi_device_node() and assign companion safely below.

>
>> +	bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
>>   				  sysdata, &info->resources);
>>   	if (!bus)
>>   		goto out_release_info;
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 553a029..cad836f 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2107,6 +2107,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>   	bridge->dev.parent = parent;
>>   	bridge->dev.release = pci_release_host_bridge_dev;
>>   	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>> +	ACPI_COMPANION_SET(&bridge->dev,
>> +			   parent ? to_acpi_device_node(parent->fwnode) : NULL);

pci_create_root_bus() can be called with DT device, then 
ACPI_COMPANION_SET assign no companion to bridge device.

Thanks,
Tomasz

