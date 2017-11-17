Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ibqqUZ0M1_GKCkGj_E+2DQQMOLAVTyPd7mSJDAypkHjQ@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5556673.MXo6XDN1f4@aspire.rjw.lan>
 <CAPDyKFpzSd4zwW_awuxuim0gzyKV5s9dm66X+szsSUKRnBakbA@mail.gmail.com>
 <2654404.6YT5rmSnae@aspire.rjw.lan> <CAPDyKFo4gE6O=xMoS2Phe0kNgNUGBffy1hxT3iPrY71ieGcumQ@mail.gmail.com>
 <CAJZ5v0ibqqUZ0M1_GKCkGj_E+2DQQMOLAVTyPd7mSJDAypkHjQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Nov 2017 14:49:20 +0100
Message-ID: <CAPDyKFrsabWL2cVE2SwguRRiEV5sJHLpzpyhahLucdER_RAEpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
>>>> Second, have you considered setting the default value of
>>>> dev->power.may_skip_resume to true?
>>>
>>> Yes.
>>>
>>>> That would means the subsystem
>>>> instead need to implement an opt-out method. I am thinking that it may
>>>> not be an issue, since we anyway at this point, don't have drivers
>>>> using the LEAVE_SUSPENDED flag.
>>>
>>> Opt-out doesn't work because of the need to invoke the "noirq" callbacks.
>>
>> I am not sure I follow that.
>>
>> Whatever needs to be fixed on the subsystem level, that could be done
>> before the driver starts using the LEAVE_SUSPENDED flag. No?
>
> That requires a bit of explanation, sorry for being overly concise.
>
> The core calls ->resume_noirq from the middle layer regardless of
> whether or not the device will be left suspended, so the
> ->resume_noirq cannot do arbitrary things to it.  Setting
> may_skip_resume by the middle layer tells the core that the middle
> layer is ready for that and is going to cooperate.  If may_skip_resume
> had been set by default, that piece of information would have been
> missing.

Huh, I still don't get that. Sorry.

If the "may_skip_resume" is default set to true by the PM core,
wouldn't that just mean that the middle-layer needs to implement an
opt-out method, rather than opt-in. In principle to opt-out the
middle-layer needs to set may_skip_resume to false in suspend_noirq
phase, no?

Then we only need to make sure drivers don't starts use
LEAVE_SUSPENDED, before we make sure the middle layers is adopted. But
that should not be a problem.

The benefit would be that those middle layers that can cope with
LEAVE_SUSPENDED as of today don't need to change.

Kind regards
Uffe
