Return-Path: <SRS0=CXPL=FU=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=CXPL=FU=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 26 Feb 2018 12:24:36 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario.Limonciello@dell.com
Cc: helgaas@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
	andriy.shevchenko@linux.intel.com, lenb@kernel.org,
	michael.jamet@intel.com, yehezkel.bernat@intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180226102436.GH27191@lahna.fi.intel.com>
References: <20180215144000.60456-1-mika.westerberg@linux.intel.com>
 <20180215144000.60456-2-mika.westerberg@linux.intel.com>
 <20180223002733.GH14632@bhelgaas-glaptop.roam.corp.google.com>
 <c00e7c7a-6ebd-41b6-a924-92a2070e3db3@Dell.com>
 <20180223172543.GK14632@bhelgaas-glaptop.roam.corp.google.com>
 <5506aacec14e4696a6f306ebd7df6fd2@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5506aacec14e4696a6f306ebd7df6fd2@ausx13mpc120.AMER.DELL.COM>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:06:59PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Friday, February 23, 2018 11:26 AM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: bhelgaas@google.com; rjw@rjwysocki.net;
> > andriy.shevchenko@linux.intel.com; lenb@kernel.org; michael.jamet@intel.com;
> > yehezkel.bernat@intel.com; linux-acpi@vger.kernel.org; linux-
> > pci@vger.kernel.org; mika.westerberg@linux.intel.com
> > Subject: Re: [PATCH v2 1/5] PCI: Make sure all bridges reserve at least one bus
> > number
> > 
> > On Fri, Feb 23, 2018 at 12:52:18AM +0000, Mario.Limonciello@dell.com wrote:
> > > On Feb 22, 2018 18:27, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Feb 15, 2018 at 05:39:55PM +0300, Mika Westerberg wrote:
> > > > > When distributing extra buses between hotplug bridges we need to make
> > > > > sure each bridge reserve at least one bus number, even if there is
> > > > > currently nothing connected to it. For instance ACPI hotplug may bring
> > > > > in additional devices to non-hotplug bridges later on. To make sure we
> > > > > don't run out of bus numbers for non-hotplug bridges reserve one bus
> > > > > number for them upfront before distributing buses for hotplug bridges.
> > > > >
> > > > > Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable
> > bridges")
> > > > > Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> > > >
> > > > Is there a bugzilla or email URL we can include here?
> > >
> > > Sorry it was private communication that I believe Mika is referring to in Reported-
> > By here.
> > >
> > > You can remove the tag if you think it's inappropriate for this commit.
> > 
> > I like to give credit whenever possible, so I wouldn't necessarily
> > remove the Reported-by.
> > 
> > But it would be very useful to also have a URL to something with more
> > details, e.g., what sort of failure the user would observe, dmesg
> > logs, PCI topology, etc.
> > 
> > This information can certainly be redacted to remove any proprietary
> > things that can't be made public.  Usually that isn't of interest to
> > structural issues like this anyway.
> 
> It was a result of a very long communication chain, but I think I pulled
> out the relevant details here if you would like a URL to include:
> https://gist.github.com/superm1/100a2ed20449f684ebb84c392e35dbed

Thanks Mario.

I'll update changelog to include the above information as well.
