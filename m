Return-Path: <cq.tang@intel.com>
Return-Path: <cq.tang@intel.com>
From: "Tang, CQ" <cq.tang@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Lance Ortiz
	<lance.ortiz@hpe.com>, Betty Dall <betty.dall@hpe.com>, Hidetoshi Seto
	<seto.hidetoshi@jp.fujitsu.com>, Chen Gong <gong.chen@linux.intel.com>,
	"KeithBuschkeith.busch@intel.com" <KeithBuschkeith.busch@intel.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>,
	"Huang, Ying" <ying.huang@intel.com>, Vijay Mohan Pandarathil
	<vijaymohan.pandarathil@hpe.com>, "Derrick, Jonathan"
	<jonathan.derrick@intel.com>
Subject: RE: [PATCH 0/2] PCI/AER: Remove module parameters
Date: Sat, 17 Sep 2016 04:49:11 +0000
Message-ID: <1D440B9B88E22A4ABEF89F9F1F81BC2949120D8F@FMSMSX106.amr.corp.intel.com>
References: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160914203019.GB13189@localhost>
In-Reply-To: <20160914203019.GB13189@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Bjorn,
     Can we extend this aerdriver to support AER from a root complex integr=
ated endpoint? Root complex event collector has the same job as root port i=
n this case.

     It looks that both port driver and aer driver check PCI_EXP_TYPE_ROOT_=
PORT/PCI_EXP_TYPE_UPSTREAM/PCI_EXP_TYPE_DOWNSTREAM only.
portdrv_pci.c:127, aerdrv.c:86

      Is it just a simple addition of PCI_EXP_TYPE_RC_EC to above two place=
s?  Is there any difference to recover a root complex integrated endpoint? =
(compared with devices connected to root port).

Thanks.
--CQ

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Wednesday, September 14, 2016 1:30 PM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org; Lance Ortiz <lance.ortiz@hpe.com>; Betty D=
all
> <betty.dall@hpe.com>; Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>;
> Chen Gong <gong.chen@linux.intel.com>; KeithBuschkeith.busch@intel.com;
> Rafael J. Wysocki <rjw@rjwysocki.net>; linux-kernel@vger.kernel.org; Shua=
h
> Khan <shuahkh@osg.samsung.com>; Huang, Ying <ying.huang@intel.com>;
> Vijay Mohan Pandarathil <vijaymohan.pandarathil@hpe.com>; Derrick,
> Jonathan <jonathan.derrick@intel.com>
> Subject: Re: [PATCH 0/2] PCI/AER: Remove module parameters
>=20
> On Tue, Sep 06, 2016 at 05:19:22PM -0500, Bjorn Helgaas wrote:
> > I'd like to remove the aerdriver.nosourceid and aerdriver.forceload
> > kernel parameters.  They seem like basically debugging things that are
> > not really supportable upstream.
> >
> > "nosourceid" may have some legitimate uses, but I'd rather it were
> > done via quirks with the flag Jon Derrick recently added so it happens
> > automatically, without users having to specify the parameter.
> >
> > I don't *know* of any actual users of either of these, but obviously
> > that doesn't mean there are none.  Comments welcome.
> >
> > ---
> >
> > Bjorn Helgaas (2):
> >       PCI/AER: Remove aerdriver.nosourceid kernel parameter
> >       PCI/AER: Remove aerdriver.forceload kernel parameter
> >
> >
> >  Documentation/PCI/pcieaer-howto.txt |   26 +++++++++-----------------
> >  drivers/pci/pcie/aer/aerdrv.c       |    7 +------
> >  drivers/pci/pcie/aer/aerdrv.h       |    8 --------
> >  drivers/pci/pcie/aer/aerdrv_core.c  |   31 ++++-----------------------=
----
> >  4 files changed, 14 insertions(+), 58 deletions(-)
>=20
> I'm going to go out on a limb a little bit and apply these to pci/aer for=
 v4.9.
> Please let me know if you trip over any issues.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
