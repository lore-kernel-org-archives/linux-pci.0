Return-Path: <SRS0=Pusd=GQ=denx.de=wd@kernel.org>
Return-Path: <SRS0=Pusd=GQ=denx.de=wd@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
    linux-acpi@vger.kernel.org,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180326112647.GC2703@lahna.fi.intel.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> <20180325122828.7FC55247245@gemini.denx.de> <20180326112647.GC2703@lahna.fi.intel.com>
Date: Mon, 26 Mar 2018 17:00:50 +0200
Message-Id: <20180326150050.086232476FF@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Mika,

In message <20180326112647.GC2703@lahna.fi.intel.com> you wrote:
>
> > I have updated the information (lspci output, dmesg output) for all
> > three boards here:
> > 
> > https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr
> 
> Looking at the MSI Tomahawk dmesg when you have the adaptec card
> connected, the BIOS adds an additional ACPI SSDT table:
> 
> [    0.000000] ACPI: SSDT 0x000000008C039120 002611 (v02 PegSsd PegSsdt 00001000 INTL 20160422)
> 
> This is missing when LSI card is connected. There might be some sort of
> preboot protocol or whitelist that prevents the root port to be enabled
> in BIOS.
> 
> Wolfgang, could you also add acpidump output of these systems to that
> share site?

Done.

[I hope this is what you need.  Fedora does not seem to provide the
acpidump tool ready to use in any package, but I found the sources
in the kcbench package.]

All three boards behave a bit different here, but see yourself...

[What they have in common is that none works as I would like to have
it :-( ]


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I can't understand it. I can't even understand  the  people  who  can
understand it.                    - Queen Juliana of the Netherlands.
