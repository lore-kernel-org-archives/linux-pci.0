Return-Path: <SRS0=mvie=7D=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=mvie=7D=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170731215957.GG9303@bhelgaas-glaptop.roam.corp.google.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <4853865.5aRGCM4CdQ@aspire.rjw.lan>
 <4690779.IRjbMOd2yB@aspire.rjw.lan> <20170731215957.GG9303@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Aug 2017 02:39:37 +0200
Message-ID: <CAJZ5v0j3+co--weVTSKKY6jyyYYNaF=qPY9KPTQ4K1aoW0S45g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / PCI / PM: Rework acpi_pci_propagate_wakeup()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 11:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jul 21, 2017 at 11:30:24PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The acpi_pci_propagate_wakeup() routine is there to handle cases in
>> which PCI bridges (or PCIe ports) are expected to signal wakeup
>> for devices below them, but currently it doesn't do that correctly.
>>
>> The problem is that acpi_pci_propagate_wakeup() uses
>> acpi_pm_set_device_wakeup() for bridges and if that routine is
>> called for multiple times to disable wakeup for the same device,
>> it will disable it on the first invocation and the next calls
>> will have no effect (it works analogously when called to enable
>> wakeup, but that is not a problem).
>>
>> Now, say acpi_pci_propagate_wakeup() has been called for two
>> different devices under the same bridge and it has called
>> acpi_pm_set_device_wakeup() for that bridge each time.  The
>> bridge is now enabled to generate wakeup signals.  Next,
>> suppose that one of the devices below it resumes and
>> acpi_pci_propagate_wakeup() is called to disable wakeup for that
>> device.  It will then call acpi_pm_set_device_wakeup() for the bridge
>> and that will effectively disable remote wakeup for all devices under
>> it even though some of them may still be suspended and remote wakeup
>> may be expected to work for them.
>>
>> To address this (arguably theoretical) issue, allow
>> wakeup.enable_count under struct acpi_device to grow beyond 1 in
>> certain situations.  In particular, allow that to happen in
>> acpi_pci_propagate_wakeup() when wakeup is enabled or disabled
>> for PCI bridges, so that wakeup is actually disabled for the
>> bridge when all devices under it resume and not when just one
>> of them does that.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> But see questions below, stemming from my ignorance of ACPI PM.  I
> don't want to start a discussion and delay this.  If my questions
> don't suggest any useful changes, please ignore them.
>
>> ---
>>
>> -> v2: Rearrange checks in acpi_device_wakeup_enable() to reduce indentation
>>           level and possibly save some unnecessary checks for max_count == 1.
>>
>> ---
>>  drivers/acpi/device_pm.c |   46 +++++++++++++++++++++++++++++-----------------
>>  drivers/pci/pci-acpi.c   |    4 ++--
>>  include/acpi/acpi_bus.h  |   14 ++++++++++++--
>>  3 files changed, 43 insertions(+), 21 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/device_pm.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/device_pm.c
>> +++ linux-pm/drivers/acpi/device_pm.c
>> @@ -682,19 +682,8 @@ static void acpi_pm_notify_work_func(str
>>
>>  static DEFINE_MUTEX(acpi_wakeup_lock);
>>
>> -/**
>> - * acpi_device_wakeup_enable - Enable wakeup functionality for device.
>> - * @adev: ACPI device to enable wakeup functionality for.
>> - * @target_state: State the system is transitioning into.
>> - *
>> - * Enable the GPE associated with @adev so that it can generate wakeup signals
>> - * for the device in response to external (remote) events and enable wakeup
>> - * power for it.
>> - *
>> - * Callers must ensure that @adev is a valid ACPI device node before executing
>> - * this function.
>> - */
>> -static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
>> +static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>> +                                    u32 target_state, int max_count)
>
> It looks like @max_count is always either 1 or INT_MAX, so it's
> effectively a boolean.  Is there a way to interpret @max_count in
> terms of the PCI topology?  It's obviously related to
> wakeup->enable_count; does wakeup->enable_count basically mean "the
> number of subordinate devices that are enabled to generate wakeups"?

Yes, it does, for bridges.

> __acpi_pm_set_device_wakeup() is exported; maybe only to make the
> inlined callers in acpi_bus.h work?  It might be worth un-inlining
> them to avoid having to export __acpi_pm_set_device_wakeup().  I'm
> just thinking that exporting it makes it visible everywhere, and
> @max_count seems like an internal detail that's hard to document for
> use by non-core code.

I can do that.

> I guess you still have to export both acpi_pm_set_device_wakeup()
> (currently already exported) and acpi_pm_set_bridge_wakeup()
> (this patch effectively exports it by implementing it as an inline
> function).
>
> It'd be nice if we could distinguish the device case from the bridge
> case inside acpi_pm_set_device_wakeup() so we wouldn't have to rely on
> the caller using the correct one.  But I assume you already considered
> that and found it impractical.

That's correct.
