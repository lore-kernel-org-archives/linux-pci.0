Return-Path: <SRS0=3FyK=GR=denx.de=wd@kernel.org>
Return-Path: <SRS0=3FyK=GR=denx.de=wd@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
    Mika Westerberg <mika.westerberg@linux.intel.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180326190938.GA224629@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com> <20180324201534.092D2247245@gemini.denx.de> <20180326135107.GH210003@bhelgaas-glaptop.roam.corp.google.com> <20180326135235.GA221217@bhelgaas-glaptop.roam.corp.google.com> <20180326151252.B7C8F2476FF@gemini.denx.de> <20180326190938.GA224629@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 27 Mar 2018 15:46:27 +0200
Message-Id: <20180327134627.3BA0624077B@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

In message <20180326190938.GA224629@bhelgaas-glaptop.roam.corp.google.com> you wrote:
>
> On the MSI Z370 Tomahawk and the Gigabyte Z270X Ultra Gaming systems,
> it looks like you're using what the BIOS designates as "Slot #1",
> which is below an Intel Root Port (00:01.0 in both cases).  When the

Correct.  I always used the first available (x16) slot; on these two
boards I have Intel Core i5 processors, so I can use the on-cip
graphics and have no need for a graphics adapter, so this is really
the first PCIe x16 slot.

> On the Gigabyte AB350 Gaming system, you're using "Slot #1" (this
> comes from the Slot Capabilities register and may not match any
> silk-screened labels on the board).  This is below an AMD PCIe switch,
> where 04:04.0 is the Downstream Port leading to that slot.  When the
> SAS3444E is in the slot, we do see the 04:04.0 Downstream Port, so we
> *should* still be able to see the SAS device.

This board has a AMD Ryzen 5 1600 Six-Core Processor, so I have to
use a graphics adapter, which occupies the 1st PCIe x16 slot.  So I
used the next frree one.

> On that system, you could try something like this to reset the
> SAS3444E device and try to rescan the bus:

And now comes the next surprise:

On this board the LSI controller suddenly started working!  I get
the BIOS start message from it, and Linux detects it...

The only difference is that i have installed the kcbench package to
get at the acpidump tool:

2018-03-26T14:15:15Z INFO Installed: kcbench-data-4.4-0.1-21.fc27.noarch
2018-03-26T14:15:16Z INFO Installed: kcbench-0.3-17.fc27.noarch
2018-03-26T14:15:16Z INFO Installed: kcbench-data-0.1-21.fc27.noarch

No other changes to the hardware or software at all.  And I always
powered off the system when changing the boards, so even this makes
no difference.

Oh, and we are running at DST now, so maybe it is POM dependent :-(


I have uploaded updated lspci/dmesg/acpidump output for this new,
working case, see files

Gigabyte-AB350-Gaming-CF-lspci-lsi-sas3444e.1
Gigabyte-AB350-Gaming-CF-dmesg-lsi-sas3444e.1
Gigabyte-AB350-Gaming-CF-acpidump-lsi-sas3444e.1

On the other Gigabyte board I see tiny changes in the logs, but the
card is still not working.  New log files (sith suffix .1) also
uploaded.

Gigbyte support recommeded to "try  Other PCI devices: Legacy in
bios setup".  Good point.  Tried that on the remainin non-working
Gigabyte board.  Some difference in the acpidump, no differences in
lspci output or behaviour.  Nonworking. New log files with suffix .2

Strange...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The thing is, as you progress in the Craft,  you'll  learn  there  is
another rule... When you break rules, break 'em good and hard.
                                    - Terry Pratchett, _Wyrd Sisters_
