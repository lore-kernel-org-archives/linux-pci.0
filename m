Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 12 Sep 2016 11:10:50 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Durbin <adurbin@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: ACPI device using sub-resource of PCI device
Message-ID: <20160912081050.GV15313@lahna.fi.intel.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <3103060.86QBTjSLk3@vostro.rjw.lan>
 <CAE2855sB73=1gznGFonGver_FtaCdoAa4-8Bz8sAXCXuBZvxfg@mail.gmail.com>
 <3861743.KWBechkp08@vostro.rjw.lan>
 <CAE2855sk2M_77W7dPUb-G43zaDgiNvH2fwpEUvZKOZCBZ-1UpQ@mail.gmail.com>
 <CAE2855uNKxtSJSGdF9T7LcGV+F6HzqJhmgDEdgAEwrY=HjPnrQ@mail.gmail.com>
 <20160816091502.GB1751@lahna.fi.intel.com>
 <CAE2855ts_Xw2ahGRYpVWHAqCEvzNYV7BmOVejeErJ_e2oXZ1qg@mail.gmail.com>
 <CAE2855u7vLDVSJ04gr8yrg+U=W2DwwNk2+8jGhb-_isixDWvHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE2855u7vLDVSJ04gr8yrg+U=W2DwwNk2+8jGhb-_isixDWvHw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 09:12:49AM -0500, Aaron Durbin wrote:
> On Wed, Aug 17, 2016 at 6:02 PM, Aaron Durbin <adurbin@google.com> wrote:
> > On Tue, Aug 16, 2016 at 2:15 AM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> >> On Fri, Aug 12, 2016 at 11:45:30AM -0500, Aaron Durbin wrote:
> >>> Was anyone able to take a look into a solution for the current
> >>> problem?  Again, please feel free to ask if anyone would like help
> >>> testing potential solutions.
> >>
> >> Below is one proposal for fixing the issue. It is just a prototype and
> >> I'm not sure if it takes everything needed into account. Would you be
> >> able to try it out and let us know if it works for you?
> >
> > Yes. I'll give it a go. I'm traveling this week so it won't likely be
> > til early next week. Thanks for the proposed fix. I'll report back on
> > my findings.
> >
> 
> Sorry for the late response. I tried the patch and it works with ACPI
> devices in a hierarchy below PCI devices. I didn't have any ACPI
> drivers probed but I was able to hang 2 ACPI devices off of a BAR that
> had a driver for the PCI device without any resource conflicts
> (snippet from /proc/iomem):
> 
>     c2a43000-c2a43fff : 0000:00:1b.0
>       c2a43000-c2a437ff : GOOG1234:00
>       c2a43800-c2a43fff : GOOG1235:00

Thanks for testing.

> One observation that I don't think matters much, but I wanted to write
> it down in case anyone pulls this thread up again. In the case of
> finding the parent resource, the ACPI devcie's resources won't show up
> in the resource tree until the pci parent devices' resources are
> inserted.

Right, that's expected as the parent PCI device resources will be
allocated a bit later when pcibios_resource_survey_bus() is called.

Rafael, Bjorn,

What do you think? Should I clean up the code and send it out as a
formal patch?
