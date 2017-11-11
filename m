Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <6330680.LdxjlP4uri@aspire.rjw.lan> <2932219.eEdIVn6WWf@aspire.rjw.lan>
 <CAPDyKFrbnLjBzY3yE1OyXOpG3--K+C-1BCWQtyL9S6zQ5cmdhw@mail.gmail.com> <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 11 Nov 2017 01:41:51 +0100
Message-ID: <CAJZ5v0i1LEAdfjDAbLfEKTiYR3MT+69-BR2eR=ie-oioXHWCwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Sat, Nov 11, 2017 at 12:45 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Nov 10, 2017 at 10:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 8 November 2017 at 14:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
>>> instruct the PM core and middle-layer (bus type, PM domain, etc.)
>>> code that it is desirable to leave the device in runtime suspend
>>> after system-wide transitions to the working state (for example,
>>> the device may be slow to resume and it may be better to avoid
>>> resuming it right away).
>>>
>>> Generally, the middle-layer code involved in the handling of the
>>> device is expected to indicate to the PM core whether or not the
>>> device may be left in suspend with the help of the device's
>>> power.may_skip_resume status bit.  That has to happen in the "noirq"
>>> phase of the preceding system suspend (or analogous) transition.
>>> The middle layer is then responsible for handling the device as
>>> appropriate in its "noirq" resume callback which is executed
>>> regardless of whether or not the device may be left suspended, but
>>> the other resume callbacks (except for ->complete) will be skipped
>>> automatically by the core if the device really can be left in
>>> suspend.
>>
>> I don't understand the reason to why you need to skip invoking resume
>> callbacks to achieve this behavior, could you elaborate on that?
>
> The reason why it is done this way is because that takes less code and
> is easier (or at least less error-prone, because it avoids repeating
> patterns in middle layers).

Actually, it also is a matter of correctness, at least to some extent.

Namely, if the parent or any supplier of the device has
power.must_resume clear in dpm_noirq_resume_devices(), then the device
should not be touched during the whole system resume transition
(because the access may very well go through the suspended parent or
supplier) and the most straightforward way to make that happen is to
avoid running the code that may touch the device.  [Arguably, if
middle layers were made responsible for handling that, they would need
to do pretty much the same thing and so there is no reason for not
doing it in the core.]

Allowing the "noirq" callback from middle layers to run in that case
is a stretch already, but since genpd needs that, well, tough nuggets.

All of that said, if there is a middle layer wanting to set
power.skip_resume and needing to do something different for the resume
callbacks, then this piece can be moved from the core to the middle
layers at any time later.  So far there's none, though.  At least not
in this patch series.

Thanks,
Rafael
