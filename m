Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:42336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759421AbdACQqE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 11:46:04 -0500
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Peter Wu' <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Subject: RE: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Tue, 3 Jan 2017 16:44:48 +0000
Message-ID: <BN6PR12MB1652D078A710EAAFB52FCD6BF76E0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170102121019.GA3353@lahna.fi.intel.com>
 <20170102144852.GE3353@lahna.fi.intel.com>
 <1731082.izJCnRoq0n@aspire.rjw.lan>
 <20170103095158.GH3353@lahna.fi.intel.com> <20170103151547.GB9763@al>
 <20170103161123.GA20915@wunner.de> <20170103163130.GC9763@al>
In-Reply-To: <20170103163130.GC9763@al>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Peter Wu [mailto:peter@lekensteyn.nl]
> Sent: Tuesday, January 03, 2017 11:32 AM
> To: Lukas Wunner
> Cc: Mika Westerberg; Rafael J. Wysocki; Kilian Singer; Bjorn Helgaas; lin=
ux-pci;
> Deucher, Alexander; Dave Airlie
> Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
>=20
> On Tue, Jan 03, 2017 at 05:11:23PM +0100, Lukas Wunner wrote:
> > [cc +=3D Dave Airlie:
> >
> > Dave, we're about to lose support for newer Optimus laptops which use
> > _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
> > a commit on his for-linus branch to remove runtime PM for PCIe ports.
> > This fixes a regression on Kilian Singer's laptop on which locking the
> > screen breaks USB and PS/2 input devices:  Mouse movements are still
> > visible, but button or key presses no longer have any effect.  The GPU
> > is powered down upon locking the screen and the current theory is that
> > this causes the issues.]
>=20
> (+cc Alex: this might affect amdgpu/radeon too.]
>=20
> Bjorn, please reconsider the rpm patch. Reverting support would
> introduce other regressions (see issues below) and make future
> Thunderbolt work harder (according to Lukas). If Kilian's laptop has
> issues, what about a "temporary" quirk?
>=20
> > On Tue, Jan 03, 2017 at 04:15:47PM +0100, Peter Wu wrote:
> > > The acpidump from the bug does not show known issues, it *looks* fine=
.
> > > There have been other issues related to resuming power on newer
> Nvidia
> > > hardware (https://bugs.freedesktop.org/show_bug.cgi?id=3D94725,
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D156341) but there is no=
t
> > > much progress here.  (The last time I traced the PCIe register access=
es
> > > (via kprobes) and tried to disable some of those, it still did not he=
lp
> > > with preventing the power issue.)
> >
> > It seems that the _DSM method works on Kilian's laptop.  Would it be
> > viable to default to _DSM if it's available, and only use _PR3 if not?
>=20
> DSM should not be preferred when PR3 is available:
>=20
>  - After MS introduced D3cold (PR3) support to Win8+, vendors are
>    unlikely to test legacy DSM and the likelihood of breakage increases.
>  - On one Lenovo laptop, the DSM method causes memory corruption while
>    PR3 fixes this problem.
>  - On some laptops, DSM keeps the fan on while PR3 stopped the noise.
>  - On some laptops, DSM does not really power off the GPU and results in
>    increased power consumption during runtime/system sleep. PR3 fully
>    removes the power, as desired.

Yes, this will affect just about all AMD multi-GPU laptops from late 2013 o=
nward.  I'd much prefer a temporary quirk for this specific laptop than to =
disable PR3 for everything.

Alex

> --
> Kind regards,
> Peter Wu
> https://lekensteyn.nl
