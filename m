Return-Path: <andriy.shevchenko@linux.intel.com>
Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1476892081.11323.503.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	x86@kernel.org
Date: Wed, 19 Oct 2016 18:48:01 +0300
In-Reply-To: <20161019151055.GA16147@localhost>
References: 
	<63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
	 <20161019151055.GA16147@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-10-19 at 10:10 -0500, Bjorn Helgaas wrote:
> On Sun, Oct 09, 2016 at 02:46:29PM +0200, Lukas Wunner wrote:
> > 
> > Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> > state") augmented struct pci_platform_pm_ops with a ->get_state hook
> > and
> > implemented it for acpi_pci_platform_pm, the only
> > pci_platform_pm_ops
> > existing till v4.7.
> > 
> > However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> > Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> > Add
> > Power Management Unit driver").  It is missing the ->get_state hook,
> > which is fatal since pci_set_platform_pm() enforces its presence.
> 
> I assume Andy tested 5823d0893ec2, so apparently "fatal" here doesn't
> mean a panic on the MIDs?  I'm wondering (1) exactly what the user-
> visible failure mode is, 

Fatal means it crashes without even a character printed out on serial
console and reboot (since watchdog).

> and (2) whether there's anything we can do to
> avoid omissions like this in the future.

It happened because the feature was developed in PCI subsystem namespace
(mailing lists, etc.) without knowing anything about new coming users. I
have no idea how to avoid this except browsing / grepping linux-next on
regular basis when developing either "feature" or "user" of the API in
question.

> 
> pci_set_platform_pm() does indeed return -EINVAL if it receives a
> pci_platform_pm_ops with a NULL ops->get_state pointer, but
> unfortunately neither of the callers checks that return code.

Yeah.

> 
> > 
> > Retrofit mid_pci_platform_pm with the missing callback to fix the
> > breakage.
> > 
> > Cc: x86@kernel.org
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Acked-and-tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.
> > com>
> 
> Fixes: 5823d0893ec2 ("x86/platform/intel-mid: Add Power Management
> Unit driver")
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> Sounds like this should be marked for stable, since v4.8 contains
> 5823d0893ec2 and is apparently broken?

At that point there was no "feature" commit in the tree. Perhaps the
Fixes tag should point to the "feature" commit instead. Am I right,
Lukas?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
