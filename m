Return-Path: <SRS0=4zVJ=JQ=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=4zVJ=JQ=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180629191930.GA40928@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <2518711.SfHWAsyaFM@aspire.rjw.lan>
 <20180629191930.GA40928@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 30 Jun 2018 23:15:33 +0200
Message-ID: <CAJZ5v0gmfVWA51Rxk8=veA5UmFD4rCEUba7fq=SwTVY-WDjofQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	n0000b.n000b@gmail.com, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 9:19 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jun 29, 2018 at 10:34:40AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
>> handling for devices with no callbacks) introduced a system suspend
>> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
>> port) to stay in D3 over suspend-to-RAM, which is a side effect of
>> setting power.direct_complete for the children of that bridge that
>> have no PM callbacks.
>>
>> On the majority of systems PCI bridges are not allowed to be
>> runtime-suspended (the power/control sysfs attribute is set to "on"
>> for them by default), but user space can change that setting and if
>> it does so and a given bridge has no children with PM callbacks, the
>> direct_complete optimization will be applied to it and it will stay
>> in suspend over system suspend.  Apparently, that confuses the
>> platform firmware on the affected machine and that may very well
>> happen elsewhere, so avoid the direct_complete optimization for
>> PCI bridges with no drivers (if there is a driver, it should take
>> care of the PM handling) on suspend-to-RAM altogether (that should
>> not matter for suspend-to-idle as platform firmware is not involved
>> in it).
>>
>> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
>> Reported-by: n0000b.n000b@gmail.com
>> Tested-by: n0000b.n000b@gmail.com
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Make the patch work for PCI bridges without ACPI companion objects.
>>
>> Since that doesn't really change the idea etc, but only makes the check
>> to be made earlier, I've added the Reviewed-by and Acked-by tags given to
>> the previous version.  If that's not right, please let me know.
>
> Keeping my ack is fine, and I assume you'll apply this.

I will, thanks!

> It would be nice to see that ACPI spec reference (the spec version and
> section number, not necessarily all the text) in the changelog or
> maybe even a comment in the code.

OK
