Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2655595.bSA6msl5Qp@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
 <CAPDyKFr4DgVdKtf=G1vUy=Si0nSTECsrWoqB+z9UCQHS8DuwcQ@mail.gmail.com> <2655595.bSA6msl5Qp@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Nov 2017 11:18:21 +0100
Message-ID: <CAPDyKFrP2V24ROgV0U8qgR-t91rzJ5mnEMkCQpq_tN_bZj1YPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[...]

>>
>> My general goal is that I want to make it easier (or as easy as
>> possible) for the general driver author to deploy runtime PM and
>> system-wide PM support - in an optimized manner. Therefore, I am
>> pondering over the solution you picked in this series, trying to
>> understand how it fits into those aspects.
>>
>> Particular I am a bit worried from a complexity point of view, about
>> the part with skipping callbacks from the PM core. We have observed
>> some difficulties with the direct_complete path (i2c dw driver), which
>> is based on a similar approach as this one.
>
> These are resume callbacks, not suspend callbacks.  Also not all of them
> are skipped.  That is quite a bit different from skipping *all* callbacks.
>
> Moreover, at the point the core decides to skip the callbacks, the device
> *has* *to* be left suspended and there simply is no point in running them
> no matter what.
>
> That part of code can be trivially moved to middle layers, but then each
> of them will have to do exactly the same thing.  I don't see any reason to
> do that and I'm not finding one in your comments.  Sorry.

I think my concerns boils done to that I am wondering how useful it
will be, in general, to enable the core to skip invoking resume
callbacks.

Although, if you are targeting some specific devices/drivers (ACPI,
PCI, etc), and not care that much about flexibility, then I am fine
with it. The approach seems to work.

Let me elaborate on that comment a bit.

1)
Skipping resume callbacks is not going to work for a device that may
be attached to the generic PM domain.

Well, in principle one could try to re-work genpd to cope with this
behavior, I guess, but that would also mean genpd becomes limited to
always use the noirq callbacks to power on/off the PM domain. That
isn't an acceptable limitation.

2)
Because of 1) This leads to those cross SoC drivers, dealing with
devices which sometimes may have a genpd attached and sometimes an
ACPI PM domain attached. I guess those drivers would need to have a
different set of system-wide PM callbacks, depending on the PM domain
the device is attached to, as to achieve a similar optimized behavior
during system resume. Or some other cleverness to deal with
system-wide PM.

Perhaps we can ignore both 1) and 2), because the number of cross SoC
drivers having these issues should be rather limited!?

3)
There are certainly lots of drivers that can cope with its device
remaining in runtime suspend, during system resume.
Although, some of these drivers may have some additional operations to
carry out during resume, which may not require to resume (activate)
its device. For example the driver may need to resume a queue,
re-configure an out-of-band wakeup (GPIO IRQ), re-configure pinctrls,
etc.

These drivers can't use the method behind LEAVE_SUSPENDED, because
they need their resume callbacks to be invoked.

[...]

>
> Well, this works the other way around this time, I'm afraid.  At this point
> you need to convince me that the approach has real issues. :-)

I think I have pointed out some issues above. Feel free to ignore
them, depending on what your target is.

[...]

>> >> Perhaps a better idea is to do this in the noirq suspend phase,
>> >> because it allows you to bail out in case pm_runtime_set_suspended()
>> >> fails.
>> >
>> > This doesn't make sense, sorry.
>>
>> What do you mean by "failures of that are meaningless here."?
>
> If all devices have runtime PM disabled, pm_runtime_set_suspended() should
> just do what it is asked for unless called with an invalid argument or
> similar.

Yes.

>
>> I was suggesting, instead of calling pm_runtime_set_suspended() in the
>> noirq *resume* phase, why can't you do that in the noirq *suspend*
>> phase?
>>
>> In the noirq *suspend* phase it's not too late to deal with errors!? Or is it?
>
> At that point it has not been decided whether or not the devices will stay
> suspended yet.  The status cannot be changed before making that decision,
> which only happens in the noirq resume phase.

Okay, then it's fine as is (because of your other patch to the runtime
PM core, which changes the behavior for pm_runtime_set_suspended()).

BTW, I have some additional minor comments to some other parts of the
code, but I will start over with a new thread proving you with those
comments.

Kind regards
Uffe
