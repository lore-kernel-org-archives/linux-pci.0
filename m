Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A4A2DCD@G01JPEXMBYT03>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
	<4A338DB2991D2A44B9A44B8718AECF650A4A2DCD@G01JPEXMBYT03>
Date: Tue, 4 Sep 2012 12:12:19 -0700
Message-ID: <CAE9FiQVJ0JRCgZsh+iSB8VC4TqJDcetPyno36L8=UW-UQUK4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
 hot-plugging PCI root bridges
From: Yinghai Lu <yinghai@kernel.org>
To: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
Cc: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 4, 2012 at 12:58 AM, Kaneshige, Kenji
<kaneshige.kenji@jp.fujitsu.com> wrote:
>>   -v2: Move add calling to acpi_pci_root_start by Yinghai
>>  static int acpi_pci_root_start(struct acpi_device *device)
>>  {
>>       struct acpi_pci_root *root = acpi_driver_data(device);
>> +     struct acpi_pci_driver *driver;
>> +
>> +     list_for_each_entry(driver, &acpi_pci_drivers, node)
>> +             if (driver->add)
>> +                     driver->add(device->handle);
>>
>
> I think this (invoke .add callback for each acpi pci driver) should be done
> after pci_bus_add_devices().

We need to load ioapic driver and dmar driver before normal pci drivers.

>
> It seems ACPI pci drivers run *after* pci_bus_add_devices() at the boot time
> (because no acpi pci drivers is loaded at that time). On the other hand, it
> seems that ACPI pci drivers run *before* pci_bus_add_devices() at the hotadd
> time. Those should be the same.

for boot time, sequence : normal pci driver still get loaded after
ioapic and dmar drivers.
otherwise those driver will have problem to get irq and iommu work correctly.
and if ioapic and dmar are static, and they will get initialized
around pci device get scanned and pci_bus_add_devices get called
already.
but that time normal devices driver does not get registered yet. those
pci drivers will get loaded (should be bounded)
for pci devices when those driver get registered.

Thanks

Yinghai
