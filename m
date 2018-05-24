Return-Path: <SRS0=xKl/=IL=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=xKl/=IL=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 24 May 2018 21:31:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Mario.Limonciello@dell.com, Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 04/12] PCI: Make pciehp_is_native() stricter
Message-ID: <20180524183107.GW15419@lahna.fi.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180510182844.77349-5-mika.westerberg@linux.intel.com>
 <3307721.MagQsabiPK@aspire.rjw.lan>
 <20180524180837.GC95348@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524180837.GC95348@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 01:08:37PM -0500, Bjorn Helgaas wrote:
> Why do we even need to bother checking "bridge" for NULL?
> 
> I don't believe in gratuitously checking for NULL because it can hide
> higher-level bugs, i.e., if this is called with a NULL pointer, that's
> likely a bug in the caller, and if we silently return "false", we'll
> never discover the caller's bug.

But it also makes caller's life easier because now you don't need to do
this:

   if (bus->self && hotplug_is_native(bus->self))

because it is perfectly legal to call that function for host bridge. So
you do this instead

   if (hotplug_is_native(bus->self))

and it is not hiding a bug IMHO.
