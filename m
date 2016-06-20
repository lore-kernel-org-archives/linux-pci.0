Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 20 Jun 2016 11:10:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160620081057.GV1739@lahna.fi.intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461919919-120102-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160617204824.GB10416@localhost>
 <20160617213209.GA1927@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160617213209.GA1927@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 11:32:09PM +0200, Lukas Wunner wrote:
> On Fri, Jun 17, 2016 at 03:48:24PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 29, 2016 at 11:51:59AM +0300, Mika Westerberg wrote:
> [snip]
> > > +
> > > +	/*
> > > +	 * Prevent runtime PM if the port is advertising support for PCIe
> > > +	 * hotplug. Otherwise the BIOS hotplug SMI code might not be able
> > > +	 * to enumerate devices behind this port properly (the port is
> > > +	 * powered down preventing all config space accesses to the
> > > +	 * subordinate devices). We can't be sure for native PCIe hotplug
> > > +	 * either so prevent that as well.
> > 
> > Can we wordsmith this comment a bit?  I'm not sure what "BIOS hotplug
> > SMI code" even is or why it is relevant.  And it seems x86-centric so
> > may not apply to other arches.
> 
> The comment pertains to:
> https://bugzilla.kernel.org/show_bug.cgi?id=53811
> 
> It was discussed on April 12/13:
> https://patchwork.kernel.org/patch/8782801/
> 
> Executive summary:
> On non-Macs, Thunderbolt is driven by the firmware in System Management
> Mode, on hotplug the CPU receives a Sytem Management Interrupt (SMI) and
> jumps to SMM code. This doesn't work reliably if the hotplug port has
> been transitioned to D3hot, the SMM code tries to access config space
> of hotplugged devices (not possible if port is in D3hot) and is apparently
> too dumb to check if the port is in D3hot and wake it up.

That's the best guess what happens on non-Macs.

Bjorn, do you want me to update the comment to open up what SMI means
and maybe add better explanation?

> On Macs, Thunderbolt is not driven by the firmware except immediately on
> boot: It is initially set up by an EFI driver, but once ExitBootServices
> has been called, the OS is responsible. Therefore on Macs the hotplug
> ports may be suspended to D3hot just fine. This is done by patch
> [08/13] of my series "Runtime PM for Thunderbolt on Macs".
> 
> > 
> > > +	 */
> > > +	if (!dev->is_hotplug_bridge) {
> > 
> > Your changelog mentions ACPI hotplug (I assume this means acpiphp).
> > Would it be sufficient to prevent runtime PM when we're using acpiphp?
> > That would be more selective and would avoid penalizing non-ACPI
> > platforms and newer systems that use native pciehp.
> > 
> > PCIe r3.0, sec 6.7.3.4 says a port should generate a wakeup event
> > using PME on hotplug events that occur when the port is in D1, D2, or
> > D3hot (it doesn't mention D3cold).  Is that relevant here?  Is there a
> > way to control which D-states we use based on which ones can assert
> > PME?
> 
> This was discussed between April 18 and April 21, please refer to
> the above-linked patchwork entry.
> 
> I had done some tests and the result was:
> "A hotplug port may go to D3hot and will still generate interrupts on
> hotplug, but all its parent ports are *not* allowed to go to D3hot
> because otherwise the hotplug interrupts will no longer come through.
> The algorithm in pci_bridge_d3_update() and pci_dev_check_d3cold()
> needs to be amended to take that into account. Hm, it's nontrivial
> I guess, allowing bridge_d3 = true for the lowest hotplug bridge in a
> hierarchy but not for anything above?"
> 
> Mika's reply was:
> "If we need to do things like that, it will get pretty complex and we
> still cannot be sure whether hotplug works. I think it is safer to go
> back to what I already had and disable runtime PM from such ports."

Indeed that seems to be the most reliable way.

In addition it may be possible to relax this a bit more like:

 - For ACPI hotplug bridges we disable runtime PM like we are doing
   currently.

 - For native PCIe ports supporting hotplug, enable runtime PM and call
   pci_d3cold_disable() in pcie_portdrv_probe() which allows the port to
   go into D3hot.

But I think it may be better to do that separately after v4.8-rc1 is
released :)
