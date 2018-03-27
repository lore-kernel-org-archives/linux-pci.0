Return-Path: <SRS0=HGFa=GR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=HGFa=GR=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 27 Mar 2018 22:52:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ACPI / hotplug / PCI: Mark stale PCI devices
 disconnected
Message-ID: <20180327205236.GA15613@wunner.de>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-6-mika.westerberg@linux.intel.com>
 <20180327194512.GD7759@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327194512.GD7759@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:45:12PM -0500, Bjorn Helgaas wrote:
> I hate this pci_dev_set_disconnected() thing and hope to remove it
> someday.  It's racy and adds additional states that are hard to
> manage, e.g., "device has been removed and will not respond to PCI
> accesses, but pci_dev_set_disconnected() hasn't been called yet".  If
> we can handle that case (and we should), we shouldn't need
> pci_dev_set_disconnected().

Absent pci_dev_is_disconnected(), how can the PCI core detect if
a device is still there (versus has been hot-removed)?  The only
valid method I know of is reading the vendor ID from config space.
However reading config spaces takes time.  To properly handle
surprise removal, we ought to check presence of the device frequently
lest we clutter the logs with errors, unnecessarily occupy the CPU
and bus or in some cases hang the machine.  Ideally, we should check
presence of the device every time we access it.

Now, imagine every time we access config or mmio space, we read the
vendor ID from config space, so we essentially double the number of
accesses to the device.  Does that make sense, performance-wise?

If pci_dev_is_disconnected() returns true, the device is either there
or was until very recently, so in general checking that instead of
reading the vendor ID should be sufficient and should result in
acceptable performance.

I keep hearing these complaints about the PCI_DEV_DISCONNECTED flag,
from Greg but now also from you, but I'm not seeing constructive
criticism how checking presence of a device should be handled instead,
in a way that doesn't negatively impact performance.

IMO it was a mistake to constrain visibility of the flag to the PCI core
(at Greg's behest), it should have been made available to drivers so
they're afforded a better method to detect surprise removal than just
reading the vendor ID every time they access the device.

Thanks,

Lukas
