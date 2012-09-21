Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38565 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab2IUR6T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 13:58:19 -0400
Received: by lbbgj3 with SMTP id gj3so4240273lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 21 Sep 2012 10:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120921161447.46771be7.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152323.48cb2703.izumi.taku@jp.fujitsu.com> <CAErSpo6VeKfwzVmv=WjH7wNPMf6_PLHpo99FeKoHXOrYPnYVPQ@mail.gmail.com>
 <20120921161447.46771be7.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Sep 2012 11:57:57 -0600
Message-ID: <CAErSpo60jMOqRSSC3D+GjC2wmdbKetX-Q57Wg68GTeZsjca3pQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root implementation
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 21, 2012 at 1:14 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> On Wed, 19 Sep 2012 16:03:27 -0600
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> On Tue, Sep 18, 2012 at 12:23 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> >
>> > This patch changes the implementation of acpi_pci_find_root().
>> >
>> > We can access acpi_pci_root without scanning acpi_pci_roots list.
>> > If hostbridge hotplug is supported, acpi_pci_roots list will be
>> > protected by mutex. We should not access acpi_pci_roots list
>> > if preventable to lessen deadlock risk.
>> >
>> > Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> > ---
>> >  drivers/acpi/pci_root.c |   13 ++++++++-----
>> >  1 file changed, 8 insertions(+), 5 deletions(-)
>> >
>> > Index: Bjorn-next-0903/drivers/acpi/pci_root.c
>> > ===================================================================
>> > --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
>> > +++ Bjorn-next-0903/drivers/acpi/pci_root.c
>> > @@ -265,12 +265,15 @@ static acpi_status acpi_pci_osc_support(
>> >  struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
>> >  {
>> >         struct acpi_pci_root *root;
>> > +       struct acpi_device *device;
>> >
>> > -       list_for_each_entry(root, &acpi_pci_roots, node) {
>> > -               if (root->device->handle == handle)
>> > -                       return root;
>> > -       }
>> > -       return NULL;
>> > +       if (acpi_bus_get_device(handle, &device) ||
>> > +           acpi_match_device_ids(device, root_device_ids))
>>
>> What's the purpose of the acpi_match_device_ids() check?  It's not
>> obvious, so worth calling it out in the changelog, and maybe even a
>> comment in the code.
>
>   My intention is to reject acpi_handle which doesn't represent
>   hostbrige. I think this is reasonable...

Yes, I understand that part.  I was just trying to figure out why that
check is needed.  Is there a path where we can call
acpi_pci_find_root() with a handle that is *not* a PNP0A03 device?  I
looked at all the callers, and as far as I can tell, the supplied
handle is always for a host bridge device.

But I guess I don't object to the check.  This is just another case of
a lookup that in many cases is unnecessary because we should have the
struct acpi_pci_root * available already.

>> Nice to get rid of the list traversal.
>>
>> > +               return NULL;
>> > +
>> > +       root = acpi_driver_data(device);
>> > +
>> > +       return root;
>> >  }
>> >  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
>> >
>> >
>>
>
>
> --
> Taku Izumi <izumi.taku@jp.fujitsu.com>
>
