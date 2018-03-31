Return-Path: <SRS0=jK+Y=GV=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=jK+Y=GV=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 31 Mar 2018 12:18:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180331101816.GA18877@wunner.de>
References: <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com>
 <20180331082903.GA21051@wunner.de>
 <20180331085852.GQ2703@lahna.fi.intel.com>
 <20180331091245.GA10720@wunner.de>
 <20180331092017.GS2703@lahna.fi.intel.com>
 <20180331093017.GB10720@wunner.de>
 <20180331095804.GU2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180331095804.GU2703@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 12:58:04PM +0300, Mika Westerberg wrote:
> On Sat, Mar 31, 2018 at 11:30:17AM +0200, Lukas Wunner wrote:
> > > The whole point here is that those are *not* hotplug slots just regular
> > > downstream ports.
> > 
> > Okay, understood.  Is this about the NHI or XHCI?  Because at least
> > on Alpine Ridge (C step), the bridge above the XHCI *is* a hotplug
> > bridge.  Only the bridge above the NHI is not.
> 
> Yes, exactly. I tried to clarify this mechanism a bit better in the
> other email I just sent.

But in the e-mail you just sent, the bridge above the XHCI is not a
hotplug bridge and according to the lspci output of a MacBookPro13,3
I have here, it *is* a hotplug bridge on Alpine Ridge (C step).

FWIW, the HDA controller integrated into Nvidia GPUs can be made
visible or hidden in a similar fashion by setting a bit in the
GPU's config space.  Some laptop DSDTs use this to hide the HDA
controller on boot (and resume from system sleep) if no HDMI cable
is plugged in.  I think this behavior is geared towards Windows'
driver model.  On Linux it's mostly an annoyance and we're considering
un-hiding the HDA controller unconditionally from a PCI quirk:
https://bugs.freedesktop.org/show_bug.cgi?id=75985

Thanks,

Lukas
