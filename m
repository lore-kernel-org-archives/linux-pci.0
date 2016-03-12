Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35446 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbcCLEE6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2016 23:04:58 -0500
MIME-Version: 1.0
In-Reply-To: <CA+55aFwhMWDa4=7x_AgH34Z2US+gyuHT_-=S+vwkZAbkHRm10Q@mail.gmail.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160308174558.GC19869@localhost>
	<CALCETrUHEmFoO9dYY0xbjLiLfCJQCxG7h60dkOuCMMOKonytpw@mail.gmail.com>
	<20160311232920.GA27552@localhost>
	<CALCETrV4D2Kzn=6ags5tAP+ortjFpeeNEKW-91UHsF=UA5bN+g@mail.gmail.com>
	<CA+55aFwhMWDa4=7x_AgH34Z2US+gyuHT_-=S+vwkZAbkHRm10Q@mail.gmail.com>
Date: Fri, 11 Mar 2016 23:04:57 -0500
Message-ID: <CADnq5_PvVpQpWRTNo-gUpF=0ExJNczpemG0jnNaNM+mgCDj4_A@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] PCI: Rework shadow ROM handling
From: Alex Deucher <alexdeucher@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	=?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 8:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 11, 2016 at 4:49 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> FWIW, if I disable all the checks in pci_get_rom_size, I learn that my
>> video ROM consists entirely of 0xff bytes.  Maybe there just isn't a
>> ROM shadow on my laptop.
>
> I think most laptops end up having the graphics ROM be part of the
> regular system flash, and there is no actual rom associated with the
> PCI device that is the GPU itself.
>
> The actual GPU ROM tends to be associated with plug-in cards, not
> soldered-down chips in a laptop where they don't want extra flash
> chips.

Right; on (at least AMD) mobile dGPUs and systems with APUs, the vbios
"rom" is part of the sbios image and is set up by the sbios when it
runs.  The driver either gets it from the legacy vga location or some
platform specific method such as ACPI.

Alex
