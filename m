Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26495 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbbCTFkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Mar 2015 01:40:51 -0400
Message-ID: <550BB2DE.9020804@linux.intel.com>
Date: Fri, 20 Mar 2015 13:40:46 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	"bp @ alien8 . de" <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	"yinghai @ kernel . org" <yinghai@kernel.org>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device
 is disabled when unbinding
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com> <2835680.pSPaYk3eSL@vostro.rjw.lan> <CAErSpo4r+Brx0fgpwQ=Wr_1wxBNvuAy0cJxYBSR6hBLt=d=e8Q@mail.gmail.com> <2124988.RayodtbIxy@vostro.rjw.lan>
In-Reply-To: <2124988.RayodtbIxy@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/19 23:57, Rafael J. Wysocki wrote:
> On Thursday, March 19, 2015 09:08:38 AM Bjorn Helgaas wrote:
>> On Thu, Mar 19, 2015 at 6:29 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, March 19, 2015 03:49:33 PM Jiang Liu wrote:
>>>> On 2015/3/19 6:11, Bjorn Helgaas wrote:
>>>>> On Tue, Mar 17, 2015 at 03:37:12PM +0800, Jiang Liu wrote:
>>>>>> To support IOAPIC hot-removal, we need to release PCI interrupt resource
>>>>>> when unbinding PCI device driver. But due to historical reason,
>>>>>> /*
>>>>>>  * We would love to complain here if pci_dev->is_enabled is set, that
>>>>>>  * the driver should have called pci_disable_device(), but the
>>>>>>  * unfortunate fact is there are too many odd BIOS and bridge setups
>>>>>>  * that don't like drivers doing that all of the time.
>>>>>>  * Oh well, we can dream of sane hardware when we sleep, no matter how
>>>>>>  * horrible the crap we have to deal with is when we are awake...
>>>>>>  */
>>>>>
>>>>> Quoting the comment here (especially the last two lines) is overkill and
>>>>> obscures the real point.  The important thing is that some drivers have
>>>>> legitimate reasons for not calling pci_disable_device().
>>>> Hi Bjorn,
>>>>       Thanks for review. I will rewrite the commit message.
>>>>>> some drivers don't call pci_disable_device() when unloading, which
>>>>>> prevents us from reallocating PCI interrupt resource on reloading
>>>>>> PCI driver and causes regressions.
>>>>>
>>>>> This isn't very clear.  I can believe that "drivers not calling
>>>>> pci_disable_device()" means we don't release IRQ resources, which might
>>>>> prevent you from hot-removing an IOAPIC.
>>>>>
>>>>> But "drivers not calling pci_disable_device()" doesn't cause regressions.
>>>>>
>>>>>> So release PCI interrupt resource only if PCI device is disabled when
>>>>>> unbinding. By this way, we could support IOAPIC hot-removal on latest
>>>>>> platforms and avoid regressions on old platforms.
>>>>>
>>>>> Does this mean you can only hot-remove IOAPICs if all drivers for devices
>>>>> using the IOAPIC call pci_disable_device()?  If so, it seems sort of
>>>>> dubious that we have to rely on drivers for that.
>>>> This is a quickfix for v4.0 merging window. We will try to solve this
>>>> issue for next merging window.
>>>
>>> If that is the plan, then I'd rather revert the offending commit and try
>>> again in the next cycle.
>>>
>>> Bjorn, what do you think?
>>
>> I don't know how hard it is to just revert that one commit at this
>> point, but I would be in favor of doing that if it's feasible.
> 
> The commit reverts cleanly and reverting it won't break anything that used to
> work in 3.19 and earlier (Gerry, please let me know if that is not correct).
Yes, revert should not cause new issues.
Commit b4b55cda5874("Refine the way to release PCI IRQ resources")
is a bugfix for xen-pciback. But the bugfix causes regressions on
other platform. So it would be better to revert it and fix the issue
in another better way in next merging window.

> 
> The only adverse consequence of reverting it I can see would be that the
> IOAPIC hotplug won't work in 4.0, but it didn't work before either and
> it's supposed to be a new feature in 4.0.
IOAPIC hotplug may still work, it only causes regressions to some PCI
drivers.

> 
>> We're headed toward a real morass of changelogs for a design that
>> seems destined for overhaul.  That makes it really hard to backport
>> and rework things later.
> 
> Precisely.
Sorry for the troubles.
When designing IOAPIC hotplug, I found architect has provided suitable
hook points for IOAPIC pin usage track, so I adopted hook points in
pci_enable/disable_device(). But recent regression reports remind
me that's wrong decision, so will rework it in new way.
Thanks!
Gerry
> 
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
