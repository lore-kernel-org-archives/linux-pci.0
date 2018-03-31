Return-Path: <SRS0=jK+Y=GV=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=jK+Y=GV=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 31 Mar 2018 10:29:03 +0200
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
Message-ID: <20180331082903.GA21051@wunner.de>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-2-mika.westerberg@linux.intel.com>
 <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180329115911.GN2703@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 29, 2018 at 02:59:11PM +0300, Mika Westerberg wrote:
> On Wed, Mar 28, 2018 at 01:09:06PM -0500, Bjorn Helgaas wrote:
> > The same issue could happen on any system where we use acpiphp, so I
> > don't think Thunderbolt is really relevant here, and it's easy to
> > confuse things by mentioning it.
> 
> This issue can happen regardless whether acpiphp is used or not.

If the platform has yielded hotplug control to the OS via _OSC,
I don't see how the platform could hot-add devices.  So surely
reserving a bus number for a bridge without anything below it
can be constrained to the !pciehp_is_native(bridge) case?

Thanks,

Lukas
