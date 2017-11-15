Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpB=wq+66mfrVkMoUwyBqA2QhNQav5cipG1G-VNKO7Sig@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <6330680.LdxjlP4uri@aspire.rjw.lan>
 <4184911.zoJM7jZeH4@aspire.rjw.lan> <2261600.6h5WdhsrLe@aspire.rjw.lan> <CAPDyKFpB=wq+66mfrVkMoUwyBqA2QhNQav5cipG1G-VNKO7Sig@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Nov 2017 18:55:26 +0100
Message-ID: <CAJZ5v0gfuKaCDkJLLB8k4+oWunae_xkj9AcX0NB9DuWRsw8Ocw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] PM / core: Add helpers for subsystem callback selection
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
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 15, 2017 at 8:43 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 November 2017 at 01:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Add helper routines to find and return a suitable subsystem callback
>> during the "noirq" phases of system suspend/resume (or analogous)
>> transitions as well as during the "late" phase of system suspend and
>> the "early" phase of system resume (or analogous) transitions.
>>
>> The helpers will be called from additional sites going forward.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> With a minor nitpick, see below, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>> ---
>>
>> v2 -> v3: No changes.
>>
>> ---
>>  drivers/base/power/main.c |  196 +++++++++++++++++++++++++++++++---------------
>>  1 file changed, 136 insertions(+), 60 deletions(-)
>>
>> Index: linux-pm/drivers/base/power/main.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/main.c
>> +++ linux-pm/drivers/base/power/main.c
>> @@ -525,6 +525,14 @@ static void dpm_watchdog_clear(struct dp
>>  #define dpm_watchdog_clear(x)
>>  #endif
>>
>> +static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
>> +                                                pm_message_t state,
>> +                                                const char **info_p);
>> +
>> +static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
>> +                                               pm_message_t state,
>> +                                               const char **info_p);
>> +
>
> There is no need to declare these functions.
>
> Perhaps a following patch in the series need them, but then that
> change should add these or even better (in my opinion) just move the
> implementations and avoid the declarations all together.

Well, all of the changes in this patch are for the benefit of the
subsequent patches. :-)

I just wanted to move additional code churn noise from those patches.

Thanks,
Rafael
