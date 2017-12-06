Return-Path: <SRS0=fhAv=DC=intel.com=kenji.chen@kernel.org>
Return-Path: <SRS0=fhAv=DC=intel.com=kenji.chen@kernel.org>
From: "Chen, Kenji" <kenji.chen@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Thierry Reding <treding@nvidia.com>, Manikanta Maddireddy
	<mmaddireddy@nvidia.com>, David Daney <david.daney@cavium.com>, "Krishna
 Kishore" <kthota@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, Julia Lawall
	<Julia.Lawall@lip6.fr>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Patrick Georgi <pgeorgi@chromium.org>, "Rajat
 Jain" <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>, Stefan Reinauer
	<stefan.reinauer@coreboot.org>, Duncan Laurie <dlaurie@chromium.org>
Subject: RE: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
Date: Wed, 6 Dec 2017 01:55:37 +0000
Message-ID: <A7A4B3ECFA40144E98B82E71E29693557CA5516C@PGSMSX102.gar.corp.intel.com>
References: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171205194050.GD23510@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171205194050.GD23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Su=
bstates_with_CLKREQ_31_May_2013_Rev10a.pdf
Pls also check My Intel Doc# 545845 for the bits fields description.

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org]=20
Sent: Wednesday, December 6, 2017 3:41 AM
To: linux-pci@vger.kernel.org
Cc: Chen, Kenji <kenji.chen@intel.com>; Thierry Reding <treding@nvidia.com>=
; Manikanta Maddireddy <mmaddireddy@nvidia.com>; David Daney <david.daney@c=
avium.com>; Krishna Kishore <kthota@nvidia.com>; linux-kernel@vger.kernel.o=
rg; Vidya Sagar <vidyas@nvidia.com>; Julia Lawall <Julia.Lawall@lip6.fr>; l=
inux-tegra@vger.kernel.org; Patrick Georgi <pgeorgi@chromium.org>; Rajat Ja=
in <rajatja@google.com>; Yinghai Lu <yinghai@kernel.org>; Stefan Reinauer <=
stefan.reinauer@coreboot.org>; Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support

On Sat, Dec 02, 2017 at 03:45:38PM -0600, Bjorn Helgaas wrote:
> The PCIe active link power state is L0.  ASPM defines two low-power
> states: L0s and L1.  The L1 PM Substates feature defines two=20
> additional low-power states: L1.1 and L2.2.
>=20
> The L1.2 state may have substantial entry/exit latency.  Downstream=20
> devices can use the Latency Tolerance Reporting (LTR) feature to=20
> report how much latency they can tolerate.  The L1 PM Substates=20
> capability includes a programmable L1.2 threshold register.  If the=20
> downstream devices can tolerate the latency indicated by the=20
> threshold, L1.2 may be used.
>=20
> If LTR is not enabled, the L1.2 threshold is ignored and L1.2 can be=20
> used whenever it is enabled and CLKREQ# is de-asserted.  Linux=20
> currently never enables LTR, but firmware may have done so.
>=20
> The current L1 PM substates support in Linux sets the L1.2 threshold=20
> to a fixed value (163.84us) copied from coreboot [1].  I don't know=20
> where that value came from, and it is incorrect for some platforms,=20
> e.g., Tegra [2].
>=20
> These patches change that so we calculate the L1.2 threshold based on=20
> values reported by the hardware, and we enable LTR whenever possible.
>=20
> This is all just my understanding from reading the spec.  I'd be glad=20
> to be corrected if I'm going wrong.
>=20
> I'm particularly puzzled about the coreboot code in
> pciexp_L1_substate_commit() that sets LTR_L1.2_THRESHOLD:
>=20
> +	pcie_update_cfg(root, root_cap + 0x08, ~0xe3ff0000,
> +		(1 << 21) | (1 << 23) | (1 << 30));
>=20
> This is writing the L1 PM Substates Control 1 register, but the shifts=20
> don't match up with any of the fields in the register, so this is an=20
> awfully funny way to write the threshold.
>=20
> [1]=20
> https://mail.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.
> html [2]=20
> https://lkml.kernel.org/r/1510492674-12786-1-git-send-email-vidyas@nvi
> dia.com
>=20
> ---
>=20
> Bjorn Helgaas (2):
>       PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
>       PCI/ASPM: Enable Latency Tolerance Reporting when supported
>=20
>=20
>  drivers/pci/pcie/aspm.c |   71 +++++++++++++++++++++++++++++++----------=
------
>  drivers/pci/probe.c     |   33 ++++++++++++++++++++++
>  include/linux/pci.h     |    2 +
>  3 files changed, 82 insertions(+), 24 deletions(-)

I applied these with Vidya's Reviewed-by to pci/aspm for v4.16.

I'd still really like to hear from the coreboot folks about the rationale f=
or the current coreboot code.  You folks are in a much better position to a=
ctually understand the hardware details.

Bjorn
