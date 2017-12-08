Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171208163710.GB24344@atomide.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <1894178.xtK0vD2N4H@aspire.rjw.lan> <20171114025109.GA43048@google.com>
 <1882670.s3LR2t44nD@aspire.rjw.lan> <20171206193421.GA143886@google.com>
 <20171207001754.GB28152@atomide.com> <20171207002955.GA40447@google.com> <20171208163710.GB24344@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Dec 2017 18:12:42 +0100
Message-ID: <CAJZ5v0jSOG-dQ27wSA9DXaBj2ae_KSC21VUhsBdxQc68EEOcKg@mail.gmail.com>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>, shawn.lin@rock-chips.com,
        Doug Anderson <dianders@chromium.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 8, 2017 at 5:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Brian Norris <briannorris@chromium.org> [171207 00:32]:
>> On Wed, Dec 06, 2017 at 04:17:54PM -0800, Tony Lindgren wrote:
>> > * Brian Norris <briannorris@chromium.org> [171206 19:36]:
>> > > By the way, it seems pretty ambiguous how we want to handle things like
>> > > (a) multiple devices sharing the same WAKE#
>> > > (b) systems where a slot is swappable
>> > >
>> > > For (a), the main problem is that if we have to repeat the interrupt
>> > > definition in multiple devices, then we have to deal with something like
>> > > IRQF_SHARED. That can be done, but it makes it much harder to use the
>> > > dedicated wakeirq helpers.
>> >
>> > This will get messy, let's not go there :) That is unless the hardware
>> > really has a single interrupt wired to multiple devices. And in that
>> > case almost certainly a custom interrupt handler is needed.
>>
>> As Rafael mentioned, the spec doesn't clearly delineate a required
>> hierarchy to the WAKE# pin, and it's certainly possible to share it. I'm
>> fine dodging that question for now, and only writing said custom
>> interrupt handler if/when needed.
>
> OK if the WAKE# pin is shared then PCI (or hardware specific?) code needs
> to figure out from where it came from.

Right.

Basically, that would need a list (or equivalent) of devices sharing
the wakeup IRQ and if that triggers, it needs to walk the list and
call pci_pme_wakeup() for all devices in it.

>> But device tree bindings are "forever", so it seems reasonable to at
>> least agree how it should be defined.
>
> Well that's why we're just using the existing interrupts-extended
> binding there :) It does not leave out the option for shared interrupts,
> it's just that drivers/base/power/wakeirq.c can't deal with them in a
> sane way or at least we'd have to add a flag to not enable/disable the
> wakeirq automatically.

I think that the binding needs to be sort-of PCI-specific to cover the
shared case.

I'm not sure if there are any other buses needing that (they would
need to define standard PM registers as PCI does).
