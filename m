Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63393 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab2I2B4F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 21:56:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-5-git-send-email-yinghai@kernel.org>
	<CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com>
Date: Fri, 28 Sep 2012 18:56:03 -0700
Message-ID: <CAE9FiQW2mvXGVKF7Wn0Td+_Wafu1sPMYr-sn2zffAfBycKi=Hg@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add
 root bus
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
>> After we get hot-added ioapic registered.
>> pci_enable_bridges will try to enable ioapic irq for pci bridges.
>
> What makes this specifically related to IOAPICs?
>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/acpi/pci_root.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index bce469c..27adbfd 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -644,12 +644,19 @@ static int acpi_pci_root_start(struct acpi_device *device)
>>         struct acpi_pci_root *root = acpi_driver_data(device);
>>         struct acpi_pci_driver *driver;
>>
>> +       if (system_state != SYSTEM_BOOTING)
>> +               pci_assign_unassigned_bus_resources(root->bus);
>> +
>>         mutex_lock(&acpi_pci_root_lock);
>>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>>                 if (driver->add)
>>                         driver->add(root);
>>         mutex_unlock(&acpi_pci_root_lock);
>>
>> +       /* need to after hot-added ioapic is registered */
>> +       if (system_state != SYSTEM_BOOTING)
>> +               pci_enable_bridges(root->bus);
>
> Theoretically, we should be able to assign resources and enable
> bridges here regardless of the system_state.
>
> I think the reason you don't want to do it while SYSTEM_BOOTING is
> because we currently do this at boot-time:
>
>     acpi_pci_root_add
>         pci_scan_child_bus
>     acpi_pci_root_start
>         pci_bus_add_devices
>     <account for some motherboard (PNP0C01) resources>
>     pcibios_assign_resources            # fs_initcall
>         pci_assign_unassigned_resources
>             pci_enable_bridges
>
> and without the SYSTEM_BOOTING check, we might assign PCI resources at
> boot-time that conflict with motherboard resources.
>
> Is that right?

yes.

>
> This is completely non-obvious and future readers deserve a hint about
> what's going on here.
>
> The right way to do this would be to pay attention to the host bridge
> apertures, and assign resources from within the apertures.  Then we
> could always assign PCI resources when adding a host bridge instead of
> in an fs_initcall.  I understand we still have legacy issues and
> machines where we still don't pay attention to _CRS.  But if we're
> doing things to work around a broken design, it's important to be
> aware of how the design is broken so we have some hope of eventually
> fixing the design.

that could be another big topic.
