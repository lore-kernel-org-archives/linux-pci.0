Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUrovv143dTo_k2m0DYXqwGc4BtbjmzGxo2Fk21Fp2EJw@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com> <CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
 <CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
 <CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
 <CAErSpo7Vf1Pz3bFfMAfWXoh0gF844X2JT7RQ9-ecr3uWj=z9_w@mail.gmail.com> <CAE9FiQUrovv143dTo_k2m0DYXqwGc4BtbjmzGxo2Fk21Fp2EJw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 10:07:28 -0600
Message-ID: <CAErSpo74kQkxS2L5cmpn6++QoVODAf6LdUd-h=TzwQ==rTig5A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
To: Yinghai Lu <yinghai@kernel.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 2:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Sep 27, 2012 at 11:44 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> I explained the reasons why I think it's a good idea above, but just
>> to expand on it, we currently have to create the struct pci_bus before
>> we can add _PRT information.   But adding the _PRT info doesn't
>> actually depend on the struct pci_bus; it only requires the segment
>> number and the bus number.  We have that information before we scan
>> the bus .
>>
>> I think it's useful to disentangle _PRT interface from the specifics
>> of PCI (in this case, the struct pci_bus).  We're currently using the
>> struct pci_bus here just as a convenient way to pass around the
>> segment/bus number, but I don't think it's the appropriate abstraction
>> for that.
>>
>> Do you see a technical problem with it?  Even if it's not *necessary*
>> in order to make host bridge hotplug work, I think it's worth doing to
>> make the code more understandable.
>>
>> Do you see a problem with adding the _PRT info before scanning the bus
>> or with removing it after deleting the bus?
>
> If the bus is not there, do not need that prt.
>
> So if you find the prt and add it to the list before, later if
> scanning fail etc failing path
> you will need to clean that prt in the list.

That's true.  It will add a little bit to the failure paths in
acpi_pci_root_add(), but I don't think that's much of an issue.

>> I'd like the bus scan
>> code to be able to scan/add/bind drivers all at once in the PCI core.
>> Today I think we have scan/add _PRT/device_add, where we have to do
>> this _PRT stuff in the middle, so we have to use two PCI interfaces
>> rather than one.

This is the more important bit.  My longer-term goal is to separate
out the ACPI parts from the PCI parts.  Then we can use more generic
code for the PCI part, which will help unify the architectures.

Today we have this, which is more complicated than it should be.  Note
how we do some ACPI stuff, some PCI stuff, some more ACPI stuff, then
more PCI stuff:

    acpi_pci_root_add
        pci_acpi_scan_root
            pci_scan_child_bus
        acpi_pci_irq_add_prt
        acpi_pci_osc_control_set
    acpi_pci_root_start
        pci_bus_add_devices

I don't think the ACPI/PCI mixture is anything essential dictated by
the way the hardware or firmware works.  I think it's just an artifact
of the current design, and it could be changed.  It would be better to
have this:

    acpi_pci_root_add
        acpi_pci_irq_add_prt
        acpi_pci_osc_control_set
        pci_acpi_scan_root
            pci_scan_root_bus
                pci_scan_child_bus
                pci_bus_add_devices

We can't get to this latter strategy as long as the ACPI interfaces
depend on the struct pci_bus.  So the _PRT change is a small thing in
itself, but I do think it helps enable significant improvements in the
future.

Bjorn
