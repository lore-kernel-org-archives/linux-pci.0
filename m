Return-Path: <SRS0=2uIK=GS=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=2uIK=GS=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 28 Mar 2018 08:25:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ACPI / hotplug / PCI: Mark stale PCI devices
 disconnected
Message-ID: <20180328062515.GB8212@kroah.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-6-mika.westerberg@linux.intel.com>
 <20180327194512.GD7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180327205236.GA15613@wunner.de>
 <20180327221317.GH7759@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327221317.GH7759@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 05:13:17PM -0500, Bjorn Helgaas wrote:
> > If pci_dev_is_disconnected() returns true, the device is either there
> > or was until very recently, so in general checking that instead of
> > reading the vendor ID should be sufficient and should result in
> > acceptable performance.
> > 
> > I keep hearing these complaints about the PCI_DEV_DISCONNECTED flag,
> > from Greg but now also from you, but I'm not seeing constructive
> > criticism how checking presence of a device should be handled instead,
> > in a way that doesn't negatively impact performance.

You can't have things both ways.  If you are worried about your device
going away (and you have to), then just check all reads and be fine with
it.  If you have values that can be all 0xff, then just accept that as a
valid value and move to the next read where it can't be valid.

Don't try to be smart and constantly read other registers like the
vendor id, because you will still race with reading them as well (and
some devices might not like that, as this is not a codepath that any
device expects to be "fast", so odds are the silicon isn't optimised for
that at all).

> > IMO it was a mistake to constrain visibility of the flag to the PCI core
> > (at Greg's behest), it should have been made available to drivers so
> > they're afforded a better method to detect surprise removal than just
> > reading the vendor ID every time they access the device.

No, just check the value you read read and move on.  This is something
we have had to handle for 20 years now, it's not a new thing at all, why
is this even something to be argued about?  Is it that difficult for
your driver to check this and handle the removal problem gracefully?

> To avoid the race, drivers have to check for a valid value anyway.  If
> they *also* check pci_dev_is_disconnected(), that clutters the code
> and gives a false sense of security.
> 
> When a read fails, it normally returns ~0 as the data to the driver. 
> The driver knows the semantics of the registers it reads, and often it
> can tell immediately that a successful read of the register could
> never return that value, so it doesn't need to try any more accesses
> to Vendor ID or anything else.
> 
> If ~0 *is* a possible valid value, the driver can read some other
> register (maybe Vendor ID, or maybe an MMIO register that can be read
> faster).

I totally agree with Bjorn here.

thanks,

greg k-h
