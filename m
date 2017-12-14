Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <168050887.sZlTFXWCmO@aspire.rjw.lan>
 <5115041.vUGA3IjvdM@aspire.rjw.lan>
 <alpine.DEB.2.20.1712141648190.4998@nanos>
 <11146834.AWaDHrVcmB@aspire.rjw.lan>
From: Maarten Lankhorst <dev@mblankhorst.nl>
Message-ID: <2b0e471b-db62-831e-5264-8fcb41169cce@mblankhorst.nl>
Date: Thu, 14 Dec 2017 17:17:52 +0100
MIME-Version: 1.0
In-Reply-To: <11146834.AWaDHrVcmB@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Op 14-12-17 om 16:54 schreef Rafael J. Wysocki:
> On Thursday, December 14, 2017 4:52:22 PM CET Thomas Gleixner wrote:
>> On Thu, 14 Dec 2017, Rafael J. Wysocki wrote:
>>> The problem here is that pci_pm_thaw_noirq() calls pci_restore_state() which
>>> in fact requires the device to be in D0, so the caller should put it into
>>> D0 instead of trying to "update" its power state.
>>>
>>> [Note that the PCI layer doesn't put devices into low-power states during the
>>> hibernation's "freeze" transition, but drivers can legitimately do that in
>>> their "freeze" callbacks which was overlooked in that code and that's what
>>> i915 does.]
>>>
>>> So IMO what we need is the change below.  I'm going to test it shortly,
>>> but please give it a go too.
>> So now this looks more reasonable:
>>
>>   irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
>>   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a 
>>   __pci_write_msi_msg: Not written
>>   ...
>>   device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [thaw]
>>   pci_pm_thaw_noirq <-dpm_run_callback
>>   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a 
>>   device_pm_callback_end: i915 0000:00:02.0, err=0
>>   ...
>>   resume_irqs: Resume 125
>>   ...
>>   irq_handler_entry: irq=125 name=i915
> Cool.
>
> Let me respin it with a changelog etc then.
>
> Thanks,
> Rafael
>
>
The machine I was using for reproducing the bug appears to be fixed with this patch, so I now sent
it to intel's trybot for results.

https://patchwork.freedesktop.org/series/35367/

Thanks for looking at the bug!

~Maarten
