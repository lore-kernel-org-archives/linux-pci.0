Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <550B8F50.3070402@linux.intel.com>
Date: Fri, 20 Mar 2015 11:09:04 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
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
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com> <20150318221152.GA2495@google.com> <550A7F8D.90404@linux.intel.com> <2835680.pSPaYk3eSL@vostro.rjw.lan> <CAErSpo4r+Brx0fgpwQ=Wr_1wxBNvuAy0cJxYBSR6hBLt=d=e8Q@mail.gmail.com>
In-Reply-To: <CAErSpo4r+Brx0fgpwQ=Wr_1wxBNvuAy0cJxYBSR6hBLt=d=e8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/19 22:08, Bjorn Helgaas wrote:
> On Thu, Mar 19, 2015 at 6:29 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, March 19, 2015 03:49:33 PM Jiang Liu wrote:
>>> On 2015/3/19 6:11, Bjorn Helgaas wrote:
>>>> On Tue, Mar 17, 2015 at 03:37:12PM +0800, Jiang Liu wrote:
>>>>> To support IOAPIC hot-removal, we need to release PCI interrupt resource
>>>>> when unbinding PCI device driver. But due to historical reason,
>>>>> /*
>>>>>  * We would love to complain here if pci_dev->is_enabled is set, that
>>>>>  * the driver should have called pci_disable_device(), but the
>>>>>  * unfortunate fact is there are too many odd BIOS and bridge setups
>>>>>  * that don't like drivers doing that all of the time.
>>>>>  * Oh well, we can dream of sane hardware when we sleep, no matter how
>>>>>  * horrible the crap we have to deal with is when we are awake...
>>>>>  */
>>>>
>>>> Quoting the comment here (especially the last two lines) is overkill and
>>>> obscures the real point.  The important thing is that some drivers have
>>>> legitimate reasons for not calling pci_disable_device().
>>> Hi Bjorn,
>>>       Thanks for review. I will rewrite the commit message.
>>>>> some drivers don't call pci_disable_device() when unloading, which
>>>>> prevents us from reallocating PCI interrupt resource on reloading
>>>>> PCI driver and causes regressions.
>>>>
>>>> This isn't very clear.  I can believe that "drivers not calling
>>>> pci_disable_device()" means we don't release IRQ resources, which might
>>>> prevent you from hot-removing an IOAPIC.
>>>>
>>>> But "drivers not calling pci_disable_device()" doesn't cause regressions.
>>>>
>>>>> So release PCI interrupt resource only if PCI device is disabled when
>>>>> unbinding. By this way, we could support IOAPIC hot-removal on latest
>>>>> platforms and avoid regressions on old platforms.
>>>>
>>>> Does this mean you can only hot-remove IOAPICs if all drivers for devices
>>>> using the IOAPIC call pci_disable_device()?  If so, it seems sort of
>>>> dubious that we have to rely on drivers for that.
>>> This is a quickfix for v4.0 merging window. We will try to solve this
>>> issue for next merging window.
>>
>> If that is the plan, then I'd rather revert the offending commit and try
>> again in the next cycle.
>>
>> Bjorn, what do you think?
> 
> I don't know how hard it is to just revert that one commit at this
> point, but I would be in favor of doing that if it's feasible.
I will investigate about reverting.

> 
> We're headed toward a real morass of changelogs for a design that
> seems destined for overhaul.  That makes it really hard to backport
> and rework things later.
> 
> From the revised changelog:
> 
>>> When suspending, PCI
>>> device driver may call pci_disable_device() and eventually release
>>> IOAPIC pin. When resuming, PCI device driver call pci_enable_device()
>>> and reallocating IOAPIC pin. Since v3.19, IOAPIC driver dynamically
>>> allocates IRQ number for IOAPIC pin. So when resuming, a different
>>> IRQ number may assigned, which breaks some PCI drivers' suspend/resume
>>> implementation.
> 
> It seems like you're really standing on your head to make this
> situation work, and I think the result is too complicated and
> error-prone.  One test is to see whether you can write a short, simple
> description of how driver writers need to manage IRQs with respect to
> probe/remove/suspend/remove.
> 
> There are two other possibilities I can see:
> 
> 1) Decide that a driver that captures the IRQ and then calls
> pci_enable_device() is just broken, and fix those drivers to
> re-capture the IRQ every time they call pci_enable_device().  I assume
> you've looked at this already and concluded it's not practical?
> 
> 2) Configure the IRQ in pci_device_probe().  Then it would be
> configured before the driver sees the device, and you could dispose of
> it in pci_device_remove() when the driver is unbound.
Actually I prefer solution 2 above. The key idea is to decouple
IRQ resource allocation from pci_enabe/disable_device(), so irq
resource will be allocated just before driver binding and will
be released after driver unbinding.

One issue left is the way to hook driver binding/unbinding events.
Currently pcibios_enable/disable_irq() are x86 specific, so I use
PCI notification to hook driver binding/unbinding evetns.
If you are OK with introducing two new weak functions
pcibios_enable/disable_irq() into PCI core, that's obviously
a clear solution, easier to maintain and may benefit other platforms
too in future.

So should I introduce pcibios_enable/disable_irq() into PCI core?
Thanks!
Gerry

> 
> Does either of those make sense?
> 
> Bjorn
> 
