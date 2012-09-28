Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46602 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030405Ab2I1To2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 15:44:28 -0400
Received: by lbon3 with SMTP id n3so2342038lbo.19
        for <linux-pci@vger.kernel.org>; Fri, 28 Sep 2012 12:44:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUbk+Z0OVYMuouEfXTZuwG0ZyPOi=PNwFdmuij_J07-QA@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com> <CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
 <CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
 <CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
 <CAErSpo7Vf1Pz3bFfMAfWXoh0gF844X2JT7RQ9-ecr3uWj=z9_w@mail.gmail.com>
 <CAE9FiQUrovv143dTo_k2m0DYXqwGc4BtbjmzGxo2Fk21Fp2EJw@mail.gmail.com>
 <CAErSpo74kQkxS2L5cmpn6++QoVODAf6LdUd-h=TzwQ==rTig5A@mail.gmail.com> <CAE9FiQUbk+Z0OVYMuouEfXTZuwG0ZyPOi=PNwFdmuij_J07-QA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 13:44:06 -0600
Message-ID: <CAErSpo4cR0v0Hy9ujgizDcNOB4wgLrgGrewQH2GewWihHMV9jQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
To: Yinghai Lu <yinghai@kernel.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 10:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 28, 2012 at 9:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Sep 27, 2012 at 2:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Today we have this, which is more complicated than it should be.  Note
>> how we do some ACPI stuff, some PCI stuff, some more ACPI stuff, then
>> more PCI stuff:
>>
>>     acpi_pci_root_add
>>         pci_acpi_scan_root
>>             pci_scan_child_bus
>>         acpi_pci_irq_add_prt
>>         acpi_pci_osc_control_set
>>     acpi_pci_root_start
>>         pci_bus_add_devices
>>
>> I don't think the ACPI/PCI mixture is anything essential dictated by
>> the way the hardware or firmware works.  I think it's just an artifact
>> of the current design, and it could be changed.  It would be better to
>> have this:
>>
>>     acpi_pci_root_add
>>         acpi_pci_irq_add_prt
>>         acpi_pci_osc_control_set
>>         pci_acpi_scan_root
>>             pci_scan_root_bus
>>                 pci_scan_child_bus
>>                 pci_bus_add_devices
>>
>> We can't get to this latter strategy as long as the ACPI interfaces
>> depend on the struct pci_bus.  So the _PRT change is a small thing in
>> itself, but I do think it helps enable significant improvements in the
>> future.
>
> still to handle to those fallback path like create_bus and scan bus failure.
>
> in my for-pci-next branch, with Jiang's patches and mine, now we achieved at
>
>     acpi_pci_root_add
>         pci_acpi_scan_root
>             pci_scan_root_bus
>                 pci_scan_child_bus
>         acpi_pci_osc_control_set
>         pci_bus_add_devices
>
> acpi_pci_irq_add_prt is called later during acpi binding that is
> triggered by adding to device tree.
> thought os_control set via pci_host_bridge add interface..
>
> with those BUS ADD notification, we can pass bus safely, and without
> considering about cleanup PRT and OSC setting.

I haven't looked at those patches yet.

Is there a reason why acpi_pci_osc_control_set() needs to be done
after pci_scan_child_bus()?  The argument that it might make the error
path somewhat simpler is not very convincing to me.  Having the arch
code call both pci_scan_child_bus() and pci_bus_add_devices() is a
much more fundamental complexity -- it makes x86 and ia64 different
from many architectures, and it exposes the intermediate state where
"devices have been enumerated but not added" to a lot more code.

It doesn't sound like an improvement to call acpi_pci_irq_add_prt()
using a bus add notifier.  At least for the host bridge case, it's
clear, simple, and straightforward to call it in acpi_pci_root_add().
Notifiers are useful in some cases, but they definitely make the code
harder to follow.
