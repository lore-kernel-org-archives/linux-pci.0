Return-Path: <SRS0=XD7a=YL=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=XD7a=YL=wunner.de=lukas@kernel.org>
Date: Wed, 28 Dec 2016 12:29:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20161228112954.GA17925@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> and all the debugging you've done.  Below is a revert of the troublesome
> commit.  Can you test it and verify that it also fixes the problem?
> 
> I assume Mika is looking at this and will have a better solution soon.
> But if not, I'll queue this up for v4.10.

@Kilian:  Are you using the proprietary nvidia driver?  If so,
does the issue go away if you blacklist that driver or use nouveau
instead?


With a bit of googling I found dmesg and lspci output for this model:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1437386

The keyboard and mouse seem to be PS/2 devices, accessed via I/O ports
0x60, 0x64.  I assume they're located behind the LPC bridge?

The proprietary nvidia driver has a bug, it locks the legacy PCI VGA
registers with vga_tryget() but never releases that lock.  Intel
chipsets have a quirk wherein I/O ports are routed to the bus to
which the legacy PCI VGA registers are locked.  So once vga_tryget()
is called by the nvidia driver, access to the keyboard and mouse is
routed to bus 01 (on which the Nvidia card resides) and not to bus 00
(on which the LPC bridge resides).

My theory would be that if you lock the screen, the Nvidia card
runtime suspends, allowing the root port above it to suspend,
and then the I/O ports are no longer accessible.

We have a similar issue on dual GPU MacBook Pros:  Backlight brightness
is adjusted by writing to I/O ports of a gmux controller situated below
the LPC bridge.  The nvidia driver locks the legacy VGA registers and
from that point reads from the I/O ports always return 0xff.  Commit
4eebd5a4e726 ("apple-gmux: lock iGP IO to protect from vgaarb changes")
sought to fix it but caused other breakage which remains unfixed so far:
https://bugzilla.kernel.org/show_bug.cgi?id=105051
https://bugzilla.kernel.org/show_bug.cgi?id=88861#c11

I've always wondered if the Intel chipsets would behave more sensibly
if the LPC bridge had BARs specifying the I/O regions used by devices
below it.

Reverting runtime suspend for PCIe ports is not a good solution as it's
needed for Thunderbolt runtime PM on Macs.

Thanks,

Lukas
