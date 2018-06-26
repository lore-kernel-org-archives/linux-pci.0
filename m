Return-Path: <SRS0=Mfjj=JM=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=Mfjj=JM=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Jun 2018 16:22:00 +0200
Message-ID: <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
>> handling for devices with no callbacks) introduced a system suspend
>> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
>> port) to stay in D3 over suspend-to-RAM, which is a side effect of
>> setting power.direct_complete for the children of that bridge that
>> have no PM callbacks.
>>
>> On the majority of systems PCI bridges are not allowed to be
>> runtime-suspended (the power/control sysfs attribute is set to "on"
>> for them by default), but user space can change that setting and if
>> it does so and a given bridge has no children with PM callbacks, the
>> direct_complete optimization will be applied to it and it will stay
>> in suspend over system suspend.  Apparently, that confuses the
>
> "stay in D3 over system suspend"? (just to be explicit about what "in
> suspend" means)

OK

>> platform firmware on the affected machine and that may very well
>> happen elsewhere, so avoid the direct_complete optimization for
>> PCI bridges with no drivers (if there is a driver, it should take
>> care of the PM handling) on suspend-to-RAM altogether (that should
>> not matter for suspend-to-idle as platform firmware is not involved
>> in it).
>>
>> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
>> Reported-by: n0000b.n000b@gmail.com
>> Tested-by: n0000b.n000b@gmail.com
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/pci/pci-acpi.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> Index: linux-pm/drivers/pci/pci-acpi.c
>> ===================================================================
>> --- linux-pm.orig/drivers/pci/pci-acpi.c
>> +++ linux-pm/drivers/pci/pci-acpi.c
>> @@ -638,6 +638,14 @@ static bool acpi_pci_need_resume(struct
>>       if (acpi_target_system_state() == ACPI_STATE_S0)
>>               return false;
>>
>> +     /*
>> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
>> +      * confuses the platform firmware, so avoid doing that, unless the
>> +      * bridge has a driver that should take care of PM handling.
>> +      */
>> +     if (pci_is_bridge(dev) && !dev->driver)
>> +             return true;
>
> It sounds like the question of whether leaving a bridge in D3 confuses
> the firmware has a platform-specific answer.

Well, it may confuse the platform firmware in general.

> How does the driver PM handling know how to do the right thing?

For endpoints this is not an issue as they always have been expected
to be in D3 before passing control to the platform firmware on S3
entry, but we've never done that for bridges by default, except for
PCIe ports with PM enabled (in which case the driver decides whether
or not to enable it).

> Does it need to know whether
> it's safe to put the device in D3?  Or maybe a device is never put in
> D3 for system suspend if it has a driver?

As per the above, endpoints should be OK (or they are quirky if not),
but bridges are sort of a gray area.  PCIe ports for which we enable
PM should be fine, for the rest it's better to be conservative and
resume them IMO.

> But I'm just kibbitzing; since you merged c62ec4610c40, I'm happy if
> you also merge this:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>>       return !!adev->power.flags.dsw_present;
>>  }

Thanks!
