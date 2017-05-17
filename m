Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 May 2017 16:36:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors
Message-ID: <20170517213645.GA21886@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
 <20170324154744.GE25380@bhelgaas-glaptop.roam.corp.google.com>
 <a1ac66f3-3c3f-e9c6-82c9-6e9ca5715b67@vodafone.de>
 <20170412165530.GE25197@bhelgaas-glaptop.roam.corp.google.com>
 <de846814-5884-69a5-3eb6-fec5c5c6896d@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <de846814-5884-69a5-3eb6-fec5c5c6896d@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 03:01:35PM +0200, Christian König wrote:
> Am 12.04.2017 um 18:55 schrieb Bjorn Helgaas:
> >[SNIP]
> >>>I think the specs would envision this being done via an ACPI _SRS
> >>>method on the PNP0A03 host bridge device.  That would be a more
> >>>generic path that would work on any host bridge.  Did you explore that
> >>>possibility?  I would prefer to avoid adding device-specific code if
> >>>that's possible.
> >>I've checked quite a few boards, but none of them actually
> >>implements it this way.
> >>
> >>M$ is working on a new ACPI table to enable this vendor neutral, but
> >>I guess that will still take a while.
> >>
> >>I want to support this for all AMD CPU released in the past 5 years
> >>or so, so we are going to deal with a bunch of older boards as well.
> >I've never seen _SRS for host bridges either.  I'm curious about what
> >sort of new table will be proposed.  It seems like the existing ACPI
> >resource framework could manage it, but I certainly don't know all the
> >issues.
> 
> No idea either since I'm not involved into that. My job is to get it
> working on the existing hw generations and that alone is enough work
> :)
> 
> My best guess is that MS is going to either make _SRS on the host
> bridge or a pre-configured 64bit window mandatory for the BIOS.

While researching something else, I noticed that the PCI Firmware Spec, rev
3.2, does indeed call out _PRS and _SRS as the mechanism for the OS to
configure host bridge windows.  See sections 4.1.3, 4.3.2.1, and 4.6.5.

Sec 4.6.5 also includes an implementation note that might be a clue about
the "compatibility issues" that prevent the BIOS from enabling the window
in the first place.

I'd like to incorporate some of this info into these changes, probably in a
code comment and changelog, so we can encourage a more generic approach in
the future, even if we can't use it in all existing cases.

Bjorn
