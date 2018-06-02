Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 2 Jun 2018 21:44:43 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 4/7] ACPI/hotplug/PCI: Do not scan all bridges when
 native PCIe hotplug is used
Message-ID: <20180602184443.GR15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601213505.GA199634@bhelgaas-glaptop.roam.corp.google.com>
 <20180601214818.GK15419@lahna.fi.intel.com>
 <20180602054659.GB187972@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180602054659.GB187972@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:46:59AM -0500, Bjorn Helgaas wrote:
> > I think here hotplug_is_native() would work as well. The idea is
> > that we need to avoid scanning bridges that are handled by pciehp
> > (or shpchp).
> 
> I made that change on my branch.  That way we won't have to worry
> about the cases where we set is_hotplug_bridge based on some ACPI
> methods.  I think those would be bugs because I think we *do* want
> acpiphp to scan them, and if we tested "!dev->is_hotplug_bridge", we
> would not scan them.

I agree.
