Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqXqiBzoE3Bo9u9WOo3aVqvEP4s_6oyTFZ_Cy6==DxYug@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <5769060.47kJca3s00@aspire.rjw.lan> <CAPDyKFqXqiBzoE3Bo9u9WOo3aVqvEP4s_6oyTFZ_Cy6==DxYug@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2017 12:23:45 +0100
Message-ID: <CAJZ5v0j9iYwUntC2mXVXXhybPop5uPoMVGwDUyoqW27Yo94UZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PM / core: Add SMART_SUSPEND driver flag
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

On Mon, Nov 6, 2017 at 9:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 28 October 2017 at 00:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Define and document a SMART_SUSPEND flag to instruct bus types and PM
>> domains that the system suspend callbacks provided by the driver can
>> cope with runtime-suspended devices, so from the driver's perspective
>> it should be safe to leave devices in runtime suspend during system
>> suspend.
>>
>> Setting that flag may also cause middle-layer code (bus types,
>> PM domains etc.) to skip invocations of the ->suspend_late and
>> ->suspend_noirq callbacks provided by the driver if the device
>> is in runtime suspend at the beginning of the "late" phase of
>> the system-wide suspend transition, in which case the driver's
>> system-wide resume callbacks may be invoked back-to-back with
>> its ->runtime_suspend callback, so the driver has to be able to
>> cope with that too.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> If not too late:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Not too late, thanks!

I'll be sending the next batch of this shortly. :-)
