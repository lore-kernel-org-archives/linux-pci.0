Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] ACPI / scan: Prefer devices without _HID/_CID for _ADR
 matching
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20161225102148.7706-1-hdegoede@redhat.com>
 <2022116.4lq1KAmrJA@aspire.rjw.lan>
 <651067e1-e87f-6dba-0b99-c158655d2086@redhat.com>
 <1816647.tOAZ7v3nRx@aspire.rjw.lan>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b9150482-cfc7-7737-923a-665d8b4ba9fe@redhat.com>
Date: Fri, 31 Mar 2017 12:39:35 +0200
MIME-Version: 1.0
In-Reply-To: <1816647.tOAZ7v3nRx@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 30-03-17 22:56, Rafael J. Wysocki wrote:
> On Sunday, January 01, 2017 09:30:06 PM Hans de Goede wrote:
>> Hi,
>>
>> On 30-12-16 02:27, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The way acpi_find_child_device() works currently is that, if there
>>> are two (or more) devices with the same _ADR value in the same
>>> namespace scope (which is not specifically allowed by the spec and
>>> the OS behavior in that case is not defined), the first one of them
>>> found to be present (with the help of _STA) will be returned.
>>>
>>> This covers the majority of cases, but is not sufficient if some of
>>> the devices in question have a _HID (or _CID) returning some valid
>>> ACPI/PNP device IDs (which is disallowed by the spec) and the
>>> ASL writers' expectation appears to be that the OS will match
>>> devices without a valid ACPI/PNP device ID against a given bus
>>> address first.
>>>
>>> To cover this special case as well, modify find_child_checks()
>>> to prefer devices without ACPI/PNP device IDs over devices that
>>> have them.
>>>
>>> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> I'm not actually sure if this is sufficient to fix the original 80860F14 uid "2"
>>> sd-controller problem on CherryTrail.  Hans, can you please check?
>>
>> Ok, just booted a kernel with this patch replacing my own attempt
>> at fixing this, and the kernel still sees and initializes the
>> mmc controller in question correctly with this patch:
>>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>
> Unfortunately, this breaks discrete graphics enumeration in
>
> https://bugzilla.kernel.org/show_bug.cgi?id=194889
>
> so can you please check if the patch below doesn't break the platform fixed by
> the above?

I've just tried this and this patch does not regress the platform fixed
by the original commit.

Regards,

Hans


>
> Thanks,
> Rafael
>
>
> ---
>  drivers/acpi/glue.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/glue.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -99,13 +99,13 @@ static int find_child_checks(struct acpi
>  		return -ENODEV;
>
>  	/*
> -	 * If the device has a _HID (or _CID) returning a valid ACPI/PNP
> -	 * device ID, it is better to make it look less attractive here, so that
> -	 * the other device with the same _ADR value (that may not have a valid
> -	 * device ID) can be matched going forward.  [This means a second spec
> -	 * violation in a row, so whatever we do here is best effort anyway.]
> +	 * If the device has a _HID returning a valid ACPI/PNP device ID, it is
> +	 * better to make it look less attractive here, so that the other device
> +	 * with the same _ADR value (that may not have a valid device ID) can be
> +	 * matched going forward.  [This means a second spec violation in a row,
> +	 * so whatever we do here is best effort anyway.]
>  	 */
> -	return sta_present && list_empty(&adev->pnp.ids) ?
> +	return sta_present && !adev->pnp.type.platform_id ?
>  			FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
>  }
>
>
