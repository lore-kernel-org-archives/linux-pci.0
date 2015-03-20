Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device is disabled when unbinding
Date: Fri, 20 Mar 2015 15:39:44 +0100
Message-ID: <43248547.RZiTzvDUtf@vostro.rjw.lan>
In-Reply-To: <550BB2DE.9020804@linux.intel.com>
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com> <2124988.RayodtbIxy@vostro.rjw.lan> <550BB2DE.9020804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 20, 2015 01:40:46 PM Jiang Liu wrote:
> On 2015/3/19 23:57, Rafael J. Wysocki wrote:
> > On Thursday, March 19, 2015 09:08:38 AM Bjorn Helgaas wrote:
> >> On Thu, Mar 19, 2015 at 6:29 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> On Thursday, March 19, 2015 03:49:33 PM Jiang Liu wrote:
> >>>> On 2015/3/19 6:11, Bjorn Helgaas wrote:
> >>>>> On Tue, Mar 17, 2015 at 03:37:12PM +0800, Jiang Liu wrote:
> >>>>>> To support IOAPIC hot-removal, we need to release PCI interrupt resource
> >>>>>> when unbinding PCI device driver. But due to historical reason,
> >>>>>> /*
> >>>>>>  * We would love to complain here if pci_dev->is_enabled is set, that
> >>>>>>  * the driver should have called pci_disable_device(), but the
> >>>>>>  * unfortunate fact is there are too many odd BIOS and bridge setups
> >>>>>>  * that don't like drivers doing that all of the time.
> >>>>>>  * Oh well, we can dream of sane hardware when we sleep, no matter how
> >>>>>>  * horrible the crap we have to deal with is when we are awake...
> >>>>>>  */
> >>>>>
> >>>>> Quoting the comment here (especially the last two lines) is overkill and
> >>>>> obscures the real point.  The important thing is that some drivers have
> >>>>> legitimate reasons for not calling pci_disable_device().
> >>>> Hi Bjorn,
> >>>>       Thanks for review. I will rewrite the commit message.
> >>>>>> some drivers don't call pci_disable_device() when unloading, which
> >>>>>> prevents us from reallocating PCI interrupt resource on reloading
> >>>>>> PCI driver and causes regressions.
> >>>>>
> >>>>> This isn't very clear.  I can believe that "drivers not calling
> >>>>> pci_disable_device()" means we don't release IRQ resources, which might
> >>>>> prevent you from hot-removing an IOAPIC.
> >>>>>
> >>>>> But "drivers not calling pci_disable_device()" doesn't cause regressions.
> >>>>>
> >>>>>> So release PCI interrupt resource only if PCI device is disabled when
> >>>>>> unbinding. By this way, we could support IOAPIC hot-removal on latest
> >>>>>> platforms and avoid regressions on old platforms.
> >>>>>
> >>>>> Does this mean you can only hot-remove IOAPICs if all drivers for devices
> >>>>> using the IOAPIC call pci_disable_device()?  If so, it seems sort of
> >>>>> dubious that we have to rely on drivers for that.
> >>>> This is a quickfix for v4.0 merging window. We will try to solve this
> >>>> issue for next merging window.
> >>>
> >>> If that is the plan, then I'd rather revert the offending commit and try
> >>> again in the next cycle.
> >>>
> >>> Bjorn, what do you think?
> >>
> >> I don't know how hard it is to just revert that one commit at this
> >> point, but I would be in favor of doing that if it's feasible.
> > 
> > The commit reverts cleanly and reverting it won't break anything that used to
> > work in 3.19 and earlier (Gerry, please let me know if that is not correct).
> Yes, revert should not cause new issues.
> Commit b4b55cda5874("Refine the way to release PCI IRQ resources")
> is a bugfix for xen-pciback. But the bugfix causes regressions on
> other platform. So it would be better to revert it and fix the issue
> in another better way in next merging window.

OK, I've queued up a revert of b4b55cda5874 and I'm going to push it to Linus
for 4.0-rc5 later today.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
