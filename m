Return-Path: <andriy.shevchenko@linux.intel.com>
Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1477150280.6423.19.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	x86@kernel.org
Date: Sat, 22 Oct 2016 18:31:20 +0300
In-Reply-To: <20161019180402.GA3220@wunner.de>
References: 
	<63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
	 <20161019151055.GA16147@localhost>
	 <1476892081.11323.503.camel@linux.intel.com>
	 <20161019180402.GA3220@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-10-19 at 20:04 +0200, Lukas Wunner wrote:
> On Wed, Oct 19, 2016 at 06:48:01PM +0300, Andy Shevchenko wrote:
> > On Wed, 2016-10-19 at 10:10 -0500, Bjorn Helgaas wrote:
> > > On Sun, Oct 09, 2016 at 02:46:29PM +0200, Lukas Wunner wrote:


> However so far only 4.9-rc1 is broken and we still have like 7 weeks
> to get the fix in.

One week less. :-)

> > > Fixes: 5823d0893ec2 ("x86/platform/intel-mid: Add Power Management
> > > Unit driver")
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Sounds like this should be marked for stable, since v4.8 contains
> > > 5823d0893ec2 and is apparently broken?
> > 
> > At that point there was no "feature" commit in the tree. Perhaps the
> > Fixes tag should point to the "feature" commit instead. Am I right,
> > Lukas?
> 
> Right, the Fixes tag should be:
> 
> Fixes: cc7cc02bada8 ("PCI: Query platform firmware for device power
> state")
> 
> And this shouldn't get backported to 4.8, the issue is only present
> in 4.9-rc1 so far.
> 
> @Ingo: Do you want me to repost with Bjorn's ack and the correct
> Fixes: tag?

I didn't noticed the patch in last urgent pull request, so, I assume you
need to send v3.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
