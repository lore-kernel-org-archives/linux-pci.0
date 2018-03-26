Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 26 Mar 2018 14:09:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180326190938.GA224629@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
 <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323084855.E3EAF247251@gemini.denx.de>
 <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
 <20180324201534.092D2247245@gemini.denx.de>
 <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com>
 <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com>
 <20180326151252.B7C8F2476FF@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326151252.B7C8F2476FF@gemini.denx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 26, 2018 at 05:12:52PM +0200, Wolfgang Denk wrote:
> In message <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com> you wrote:
> >
> > P.S. https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface
> > has a little interesting background on UEFI/CSM.
> 
> Thanks for the pointer.
> 
> I start wondering if the mainboard / BIOS vendors stop supporting
> such older hardware, if such support could be re-added in Linux?
> OK, obviously not for the boot device, but...
> 
> In U-Boot we have an x86 emulator to be able to initialize the
> on-board BIOS on (at least some) graphics cards so you can use these
> on ARM or Power architecture systems.  Do we really have to add
> similar stuff to Linux to support legacy hardware?
> 
> Would that even work?

On the MSI Z370 Tomahawk and the Gigabyte Z270X Ultra Gaming systems,
it looks like you're using what the BIOS designates as "Slot #1",
which is below an Intel Root Port (00:01.0 in both cases).  When the
SAS3444E is in that slot, we don't even see the Root Port itself.  To
fix that would require Linux to have chipset-specific knowledge about
how to enable that Root Port.  I guess it's conceivable that could be
done, but I don't know if the information required is public.  I
assume this would be controlled by some MSR or other Intel-specific
knob.

On the Gigabyte AB350 Gaming system, you're using "Slot #1" (this
comes from the Slot Capabilities register and may not match any
silk-screened labels on the board).  This is below an AMD PCIe switch,
where 04:04.0 is the Downstream Port leading to that slot.  When the
SAS3444E is in the slot, we do see the 04:04.0 Downstream Port, so we
*should* still be able to see the SAS device.

This is now all in the PCIe domain so the BIOS should be pretty much
out of the picture, and I can't explain why we don't see the SAS3444E
device.

On that system, you could try something like this to reset the
SAS3444E device and try to rescan the bus:

  # setpci -s04:04.0 BRIDGE_CONTROL.w=0x40
  # sleep 1
  # setpci -s04:04.0 BRIDGE_CONTROL.w=0x00
  # sleep 10
  # echo 1 > /sys/bus/pci/rescan

Check the dmesg log afterwards to see if anything happened.
