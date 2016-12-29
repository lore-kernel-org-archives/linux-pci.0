Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Date: Thu, 29 Dec 2016 17:02:30 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228112954.GA17925@wunner.de> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

One thing that was always weird in my debian system is, 
that even with working lock screen on the 4.7.0-1 version.
The lock screen is not a black screen but instead seems to
be a static screenshot of the desktop.

I currently have no system to compare with but this might be 
an abnormal behavior.

----- Original Message -----
From: "Kilian Singer" <kilian.singer@quantumtechnology.info>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Lukas Wunner" <lukas@wunner.de>, "linux-pci" <linux-pci@vger.kernel.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Thursday, December 29, 2016 10:58:44 AM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

Dear Lukas and Bjorn,
I am using the nouveau driver.
dmesg and lspci --vv is attached as a comment to the bug rebort
https://bugzilla.kernel.org/show_bug.cgi?id=190861#c15
https://bugzilla.kernel.org/show_bug.cgi?id=190861#c16

I could completely deactivate nvidia in the bios...

Best regards
Kilian

----- Original Message -----
From: "Bjorn Helgaas" <helgaas@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "Kilian Singer" <kilian.singer@quantumtechnology.info>, linux-pci@vger.kernel.org, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Wednesday, December 28, 2016 5:18:16 PM
Subject: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Wed, Dec 28, 2016 at 12:29:54PM +0100, Lukas Wunner wrote:
> On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> > Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> > and all the debugging you've done.  Below is a revert of the troublesome
> > commit.  Can you test it and verify that it also fixes the problem?
> > 
> > I assume Mika is looking at this and will have a better solution soon.
> > But if not, I'll queue this up for v4.10.
> 
> @Kilian:  Are you using the proprietary nvidia driver?  If so,
> does the issue go away if you blacklist that driver or use nouveau
> instead?
> 
> 
> With a bit of googling I found dmesg and lspci output for this model:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1437386
> 
> The keyboard and mouse seem to be PS/2 devices, accessed via I/O ports
> 0x60, 0x64.  I assume they're located behind the LPC bridge?
> 
> The proprietary nvidia driver has a bug, it locks the legacy PCI VGA
> registers with vga_tryget() but never releases that lock.  Intel
> chipsets have a quirk wherein I/O ports are routed to the bus to
> which the legacy PCI VGA registers are locked.  So once vga_tryget()
> is called by the nvidia driver, access to the keyboard and mouse is
> routed to bus 01 (on which the Nvidia card resides) and not to bus 00
> (on which the LPC bridge resides).

Interesting.  A spec reference would be a good addition to whatever
fix is proposed.

> My theory would be that if you lock the screen, the Nvidia card
> runtime suspends, allowing the root port above it to suspend,
> and then the I/O ports are no longer accessible.
> 
> We have a similar issue on dual GPU MacBook Pros:  Backlight brightness
> is adjusted by writing to I/O ports of a gmux controller situated below
> the LPC bridge.  The nvidia driver locks the legacy VGA registers and
> from that point reads from the I/O ports always return 0xff.  Commit
> 4eebd5a4e726 ("apple-gmux: lock iGP IO to protect from vgaarb changes")
> sought to fix it but caused other breakage which remains unfixed so far:
> https://bugzilla.kernel.org/show_bug.cgi?id=105051
> https://bugzilla.kernel.org/show_bug.cgi?id=88861#c11
> 
> I've always wondered if the Intel chipsets would behave more sensibly
> if the LPC bridge had BARs specifying the I/O regions used by devices
> below it.
> 
> Reverting runtime suspend for PCIe ports is not a good solution as it's
> needed for Thunderbolt runtime PM on Macs.

The choices are:

  1) Fix the regression and preserve runtime PM for PCIe ports
  2) Fix the regression by reverting runtime PM for PCIe ports

Obviously we hope for 1).  Preserving runtime PM without fixing the
regression isn't even on the list.  I know this is Linux 101, so I
apologize for restating the obvious.

Bjorn
