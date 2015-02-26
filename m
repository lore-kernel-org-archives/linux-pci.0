Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44052 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbBZXSr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 18:18:47 -0500
Received: by iecar1 with SMTP id ar1so22740136iec.11
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 15:18:46 -0800 (PST)
Date: Thu, 26 Feb 2015 17:18:43 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alnie <memobook80@comcast.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
Message-ID: <20150226231843.GC25765@google.com>
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net>
 <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net>
 <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
 <54EED7D2.7000205@comcast.net>
 <20150226174635.GA25765@google.com>
 <54EF74CF.7050909@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54EF74CF.7050909@comcast.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 11:32:31AM -0800, Alnie wrote:
> On 02/26/2015 09:46 AM, Bjorn Helgaas wrote:
> >On Thu, Feb 26, 2015 at 12:22:42AM -0800, Alnie wrote:

> >>	Capabilities: [100 v1] Advanced Error Reporting
> >>		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> >>MalfTLP- ECRC- UnsupReq+ ACSViol-
> >
> >This looks suspicious: the bridge logged an Unsupported Request error.
> >Let's see if we can figure out if this error is left there by BIOS or if
> >the PCI core or the driver or rdwrmem is doing something that causes it.
> >
> >Can you try this:
> >
> >   - Boot without the snd_hda_intel driver at all
> >   - Collect "lspci -vvs05:00.0" output
> 
> blacklist snd_hda_intel
> 
> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> PCI to PCIe Bridge (prog-if 00 [Normal decode])
> ...
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-

All three of your lspci outputs are identical, so it looks like the BIOS
probably left UnsupReq set.  Maybe the kernel should log that and clear it
at boot.  I sort of doubt this is the problem, but we can try clearing
those errors manually:

  lspci -vvs05:00.0
  setpci -s05:00.0 0x9a.w=0x0a		# clear UncorrErr UnsuppReq
  setpci -s05:00.0 0x104.l=0x00100000	# clear AER UnsupReq
  lspci -vvs05:00.0
  modprobe snd-hda-intel

> >   - Poke around with rdwr
> 
> (I am unfamiliar with this & hex, was trying different things,
> please correct me in case)
> 
> # ./mem -N -m -s 0xf4300000
> ./mem: request seek to 4096786432, but -198180864 returned
> F4300000:00
> # ./mem -N -m -s f4300000
> 00000000:53
> # ./mem -N -m -s f4310000
> 00000000:53
> # ./mem -N -m -s 0xf4310000
> ./mem: request seek to 4096851968, but -198115328 returned
> F4310000:FF

The first and last ones are on the right track.  The program uses strtoul()
to convert the address.  That function assumes decimal unless there's a
"0x" prefix.  So "-s f4300000" converts to zero, and "-s 0xf4300000" does
what you want.

The device is at [mem 0xf4300000-0xf4303fff], so anything in that region
should respond.  Why don't you try this, which should dump the whole
region:

  ./mem -N -m -s 0xf4300000 -l 0x4000

But what's interesting already is that you found these:

  F4300000:00
  F4310000:FF

So we got 0x00 at 0xf4300000, which means the device did respond there.
If that path to the device works, all PCI accesses to it *should* work.

Bjorn
