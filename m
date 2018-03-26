Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 26 Mar 2018 08:52:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
 <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323084855.E3EAF247251@gemini.denx.de>
 <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
 <20180324201534.092D2247245@gemini.denx.de>
 <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 26, 2018 at 08:51:07AM -0500, Bjorn Helgaas wrote:
> On Sat, Mar 24, 2018 at 09:15:34PM +0100, Wolfgang Denk wrote:
> > Dear Bjorn,
> > 
> > thanks - I really appreciate your help.
> > 
> > In message <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> you wrote:
> > >
> > > From lspci-adaptec-29320LPE:
> > > 
> > >   00:01.0 Intel Xeon E3-1200 v5/E3-1500 Root Port
> > >     Bus: primary=00, secondary=01, subordinate=02
> > >   01:00.0 PEX 8114 PCI Express-to-PCI/PCI-X Bridge
> > >     Bus: primary=01, secondary=02, subordinate=02
> > >   02:04.0 Adaptec ASC-29320ALP U320 (rev 10)
> > > 
> > > The 00:01.0 Root Port is built into your motherboard's chipset.  The
> > > 01:00.0 Bridge and ASC-29320ALP devices are both on the plugin card.
> > > The card should have a PLX-labeled chip and an Adaptec-labeled one.
> > 
> > Correct.  It has an AIC-7901X (Adaptec) and a PEX8114-BD13BI G (PLX).
> > 
> > > >>> I don't know if this is relevant, but in Linux (Fedora 27,
> > > >>> 4.15.6-300.fc27.x86_64 kernel), I see these error messages:
> > > >>> 
> > > >>>   ACPI Error: [_SB_.PCI0.RP05.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
> > > >>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
> > > >>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP04.PXSX, AE_NOT_FOUND (20170831/psparse-550)
> > > >>>   ACPI Error: [_SB_.PCI0.RP09.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
> > > >>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
> > > >>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP08.PXSX, AE_NOT_FOUND (20170831/psparse-550)
> > > 
> > > This is interesting.  These methods (PXSX) are connected with PCIe
> > > Root Ports, and Mika's recent patch [1] also mentioned PXSX, though
> > > that was in the context of Thunderbolt hotplug.
> > > 
> > > It's conceivable that Linux is doing something wrong here that causes
> > > BIOS to leave that 00:01.0 Root Port disabled.
> > 
> > But is not in any case the problem at least also in the mainboard
> > BIOS? Should we not see the card's BIOS start messages in any case?
> > For example, if I wanted to boot from a disk attached to this SAS
> > controller, it would need to be up and running for booting Linux.
> 
> Oh, you're right; I forgot about that point.
> 
> I guess you've already talked to MSI support, who told you:
> 
>   These are old controllers which don't support UEFI/GOP. this
>   is the reason they don't work.  Cards which have only legacy
>   support cannot be operated in modern mainboards.
> 
> That seems like sort of a lame excuse as a consumer, but if the BIOS
> writers decided they don't want to support older adapters, I don't
> know what we can really do about it.
> 
> I searched for other reports ("GIGABYTE Z370-HD3 not detected") and
> found several that could be similar.  One suggested enabling/disabling
> CSM (UEFI compatibility support module) in the BIOS setup.  If these
> BIOSes in fact decided not to support these old cards, my guess is
> there is no CSM in them, but it's worth checking.

P.S. https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface
has a little interesting background on UEFI/CSM.
