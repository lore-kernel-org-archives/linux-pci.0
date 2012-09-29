Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo5_gBQwPYSm3oMeQmqTxqRPB_r0-HVv88LD2mR72QafDQ@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-6-git-send-email-yinghai@kernel.org>
	<CAErSpo5_gBQwPYSm3oMeQmqTxqRPB_r0-HVv88LD2mR72QafDQ@mail.gmail.com>
Date: Fri, 28 Sep 2012 19:05:03 -0700
Message-ID: <CAE9FiQUnrTqvx8Sd3yjp4hBD3q8E89H=LdgUcHcc_6p1aJDFOQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI: Add pci_stop_and_remove_root_bus()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> It supports both pci root bus and pci bus under pci bridge.
>>
>> -v2: clear pci_bridge's subordinate.
>> -v3: only handle root bus. and also put Jiang's get/put pair in
>> -v4: fold pci_stop/remove_bus_devices in... reducing confusing.
>> -v5: split device_register/unregister to avoid extra get...
>>      also remove extra blank line.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/remove.c |   36 ++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h  |    2 ++
>>  2 files changed, 38 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 513972f..7c0fd92 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -111,3 +111,39 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
>>         pci_remove_bus_device(dev);
>>  }
>>  EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
>> +
>> +void pci_stop_root_bus(struct pci_bus *bus)
>> +{
>> +       struct pci_dev *child, *tmp;
>> +       struct pci_host_bridge *host_bridge;
>> +
>> +       if (!pci_is_root_bus(bus))
>> +               return;
>> +
>> +       host_bridge = to_pci_host_bridge(bus->bridge);
>
> What if we made these functions just take a "struct pci_host_bridge *"
> directly instead of a "struct pci_bus *"?  Then the caller
> (acpi_pci_root_remove()) could just look up the pci_host_bridge
> pointer itself,

yes, that could save pci_is_root_bus checking.

> or even keep that pointer in struct acpi_pci_root
> instead of keeping the pci_bus pointer.

that could be a lot of change. could be next one stage.

actually acpi root is bound to pci host bridge instead of root bus.
so it is more reasonable to save host_bridge pointer.

we also can think in another way.
host_bridge and pci bus should be one part.
we may could just embed pci bus into pci_host_bridge instead.

-Yinghai
