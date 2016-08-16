Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 16 Aug 2016 15:20:18 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aaron Durbin <adurbin@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: ACPI device using sub-resource of PCI device
Message-ID: <20160816122018.GK1751@lahna.fi.intel.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <3103060.86QBTjSLk3@vostro.rjw.lan>
 <CAE2855sB73=1gznGFonGver_FtaCdoAa4-8Bz8sAXCXuBZvxfg@mail.gmail.com>
 <3861743.KWBechkp08@vostro.rjw.lan>
 <CAE2855sk2M_77W7dPUb-G43zaDgiNvH2fwpEUvZKOZCBZ-1UpQ@mail.gmail.com>
 <CAE2855uNKxtSJSGdF9T7LcGV+F6HzqJhmgDEdgAEwrY=HjPnrQ@mail.gmail.com>
 <20160816091502.GB1751@lahna.fi.intel.com>
 <1471346604.4887.120.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1471346604.4887.120.camel@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 16, 2016 at 02:23:24PM +0300, Andy Shevchenko wrote:
> On Tue, 2016-08-16 at 12:15 +0300, Mika Westerberg wrote:
> > On Fri, Aug 12, 2016 at 11:45:30AM -0500, Aaron Durbin wrote:
> > > 
> > > Was anyone able to take a look into a solution for the current
> > > problem?  Again, please feel free to ask if anyone would like help
> > > testing potential solutions.
> > 
> > Below is one proposal for fixing the issue. It is just a prototype and
> > I'm not sure if it takes everything needed into account. Would you be
> > able to try it out and let us know if it works for you?
> 
> Just style comments below.

Thanks for the comments. As Rafael already mentioned, this is just a
prototype. We don't even know yet if it fixes the issue.

If it turns out to be working and we decide to go with this approach, I
will clean up the code accordingly and submit it as a proper patch.
