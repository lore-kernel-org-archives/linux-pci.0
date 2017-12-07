Return-Path: <SRS0=B59L=DD=intel.com=kenji.chen@kernel.org>
Return-Path: <SRS0=B59L=DD=intel.com=kenji.chen@kernel.org>
From: "Chen, Kenji" <kenji.chen@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, "David
 Daney" <david.daney@cavium.com>, Krishna Kishore <kthota@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Patrick Georgi
	<pgeorgi@chromium.org>, Rajat Jain <rajatja@google.com>, Yinghai Lu
	<yinghai@kernel.org>, Stefan Reinauer <stefan.reinauer@coreboot.org>, Duncan
 Laurie <dlaurie@chromium.org>
Subject: RE: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
Date: Thu, 7 Dec 2017 15:00:43 +0000
Message-ID: <A7A4B3ECFA40144E98B82E71E29693557CA5BA74@PGSMSX102.gar.corp.intel.com>
References: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171205194050.GD23510@bhelgaas-glaptop.roam.corp.google.com>
 <A7A4B3ECFA40144E98B82E71E29693557CA5516C@PGSMSX102.gar.corp.intel.com>
 <20171207144515.GA11788@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171207144515.GA11788@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

For Intel Broadwell, SKylake, and KabyLake PCIe Root Port, the threshold is=
 recommended as it is in the commit. If the BIOS/Coreboot porting between p=
latforms is taken into consideration, using a build definition or variables=
 from somewhere of customizable zone is preferred. Let Coreboot guys make t=
he call since I am working for Intel Only.

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org]=20
Sent: Thursday, December 7, 2017 10:45 PM
To: Chen, Kenji <kenji.chen@intel.com>
Cc: linux-pci@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Manikan=
ta Maddireddy <mmaddireddy@nvidia.com>; David Daney <david.daney@cavium.com=
>; Krishna Kishore <kthota@nvidia.com>; linux-kernel@vger.kernel.org; Vidya=
 Sagar <vidyas@nvidia.com>; Julia Lawall <Julia.Lawall@lip6.fr>; linux-tegr=
a@vger.kernel.org; Patrick Georgi <pgeorgi@chromium.org>; Rajat Jain <rajat=
ja@google.com>; Yinghai Lu <yinghai@kernel.org>; Stefan Reinauer <stefan.re=
inauer@coreboot.org>; Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support

On Wed, Dec 06, 2017 at 01:55:37AM +0000, Chen, Kenji wrote:
> https://pcisig.com/sites/default/files/specification_documents/ECN_L1_
> PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf

With all due respect, this doesn't seem to add any new information.
For example, the L1 PM Substates Control 1 register description from the ab=
ove is basically identical to the published PCIe r3.1, sec 7.33.3.

So it doesn't answer the questions of:

  1) Why coreboot sets the L1.2 threshold to a fixed value, and

  2) How "(1 << 21) | (1 << 23) | (1 << 30)" relates to the Control 1
     register

> Pls also check My Intel Doc# 545845 for the bits fields description.

I don't have access to this document.  The Linux code I'm proposing is base=
d on the PCIe spec and is intended to work on all hardware that conforms to=
 that spec.  I'm not very familiar with coreboot, but maybe the L1 Substate=
s code there is only intended to work on certain Intel chipsets and doesn't=
 need to work on other hardware?

Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, December 6, 2017 3:41 AM
> To: linux-pci@vger.kernel.org
> Cc: Chen, Kenji <kenji.chen@intel.com>; Thierry Reding=20
> <treding@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;=20
> David Daney <david.daney@cavium.com>; Krishna Kishore=20
> <kthota@nvidia.com>; linux-kernel@vger.kernel.org; Vidya Sagar=20
> <vidyas@nvidia.com>; Julia Lawall <Julia.Lawall@lip6.fr>;=20
> linux-tegra@vger.kernel.org; Patrick Georgi <pgeorgi@chromium.org>;=20
> Rajat Jain <rajatja@google.com>; Yinghai Lu <yinghai@kernel.org>;=20
> Stefan Reinauer <stefan.reinauer@coreboot.org>; Duncan Laurie=20
> <dlaurie@chromium.org>
> Subject: Re: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
>=20
> On Sat, Dec 02, 2017 at 03:45:38PM -0600, Bjorn Helgaas wrote:
> > The PCIe active link power state is L0.  ASPM defines two low-power
> > states: L0s and L1.  The L1 PM Substates feature defines two=20
> > additional low-power states: L1.1 and L2.2.
> >=20
> > The L1.2 state may have substantial entry/exit latency.  Downstream=20
> > devices can use the Latency Tolerance Reporting (LTR) feature to=20
> > report how much latency they can tolerate.  The L1 PM Substates=20
> > capability includes a programmable L1.2 threshold register.  If the=20
> > downstream devices can tolerate the latency indicated by the=20
> > threshold, L1.2 may be used.
> >=20
> > If LTR is not enabled, the L1.2 threshold is ignored and L1.2 can be=20
> > used whenever it is enabled and CLKREQ# is de-asserted.  Linux=20
> > currently never enables LTR, but firmware may have done so.
> >=20
> > The current L1 PM substates support in Linux sets the L1.2 threshold=20
> > to a fixed value (163.84us) copied from coreboot [1].  I don't know=20
> > where that value came from, and it is incorrect for some platforms,=20
> > e.g., Tegra [2].
> >=20
> > These patches change that so we calculate the L1.2 threshold based=20
> > on values reported by the hardware, and we enable LTR whenever possible=
.
> >=20
> > This is all just my understanding from reading the spec.  I'd be=20
> > glad to be corrected if I'm going wrong.
> >=20
> > I'm particularly puzzled about the coreboot code in
> > pciexp_L1_substate_commit() that sets LTR_L1.2_THRESHOLD:
> >=20
> > +	pcie_update_cfg(root, root_cap + 0x08, ~0xe3ff0000,
> > +		(1 << 21) | (1 << 23) | (1 << 30));
> >=20
> > This is writing the L1 PM Substates Control 1 register, but the=20
> > shifts don't match up with any of the fields in the register, so=20
> > this is an awfully funny way to write the threshold.
> >=20
> > [1]
> > https://mail.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.
> > html [2]
> > https://lkml.kernel.org/r/1510492674-12786-1-git-send-email-vidyas@n
> > vi
> > dia.com
> >=20
> > ---
> >=20
> > Bjorn Helgaas (2):
> >       PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristic=
s
> >       PCI/ASPM: Enable Latency Tolerance Reporting when supported
> >=20
> >=20
> >  drivers/pci/pcie/aspm.c |   71 +++++++++++++++++++++++++++++++--------=
--------
> >  drivers/pci/probe.c     |   33 ++++++++++++++++++++++
> >  include/linux/pci.h     |    2 +
> >  3 files changed, 82 insertions(+), 24 deletions(-)
>=20
> I applied these with Vidya's Reviewed-by to pci/aspm for v4.16.
>=20
> I'd still really like to hear from the coreboot folks about the rationale=
 for the current coreboot code.  You folks are in a much better position to=
 actually understand the hardware details.
>=20
> Bjorn
