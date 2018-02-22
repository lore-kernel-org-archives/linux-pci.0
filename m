Return-Path: <SRS0=SIH9=FQ=fireburn.co.uk=mike@kernel.org>
Return-Path: <SRS0=SIH9=FQ=fireburn.co.uk=mike@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180212152122.GB75542@bhelgaas-glaptop.roam.corp.google.com>
References: <20180212105523.15984-1-mika.westerberg@linux.intel.com>
 <CAHbf0-Exsu14dBmmfYy8Tcb4R58eYJKLFPPoM9RkqxHWDkqwXQ@mail.gmail.com> <20180212152122.GB75542@bhelgaas-glaptop.roam.corp.google.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 22 Feb 2018 09:19:24 +0000
Message-ID: <CAHbf0-HffVDu0vxyTrSfgCtJ5rGtu_4HqAoo2sseG3HoE-1djw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 12 February 2018 at 15:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Feb 12, 2018 at 11:08:55AM +0000, Mike Lothian wrote:
>> On 12 February 2018 at 10:55, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > Mike Lothian reported that plugging in a USB-C device does not work
>> > properly in his Dell Alienware system. This system has Intel Alpine
>> > Ridge Thunderbolt controller providing USB-C functionality. In these
>> > systems the USB controller (xHCI) is hotplugged whenever a device is
>> > connected to the port using ACPI based hotplug.
>> >
>> > The ACPI description of the root port in question looks as follows:
>> >
>> > Device (RP01)
>> > {
>> >     Name (_ADR, 0x001C0000)
>> >
>> >     Device (PXSX)
>> >     {
>> >         Name (_ADR, 0x02)
>> >
>> >         Method (_RMV, 0, NotSerialized)
>> >         {
>> >             // ...
>> >         }
>> >     }
>> >
>> > Here _ADR 0x02 means device 0, function 2 on the bus under root port
>> > (RP1) but that seems to be incorrect because device 0 is the upstream
>> > port of the Alpine Ridge PCIe switch and it does not have other
>> > functions than 0 (the bridge itself). When we get ACPI Notify() to the
>> > root port resulting from connecting a USB-C device, Linux tries to read
>> > PCI_VENDOR_ID from device 0, function 2 which of course always returns
>> > 0xffffffff because there is no such function and we never find the
>> > device.
>> >
>> > In Windows this works fine.
>> >
>> > Now, since we get ACPI Notify() to the root port and not to the PXSX
>> > device we should actually start our scan from there as well and not from
>> > the non-existent PXSX device so fix this by checking presence of the
>> > slot itself (function 0) if we fail to do that otherwise.
>> >
>> > While there use pci_bus_read_dev_vendor_id() in get_slot_status() which
>> > is the recommended way to read device and vendor ID of device on PCI bus.
>> >
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=198557
>> > Reported-by: Mike Lothian <mike@fireburn.co.uk>
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: stable@vger.kernel.org
>> > ---
>> >  drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++-------
>> >  1 file changed, 16 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> > index e2198a2feeca..b45b375c0e6c 100644
>> > --- a/drivers/pci/hotplug/acpiphp_glue.c
>> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> > @@ -541,6 +541,7 @@ static unsigned int get_slot_status(struct acpiphp_slot *slot)
>> >  {
>> >         unsigned long long sta = 0;
>> >         struct acpiphp_func *func;
>> > +       u32 dvid;
>> >
>> >         list_for_each_entry(func, &slot->funcs, sibling) {
>> >                 if (func->flags & FUNC_HAS_STA) {
>> > @@ -551,19 +552,27 @@ static unsigned int get_slot_status(struct acpiphp_slot *slot)
>> >                         if (ACPI_SUCCESS(status) && sta)
>> >                                 break;
>> >                 } else {
>> > -                       u32 dvid;
>> > -
>> > -                       pci_bus_read_config_dword(slot->bus,
>> > -                                                 PCI_DEVFN(slot->device,
>> > -                                                           func->function),
>> > -                                                 PCI_VENDOR_ID, &dvid);
>> > -                       if (dvid != 0xffffffff) {
>> > +                       if (pci_bus_read_dev_vendor_id(slot->bus,
>> > +                                       PCI_DEVFN(slot->device, func->function),
>> > +                                       &dvid, 0)) {
>> >                                 sta = ACPI_STA_ALL;
>> >                                 break;
>> >                         }
>> >                 }
>> >         }
>> >
>> > +       if (!sta) {
>> > +               /*
>> > +                * Check for the slot itself since it may be that the
>> > +                * ACPI slot is a device below PCIe upstream port so in
>> > +                * that case it may not even be reachable yet.
>> > +                */
>> > +               if (pci_bus_read_dev_vendor_id(slot->bus,
>> > +                               PCI_DEVFN(slot->device, 0), &dvid, 0)) {
>> > +                       sta = ACPI_STA_ALL;
>> > +               }
>> > +       }
>> > +
>> >         return (unsigned int)sta;
>> >  }
>> >
>> > --
>> > 2.15.1
>> >
>>
>> Thanks for this, it fixes a few other issues on my machine too
>
> Thanks for testing this.  Can you elaborate on what other issues this
> fixes?  I don't know what they are, but they might be worth mentioning
> in the changelog do make this fix more discoverable.
>
>> I'm going to do some searches around different bugzillas for the USB-C
>> non-detection and the NVMe drive disappearing after suspend issues and
>> report that they'll be getting a fix soon
>
> If you find more bugzillas that are fixed by this, please include the
> URLs so we can include them in the changelog.  (I can do this; no need
> to respin the patch just for this.)
>
>> Tested-by: Mike Lothian <mike@fireburn.co.uk>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi

Is this going in via this tree:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/

Is there anything else that needs to be done before it can go into rc3?

Cheers

Mike
