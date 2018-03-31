Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 31 Mar 2018 12:58:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180331095804.GU2703@lahna.fi.intel.com>
References: <20180226132112.81447-2-mika.westerberg@linux.intel.com>
 <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com>
 <20180331082903.GA21051@wunner.de>
 <20180331085852.GQ2703@lahna.fi.intel.com>
 <20180331091245.GA10720@wunner.de>
 <20180331092017.GS2703@lahna.fi.intel.com>
 <20180331093017.GB10720@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180331093017.GB10720@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 11:30:17AM +0200, Lukas Wunner wrote:
> > The whole point here is that those are *not* hotplug slots just regular
> > downstream ports.
> 
> Okay, understood.  Is this about the NHI or XHCI?  Because at least
> on Alpine Ridge (C step), the bridge above the XHCI *is* a hotplug
> bridge.  Only the bridge above the NHI is not.

Yes, exactly. I tried to clarify this mechanism a bit better in the
other email I just sent.
