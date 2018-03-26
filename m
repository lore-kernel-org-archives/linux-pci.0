Return-Path: <SRS0=Pusd=GQ=denx.de=wd@kernel.org>
Return-Path: <SRS0=Pusd=GQ=denx.de=wd@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
    Mika Westerberg <mika.westerberg@linux.intel.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> <20180324201534.092D2247245@gemini.denx.de> <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com> <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 26 Mar 2018 17:12:52 +0200
Message-Id: <20180326151252.B7C8F2476FF@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

In message <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com> you wrote:
>
> P.S. https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface
> has a little interesting background on UEFI/CSM.

Thanks for the pointer.

I start wondering if the mainboard / BIOS vendors stop supporting
such older hardware, if such support could be re-added in Linux?
OK, obviously not for the boot device, but...

In U-Boot we have an x86 emulator to be able to initialize the
on-board BIOS on (at least some) graphics cards so you can use these
on ARM or Power architecture systems.  Do we really have to add
similar stuff to Linux to support legacy hardware?

Would that even work?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"I didn't know it was impossible when I did it."
