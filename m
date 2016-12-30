Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 01:19:14 +0100
Message-ID: <15778800.7CbgT5Og6y@aspire.rjw.lan>
In-Reply-To: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228112954.GA17925@wunner.de> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 28, 2016 10:18:16 AM Bjorn Helgaas wrote:
> On Wed, Dec 28, 2016 at 12:29:54PM +0100, Lukas Wunner wrote:
> > On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> > > Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> > > and all the debugging you've done.  Below is a revert of the troublesome
> > > commit.  Can you test it and verify that it also fixes the problem?
> > > 
> > > I assume Mika is looking at this and will have a better solution soon.
> > > But if not, I'll queue this up for v4.10.
> > 
> > @Kilian:  Are you using the proprietary nvidia driver?  If so,
> > does the issue go away if you blacklist that driver or use nouveau
> > instead?
> > 
> > 
> > With a bit of googling I found dmesg and lspci output for this model:
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1437386
> > 
> > The keyboard and mouse seem to be PS/2 devices, accessed via I/O ports
> > 0x60, 0x64.  I assume they're located behind the LPC bridge?
> > 
> > The proprietary nvidia driver has a bug, it locks the legacy PCI VGA
> > registers with vga_tryget() but never releases that lock.  Intel
> > chipsets have a quirk wherein I/O ports are routed to the bus to
> > which the legacy PCI VGA registers are locked.  So once vga_tryget()
> > is called by the nvidia driver, access to the keyboard and mouse is
> > routed to bus 01 (on which the Nvidia card resides) and not to bus 00
> > (on which the LPC bridge resides).
> 
> Interesting.  A spec reference would be a good addition to whatever
> fix is proposed.
> 
> > My theory would be that if you lock the screen, the Nvidia card
> > runtime suspends, allowing the root port above it to suspend,
> > and then the I/O ports are no longer accessible.
> > 
> > We have a similar issue on dual GPU MacBook Pros:  Backlight brightness
> > is adjusted by writing to I/O ports of a gmux controller situated below
> > the LPC bridge.  The nvidia driver locks the legacy VGA registers and
> > from that point reads from the I/O ports always return 0xff.  Commit
> > 4eebd5a4e726 ("apple-gmux: lock iGP IO to protect from vgaarb changes")
> > sought to fix it but caused other breakage which remains unfixed so far:
> > https://bugzilla.kernel.org/show_bug.cgi?id=105051
> > https://bugzilla.kernel.org/show_bug.cgi?id=88861#c11
> > 
> > I've always wondered if the Intel chipsets would behave more sensibly
> > if the LPC bridge had BARs specifying the I/O regions used by devices
> > below it.
> > 
> > Reverting runtime suspend for PCIe ports is not a good solution as it's
> > needed for Thunderbolt runtime PM on Macs.
> 
> The choices are:
> 
>   1) Fix the regression and preserve runtime PM for PCIe ports
>   2) Fix the regression by reverting runtime PM for PCIe ports
> 
> Obviously we hope for 1).  Preserving runtime PM without fixing the
> regression isn't even on the list.  I know this is Linux 101, so I
> apologize for restating the obvious.

There is a couple of obvious things we can do other than reverting, though.

Like for example changing the cutoff date we have in there to cover the Kilian's
system.

Thanks,
Rafael
