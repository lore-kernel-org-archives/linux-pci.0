Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60893 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab2INOoW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2012 10:44:22 -0400
Received: by lbbgj3 with SMTP id gj3so2804814lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 14 Sep 2012 07:44:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120914133501.e17d1395.izumi.taku@jp.fujitsu.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
 <20120903170602.375b00cc.izumi.taku@jp.fujitsu.com> <CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
 <20120914133501.e17d1395.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Sep 2012 08:43:59 -0600
Message-ID: <CAErSpo7MHmOQAj95xsfyZ1A5oZ9UcF8djQhQedKUkS4fX_uw8w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI, PCI: add acpi_pci_roots protection
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 13, 2012 at 10:35 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> On Wed, 12 Sep 2012 17:40:45 -0600
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> On Mon, Sep 3, 2012 at 2:06 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> > Use mutex and RCU to protect global acpi_pci_roots list against
>> > PCI host bridge hotplug operations.
>> >
>> > RCU is used to avoid possible deadlock in function acpi_pci_find_root()
>> > and acpi_get_pci_rootbridge_handle(). A possible call graph:
>> > acpi_pci_register_driver()
>> >         mutex_lock(&acpi_pci_root_lock)
>> >                 driver->add(root)
>> >                         ......
>> >                                 acpi_pci_find_root()
>>
>> Where does this path occur?  I didn't see in in the current tree
>> (where the only users of acpi_pci_register_driver() are for
>> acpi_pci_slot_driver and acpi_pci_hp_driver).  Maybe it's in Yinghai's
>> work, which adds more acpi_pci_register_driver() users.
>
>   First I protected acpi_pci_roots list by using mutex(acpi_pci_root_lock).
>   In that case I faced deadlock at the following path:
>   acpiphp_glue_init
>      + acpi_pci_register_driver
>        ...
>          + add_bridge
>            + acpi_pci_find_root
>
>   So I used RCU instead.

Oh, right.  I missed the acpiphp_glue_init() path.  That's clearly a problem.

>> RCU seems unnecessarily complicated for this list, but I haven't gone
>> through Yinghai's work yet, so I don't know what it requires.
>>
>> In acpi_pci_root_start() and acpi_pci_root_remove(), we have the
>> struct acpi_pci_root, which has all sorts of information that would be
>> useful to the .add() and .remove() methods of sub-drivers.  It seems
>> sort of stupid that we only pass the acpi_handle to the sub-drivers,
>> forcing them to use hacks like acpi_pci_find_root() to look up the
>> information we just threw away.  Can we just fix the .add() and
>> .remove() interfaces to pass something more useful so we avoid the
>> need for this deadlock path?
>
>   Maybe yes. Do you prefer imprementation without RCU ?

Yes, if it's possible, I prefer to avoid RCU in this case.  RCU is
appropriate for performance paths, but it's much more difficult to
analyze than mutex locking.

Host bridge hotplug is definitely not a path where performance is an
issue, and I think reworking the .add()/.remove() interfaces will
allow us to use mutex locking.

I think it will also simplify the sub-drivers because having the
struct acpi_pci_root means they can get rid of acpi_pci_find_root(),
they don't have to re-evaluate _SEG and _BBN (in acpi_pci_slot_add()
-> walk_root_bridge()), they don't have to use pci_find_bus(), etc.
