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
In-reply-to: <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> <20180324201534.092D2247245@gemini.denx.de> <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 26 Mar 2018 17:09:27 +0200
Message-Id: <20180326150927.9BFA72476FF@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

In message <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com> you wrote:
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

What makes me wonder is why the Adaptec card behaves different here
- it is as old as the LSI controllers and certainly has no UEFI
compatible BIOS either.

> I searched for other reports ("GIGABYTE Z370-HD3 not detected") and
> found several that could be similar.  One suggested enabling/disabling

I've seen these, too. Those that looked reliable were mostly about
graphics cards, though, and recent ones as well.

> CSM (UEFI compatibility support module) in the BIOS setup.  If these
> BIOSes in fact decided not to support these old cards, my guess is
> there is no CSM in them, but it's worth checking.

At least it is not mentioned in the documentation, and I cannot find
any settings in the BIOS where I could switch off UEFI.

> Otherwise, I think I'm out of ideas.  I don't think we've seen
> anything yet that indicates a Linux issue, although maybe Mika will
> come up with something from the acpidumps.

Agreed.  Any information I could use for communication with the
motherboard vendors would be helpful.

What I cannot understand is why I am apparently one of the first
ones to run into such an issue?  OK, SAS controllers is more server
stuff, and server mainboards are apparently more conservative in
their settings.  But still...

Thanks!

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Copy from one, it's plagiarism; copy from two, it's research.
