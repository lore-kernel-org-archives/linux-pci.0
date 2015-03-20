Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32880 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbCTNLr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 09:11:47 -0400
Received: by qgfa8 with SMTP id a8so91966611qgf.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 06:11:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <550B8F50.3070402@linux.intel.com>
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com>
 <20150318221152.GA2495@google.com> <550A7F8D.90404@linux.intel.com>
 <2835680.pSPaYk3eSL@vostro.rjw.lan> <CAErSpo4r+Brx0fgpwQ=Wr_1wxBNvuAy0cJxYBSR6hBLt=d=e8Q@mail.gmail.com>
 <550B8F50.3070402@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Mar 2015 08:11:26 -0500
Message-ID: <CAErSpo7a9Pnxq77DSL3insZ_k1-Re5FixZ16sqbwd+mNbDxXig@mail.gmail.com>
Subject: Re: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device is
 disabled when unbinding
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 19, 2015 at 10:09 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> On 2015/3/19 22:08, Bjorn Helgaas wrote:

>> There are two other possibilities I can see:
>>
>> 1) Decide that a driver that captures the IRQ and then calls
>> pci_enable_device() is just broken, and fix those drivers to
>> re-capture the IRQ every time they call pci_enable_device().  I assume
>> you've looked at this already and concluded it's not practical?

Did you look at this or not?  I don't have any idea of the scope of the problem.

I think in general we want drivers to start from scratch whenever they
call pci_enable_device().  They should not assume that BARs are the
same, IRQs are the same, etc.  If we ever want to dynamically reassign
resources, e.g., move BARs around to accommodate new hotplugged
devices, a path involving pci_enable_device() seems a likely route of
having the drivers learn about resource changes.

>> 2) Configure the IRQ in pci_device_probe().  Then it would be
>> configured before the driver sees the device, and you could dispose of
>> it in pci_device_remove() when the driver is unbound.
> Actually I prefer solution 2 above. The key idea is to decouple
> IRQ resource allocation from pci_enabe/disable_device(), so irq
> resource will be allocated just before driver binding and will
> be released after driver unbinding.

Solution 2 does have the advantage of making it simpler for driver writers.

One disadvantage is that it *forces* us to do IRQ allocation, even
though it may not be required.  There are drivers that don't need IRQs
because they use MSI or don't need interrupts at all.  If we do IRQ
allocation before binding the driver, and the allocation fails, these
driver will no longer work even though they don't need the IRQs.

> One issue left is the way to hook driver binding/unbinding events.
> Currently pcibios_enable/disable_irq() are x86 specific, so I use
> PCI notification to hook driver binding/unbinding evetns.
> If you are OK with introducing two new weak functions
> pcibios_enable/disable_irq() into PCI core, that's obviously
> a clear solution, easier to maintain and may benefit other platforms
> too in future.
>
> So should I introduce pcibios_enable/disable_irq() into PCI core?

I think it would be better to add new weak interfaces than to use
bus_register_notifier().  New interfaces are much more explicit when
reading the code, and their ordering is very clearly defined.

Bjorn
