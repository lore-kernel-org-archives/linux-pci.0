Return-Path: <SRS0=3zRK=YU=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=3zRK=YU=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kilian Singer <kilian.singer@quantumtechnology.info>, linux-pci <linux-pci@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 06 Jan 2017 02:21:11 +0100
Message-ID: <2634193.tHuT6mNBBA@aspire.rjw.lan>
In-Reply-To: <20170105144220.GA21446@wunner.de>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <20170104210954.GA11946@al> <20170105144220.GA21446@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 05, 2017 03:42:20 PM Lukas Wunner wrote:
> On Wed, Jan 04, 2017 at 10:09:54PM +0100, Peter Wu wrote:
> > [ Help/ideas are welcome, I suspect that these failures to restore power
> > on laptops designed for Win8+ all have the same cause, related to some
> > unknown interaction between ACPI and PCI. Some links:
> > https://bugzilla.kernel.org/show_bug.cgi?id=190861
> > https://bugzilla.kernel.org/show_bug.cgi?id=156341 ]
> 
> Looking at Kilian's acpidump again I notice that the methods to power
> the GPU on or off (GPON / GPOF) are called from two places:
> 
> - From the _PS0 and _PS3 methods of the GPU and
> - from the _PR3 power resource of the root port above the GPU.
> 
> In the former case they're called for pre Windows 2013 or if VDAD is true.
> In the latter case they're called unconditionally but GPOF becomes a no-op
> in the pre Windows 2013 case.
> 
> This means that GPOF would be executed *twice* on Windows 2013+ if VDAD
> is true.  I could imagine this to cause issues.

Right.  Exactly my observation (http://marc.info/?l=linux-pci&m=148362622326066&w=2).

So on (newer) Windows something is done in order to make it work in addition to
the _PR3 _OSC handshake.

So, I'd like to try to follow the Mika's suggestion to use the response we get
from the _OSC handshake for \_SB and if that says "no _PR3", ignore power
resources for PCIe ports at least.

Thanks,
Rafael
