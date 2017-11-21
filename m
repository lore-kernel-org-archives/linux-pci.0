Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqODyR6rcTitUdvU3dRwmYpOQF+4p0xXMpkpGQfDB_tBQ@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4184911.zoJM7jZeH4@aspire.rjw.lan>
 <1917233.X2U0QN21my@aspire.rjw.lan> <13167729.Euq9qh5SXX@aspire.rjw.lan> <CAPDyKFqODyR6rcTitUdvU3dRwmYpOQF+4p0xXMpkpGQfDB_tBQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2017 01:16:51 +0100
Message-ID: <CAJZ5v0gdSpPQ82Oa+orQyMbANJMgu=mp_3wbrHzhXtkOwCxTrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: Ulf Hansson <ulf.hansson@linaro.org>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 20, 2017 at 1:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 November 2017 at 15:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
>> instruct the PM core and middle-layer (bus type, PM domain, etc.)
>> code that it is desirable to leave the device in runtime suspend
>> after system-wide transitions to the working state (for example,
>> the device may be slow to resume and it may be better to avoid
>> resuming it right away).
>>
>> Generally, the middle-layer code involved in the handling of the
>> device is expected to indicate to the PM core whether or not the
>> device may be left in suspend with the help of the device's
>> power.may_skip_resume status bit.  That has to happen in the "noirq"
>> phase of the preceding system suspend (or analogous) transition.
>> The middle layer is then responsible for handling the device as
>> appropriate in its "noirq" resume callback which is executed
>> regardless of whether or not the device may be left suspended, but
>> the other resume callbacks (except for ->complete) will be skipped
>> automatically by the core if the device really can be left in
>> suspend.
>>
>> The additional power.must_resume status bit introduced for the
>> implementation of this mechanisn is used internally by the PM core
>> to track the requirement to resume the device (which may depend on
>> its children etc).
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!
