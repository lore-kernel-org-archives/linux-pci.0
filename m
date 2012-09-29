Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34817 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab2I2CJH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 22:09:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4c6ti0OCmBvP+_M43920HU5+8RgnvEHKw=zBw2LkmGDA@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-9-git-send-email-yinghai@kernel.org>
	<CAErSpo4c6ti0OCmBvP+_M43920HU5+8RgnvEHKw=zBw2LkmGDA@mail.gmail.com>
Date: Fri, 28 Sep 2012 19:09:05 -0700
Message-ID: <CAE9FiQV8tvRB7ZiseSrkWbHoZ=DN9r=xOn_fwGy8Akj_R6y-nA@mail.gmail.com>
Subject: Re: [PATCH 8/8] PCI, ACPI: remove acpi_root_driver in reserse order
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> aka stop acpi root driver in this sequence: acpiphp, iommu, ioapic.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/acpi/pci_root.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index a27cbb57..012f40d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -672,7 +672,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
>>         pci_stop_root_bus(root->bus);
>>
>>         mutex_lock(&acpi_pci_root_lock);
>> -       list_for_each_entry(driver, &acpi_pci_drivers, node)
>> +       list_for_each_entry_reverse(driver, &acpi_pci_drivers, node)
>>                 if (driver->remove)
>>                         driver->remove(root);
>
> This seems sort of OK just because we call the ->add() methods in
> forward order, so it is symmetric to call the ->remove() methods in
> reverse order.
>
> But I'm uncomfortable with using this as a way to enforce ->remove()
> ordering across acpiphp, iommu, and ioapic.  That seems fragile.
>
> What are the dependencies between these drivers that require this ordering?

ioapic should come at first, and iommu and last is acpiphp.

iommu will check if intr-mapping is corresponding to ioapic controller number.
also dmar controller will need one normal irq without intr-remapping
for error handling.

need to use link sequence in Makefile to make sure iommu come at first.

-Yinghai
