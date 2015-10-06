Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33805 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbbJFXo6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2015 19:44:58 -0400
MIME-Version: 1.0
In-Reply-To: <20151006232625.GI31850@dtor-ws>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan>
	<1927174.T9TA7zgbS1@vostro.rjw.lan>
	<20151006224308.GD31850@dtor-ws>
	<1769930.Ws5UzSBdLV@vostro.rjw.lan>
	<20151006232625.GI31850@dtor-ws>
Date: Wed, 7 Oct 2015 01:44:56 +0200
Message-ID: <CAJZ5v0igPJhU5Qh0+bpLKDnsJKiRALJpnTELkR_M3fY4kEwOZw@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 3/3] input: i8042: Avoid resetting controller on
 system suspend/resume
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 7, 2015 at 1:26 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 07, 2015 at 01:31:44AM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, October 06, 2015 03:43:08 PM Dmitry Torokhov wrote:
>> > On Wed, Oct 07, 2015 at 01:08:30AM +0200, Rafael J. Wysocki wrote:
>> > > On Tuesday, October 06, 2015 03:34:42 PM Dmitry Torokhov wrote:

[cut]

>> So something like this I suppose:
>>
>> ---
>>  drivers/input/serio/i8042.c |   16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/input/serio/i8042.c
>> ===================================================================
>> --- linux-pm.orig/drivers/input/serio/i8042.c
>> +++ linux-pm/drivers/input/serio/i8042.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/i8042.h>
>>  #include <linux/slab.h>
>> +#include <linux/suspend.h>
>>
>>  #include <asm/io.h>
>>
>> @@ -1170,7 +1171,8 @@ static int i8042_pm_suspend(struct devic
>>  {
>>       int i;
>>
>> -     i8042_controller_reset(true);
>> +     if (pm_suspend_via_firmware())
>> +             i8042_controller_reset(true);
>>
>>       /* Set up serio interrupts for system wakeup. */
>>       for (i = 0; i < I8042_NUM_PORTS; i++) {
>> @@ -1183,6 +1185,14 @@ static int i8042_pm_suspend(struct devic
>>       return 0;
>>  }
>>
>> +static int i8042_pm_resume_noirq(struct device *dev)
>> +{
>> +     if (!pm_resume_via_firmware())
>> +             i8042_interrupt(0, NULL);
>> +
>> +     return 0;
>> +}
>> +
>>  static int i8042_pm_resume(struct device *dev)
>>  {
>>       int i;
>> @@ -1199,7 +1209,8 @@ static int i8042_pm_resume(struct device
>>        * to bring it in a sane state. (In case of S2D we expect
>>        * BIOS to reset the controller for us.)
>>        */
>> -     return i8042_controller_resume(true);
>> +     return pm_suspend_via_firmware() ?
>> +             i8042_controller_resume(pm_resume_via_firmware()) : 0;
>
> Hmm, looks right, maybe just be more verbose...
>
>         /*
>          * If firmware was not going to be involved in suspend we did
>          * not restore controller state to whatever it was when we were
>          * booting, so we do not need to do anything.
>          */
>         if (!pm_suspend_via_firmware())
>                 return 0;
>
>         /*
>          * We only need to reset controller if we are resuming after
>          * handing off control to the firmware, otherwise we can
>          * simply restore the mode.
>          */
>         do_reset = pm_resume_via_firmware();
>
>         return i8042_controller_resume(do_reset);
>
>>  }
>>
>>  static int i8042_pm_thaw(struct device *dev)
>> @@ -1223,6 +1234,7 @@ static int i8042_pm_restore(struct devic
>>
>>  static const struct dev_pm_ops i8042_pm_ops = {
>>       .suspend        = i8042_pm_suspend,
>> +     .resume_noirq   = i8042_pm_resume_noirq,
>>       .resume         = i8042_pm_resume,
>>       .thaw           = i8042_pm_thaw,
>>       .poweroff       = i8042_pm_reset,

OK

I'll send a new version shortly.

Thanks,
Rafael
