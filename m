Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <503F8A27.2040005@gmail.com>
Date: Thu, 30 Aug 2012 23:43:35 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: Re: [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in
 function pci_remove_bus()
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <20120810151227.cc02c783.izumi.taku@jp.fujitsu.com> <CAErSpo6ukOVgCNgrYJ7nZFH_4dwQKwqZhS1w6oSiR9LtNy8Maw@mail.gmail.com>
In-Reply-To: <CAErSpo6ukOVgCNgrYJ7nZFH_4dwQKwqZhS1w6oSiR9LtNy8Maw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/17/2012 01:11 AM, Bjorn Helgaas wrote:
> On Thu, Aug 9, 2012 at 11:12 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>>     Correctly clean up pci root buses in function pci_remove_bus()
>>
>>     The function pci_create_root_bus() allocates the pci bus structure,
>>     registers the bus device and creates the legacy files for a pci root
>>     bus, but returns without setting the is_added flag. The is_added flag
>>     for a pci root bus will be set by function pci_scan_child_bus().
>>     If a pci root bus is destroyed before calling pci_scan_child_bus(),
>>     the is_added flag will not be set.
> 
> What's the scenario where this happens?  Most of the
> pci_scan_child_bus() calls look like this:
> 
>     bus = pci_create_root_bus();
>     pci_scan_child_bus(bus);
> 
> In those cases, there's no opportunity to destroy the root bus before
> calling pci_scan_child_bus().
> 
> I don't like to add additional tests as you're doing here because it's
> telling us that we have more special cases to think about.  Apparently
> bus->is_added is telling us that we've created legacy files and
> registered the bus device.  EXCEPT for root buses.  Why is it
> different for root buses?  Why don't we set root_bus->is_added at the
> same time we create the legacy files and register the root bus's
> device?
Hi Bjorn,
	Previously this patch was used to cover error recovery path in
our new ACPI based hotplug framework. Now thing has changed a lot and
it can't be cleanly applied to pci-next branch, so please ignore it:)
I will resubmit it if needed in future.
	--Gerry

> 
>>     So teach function pci_remove_bus()
>>     to detect such a case and correctly clean up pci root buses.
>>
>>     Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>>     Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>     Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> ---
>>  drivers/pci/remove.c |    9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> Index: Bjorn-next-0808/drivers/pci/remove.c
>> ===================================================================
>> --- Bjorn-next-0808.orig/drivers/pci/remove.c
>> +++ Bjorn-next-0808/drivers/pci/remove.c
>> @@ -70,11 +70,10 @@ void pci_remove_bus(struct pci_bus *pci_
>>         list_del(&pci_bus->node);
>>         pci_bus_release_busn_res(pci_bus);
>>         up_write(&pci_bus_sem);
>> -       if (!pci_bus->is_added)
>> -               return;
>> -
>> -       pci_remove_legacy_files(pci_bus);
>> -       device_unregister(&pci_bus->dev);
>> +       if (pci_bus->is_added || pci_is_root_bus(pci_bus)) {
>> +               pci_remove_legacy_files(pci_bus);
>> +               device_unregister(&pci_bus->dev);
>> +       }
>>  }
>>  EXPORT_SYMBOL(pci_remove_bus);
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

