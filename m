Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 23 Mar 2018 23:47:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
 <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323084855.E3EAF247251@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180323084855.E3EAF247251@gemini.denx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mika, Rafael, linux-acpi]
[I cobbled this together from our earlier conversation to try to give
context for the new additions]

On Fri, Mar 23, 2018 at 09:48:55AM +0100, Wolfgang Denk wrote:
> In message <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> Bjorn wrote:
>> Wolfgang Denk originally wrote:
>>> Both on a GIGABYTE Z370-HD3 and on a MSI Z370 TOMAHAWK mainboard
>>> neither of my LSI SAS controllers (SAS3444 E PCIe x4 and
>>> SAS3442E-R PCIe x4) gets detected.  Not by the system BIOS, there
>>> is not messages from the SAS Controller BIOS, Linux does not see
>>> it in the PCI bus scan - nothing.  Both controllers work find in
>>> older mainboards.
>>>
>>> I asked MSI support, who told me:
>>>
>>>   These are old controllers which don't support UEFI/GOP. this is
>>>   the reason they don't work.  Cards which have only legacy
>>>   support cannot be operated in modern mainboards.
>>
>> That doesn't make sense to me.  Maybe these controllers have option
>> ROMs that aren't compatible with UEFI (though even that sounds
>> unlikely to me).  But even in that case, I would expect the card to
>> at least be visible in PCI config space, because that's needed even
>> to read the option ROM from the card.
> 
> I speculate that, like on some graphics cards, the card BIOS needs
> to run to initialize for example on-board memory etc., before the
> card becomes realy visible to the rest of the system?

We can't run the card BIOS unless the card responds to the config
reads we use to enumerate the device.

>>> I also have a PCIe x 1 Adaptect SCSI controller (29320LPE,
>>> firmware version v4.31.4 of 2007) which certainly never heard of
>>> UEFI/GOP before, and this is working fine: I see the BIOS messages
>>> when it does the SCSI bus scan, I see the initialization under
>>> Linux, and I can access the SCSI devices under Linux.
>>> ...
>>>
>> With the SAS3444 in the system, I wonder the port leading to that
>> slot is disabled or not negotiating the link for some reason.  Can
>> you collect "lspci -vvv" output with the working card and with one
>> of the non-working cards?
> 
> Done.  See below.

>From lspci-adaptec-29320LPE:

  00:01.0 Intel Xeon E3-1200 v5/E3-1500 Root Port
    Bus: primary=00, secondary=01, subordinate=02
  01:00.0 PEX 8114 PCI Express-to-PCI/PCI-X Bridge
    Bus: primary=01, secondary=02, subordinate=02
  02:04.0 Adaptec ASC-29320ALP U320 (rev 10)

The 00:01.0 Root Port is built into your motherboard's chipset.  The
01:00.0 Bridge and ASC-29320ALP devices are both on the plugin card.
The card should have a PLX-labeled chip and an Adaptec-labeled one.

In lspci-lsi-SAS3444E, the 00:01.0 Root Port doesn't appear at all, so
it must be disabled, which means we can't reach the card in that slot.
Linux doesn't know how to enable the Root Port directly (it requires
chipset-specific knowledge, so it's done by the BIOS).

>>> I don't know if this is relevant, but in Linux (Fedora 27,
>>> 4.15.6-300.fc27.x86_64 kernel), I see these error messages:
>>> 
>>>   ACPI Error: [_SB_.PCI0.RP05.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
>>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
>>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP04.PXSX, AE_NOT_FOUND (20170831/psparse-550)
>>>   ACPI Error: [_SB_.PCI0.RP09.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
>>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
>>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP08.PXSX, AE_NOT_FOUND (20170831/psparse-550)

This is interesting.  These methods (PXSX) are connected with PCIe
Root Ports, and Mika's recent patch [1] also mentioned PXSX, though
that was in the context of Thunderbolt hotplug.

It's conceivable that Linux is doing something wrong here that causes
BIOS to leave that 00:01.0 Root Port disabled.

Do these PXSX messages also occur when you boot with the working
29320LPE card in the slot?

> > You could try locating the port leading to the slot and using setpci
> > to reset its secondary bus, then using /sys/bus/pci/rescan to rescan
> > the bus.
> 
> Sorry, I need help here.  Which options/parameters are needed to
> setpci to do that?

This idea won't work because the port leading to the slot isn't visible at
all.

> The log files are available here:
> 
> 	https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr

[1] https://lkml.kernel.org/r/20180212105523.15984-1-mika.westerberg@linux.intel.com
