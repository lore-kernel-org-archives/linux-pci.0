Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Mon, 14 Nov 2016 13:10:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Check for PCIe capabilities change after
 resume
Message-ID: <20161114121021.GB9938@wunner.de>
References: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161110231808.GA8155@wunner.de>
 <20161111002448.GC12055@bhelgaas-glaptop.roam.corp.google.com>
 <20161111064417.GA8178@wunner.de>
 <20161111154919.GA8484@wunner.de>
 <20161111182831.GA9868@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111182831.GA9868@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 12:28:31PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2016 at 04:49:19PM +0100, Lukas Wunner wrote:
> I'd love to be proven wrong, but I don't believe it's a silicon bug.
> All we have is Yinghai's vague assertion with no erratum and no
> details to back it up.
> 
> As I read it, the response Len got from the validation team (comment
> #22) does not confirm a silicon bug.  It merely restates the fact that
> the PCIe spec requires that Presence Detect State be hardwired to 1b
> if Slot Implemented is 0b (PCIe spec r3.0, sec 7.8.11).  It also
> quotes this language from an Intel spec:
> 
>   Slot Implemented (SI) - R/WO. Indicates whether the root port is
>   connected to a slot.  Slot support is platform specific.  BIOS
>   programs this field, and it is maintained until a platform reset.
> 
> I found this in the "Intel 8 Series/C220 Series Chipset Family
> Platform Controller Hub (PCH) Datasheet", May 2014, sec 19.1.24.
> Technically this spec actually covers the Dell [8086:9c10] device, not
> the MacBook Pro [8086:8c10] device, but the Intel validation folks say
> it applies to the Dell as well.
> 
> That suggests to me that it's a Dell BIOS bug: BIOS should have
> programmed Slot Implemented the same way for initial boot and for
> resume, but it did not.

Hm, sounds plausible.


> We could do a quirk for [8086:9c10] as long as it was qualified by
> some sort of DMI check.  I don't think we could turn off hotplug for
> all [8086:9c10] root ports.  The data I see says the hardware is
> working per spec, and it's consistent with the PCIe spec.
> 
> I do like the idea of a quirk much more than mucking around in pciehp.
> However, I think we still should account for the PCI_EXP_FLAGS_SLOT
> change somehow.  If we do nothing, the accessors will still assume the
> slot registers exist after resume, but the hardware will return
> different results when we read them (PCIe sec 7.8 says that except for
> Presence Detect State, the slot registers should be hardwired to zero
> if Slot Implemented is zero).
> 
> Slot Implemented is defined as "R/WO".  The Intel spec (sec 9) says it
> becomes read-only after the first write.  If the BIOS didn't write it,
> I wonder if an OS quirk that runs after resume could still write it,
> or if there's some other locking mechanism involved.  If an OS quirk
> could set Slot Implemented, the way it was at initial boot, everything
> should just work.  Presence Detect State (sec 19.1.33) should then be
> 0b, indicating the slot is empty, so pciehp wouldn't try to bring up
> the link.

Len could try "setpci -s 00:1c.0 42.w=142" after resume to set the
Slot Implemented bit.

Then use "setpci -s 00:1c.0 42.w" to test if the bit was written.

If this works, it could go into a DECLARE_PCI_FIXUP_RESUME_EARLY() quirk.

If this doesn't work, the DECLARE_PCI_FIXUP_HEADER() would have to clear
not just the is_hotplug_bridge bit (to prevent pciehp from binding) but
also the Slot Implemented bit in the cached pcie_flags_reg word.

Thanks,

Lukas
