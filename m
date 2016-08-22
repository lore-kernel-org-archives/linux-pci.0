Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 22 Aug 2016 17:15:36 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160822211536.GE28276@localhost.localdomain>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160822165524.GC18628@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 22, 2016 at 11:55:24AM -0500, Bjorn Helgaas wrote:
> I was imagining these LEDs as some sort of extension to the PCIe
> hotplug model, but I think that was a mistake: logically, they have
> nothing to do with hotplug, and the only reason they're currently
> associated with hotplug is because you chose to re-use a bus (VPP)
> that happens to be connected to the Slot Control registers.
> 
> From an architectural point of view, these LEDs seem device-specific
> or storage-specific, with no connection to PCIe at all, so I don't
> know why we would put them in the PCIe spec or teach pciehp about
> them.

It's not entirely for hotplug scenarios, but it does help with user pain
points locating devices they intend to hot remove.

I hear many vendors are for the concept of proposing new status
and location indicator definitions to PCIe. I don't think anyone is
suggesting the implementation requiring this patch be made standard;
this generation of hardware is just a non-standard implementation that
needs a quirk to help fill the gap.

Would it be more palatable if I modify the quirk such that when set,
pciehp provides a sysfs entry allowing arbitrary user defined Slot Control
commands? That removes the dangerous direct access from user space.
