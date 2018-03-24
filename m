Return-Path: <SRS0=N1sc=GO=denx.de=wd@kernel.org>
Return-Path: <SRS0=N1sc=GO=denx.de=wd@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
    Mika Westerberg <mika.westerberg@linux.intel.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
Date: Sat, 24 Mar 2018 21:15:34 +0100
Message-Id: <20180324201534.092D2247245@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

thanks - I really appreciate your help.

In message <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> you wrote:
>
> From lspci-adaptec-29320LPE:
> 
>   00:01.0 Intel Xeon E3-1200 v5/E3-1500 Root Port
>     Bus: primary=00, secondary=01, subordinate=02
>   01:00.0 PEX 8114 PCI Express-to-PCI/PCI-X Bridge
>     Bus: primary=01, secondary=02, subordinate=02
>   02:04.0 Adaptec ASC-29320ALP U320 (rev 10)
> 
> The 00:01.0 Root Port is built into your motherboard's chipset.  The
> 01:00.0 Bridge and ASC-29320ALP devices are both on the plugin card.
> The card should have a PLX-labeled chip and an Adaptec-labeled one.

Correct.  It has an AIC-7901X (Adaptec) and a PEX8114-BD13BI G (PLX).

> >>> I don't know if this is relevant, but in Linux (Fedora 27,
> >>> 4.15.6-300.fc27.x86_64 kernel), I see these error messages:
> >>> 
> >>>   ACPI Error: [_SB_.PCI0.RP05.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
> >>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
> >>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP04.PXSX, AE_NOT_FOUND (20170831/psparse-550)
> >>>   ACPI Error: [_SB_.PCI0.RP09.PXSX] Namespace lookup failure, AE_NOT_FOUND (20170831/dswload2-191)
> >>>   ACPI Exception: AE_NOT_FOUND, During name lookup/catalog (20170831/psobject-252)
> >>>   ACPI Error: Method parse/execution failed \_SB.PCI0.RP08.PXSX, AE_NOT_FOUND (20170831/psparse-550)
> 
> This is interesting.  These methods (PXSX) are connected with PCIe
> Root Ports, and Mika's recent patch [1] also mentioned PXSX, though
> that was in the context of Thunderbolt hotplug.
> 
> It's conceivable that Linux is doing something wrong here that causes
> BIOS to leave that 00:01.0 Root Port disabled.

But is not in any case the problem at least also in the mainboard
BIOS? Should we not see the card's BIOS start messages in any case?
For example, if I wanted to boot from a disk attached to this SAS
controller, it would need to be up and running for booting Linux.

> Do these PXSX messages also occur when you boot with the working
> 29320LPE card in the slot?

Yes, they appear always - without any card, with the working Adaptec
SCSI controller, and with the non-working LSI SAS controllers.

For reference, I have uploaded the complete boot logs for these
three cases to the same directory, see files "dmesg-no-card",
"lspci-adaptec-29320LPE" and "lspci-lsi-SAS3444E" at

https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Let's say the docs present a simplified view of reality...    :-)
                      - Larry Wall in  <6940@jpl-devvax.JPL.NASA.GOV>
