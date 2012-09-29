Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50666D08.6050509@huawei.com>
Date: Sat, 29 Sep 2012 11:37:44 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add
 root bus
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org> <1348733519-24684-5-git-send-email-yinghai@kernel.org> <CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com> <CAE9FiQW2mvXGVKF7Wn0Td+_Wafu1sPMYr-sn2zffAfBycKi=Hg@mail.gmail.com> <CAErSpo4Or84GO-DjKcu=G7hqUo8BF8Lu7czHwfmZDecvVS-tMQ@mail.gmail.com>
In-Reply-To: <CAErSpo4Or84GO-DjKcu=G7hqUo8BF8Lu7czHwfmZDecvVS-tMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-9-29 11:31, Bjorn Helgaas wrote:
> On Fri, Sep 28, 2012 at 7:56 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> After we get hot-added ioapic registered.
>>>> pci_enable_bridges will try to enable ioapic irq for pci bridges.
>>>
>>> What makes this specifically related to IOAPICs?
> 
> I think you missed this question.
> 
>>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>> ---
>>>>  drivers/acpi/pci_root.c |    7 +++++++
>>>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>> index bce469c..27adbfd 100644
>>>> --- a/drivers/acpi/pci_root.c
>>>> +++ b/drivers/acpi/pci_root.c
>>>> @@ -644,12 +644,19 @@ static int acpi_pci_root_start(struct acpi_device *device)
>>>>         struct acpi_pci_root *root = acpi_driver_data(device);
>>>>         struct acpi_pci_driver *driver;
>>>>
>>>> +       if (system_state != SYSTEM_BOOTING)
>>>> +               pci_assign_unassigned_bus_resources(root->bus);
>>>> +
>>>>         mutex_lock(&acpi_pci_root_lock);
>>>>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>>>>                 if (driver->add)
>>>>                         driver->add(root);
>>>>         mutex_unlock(&acpi_pci_root_lock);
>>>>
>>>> +       /* need to after hot-added ioapic is registered */
>>>> +       if (system_state != SYSTEM_BOOTING)
>>>> +               pci_enable_bridges(root->bus);
>>>
>>> Theoretically, we should be able to assign resources and enable
>>> bridges here regardless of the system_state.
>>>
>>> I think the reason you don't want to do it while SYSTEM_BOOTING is
>>> because we currently do this at boot-time:
>>>
>>>     acpi_pci_root_add
>>>         pci_scan_child_bus
>>>     acpi_pci_root_start
>>>         pci_bus_add_devices
>>>     <account for some motherboard (PNP0C01) resources>
>>>     pcibios_assign_resources            # fs_initcall
>>>         pci_assign_unassigned_resources
>>>             pci_enable_bridges
>>>
>>> and without the SYSTEM_BOOTING check, we might assign PCI resources at
>>> boot-time that conflict with motherboard resources.
>>>
>>> Is that right?
>>
>> yes.
>>
>>>
>>> This is completely non-obvious and future readers deserve a hint about
>>> what's going on here.
>>>
>>> The right way to do this would be to pay attention to the host bridge
>>> apertures, and assign resources from within the apertures.  Then we
>>> could always assign PCI resources when adding a host bridge instead of
>>> in an fs_initcall.  I understand we still have legacy issues and
>>> machines where we still don't pay attention to _CRS.  But if we're
>>> doing things to work around a broken design, it's important to be
>>> aware of how the design is broken so we have some hope of eventually
>>> fixing the design.
>>
>> that could be another big topic.
> 
> I agree, and I'm not asking you to fix that.  I'm just trying to
> understand what's going on and write some comments and changelogs that
> will help make this maintainable in the future.
> 
> Also note the question at the top -- your changelog calls out IOAPICs,
> but I'm still not sure what this patch has to do with IOAPICs.
Hi Bjorn，
	Another weay is to add an ACPI driver for IOAPIC, so we can control
the order between IOAPIC and PCI host bridge.
	Thanks!
	Gerry

