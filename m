Return-Path: <SRS0=9ysh=YR=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=9ysh=YR=wunner.de=lukas@kernel.org>
Date: Tue, 3 Jan 2017 17:11:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170103161123.GA20915@wunner.de>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170102121019.GA3353@lahna.fi.intel.com>
 <20170102144852.GE3353@lahna.fi.intel.com>
 <1731082.izJCnRoq0n@aspire.rjw.lan>
 <20170103095158.GH3353@lahna.fi.intel.com>
 <20170103151547.GB9763@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170103151547.GB9763@al>
List-ID: <linux-pci.vger.kernel.org>

[cc += Dave Airlie:

Dave, we're about to lose support for newer Optimus laptops which use
_PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
a commit on his for-linus branch to remove runtime PM for PCIe ports.
This fixes a regression on Kilian Singer's laptop on which locking the
screen breaks USB and PS/2 input devices:  Mouse movements are still
visible, but button or key presses no longer have any effect.  The GPU
is powered down upon locking the screen and the current theory is that
this causes the issues.]

On Tue, Jan 03, 2017 at 04:15:47PM +0100, Peter Wu wrote:
> The acpidump from the bug does not show known issues, it *looks* fine.
> There have been other issues related to resuming power on newer Nvidia
> hardware (https://bugs.freedesktop.org/show_bug.cgi?id=94725,
> https://bugzilla.kernel.org/show_bug.cgi?id=156341) but there is not
> much progress here.  (The last time I traced the PCIe register accesses
> (via kprobes) and tried to disable some of those, it still did not help
> with preventing the power issue.)

It seems that the _DSM method works on Kilian's laptop.  Would it be
viable to default to _DSM if it's available, and only use _PR3 if not?

Thanks,

Lukas
