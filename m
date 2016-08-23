Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbcHWNjS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 09:39:18 -0400
Date: Tue, 23 Aug 2016 08:39:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823133913.GN18628@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160822211536.GE28276@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 22, 2016 at 05:15:36PM -0400, Keith Busch wrote:
> On Mon, Aug 22, 2016 at 11:55:24AM -0500, Bjorn Helgaas wrote:
> > I was imagining these LEDs as some sort of extension to the PCIe
> > hotplug model, but I think that was a mistake: logically, they have
> > nothing to do with hotplug, and the only reason they're currently
> > associated with hotplug is because you chose to re-use a bus (VPP)
> > that happens to be connected to the Slot Control registers.
> > 
> > From an architectural point of view, these LEDs seem device-specific
> > or storage-specific, with no connection to PCIe at all, so I don't
> > know why we would put them in the PCIe spec or teach pciehp about
> > them.
> 
> It's not entirely for hotplug scenarios, but it does help with user pain
> points locating devices they intend to hot remove.
> 
> I hear many vendors are for the concept of proposing new status
> and location indicator definitions to PCIe. I don't think anyone is
> suggesting the implementation requiring this patch be made standard;
> this generation of hardware is just a non-standard implementation that
> needs a quirk to help fill the gap.

I'm still not buying the hotplug connection.  The existing Attention
Indicator is already defined for the purpose of locating a device
(PCIe r3.0, sec 6.7.1.1.1):

  A blinking Attention Indicator indicates that system software is
  identifying this slot for a human operator to find. This behavior is
  controlled by a user (for example, from a software user interface or
  management tool).

The other IBPI states (fail, rebuild, predicted failure, hotspare,
degraded, failed) all seem like storage-related things without an
obvious connection to pciehp.  I would expect a kernel driver like md
to manage those states.

PCIe hotplug is designed with a 1:1:1 relationship between the
Downstream Port, the slot, and a replaceable device.  It's not obvious
to me how the IBPI signaling maps into that.  The first diagram on the
IBPI wikipedia page shows a single iPass cable (e.g., a single PCIe
slot connection) connected to an enclosure of four drives.  Each drive
has three LEDs, so we couldn't control all twelve of those LEDs using
the single Slot Control of the Downstream Port.

> Would it be more palatable if I modify the quirk such that when set,
> pciehp provides a sysfs entry allowing arbitrary user defined Slot Control
> commands? That removes the dangerous direct access from user space.

Maybe, I dunno.  So far, it still seems like an unrelated wart on pciehp.

Bjorn
