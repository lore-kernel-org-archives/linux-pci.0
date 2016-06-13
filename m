Return-Path: <andriy.shevchenko@linux.intel.com>
Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1465823973.30123.15.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael
	J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Date: Mon, 13 Jun 2016 16:19:33 +0300
In-Reply-To: <20160613131346.GA11051@localhost>
References: 
	<1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-06-13 at 08:13 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2016 at 02:40:54PM +0300, Andy Shevchenko wrote:
> > On Fri, 2016-06-10 at 19:19 -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 07, 2016 at 08:48:33PM +0300, Andy Shevchenko wrote:
> > > > When cast pci_power_t type of variables a static analizer tool
> > > > complains on
> > > > that.
> > > > 
> > > > 	include/linux/pci.h:119:37: warning: cast from
> > > > restricted
> > > > pci_power_t
> > > > 
> > > > Enforce type casting to make static analizer happy.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
> > > > m>
> > > 
> > > Applied to pci/pm for v4.8, thanks, Andy.
> > 
> > Thanks.
> > 
> > By the way, what was the main point to use __bitwise annotation to
> > this
> > type in the first place?
> 
> I don't know.  It looks like pci_power_t was the first use of
> __bitwise in
> pci.h, added by e8191db240d2 ("[PATCH] PCI: Cleanup PCI power
> states").
> That changelog mentions type-safety, but I must admit that doesn't
> make it
> obvious to me.

I'm asking since any code which is using this type (all direct
assignments or comparisons) brings a static analyzer complain.
You may check by yourself with (my usual command to build kernel)

% make C=1 CF=-D__CHECK_ENDIAN__ W=1 -j64

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
