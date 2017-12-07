Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpyfMTw9vdSDHxarZquSRA9zU9aMdb-pkzhMWKrFGxayw@mail.gmail.com>
References: <3600031.yTsliOITBg@aspire.rjw.lan> <CAPDyKFpyfMTw9vdSDHxarZquSRA9zU9aMdb-pkzhMWKrFGxayw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Dec 2017 22:17:42 +0100
Message-ID: <CAJZ5v0j=61dC0+pzpwcZ3zzH0UotfqGycDH833gK-4s+fLWmsA@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Avoid excess pm_runtime_enable() calls in device_resume()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 7, 2017 at 8:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 7 December 2017 at 03:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Middle-layer code doing suspend-time optimizations for devices with
>> the DPM_FLAG_SMART_SUSPEND flag set (currently, the PCI bus type and
>> the ACPI PM domain) needs to make the core skip ->thaw_early and
>> ->thaw callbacks for those devices in some cases and it sets the
>> power.direct_complete flag for them for this purpose.
>>
>> However, it turns out that setting power.direct_complete outside of
>> the PM core is a bad idea as it triggers an excessive invocation of
>> pm_runtime_enable() in device_resume().
>
> Do we need to clarify the comment about the flag in pm.h?
>
> Or is "/* Owned by the PM core */" sufficient?

That should be sufficient (and I sort of tried to ignore it ...).

>>
>> For this reason, provide a helper to clear power.is_late_suspended
>> and power.is_suspended to be invoked by the middle-layer code in
>> question instead of setting power.direct_complete and make that code
>> call the new helper.
>>
>> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
>> Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro,org>

Thanks!
