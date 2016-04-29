Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Apr 2016 18:31:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
Message-ID: <20160429233119.GA10197@localhost>
References: <57223D46.7070102@suse.de>
 <20160428180641.GA25125@localhost>
 <57228317.1030808@suse.de>
 <20160429134126.GA949@localhost>
 <CAKv+Gu-4vqT-tQXdwJbLV0r3FhtrYk=TOWxDYS6LjG_BNf=b_A@mail.gmail.com>
 <20160429200609.GA28261@localhost>
 <35998183-0322-49D4-91CD-4D441577C44F@linaro.org>
 <5723C956.4040907@suse.de>
 <20160429213751.GB5359@localhost>
 <5723D7AF.3080108@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5723D7AF.3080108@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matt, because I'm out of my depth in this UEFI stuff]

On Fri, Apr 29, 2016 at 11:52:47PM +0200, Alexander Graf wrote:
> On 29.04.16 23:37, Bjorn Helgaas wrote:
> > On Fri, Apr 29, 2016 at 10:51:34PM +0200, Alexander Graf wrote:

> >> I think the only thing we can really take as granted is the physical
> >> address we receive. Any efi device topology may be as implementation
> >> dependent as your firmware vendor wants to it to be.
> >>
> >> So couldn't we just try to see whether the efifb is within a pci mmio
> >> window? We could then go through all devices on it, search for
> >> overlapping BAR allocations and know the device. From there it would
> >> just be a matter of officially reserving the region - or setting the
> >> resource to FIXED, right?
> > 
> > You could do something like a quirk that ran on every device after
> > reading the BARs.  Then you could see if any of the device's resources
> > contain the framebuffer address, and if so, set the FIXED bit for that
> > resource.  Or you could save the pci_dev and the BAR number and make
> > the framebuffer driver actually claim that device.  That would have
> > the advantage of cleaner ownership and allowing the core to reassign
> > it if necessary.
> 
> Unfortunately the framebuffer driver gets initialized after the BARs got
> reassigned, so that wouldn't work :).

Quirks (fixups) can run at several different times, including before
we read the BARs, after we read them but before any reassignment, etc.
I'll attach a call graph of the enumeration process (somewhat out of
date now, but enough to show the fixup points).  If we went this
route, a header quirk (DECLARE_PCI_FIXUP_HEADER) would do what we
need.

> Can you point me to the code that does "read[ing] the BARs"? So far my
> impression was that we don't even try to read out the current BAR values
> from pci config space, but I can't claim I fully grasp the Linux pci
> code quite yet.

The efifb.c driver doesn't do anything at all with PCI (it includes
linux/pci.h, but probably doesn't need it).  That's part of what I'm
suggesting -- if it *did* register as a PCI device driver, then it
would look at pci_dev->resource[n], which is populated by the PCI
core based on the BAR values.

> > It would be a lot nicer if UEFI told us which device was the console.
> > We can't figure this out from the ConOut variable or the HCDP or PCDP
> > table or something?
> 
> I guess you could try to look at the device path for the GOP handle, but
> I'm not sure any layout of the device paths is mandated by the spec. For
> all I know a valid implementation could just claim the GOP interface
> fell from the skies and it'd be legitimate. But I'm happy to stand
> corrected if someone points me to the respective part of the spec.

Is ConOut what you're after?  I.e., is the whole point of this
exercise to get a framebuffer driver attached to the device that was
the firmware console?  I would think the ConOut path should be
decodable -- it has to tell you how to navigate the interconnect from
the CPU to the device.  But I don't know how to do it.

It looks like on x86, at least, setup_gop32()/setup_gop64() might be
extracting the framebuffer address from the ConOut device and stuffing
it into screen_info, which is what efifb.c later looks at (maybe this
is what Ard was referring to).

> I suppose HCDP and PCDP are ACPI tables? We can't rely on those :).
> AArch64 systems can (and some do) boot perfectly fine without any ACPI
> tables exposed via uEFI. And the less we have to marry ACPI with uEFI
> the happier I am - uEFI seems like a pretty nice path towards
> standardized booting while ACPI was quite a nightmare every time I
> looked at it so far ;).

HCDP/PCDP was from DIG64, originally for ia64, but I can't find a copy
of the spec anymore.  The http://www.dig64.org/specifications/ pointer
in pcdp.h appears broken.  So forget I brought this up; this looks dead.

Bjorn


PCI enumeration call graph:

  pci_scan_root_bus
    pci_create_root_bus
      pci_alloc_host_bridge
      device_register(pci_host_bridge)
      device_register(pci_bus)
      pcibios_add_bus(pci_bus)                  # pcibios

    pci_scan_child_bus
      pci_scan_slot
        pci_scan_single_device
          pci_scan_device
            pci_alloc_dev
            pci_setup_device
              printk("[%04x:%04x] type ...")
              pci_fixup_device(pci_fixup_early) # fixup
              PCI_HEADER_TYPE_NORMAL:
                pci_read_irq
                pci_read_bases                  # <-- read BARs
              PCI_HEADER_TYPE_BRIDGE:
                pci_read_irq
                pci_read_bases
              PCI_HEADER_TYPE_CARDBUS:
                pci_read_irq
                pci_read_bases
          pci_device_add
            pci_fixup_device(pci_fixup_header)  # fixup
            pci_reassigndev_resource_alignment
            pci_init_capabilities
            pcibios_add_device                  # pcibios
            device_add
        pcie_aspm_init_link_state

      for (pass = 0; pass < 2; pass++)
        list_for_each_entry
          pci_scan_bridge
            pci_add_new_bus
              pci_alloc_child_bus
                pci_alloc_bus
                dev_set_name(pci_bus)
                device_register(pci_bus)
                pcibios_add_bus                 # pcibios
                pci_create_legacy_files
            pci_scan_child_bus                  # recursive

    pci_bus_add_devices
      list_for_each_entry(dev, &bus->devices, ...)
        pci_bus_add_device
          pci_fixup_device(pci_fixup_final)             # fixup
          pci_create_sysfs_dev_files
          pci_proc_attach_device
      list_for_each_entry(dev, &bus->devices, ...)
        pci_bus_add_devices(dev->subordinate)           # recursive

  pci_assign_unassigned_resources                       # from arch code
    list_for_each_entry(..., &pci_root_buses, ...)
      pci_assign_unassigned_root_bus_resources          # <-- assignment
        __pci_bus_size_bridges
          pci_bridge_check_ranges
            pci_read_config_word(..., PCI_IO_BASE, ...)
            pci_read_config_word(..., PCI_PREF_MEMORY_BASE, ...)

  <driver>
    pci_enable_device
      pci_enable_device_flags(MEM | IO)
        pci_enable_bridge(pci_upstream_bridge)
          pci_enable_bridge(pci_upstream_bridge)          # recursive
          pci_enable_device
          pci_set_master
        do_pci_enable_device
          pci_set_power_state(D0)
          pcibios_enable_device                           # pcibios
          pci_fixup_device(pci_fixup_enable)              # fixup
