Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org
Cc: tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: Re: [PATCH 3/4] x86/ioapic: Fix lost ioapic resource after hot-removal and hotadd
Date: Wed, 27 Jul 2016 10:35:12 +0800
Message-Id: <1469586912-21693-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160726202422.GF15037@localhost>
References: <20160726202422.GF15037@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, July 27, 2016 4:24 AM, Bjorn Helgaas wrote:
> On Wed, Jul 27, 2016 at 12:13:16AM +0800, Rui Wang wrote:
> > ioapic resource at 0xfecxxxxx gets lost from /proc/iomem after
> > hot-removing and then hot-adding the ioapic devices.
> >
> > After system boot, in /proc/iomem:
> > fec00000-fecfffff : PNP0003:00
> >   fec00000-fec003ff : IOAPIC 0
> >   fec01000-fec013ff : IOAPIC 1
> >   fec40000-fec403ff : IOAPIC 2
> >   fec80000-fec803ff : IOAPIC 3
> >   fecc0000-fecc03ff : IOAPIC 4
> >
> > Then hot-remove IOAPIC 2 and hot-add it again:
> > fec00000-fecfffff : PNP0003:00
> >   fec00000-fec003ff : IOAPIC 0
> >   fec01000-fec013ff : IOAPIC 1
> >   fec80000-fec803ff : IOAPIC 3
> >   fecc0000-fecc03ff : IOAPIC 4
> >
> > The range at 0xfec40000 is lost from /proc/iomem. It is because
> > handle_ioapic_add() requests resource from either PCI config BAR or
> > acpi _CRS, not both. But Intel platforms map the IOxAPIC registers
> 
> s/acpi/ACPI/
> s/ioapic/IOAPIC/ throughout
> 
> > at both the PCI config BAR (called MBAR) and the 0xfecX_YZ00 to
> > 0xfecX_Y2FF range (called ABAR). Both of the ranges should be claimed
> 
> I guess you mean the 0xfecX_YZ00-0xfecX_Y2FF range appears in _CRS?

Yes. That range appears in _CRS for each IOAPIC. I'll make it cleaner in
the commit message.

Thanks
Rui
