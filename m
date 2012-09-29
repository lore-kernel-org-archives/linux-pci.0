Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-4-git-send-email-yinghai@kernel.org>
	<CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
	<CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com>
	<CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
Date: Fri, 28 Sep 2012 21:13:42 -0700
Message-ID: <CAE9FiQWvozrogC2L5kXpYY2Lp3jmx65CVn3yCs8MAJd9GoGV2A@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 6:52 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 28, 2012 at 6:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> So could use assign_unassigned_bus_res pci root bus add
>>>
>>> After your series, acpi_pci_root_start() looks like this:
>>>
>>>     pci_assign_unassigned_bus_resources
>>>     list_for_each_entry(driver, &acpi_pci_drivers, node)
>>>         driver->add(root);
>>>     pci_enable_bridges(root->bus);
>>>
>>> so apparently it's important that the driver->add() methods be run
>>> *before* the bridges are enabled.  Why?
>>
>
> During rebase, the changelog get lost.
>
>  pci_enable_bridges
>     ==> pci_enable_device
>         ==> ...
>            ===> pcibios_enable_device
>                ===> pcibios_enable_irq
>
> and one of driver in acpi_pci_drivers, is ioapic drivers and it will
> enable ioapic there.
>
> So we need to enable bridges that later.

old changelog before rebase:

-----
Subject: [PATCH] PCI, x86: Move pci_enable_bridges() down

After we get hot-added ioapic registered.
pci_enable_bridges will try to enable ioapic irq for pci bridge.

So need to move it down.

Or We can move out pcibios_enable_irq() out of pci_enable_device()
and call pcibios_enable_irq in pci_bus_add_devices ?
also will need to move ...
        pcibios_resource_survey_bus(root->bus);
        pci_assign_unassigned_bus_resources(root->bus);
to the start add ....
----
