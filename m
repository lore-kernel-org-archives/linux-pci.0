Return-Path: <SRS0=PYID=YQ=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=PYID=YQ=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Kilian Singer <kilian.singer@quantumtechnology.info>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Mon, 02 Jan 2017 22:31:07 +0100
Message-ID: <1731082.izJCnRoq0n@aspire.rjw.lan>
In-Reply-To: <20170102144852.GE3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <20170102121019.GA3353@lahna.fi.intel.com> <20170102144852.GE3353@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, January 02, 2017 04:48:52 PM Mika Westerberg wrote:
> On Mon, Jan 02, 2017 at 02:10:19PM +0200, Mika Westerberg wrote:
> > I've checked the acpidump of this machine and it does not seem to be a
> > traditional Optimus machine. At least this one is missing the magic _DSM
> > which is used to gather capabilities of the graphics device.
> > 
> > However, it does have _PR3 and it is attached to the device
> > (_SB.PCI0.PEG) itself, not the root port.
> 
> Nah, actually PEG is the root port. So it certainly looks like
> a traditional Optimus machine.

So can we quirk that thing somehow and see if that helps (for debugging
purposes at least)?

Thanks,
Rafael
