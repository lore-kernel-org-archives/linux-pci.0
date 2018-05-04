Return-Path: <SRS0=h3bN=HX=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=h3bN=HX=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 4 May 2018 10:20:44 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/9] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
Message-ID: <20180504072044.GH17277@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180502115509.GF2355@lahna.fi.intel.com>
 <20180502134148.GF11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503104250.GJ2355@lahna.fi.intel.com>
 <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 06:01:08PM -0500, Bjorn Helgaas wrote:
> If you think we can remove pciehp_force, that would be awesome.  This
> should be a separate patch all by itself, of course, and include your
> reasoning above.
> 
> I would also love to revert db63d40017a5 ("PCI: pciehp: Do not clear
> Presence Detect Changed during initialization") because I'm not
> convinced that trying to handle interrupts that happened before
> binding the driver makes sense.  It *would* make sense to me to enable
> interrupts, clear the "changed" status bits so future changes will
> cause interrupts, and check the "state" status bits and act on them.

OK, I'll make that a separate patch series completely.

Regarding the current patch set, do you have any additional comments /
converns? I would like to send out v6 next week.
