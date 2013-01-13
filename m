Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50F2D3A3.6080602@gmail.com>
Date: Sun, 13 Jan 2013 23:32:51 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 11/22] PCI: correctly detect ACPI PCI host bridge objects
References: <1357944049-29620-1-git-send-email-yinghai@kernel.org> <1357944049-29620-12-git-send-email-yinghai@kernel.org> <2669837.JomPNBOLKK@vostro.rjw.lan>
In-Reply-To: <2669837.JomPNBOLKK@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/13/2013 07:34 AM, Rafael J. Wysocki wrote:
> On Friday, January 11, 2013 02:40:38 PM Yinghai Lu wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>> The code in pci_root_hp.c depends on function acpi_is_root_bridge()
>> to check whether an ACPI object is a PCI host bridge or not.
>> If an ACPI device hasn't been created for the ACPI object yet,
>> function acpi_is_root_bridge() will return false even if the object
>> is a PCI host bridge object. That behavior will cause two issues:
>> 1) No ACPI notification handler installed for PCI host bridges absent
>>    at startup, so hotplug events for those bridges won't be handled.
>> 2) rescan_root_bridge() can't reenumerate offlined PCI host bridges
>>    because the ACPI devices have been already destroyed.
>>
>> So use acpi_match_object_info_ids() to correctly detect PCI host bridges.
>>
>> -v2: update to use acpi_match_object_info_ids() from Tang Chen  - Yinghai
>> -v3: drop the PNP0A008, according to Bjorn.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> ---
>>  drivers/acpi/pci_root.c |   19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 5ae36d8..d30fb94 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -923,6 +923,23 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
>>  				_handle_hotplug_event_root);
>>  }
>>  
>> +static bool acpi_is_root_bridge_object(acpi_handle handle)
>> +{
>> +	struct acpi_device_info *info = NULL;
>> +	acpi_status status;
>> +	bool ret;
>> +
>> +	status = acpi_get_object_info(handle, &info);
>> +	if (ACPI_FAILURE(status))
>> +		return false;
>> +
>> +	ret = !acpi_match_object_info_ids(info, root_device_ids);
>> +
> 
> Well, I kind of don't understand why don't we check info->flags
> against ACPI_PCI_ROOT_BRIDGE that acpi_get_object_info() sets for us if it
> finds a PCI root bridge?
Hi Rafael,
	Thanks for reminder, we should test ACPI_PCI_ROOT_BRIDGE flag
instead of a redundant calling to acpi_match_object_info_ids(). To be honest,
I don't know the existence of ACPI_PCI_ROOT_BRIDGE flag before:(

> 
>> +	kfree(info);
>> +
>> +	return ret;
>> +}
>> +
>>  static acpi_status __init
>>  find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
>>  {
>> @@ -931,7 +948,7 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
>>  				      .pointer = objname };
>>  	int *count = (int *)context;
>>  
>> -	if (!acpi_is_root_bridge(handle))
>> +	if (!acpi_is_root_bridge_object(handle))
>>  		return AE_OK;
>>  
>>  	(*count)++;
>>
> 
> Thanks,
> Rafael
> 
> 

