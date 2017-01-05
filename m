Return-Path: <SRS0=HwEz=YT=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=HwEz=YT=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Kilian Singer <kilian.singer@quantumtechnology.info>, linux-pci <linux-pci@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Thu, 05 Jan 2017 15:19:29 +0100
Message-ID: <3816163.sBXNGQ24bW@aspire.rjw.lan>
In-Reply-To: <20170105104940.GA3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <59349185.1aqio7kYFn@aspire.rjw.lan> <20170105104940.GA3353@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 05, 2017 12:49:40 PM Mika Westerberg wrote:
> On Wed, Jan 04, 2017 at 10:58:10PM +0100, Rafael J. Wysocki wrote:
> > I would rather add a quirk to the ACPI core to prevent the power resources in
> > question from being enumerated.  Or even to prevent ACPI PM from being
> > used for the port in question.
> 
> If we are going to add a quirk, I agree that it should be put to the
> ACPI core.
> 
> However, Windows seems to be able to use _PR3 just fine. So there is
> something that we are missing or do not implement properly which causes
> all the troubles. IMHO we should try to find out what that difference is
> and fix that if possible.

But we are time-constrained and that may take forever.

In the particular case of the Kilian's system, the power resource used by
_PR0 and _PR3 for the port actually operates the same hardware registers
as _PS0 and _PS3 for the VID device under the port (if I remember the name
correctly), so there is something in Windows switching between the two
depending on something.

I gess that depends on the version of Windows, but that's pure speculation.

We don't know what that is and a have little hope to learn about that, so let's
just say that this power resource is fishy and don't use it until we find out
(which frankly may or may not happen).

Thanks,
Rafael
