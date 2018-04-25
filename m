Return-Path: <SRS0=SZbP=HO=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=SZbP=HO=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 25 Apr 2018 10:29:46 +0300
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
Subject: Re: [PATCH v5 6/9] PCI: Move resource distribution for a single
 bridge outside of the loop
Message-ID: <20180425072946.GH2173@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-7-mika.westerberg@linux.intel.com>
 <20180424230558.GA101734@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180424230558.GA101734@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:05:58PM -0500, Bjorn Helgaas wrote:
> > +	/*
> > +	 * There is only one bridge on the bus so it gets all available
> > +	 * resources which it can then distribute to the possible
> > +	 * hotplug bridges below.
> > +	 */
> > +	if ((hotplug_bridges == 0 && normal_bridges == 1) ||
> > +	    (hotplug_bridges == 1 && normal_bridges == 0)) {
> 
>   if (hotplug_bridges + normal_bridges == 1) {
> 
> Don't repost just for this; I can fold it in if you agree.

I agree, looks better like that. Thanks!
