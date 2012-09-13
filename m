Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170602.375b00cc.izumi.taku@jp.fujitsu.com>
	<CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
Date: Thu, 13 Sep 2012 12:09:31 -0700
Message-ID: <CAE9FiQVHgLGCmU2GTPkRKO8qRrWDwXOXNXoOf0OxvjWJBPLWMA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI, PCI: add acpi_pci_roots protection
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2012 at 4:40 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Sep 3, 2012 at 2:06 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> Use mutex and RCU to protect global acpi_pci_roots list against
>> PCI host bridge hotplug operations.
>>
>> RCU is used to avoid possible deadlock in function acpi_pci_find_root()
>> and acpi_get_pci_rootbridge_handle(). A possible call graph:
>> acpi_pci_register_driver()
>>         mutex_lock(&acpi_pci_root_lock)
>>                 driver->add(root)
>>                         ......
>>                                 acpi_pci_find_root()
>
> Where does this path occur?  I didn't see in in the current tree
> (where the only users of acpi_pci_register_driver() are for
> acpi_pci_slot_driver and acpi_pci_hp_driver).  Maybe it's in Yinghai's
> work, which adds more acpi_pci_register_driver() users.
>
> RCU seems unnecessarily complicated for this list, but I haven't gone
> through Yinghai's work yet, so I don't know what it requires.
>
> In acpi_pci_root_start() and acpi_pci_root_remove(), we have the
> struct acpi_pci_root, which has all sorts of information that would be
> useful to the .add() and .remove() methods of sub-drivers.  It seems
> sort of stupid that we only pass the acpi_handle to the sub-drivers,
> forcing them to use hacks like acpi_pci_find_root() to look up the
> information we just threw away.  Can we just fix the .add() and
> .remove() interfaces to pass something more useful so we avoid the
> need for this deadlock path?

new added acpi_pci_driver for ioapic, and iommu does not call
acpi_pci_find_root().

after split out pci_root_hp.c from acpiphp_glue.c, there will be
acpi_root_configure_bridge in pci_root_hp.c. that one could be
converted to
passing device instead of handle.

Thanks

Yinghai
