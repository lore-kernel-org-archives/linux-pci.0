Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Wed, 19 Oct 2016 20:04:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
Message-ID: <20161019180402.GA3220@wunner.de>
References: <63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
 <20161019151055.GA16147@localhost>
 <1476892081.11323.503.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1476892081.11323.503.camel@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 19, 2016 at 06:48:01PM +0300, Andy Shevchenko wrote:
> On Wed, 2016-10-19 at 10:10 -0500, Bjorn Helgaas wrote:
> > On Sun, Oct 09, 2016 at 02:46:29PM +0200, Lukas Wunner wrote:
> > > Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> > > state") augmented struct pci_platform_pm_ops with a ->get_state hook
> > > and
> > > implemented it for acpi_pci_platform_pm, the only
> > > pci_platform_pm_ops
> > > existing till v4.7.
> > > 
> > > However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> > > Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> > > Add
> > > Power Management Unit driver").  It is missing the ->get_state hook,
> > > which is fatal since pci_set_platform_pm() enforces its presence.
> > 
> > I assume Andy tested 5823d0893ec2, so apparently "fatal" here doesn't
> > mean a panic on the MIDs?  I'm wondering (1) exactly what the user-
> > visible failure mode is, 
> 
> Fatal means it crashes without even a character printed out on serial
> console and reboot (since watchdog).
> 
> > and (2) whether there's anything we can do to
> > avoid omissions like this in the future.
> 
> It happened because the feature was developed in PCI subsystem namespace
> (mailing lists, etc.) without knowing anything about new coming users. I
> have no idea how to avoid this except browsing / grepping linux-next on
> regular basis when developing either "feature" or "user" of the API in
> question.

Basically it was my fault because my development tree lags behind
mainline for technical reasons.  I use ZFS for my root partition
and every new kernel release requires adjustments to the out-of-tree
ZoL.  So before I can upgrade I have to either wait until the ZoL
folks make those adjustments or I have to make them myself (usually
I'm too lazy).

In this case I didn't rebase my tree on 4.8 until the merge window
for 4.9 had already opened, so I noticed the breakage fairly late.

However so far only 4.9-rc1 is broken and we still have like 7 weeks
to get the fix in.


> > 
> > pci_set_platform_pm() does indeed return -EINVAL if it receives a
> > pci_platform_pm_ops with a NULL ops->get_state pointer, but
> > unfortunately neither of the callers checks that return code.

At least in the case of intel-mid it wouldn't matter if the return code
would be checked and passed up the call chain because the ultimate
callee, do_initcall_level(), doesn't check the return value of
do_one_initcall().

Perhaps the solution would be to not return -EINVAL but to throw a WARN
and limp on.  That way the user or developer at least gets an error
message and knows what's wrong.

> > Fixes: 5823d0893ec2 ("x86/platform/intel-mid: Add Power Management
> > Unit driver")
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Sounds like this should be marked for stable, since v4.8 contains
> > 5823d0893ec2 and is apparently broken?
> 
> At that point there was no "feature" commit in the tree. Perhaps the
> Fixes tag should point to the "feature" commit instead. Am I right,
> Lukas?

Right, the Fixes tag should be:

Fixes: cc7cc02bada8 ("PCI: Query platform firmware for device power state")

And this shouldn't get backported to 4.8, the issue is only present
in 4.9-rc1 so far.

@Ingo: Do you want me to repost with Bjorn's ack and the correct Fixes: tag?

Thanks!

Lukas
